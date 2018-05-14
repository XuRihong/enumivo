/**
 *  @file
 *  @copyright defined in eos/LICENSE.txt
 */
#pragma once
#include <enumivolib/types.h>

extern "C" {

   /**
    * @defgroup systemapi System API
    * @ingroup contractdev
    * @brief Define API for interacting with system level intrinsics
    *
    */

   /**
    * @defgroup systemcapi System C API
    * @ingroup systemapi
    * @brief Define API for interacting with system level intrinsics
    *
    * @{
    */

   /**
    *  Aborts processing of this action and unwinds all pending changes if the test condition is true
    *  @brief Aborts processing of this action and unwinds all pending changes
    *  @param test - 0 to abort, 1 to ignore
    *  @param cstr - a null terminated action to explain the reason for failure

    */
   void  eosio_assert( uint32_t test, const char* cstr );

   /**
    * This method will abort execution of wasm without failing the contract. This
    * is used to bypass all cleanup / destructors that would normally be called.
    */
   [[noreturn]] void  eosio_exit( int32_t code );


   /**
    *  Returns the time in microseconds from 1970 of the current block
    *  @brief Get time of the current block (i.e. the block including this action)
    *  @return time in microseconds from 1970 of the current block
    */
   uint64_t  current_time();

   /**
    *  Returns the time in seconds from 1970 of the block including this action
    *  @brief Get time (rounded down to the nearest second) of the current block (i.e. the block including this action)
    *  @return time in seconds from 1970 of the current block
    */
   uint32_t  now() {
      return (uint32_t)( current_time() / 1000000 ); 
   }
   ///@ } systemcapi


}
