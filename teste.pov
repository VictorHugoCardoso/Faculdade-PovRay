#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
#include "Column_Kernel_01.inc" 

#declare Stone_Texture = // Column kernel stone texture
     texture { T_Grnt16
               normal { agate 0.35 scale 0.05}
               finish { phong 0.2 } 
               scale 1 
             }

#declare Column_Kernel_Texture = // with vertical subdivisions 
    texture { gradient<0,1,0> scale <1,0.67,1> turbulence 0.01 //------------------- 
               texture_map{ [0.00 Stone_Texture ]
                            [0.001 pigment{ color rgb <1,1,1>*0.1} ]
                            [0.005 pigment{ color rgb <1,1,1>*0.1} ]
                            [0.006 Stone_Texture ]
                            [1.00 Stone_Texture ]
                          } // end of texture_map      
             }      
       
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------

#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <1.4 , 0.5 ,-2>
                            right     x*image_width/image_height
                            look_at   <1.4, 0.7, 0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 95   // diagonal view
                            location  <2.0 , 2, -1.2>
                            right     x*image_width/image_height
                            look_at   <1.0 , 0.2 , 2.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <-2 , 1.0 , 1.6>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 1.6>}
#declare Camera_4 = camera {/*ultra_wide_angle*/ angle 105      // front view
                            location  <0.4 , 0.3 ,0.5>
                            right     x*image_width/image_height
                            look_at   <1.4, 0.7, 1.3>}

#declare Camera_5 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <1.4 , 4.2 , 1.7>
                            right     x*image_width/image_height
                            look_at   <1.4 , 0.5 , 1.7>}
camera{Camera_5
}

// sun ---------------------------------------------------------------------
light_source{
  <-1500,2000,-2500>
  color White
  area_light
  <5, 0, 0> <0, 5, 0>
  4,4 // numbers in directions
  adaptive 4  // 0,1,2,3...
  jitter // random softening
  rotate x*-5
}

// sky -------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   50
      color      White  
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    }

// TETO ============================================================
// end of box --------------------------------------

  union{
   merge{                                       
    box { <0,0,0>,<2.70, 0.285, 3.25>
      scale <1,1,1> rotate<0,0,0> translate<0,1.15,0> 
    }
    box { <0,0,0>,<2.74, 0.02, 3.29>
      scale <1,1,1> rotate<0,0,0> translate<-0.02,1.2,-0.02> 
    }
    
    #declare strips = union{
        box { <0,0,0>,<0.01, 0.1, 3.28>
          scale <1,1,1> rotate<0,0,0> translate<0.03,1.23,-0.01> 
        }
        box { <0,0,0>,<0.01, 0.1, 3.28>
          scale <1,1,1> rotate<0,0,0> translate<0.06,1.23,-0.01> 
        }
        box { <0,0,0>,<0.01, 0.1, 3.28>
          scale <1,1,1> rotate<0,0,0> translate<0.09,1.23,-0.01> 
        }   
    }
    union{ //-----------------------------------
    
     #for (I, 0, 11, 1) 
    
       object{ strips translate< I*0.232, 0, 0 >} 
    
     #end // --------------- end of #for loop 
    
    rotate<0,0,0> 
    translate<0,0,0>
    } // end of union ----c----------------------
     
    union{ //-----------------------------------
    
     #for (I, 0, 14, 1) 
    
        object{ strips scale<1,1,0.83> translate< -0.13 + I*(-0.222), -0.02, -0 > rotate<0,90,0>} 
     
     #end // --------------- end of #for loop 
    
    box { <0,0,0>,<2.74, 0.02, 3.29>
      scale <1,1,1> rotate<0,0,0> translate<-0.02,1.35,-0.02> 
    }
    
    box { <0,0,0>,<2.74, 0.02, 3.29>
      scale <1,1,1> rotate<0,0,0> translate<-0.02,1.42,-0.02> 
    }
    
    
    rotate<0,0,0> 
    translate<0,0,0>
    } // end of union --------------------------
     
    
             texture { T_Grnt16 
                   //normal { agate 0.15 scale 0.15}
                   finish { phong 0.5 } 
                   scale 1 
                 } // end of texture 

   }
   
   merge{
    // linear prism in z-direction: from ,to ,number of points (first = last)
    prism { -1.10 ,1.10 , 7
       <-1.05, 0.95>,  // first point
       < 0.00, 1.30>,  
       < 1.05, 0.95>, 
       < 1.05, 1.00>, 
       < 0.00, 1.35>, 
       <-1.05, 1.00>, 
       <-1.05, 0.95>  // last point = first point!!!!
       rotate<-90,0,0> scale<1,1,-1> //turns prism in z direction! Don't change this line! 
       
      texture{ T_Stone8    
        normal { agate 0.25 scale 0.15 rotate<0,0,0> }
        finish { phong 1 } 
        rotate<0,0,0> scale 0.5 translate<0,0,0>
      } // end of texture 

       #declare I = 0;
        #while(I <= 30)
        
        #declare I = I + 1;
       #end 
       
       scale <1.30,1.00,1.49>       
       rotate <0,0,0> 
       translate <1.35,0.46,1.63> 
     } // end of prism --------------------------------------------------------

    // linear prism in z-direction: from ,to ,number of points (first = last)
    difference{
      prism { -1.00 ,1.00 , 6
           <-1.00, 0.00>,  // first point
           < 1.00, 0.00>, 
           < 1.00, 0.50>, 
           < 0.00, 7.00>, 
           <-1.00, 0.50>, 
           <-1.00, 0.00>   // last point = first point!!!!
           rotate<-90,0,0> scale<1,1,-1> //turns prism in z direction! Don't change this line! 
           
          texture{ T_Stone9    
            normal { agate 0.25 scale 0.15 rotate<0,0,0> }
            finish { phong 1 } 
            rotate<0,0,0> scale 0.5 translate<0,0,0>
          } // end of texture 


           
           scale <1.30,0.05,1.49>       
           rotate <0,0,0> 
           translate <1.35,1.45,1.51>  
         } // end of prism --------------------------------------------------------
      
        #declare I = 0;
        #while(I <= 30)
             cylinder { <0,0,0>,<0,0.8,0>, 0.01                   
               scale <1,1,1> rotate<0,0,0> translate<I*0.1,1.15,0.025>
             } // end of cylinder -------------------------------------  
        #declare I = I + 1;
        #end 
             
        
            
    }
   }
   
  }                                                                         


