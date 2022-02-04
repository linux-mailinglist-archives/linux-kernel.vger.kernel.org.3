Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B124A9205
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356516AbiBDBas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:30:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:49458 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234434AbiBDBar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643938247; x=1675474247;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gR5KfMpZ8UPykq6cbIlOtC+zxtW5V7mQ9BrL/dmC4AE=;
  b=HlcVShRylW3398ex4B2PRFpSz3qKKl3TqqFVtcVzAraejnNMS5jskOh7
   E0MG5V54oj0Bq6R1VD3Ixm1PzsXsbSC78E58v8No8tf9kAKzT5m1UNdOL
   E1h/CzUQHIIyqRx7etza1SBvnZ53oRh6EX3lMMn+oijnQVm6M8tbYYjAI
   avRtiBGkZkpUK8VHA0a6B1SQ9f91sFL5k42DQxcR7vTA95ksXN2+CxUck
   U/Q6Nw4kMyFE9cQkzjqogmNSt8esjqV4b/+73luATiPH+OHekLRtOildU
   fYGN4Pu146c7aHRi3jW1aGVzkEnfCWJK2npaj+OdoM9eOhKvF+dhJ0j6L
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="235691055"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="235691055"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 17:30:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="627640298"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2022 17:30:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFnQy-000Wur-KJ; Fri, 04 Feb 2022 01:30:44 +0000
Date:   Fri, 4 Feb 2022 09:30:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Biggers <ebiggers@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 8961/9999] arch/arm/crypto/blake2s-core.S:201: Error: bad instruction `rev_l
 r2,r14'
Message-ID: <202202040449.xFIRtYbH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   a2429bd75fe959e3bf866aa5005606031b5c16be
commit: 8ac05d760d253d96daa5fb4e19d46a0c400e7481 [8961/9999] UPSTREAM: crypto: arm/blake2s - fix for big endian
config: arm-randconfig-r033-20220130 (https://download.01.org/0day-ci/archive/20220204/202202040449.xFIRtYbH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/8ac05d760d253d96daa5fb4e19d46a0c400e7481
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout 8ac05d760d253d96daa5fb4e19d46a0c400e7481
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm/crypto/blake2s-core.S: Assembler messages:
>> arch/arm/crypto/blake2s-core.S:201: Error: bad instruction `rev_l r2,r14'
>> arch/arm/crypto/blake2s-core.S:201: Error: bad instruction `rev_l r3,r14'
>> arch/arm/crypto/blake2s-core.S:201: Error: bad instruction `rev_l r4,r14'
>> arch/arm/crypto/blake2s-core.S:201: Error: bad instruction `rev_l r5,r14'
>> arch/arm/crypto/blake2s-core.S:201: Error: bad instruction `rev_l r6,r14'
>> arch/arm/crypto/blake2s-core.S:201: Error: bad instruction `rev_l r7,r14'
>> arch/arm/crypto/blake2s-core.S:201: Error: bad instruction `rev_l r8,r14'
>> arch/arm/crypto/blake2s-core.S:201: Error: bad instruction `rev_l r9,r14'
   arch/arm/crypto/blake2s-core.S:204: Error: bad instruction `rev_l r2,r14'
   arch/arm/crypto/blake2s-core.S:204: Error: bad instruction `rev_l r3,r14'
   arch/arm/crypto/blake2s-core.S:204: Error: bad instruction `rev_l r4,r14'
   arch/arm/crypto/blake2s-core.S:204: Error: bad instruction `rev_l r5,r14'
   arch/arm/crypto/blake2s-core.S:204: Error: bad instruction `rev_l r6,r14'
   arch/arm/crypto/blake2s-core.S:204: Error: bad instruction `rev_l r7,r14'
   arch/arm/crypto/blake2s-core.S:204: Error: bad instruction `rev_l r8,r14'
   arch/arm/crypto/blake2s-core.S:204: Error: bad instruction `rev_l r9,r14'
>> arch/arm/crypto/blake2s-core.S:291: Error: bad instruction `rev_l r3,r4'


