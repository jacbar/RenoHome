import { useState } from 'react'
import { Box, Button, Heading, Text } from '@chakra-ui/react'
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <Box
      minH="100vh"
      display="flex"
      alignItems="center"
      justifyContent="center"
      px={6}
      py={12}
      bg="gray.50"
    >
      <Box
        w="full"
        maxW="640px"
        bg="white"
        borderWidth="1px"
        borderColor="gray.200"
        borderRadius="lg"
        boxShadow="sm"
        p={8}
      >
        <Heading size="lg" mb={2}>
          RenoHome
        </Heading>
        <Text color="gray.600" fontSize="md" mb={6}>
          Your home renovation companion. Start building your project.
        </Text>

        <Button
          colorScheme="teal"
          onClick={() => setCount((c) => c + 1)}
        >
          Clicked {count} {count === 1 ? 'time' : 'times'}
        </Button>
      </Box>
    </Box>
  )
}

export default App