// CHAO  ------------------------------------------------------------
plane { <0,1,0>, 0 
    texture{ pigment{ color rgb<0.35,0.65,0.0>*0.72 }
         normal { bumps 0.75 scale 0.015 }
             finish { phong 0.1 }
           } // end of texture
  } // end of plane

  //escadas
  union{ 
    box { <0,0,0>,< 2.70, 0.05, 3.25>   
      scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
    } // end of box --------------------------------------
                                                              
    box { <0,0,0>,< 2.50, 0.05, 3.05>   
      scale <1,1,1> rotate<0,0,0> translate<0.1,0.05,0.1> 
    } // end of box --------------------------------------                                                           
                                                           
    box { <0,0,0>,< 2.30, 0.05, 2.85>   
      scale <1,1,1> rotate<0,0,0> translate<0.2,0.10,0.2>
    } // end of box --------------------------------------                   
    texture { Column_Kernel_Texture } // end of texture 
   }  
   // end of escadas --------------------------------------  
   
      
//INTERIOR ===========================================================       
    difference{
       box { <0,0,0>,< 1.00, 1.05, 1.75>   
          scale <1,1,1> rotate<0,0,0> 
          translate<0.9,0.10,0.7> 
          //translate<0.2,0.10,0.2>
          
        } // end of box --------------------------------------
        cylinder { <0,0,0>,<0,0,2>,0.25 
           texture { pigment { color rgb<1,1,1>}
                   //normal  { bumps 0.5 scale 0.005}  
                     finish  { phong 0.5 reflection{ 0.00 metallic 0.00} } 
                   } // end of texture
           scale <0,3,0> rotate<0,0,0> translate<1.4,0.5,0.35>
         } // end of cylinder  ------------------------------------

        texture { Column_Kernel_Texture } // end of texture 
   }


// PILARES ============================================================     
    
    
    #declare cilindro =object{ Column_Kernel_01 ( 1, // Column_Total_Height,  // 
                               16,   // Column_Subdivision, // integer ~ 16
                           0.07, // Column_Base_Radius, 
                           0.06  // Column_Top_Radius,  
                  ) //---------------------------------

        texture { Column_Kernel_Texture}  
        scale<1,1,1>  rotate< 0,0,0>  translate<0.35,0.15,0.35>  
      } // end of "Column_01(...) --------------------------------------- 
    
    
    #declare pilar =  
    union {
        
        difference{
           box { <0,0,0>,< 0.3, 0.01999, 0.3> 
              scale <1,1,1> rotate<0,0,0> translate<0.2,1.13,0.2> 
            }
           cilindro 
        } 
         

        difference{         
            box { <0,0,0>,< 0.24, 0.07, 0.24>   
        
              scale <1,1,1> rotate<0,0,0> translate<0.23,0.15,0.25> 
            } // end of box --------------------------------------
            cilindro
        }
        difference{         
     
            sphere { <0,0,0>, 0.1  
                 scale<1,0.25,1>
               
                 rotate<0,0,0>  translate<0.35,0.25,0.35>  
               }  // end of sphere -------------------------------------------------- 

            cilindro
        }
        
        cilindro 
           
        texture { Column_Kernel_Texture} // end of texture 
                  
        scale <1,1,1> rotate<0,0,0> translate<0,0,0>
    }
    object{ pilar translate< 0, 0, 0 >}
    
    union{ //-----------------------------------
    
     #for (I, 0, 5, 1) 
    
       object{ pilar translate< 0, 0, I*0.5 >} 
    
     #end // --------------- end of #for loop 
    
    rotate<0,0,0> 
    translate<0,0,0>
    } // end of union --------------------------
    
    union{ //-----------------------------------
    
     #for (I, 0, 3, 1) 
    
       object{ pilar translate< I*0.5, 0, 0 >} 
    
     #end // --------------- end of #for loop 
    
    rotate<0,0,0> 
    translate<0.5,0,0>
    } // end of union -------------------------- 
    
    union{ //-----------------------------------
    
     #for (I, 0, 4, 1) 
    
       object{ pilar translate< 0, 0, I*0.5 >} 
    
     #end // --------------- end of #for loop 
    
    rotate<0,0,0> 
    translate<2,0,0.5>
    } // end of union --------------------------
    
    union{ //-----------------------------------
    
     #for (I, 0, 3, 1) 
    
       object{ pilar translate< I*0.5, 0, 0 >} 
    
     #end // --------------- end of #for loop 
    
    rotate<0,0,0> 
    translate<0.5,0,2.5>
    } // end of union --------------------------
   
         
//chao esta em 0.15     
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------












