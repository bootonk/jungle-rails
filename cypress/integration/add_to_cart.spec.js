describe("homepage to add to cart testing", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("Should add an item to the cart and increase the cart total count", () => {
    cy.get(".products article").first().find(".btn").click({ force: true });

    cy.get(".navbar .nav-link").last().contains("My Cart (1)");
  });
});
