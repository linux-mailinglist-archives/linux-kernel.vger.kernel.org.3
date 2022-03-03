Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24274CC3C5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiCCRb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiCCRby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:31:54 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BC8199D51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646328666; x=1677864666;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mm7XANStyODIDUYY+dr81LRMNJv8scZwWgW2kxdMHi0=;
  b=Kmf6FUYmBEbJDnBDRpuhcW8iO45LA/Jb9vgYb7EiM4krLAcR2SOiGUxL
   xPNHFND2s8NPCAlOdvPegwXdPhqdJc/Ne/naSi2j9kbdxpv9Qhf4WzUKl
   /oJXmhfy3vLXoy/Hk8G7LZowDSspYkiKQCKZlS8H9pPzw8SVZGkzbcs3c
   M3cOAWiHqoU3KuEIb7AgJUal/rP6kK/XmNUjJxvujY5hwFHBhk6a6+CGK
   QgjtcoMDfVKIOXX4jnMACUG+Dy+6mHQ8lzB1mEVhyFm3sSGnYA49WiGIO
   o4LT2yreURwgF0k4/xJh64wgJoOtHkaRX3eKM6YfK6nalcL1V0V2gZc1G
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="316965778"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="316965778"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 09:31:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="576574736"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2022 09:31:05 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPpI8-0000mX-Bv; Thu, 03 Mar 2022 17:31:04 +0000
Date:   Fri, 4 Mar 2022 01:30:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oliver Glitta <glittao@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [vbabka:slub-stackdepot-v2 3/6] m68k-linux-ld: slub.c:undefined
 reference to `stack_depot_want_early_init'
Message-ID: <202203040140.4yvMvHSM-lkp@intel.com>
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
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220304/202203040140.4yvMvHSM-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/commit/?id=80a4eec3b671b3f834d5357d4bf0027f325606c5
        git remote add vbabka https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git
        git fetch --no-tags vbabka slub-stackdepot-v2
        git checkout 80a4eec3b671b3f834d5357d4bf0027f325606c5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: mm/slub.o: in function `setup_slub_debug':
   slub.c:(.init.text+0x126): undefined reference to `stack_depot_want_early_init'
>> m68k-linux-ld: slub.c:(.init.text+0x164): undefined reference to `stack_depot_want_early_init'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
