Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A778A4CBCBF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiCCLfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiCCLdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:33:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0751B17ED8A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646307117; x=1677843117;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wB/xcW1nQ+F/5VuuURAvhqvcyvdKsaPRyTepIQdzveE=;
  b=ZiwMciSQfuFyZBBCSBzHY7W2I4qEAJjmaS/gH8X1+mECqhRlpV5PmKjg
   RAEATrmtngR4T0aSA8M/Pw0jZSQFR7/t8mFX6F3t51BLKdyl8ekuZiHWt
   QJl0sQCkTgnhLNhNTG0Q5tzIV9vbuM49c+VYo+D+p0CBUaXGA8Q7iFM41
   3bMdfPTjT5DnIKDPnYoomvcjAvZzVr5bTdGpfgoPcY6aF7UAfJyhf+GgN
   AWX1a2lOtiG0U9XA6UCtU63XPkqAzH4g428EsIOR//VO7gi5B4TmVAXwX
   dxnR0vEIyMt+lxmJV5Dy+RNfs7PsxLymONxnjR23U89CWX7iFG88RvqYn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="340080865"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="340080865"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 03:31:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="576457390"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2022 03:31:52 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPjgV-0000Rf-1a; Thu, 03 Mar 2022 11:31:51 +0000
Date:   Thu, 3 Mar 2022 19:31:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oliver Glitta <glittao@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [vbabka:slub-stackdepot-v2 3/6] slub.c:undefined reference to
 `stack_depot_want_early_init'
Message-ID: <202203031903.ZpsZPgv7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git slub-stackdepot-v2
head:   81001c54e58478cef57829b8b468f8d2865b7563
commit: 80a4eec3b671b3f834d5357d4bf0027f325606c5 [3/6] mm/slub: use stackdepot to save stack trace in objects
config: nios2-randconfig-r035-20220303 (https://download.01.org/0day-ci/archive/20220303/202203031903.ZpsZPgv7-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/commit/?id=80a4eec3b671b3f834d5357d4bf0027f325606c5
        git remote add vbabka https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git
        git fetch --no-tags vbabka slub-stackdepot-v2
        git checkout 80a4eec3b671b3f834d5357d4bf0027f325606c5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: mm/slub.o: in function `setup_slub_debug':
>> slub.c:(.init.text+0x1c0): undefined reference to `stack_depot_want_early_init'
>> nios2-linux-ld: slub.c:(.init.text+0x1c4): undefined reference to `stack_depot_want_early_init'
   nios2-linux-ld: slub.c:(.init.text+0x218): undefined reference to `stack_depot_want_early_init'
   nios2-linux-ld: slub.c:(.init.text+0x21c): undefined reference to `stack_depot_want_early_init'
   nios2-linux-ld: net/core/sock.o: in function `sk_destruct':
   sock.c:(.text+0x35d8): undefined reference to `__sk_defer_free_flush'
   sock.c:(.text+0x35d8): relocation truncated to fit: R_NIOS2_CALL26 against `__sk_defer_free_flush'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
