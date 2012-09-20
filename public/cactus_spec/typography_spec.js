//Headings
Cactus.expect("h1", "font-family").toContain("Arial");
Cactus.expect("h1", "font-size").toEqual("30px");    
Cactus.expect("h1", "color").toHaveColor("#4D4F53"); 

// paragraphs
Cactus.expect("p", "font-family").toContain("Arial");
Cactus.expect("p", "font-size").toEqual("16px");
Cactus.expect("p:not([class])", "color").toHaveColor("#4d4f53");

