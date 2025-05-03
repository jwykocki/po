const express = require('express');
const cors = require('cors');
const app = express();
const PORT = 8080;

app.use(cors());
app.use(express.json());

// Mock products
const products = [
    { id: 1, name: 'Laptop', price: 999.99, description: 'Powerful laptop' },
    { id: 2, name: 'Headphones', price: 199.99, description: 'Noise-cancelling' },
    { id: 3, name: 'Mouse', price: 49.99, description: 'Wireless mouse' }
];

// GET /api/products
app.get('/api/products', (req, res) => {
    res.json(products);
});

// POST /api/payments
app.post('/api/payments', (req, res) => {
    const { orderId, amount, cardNumber, cardHolder, expiryDate, cvv } = req.body;

    if (!cardNumber || !cardHolder || !expiryDate || !cvv) {
        return res.status(400).json({ message: 'Missing payment fields' });
    }

    // Simulate success
    res.json({ message: `Payment of $${amount} for ${orderId} processed successfully.` });
});

app.listen(PORT, () => {
    console.log(`Mock API server running at http://localhost:${PORT}`);
});
