Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB13585DEA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 09:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiGaHU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 03:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbiGaHU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 03:20:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8EB12D23
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 00:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659252057; x=1690788057;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1cRnKlpGfU+uJrkz6yLcjROXGrpyWa6oNa7zZF5wXmA=;
  b=jVnLZzJ7+eStYwuf75Iph6L+4NWhADH92Rd7eGt/C9+Zqb9UiNZiInAz
   zvW5wOuRrE6P9iW0rAIvAzqvz2q8IBfuvwEDZN9TnkHt5U8jnAneHo5Kr
   kLBwBlR8UgytwjOCuwa5VhJ7fgS03xbYuD30NZedEPHwRbsUQBQcJiin9
   ZRCAMyKeBxWlyusqYx0qRnTPrvQaTKwLtmZpF03VCD5e1GJvxmgsDWkcS
   1LJlyiPEeRLAGCehSaKcNF8Lpm8bi1nQhLufwAShD+1xh3JQcakvjQ0Qt
   10KeZd01uyu/gkA4P+gSbYnySMc3onfpxXuJuwH1a//gfkuKBFvZ/35lB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="268741397"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="268741397"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 00:20:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="691148107"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2022 00:20:54 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oI3Fu-000DqR-0Q;
        Sun, 31 Jul 2022 07:20:54 +0000
Date:   Sun, 31 Jul 2022 15:20:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 9/9]
 arch/x86/entry/vdso/vgetrandom.c:11: undefined reference to `__fentry__'
Message-ID: <202207311544.Ik8B39of-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   a216645bda19c97d0f68f9b83351696ecd251eb5
commit: a216645bda19c97d0f68f9b83351696ecd251eb5 [9/9] random: implement getrandom() in vDSO
config: x86_64-rhel-8.3-syz (https://download.01.org/0day-ci/archive/20220731/202207311544.Ik8B39of-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/a216645bda19c97d0f68f9b83351696ecd251eb5
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout a216645bda19c97d0f68f9b83351696ecd251eb5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/entry/vdso/vgetrandom.o: warning: relocation in read-only section `__mcount_loc'
   ld: arch/x86/entry/vdso/vgetrandom.o: in function `chacha_permute':
>> arch/x86/entry/vdso/../../../../lib/vdso/../crypto/chacha.c:17: undefined reference to `__fentry__'
   ld: arch/x86/entry/vdso/vgetrandom.o: in function `chacha_block_generic':
   arch/x86/entry/vdso/../../../../lib/vdso/../crypto/chacha.c:77: undefined reference to `__fentry__'
   ld: arch/x86/entry/vdso/vgetrandom.o: in function `hchacha_block_generic':
   arch/x86/entry/vdso/../../../../lib/vdso/../crypto/chacha.c:104: undefined reference to `__fentry__'
   ld: arch/x86/entry/vdso/vgetrandom.o: in function `__vdso_getrandom':
>> arch/x86/entry/vdso/vgetrandom.c:11: undefined reference to `__fentry__'
   ld: arch/x86/entry/vdso/vgetrandom.o: in function `__vdso_getrandom_alloc':
   arch/x86/entry/vdso/vgetrandom.c:19: undefined reference to `__fentry__'
   ld: warning: creating DT_TEXTREL in a shared object
>> objdump: 'arch/x86/entry/vdso/vdso64.so.dbg': No such file
--
>> objcopy: 'arch/x86/entry/vdso/vdso64.so.dbg': No such file


vim +11 arch/x86/entry/vdso/vgetrandom.c

     9	
    10	ssize_t __vdso_getrandom(void *state, void *buffer, size_t len, unsigned int flags)
  > 11	{
    12		return __cvdso_getrandom(state, buffer, len, flags);
    13	}
    14	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