vim +201 arch/arm/crypto/blake2s-core.S

   168	
   169	//
   170	// void blake2s_compress_arch(struct blake2s_state *state,
   171	//			      const u8 *block, size_t nblocks, u32 inc);
   172	//
   173	// Only the first three fields of struct blake2s_state are used:
   174	//	u32 h[8];	(inout)
   175	//	u32 t[2];	(inout)
   176	//	u32 f[2];	(in)
   177	//
   178		.align		5
   179	ENTRY(blake2s_compress_arch)
   180		push		{r0-r2,r4-r11,lr}	// keep this an even number
   181	
   182	.Lnext_block:
   183		// r0 is 'state'
   184		// r1 is 'block'
   185		// r3 is 'inc'
   186	
   187		// Load and increment the counter t[0..1].
   188		__ldrd		r10, r11, r0, 32
   189		adds		r10, r10, r3
   190		adc		r11, r11, #0
   191		__strd		r10, r11, r0, 32
   192	
   193		// _blake2s_round is very short on registers, so copy the message block
   194		// to the stack to save a register during the rounds.  This also has the
   195		// advantage that misalignment only needs to be dealt with in one place.
   196		sub		sp, sp, #64
   197		mov		r12, sp
   198		tst		r1, #3
   199		bne		.Lcopy_block_misaligned
   200		ldmia		r1!, {r2-r9}
 > 201		_le32_bswap_8x	r2, r3, r4, r5, r6, r7, r8, r9,  r14
   202		stmia		r12!, {r2-r9}
   203		ldmia		r1!, {r2-r9}
   204		_le32_bswap_8x	r2, r3, r4, r5, r6, r7, r8, r9,  r14
   205		stmia		r12, {r2-r9}
   206	.Lcopy_block_done:
   207		str		r1, [sp, #68]		// Update message pointer
   208	
   209		// Calculate v[8..15].  Push v[9..15] onto the stack, and leave space
   210		// for spilling v[8..9].  Leave v[8..9] in r8-r9.
   211		mov		r14, r0			// r14 = state
   212		adr		r12, .Lblake2s_IV
   213		ldmia		r12!, {r8-r9}		// load IV[0..1]
   214		__ldrd		r0, r1, r14, 40		// load f[0..1]
   215		ldm		r12, {r2-r7}		// load IV[3..7]
   216		eor		r4, r4, r10		// v[12] = IV[4] ^ t[0]
   217		eor		r5, r5, r11		// v[13] = IV[5] ^ t[1]
   218		eor		r6, r6, r0		// v[14] = IV[6] ^ f[0]
   219		eor		r7, r7, r1		// v[15] = IV[7] ^ f[1]
   220		push		{r2-r7}			// push v[9..15]
   221		sub		sp, sp, #8		// leave space for v[8..9]
   222	
   223		// Load h[0..7] == v[0..7].
   224		ldm		r14, {r0-r7}
   225	
   226		// Execute the rounds.  Each round is provided the order in which it
   227		// needs to use the message words.
   228		.set brot, 0
   229		.set drot, 0
   230		_blake2s_round	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
   231		_blake2s_round	14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3
   232		_blake2s_round	11, 8, 12, 0, 5, 2, 15, 13, 10, 14, 3, 6, 7, 1, 9, 4
   233		_blake2s_round	7, 9, 3, 1, 13, 12, 11, 14, 2, 6, 5, 10, 4, 0, 15, 8
   234		_blake2s_round	9, 0, 5, 7, 2, 4, 10, 15, 14, 1, 11, 12, 6, 8, 3, 13
   235		_blake2s_round	2, 12, 6, 10, 0, 11, 8, 3, 4, 13, 7, 5, 15, 14, 1, 9
   236		_blake2s_round	12, 5, 1, 15, 14, 13, 4, 10, 0, 7, 6, 3, 9, 2, 8, 11
   237		_blake2s_round	13, 11, 7, 14, 12, 1, 3, 9, 5, 0, 15, 4, 8, 6, 2, 10
   238		_blake2s_round	6, 15, 14, 9, 11, 3, 0, 8, 12, 2, 13, 7, 1, 4, 10, 5
   239		_blake2s_round	10, 2, 8, 4, 7, 6, 1, 5, 15, 11, 9, 14, 3, 12, 13, 0
   240	
   241		// Fold the final state matrix into the hash chaining value:
   242		//
   243		//	for (i = 0; i < 8; i++)
   244		//		h[i] ^= v[i] ^ v[i + 8];
   245		//
   246		ldr		r14, [sp, #96]		// r14 = &h[0]
   247		add		sp, sp, #8		// v[8..9] are already loaded.
   248		pop		{r10-r11}		// load v[10..11]
   249		eor		r0, r0, r8
   250		eor		r1, r1, r9
   251		eor		r2, r2, r10
   252		eor		r3, r3, r11
   253		ldm		r14, {r8-r11}		// load h[0..3]
   254		eor		r0, r0, r8
   255		eor		r1, r1, r9
   256		eor		r2, r2, r10
   257		eor		r3, r3, r11
   258		stmia		r14!, {r0-r3}		// store new h[0..3]
   259		ldm		r14, {r0-r3}		// load old h[4..7]
   260		pop		{r8-r11}		// load v[12..15]
   261		eor		r0, r0, r4, ror #brot
   262		eor		r1, r1, r5, ror #brot
   263		eor		r2, r2, r6, ror #brot
   264		eor		r3, r3, r7, ror #brot
   265		eor		r0, r0, r8, ror #drot
   266		eor		r1, r1, r9, ror #drot
   267		eor		r2, r2, r10, ror #drot
   268		eor		r3, r3, r11, ror #drot
   269		  add		sp, sp, #64		// skip copy of message block
   270		stm		r14, {r0-r3}		// store new h[4..7]
   271	
   272		// Advance to the next block, if there is one.  Note that if there are
   273		// multiple blocks, then 'inc' (the counter increment amount) must be
   274		// 64.  So we can simply set it to 64 without re-loading it.
   275		ldm		sp, {r0, r1, r2}	// load (state, block, nblocks)
   276		mov		r3, #64			// set 'inc'
   277		subs		r2, r2, #1		// nblocks--
   278		str		r2, [sp, #8]
   279		bne		.Lnext_block		// nblocks != 0?
   280	
   281		pop		{r0-r2,r4-r11,pc}
   282	
   283		// The next message block (pointed to by r1) isn't 4-byte aligned, so it
   284		// can't be loaded using ldmia.  Copy it to the stack buffer (pointed to
   285		// by r12) using an alternative method.  r2-r9 are free to use.
   286	.Lcopy_block_misaligned:
   287		mov		r2, #64
   288	1:
   289	#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
   290		ldr		r3, [r1], #4
 > 291		_le32_bswap	r3, r4

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
