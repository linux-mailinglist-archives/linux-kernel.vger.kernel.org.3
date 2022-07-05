Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEB4566016
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiGEAZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiGEAZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:25:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04373C6F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 17:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656980732; x=1688516732;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RTyvOi8ftPLsvifit+EtszbaBXYmrQ2y1HqzBhQYlX4=;
  b=P8un7nGkgLxo1jofkT1BPNKHrOEBiATSIQQd1bkKqKzFp+hZjbZAY6EW
   6hUUgCL0Drps/LUfAa5/VisyHCDqJtmIz8eOhlwU+sr8BMlFkNr+JYNC7
   gePeutXtkpqv8JsrpbE0Jqpldgvf5na2qdZvc5xmqFM5lX4k/4F2mBtbv
   /E85meG1aAbEgPRam9PzSAKZWL21ra7wOE1K5rm1NjATD/QcnblAci68M
   PRd8xrkLIrj4sj12Tqn5eD0WS9JZL0dqFACsfdsLA5TRhTUIF/QwuEeo7
   +TtpW0ECBc/FF6Yp3KM37OH+SVpWlDz/p2OJ8fLaOBhl0iMUrzDvJlhRS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="283243886"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="283243886"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 17:25:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="625252336"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Jul 2022 17:25:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8WNe-000IUK-Bv;
        Tue, 05 Jul 2022 00:25:30 +0000
Date:   Tue, 5 Jul 2022 08:24:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [esmil:visionfive 3/49] arch/riscv/lib/string.c:48: undefined
 reference to `_mcount'
Message-ID: <202207050825.5E6Jlwd8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   575362a88f9e6ef14a1a35eb7bd1593745cf019e
commit: 163ef6b6c194ae4d1f709053e4677687e6b87a27 [3/49] riscv: optimized memmove
config: riscv-buildonly-randconfig-r001-20220703 (https://download.01.org/0day-ci/archive/20220705/202207050825.5E6Jlwd8-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/163ef6b6c194ae4d1f709053e4677687e6b87a27
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 163ef6b6c194ae4d1f709053e4677687e6b87a27
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: arch/riscv/purgatory/purgatory.ro: in function `.L355':
   string.c:(.text+0x20e0): undefined reference to `_mcount'
   riscv64-linux-ld: arch/riscv/purgatory/purgatory.ro: in function `__memcpy':
>> arch/riscv/lib/string.c:48: undefined reference to `_mcount'


vim +48 arch/riscv/lib/string.c

6a48862f530a59 Matteo Croce 2021-09-29  30  
6a48862f530a59 Matteo Croce 2021-09-29  31  void *__memcpy(void *dest, const void *src, size_t count)
6a48862f530a59 Matteo Croce 2021-09-29  32  {
6a48862f530a59 Matteo Croce 2021-09-29  33  	union const_types s = { .as_u8 = src };
6a48862f530a59 Matteo Croce 2021-09-29  34  	union types d = { .as_u8 = dest };
6a48862f530a59 Matteo Croce 2021-09-29  35  	int distance = 0;
6a48862f530a59 Matteo Croce 2021-09-29  36  
6a48862f530a59 Matteo Croce 2021-09-29  37  	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
6a48862f530a59 Matteo Croce 2021-09-29  38  		if (count < MIN_THRESHOLD)
6a48862f530a59 Matteo Croce 2021-09-29  39  			goto copy_remainder;
6a48862f530a59 Matteo Croce 2021-09-29  40  
6a48862f530a59 Matteo Croce 2021-09-29  41  		/* Copy a byte at time until destination is aligned. */
6a48862f530a59 Matteo Croce 2021-09-29  42  		for (; d.as_uptr & WORD_MASK; count--)
6a48862f530a59 Matteo Croce 2021-09-29  43  			*d.as_u8++ = *s.as_u8++;
6a48862f530a59 Matteo Croce 2021-09-29  44  
6a48862f530a59 Matteo Croce 2021-09-29  45  		distance = s.as_uptr & WORD_MASK;
6a48862f530a59 Matteo Croce 2021-09-29  46  	}
6a48862f530a59 Matteo Croce 2021-09-29  47  
6a48862f530a59 Matteo Croce 2021-09-29 @48  	if (distance) {
6a48862f530a59 Matteo Croce 2021-09-29  49  		unsigned long last, next;
6a48862f530a59 Matteo Croce 2021-09-29  50  
6a48862f530a59 Matteo Croce 2021-09-29  51  		/*
6a48862f530a59 Matteo Croce 2021-09-29  52  		 * s is distance bytes ahead of d, and d just reached
6a48862f530a59 Matteo Croce 2021-09-29  53  		 * the alignment boundary. Move s backward to word align it
6a48862f530a59 Matteo Croce 2021-09-29  54  		 * and shift data to compensate for distance, in order to do
6a48862f530a59 Matteo Croce 2021-09-29  55  		 * word-by-word copy.
6a48862f530a59 Matteo Croce 2021-09-29  56  		 */
6a48862f530a59 Matteo Croce 2021-09-29  57  		s.as_u8 -= distance;
6a48862f530a59 Matteo Croce 2021-09-29  58  
6a48862f530a59 Matteo Croce 2021-09-29  59  		next = s.as_ulong[0];
6a48862f530a59 Matteo Croce 2021-09-29  60  		for (; count >= BYTES_LONG; count -= BYTES_LONG) {
6a48862f530a59 Matteo Croce 2021-09-29  61  			last = next;
6a48862f530a59 Matteo Croce 2021-09-29  62  			next = s.as_ulong[1];
6a48862f530a59 Matteo Croce 2021-09-29  63  
6a48862f530a59 Matteo Croce 2021-09-29  64  			d.as_ulong[0] = last >> (distance * 8) |
6a48862f530a59 Matteo Croce 2021-09-29  65  					next << ((BYTES_LONG - distance) * 8);
6a48862f530a59 Matteo Croce 2021-09-29  66  
6a48862f530a59 Matteo Croce 2021-09-29  67  			d.as_ulong++;
6a48862f530a59 Matteo Croce 2021-09-29  68  			s.as_ulong++;
6a48862f530a59 Matteo Croce 2021-09-29  69  		}
6a48862f530a59 Matteo Croce 2021-09-29  70  
6a48862f530a59 Matteo Croce 2021-09-29  71  		/* Restore s with the original offset. */
6a48862f530a59 Matteo Croce 2021-09-29  72  		s.as_u8 += distance;
6a48862f530a59 Matteo Croce 2021-09-29  73  	} else {
6a48862f530a59 Matteo Croce 2021-09-29  74  		/*
6a48862f530a59 Matteo Croce 2021-09-29  75  		 * If the source and dest lower bits are the same, do a simple
6a48862f530a59 Matteo Croce 2021-09-29  76  		 * 32/64 bit wide copy.
6a48862f530a59 Matteo Croce 2021-09-29  77  		 */
6a48862f530a59 Matteo Croce 2021-09-29  78  		for (; count >= BYTES_LONG; count -= BYTES_LONG)
6a48862f530a59 Matteo Croce 2021-09-29  79  			*d.as_ulong++ = *s.as_ulong++;
6a48862f530a59 Matteo Croce 2021-09-29  80  	}
6a48862f530a59 Matteo Croce 2021-09-29  81  
6a48862f530a59 Matteo Croce 2021-09-29  82  copy_remainder:
6a48862f530a59 Matteo Croce 2021-09-29  83  	while (count--)
6a48862f530a59 Matteo Croce 2021-09-29  84  		*d.as_u8++ = *s.as_u8++;
6a48862f530a59 Matteo Croce 2021-09-29  85  
6a48862f530a59 Matteo Croce 2021-09-29  86  	return dest;
6a48862f530a59 Matteo Croce 2021-09-29  87  }
6a48862f530a59 Matteo Croce 2021-09-29  88  EXPORT_SYMBOL(__memcpy);
6a48862f530a59 Matteo Croce 2021-09-29  89  

:::::: The code at line 48 was first introduced by commit
:::::: 6a48862f530a593cadaab50ae4006b3a70a112e6 riscv: optimized memcpy

:::::: TO: Matteo Croce <mcroce@microsoft.com>
:::::: CC: Emil Renner Berthing <emil.renner.berthing@canonical.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
