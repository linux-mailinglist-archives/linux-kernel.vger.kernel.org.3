Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C6F51CFD3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388798AbiEFDur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347188AbiEFDun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:50:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CF0443E1
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651808822; x=1683344822;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PuYrMj63YyMRYLmAA4R6IiGv02Cb+xhTPXskjUxQXQ8=;
  b=h5zJAOOHA2B4I8cRKzmn4431uiZbR9iAHREC/GwjmQWn6XcLu7vg2cBy
   c3eNR4277EA3RVQKJAWGNwse2BtgiWcuCUJHUBQaZ4shmnu694RYBph2x
   8ovLvm6ZhgijGRNO4q/G6uBaxRXWeHRJE7lqJusRMYEHqfkIx/Ru/luis
   iSNSl2bIVXWQN6pY3y+k5dhE9WufSVLKAAHms5BupR5C2oyOKB1r5t+ke
   Xgu1dZAb4Kx1T1ZsOvfIO+MsDdp7RQbZU2dx4n+yw/JJUtGR7FuzxjOjL
   nDvmkxsAf0PGfoRq+IkDduuyzPJ/K8ZVOCgpMRtue19twD7MGX3LXpabs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268235368"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268235368"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 20:47:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="812119207"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 May 2022 20:47:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmovj-000D40-NO;
        Fri, 06 May 2022 03:46:59 +0000
Date:   Fri, 6 May 2022 11:46:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [linuxppc:next-test 75/91] arch/powerpc/kernel/prom_parse.c:10:6:
 warning: no previous prototype for 'of_parse_dma_window'
Message-ID: <202205061138.zH9VucCL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/linuxppc/linux next-test
head:   1d8abffc14aef88bfe1ad036084070af62f30c03
commit: 34fa52eec206db38399dc9b54f2da2eed4fdad5e [75/91] powerpc: Remove asm/prom.h from all files that don't need it
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220506/202205061138.zH9VucCL-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linuxppc/linux/commit/34fa52eec206db38399dc9b54f2da2eed4fdad5e
        git remote add linuxppc https://github.com/linuxppc/linux
        git fetch --no-tags linuxppc next-test
        git checkout 34fa52eec206db38399dc9b54f2da2eed4fdad5e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/powerpc/kernel/prom_parse.c:10:6: warning: no previous prototype for 'of_parse_dma_window' [-Wmissing-prototypes]
      10 | void of_parse_dma_window(struct device_node *dn, const __be32 *dma_window,
         |      ^~~~~~~~~~~~~~~~~~~


vim +/of_parse_dma_window +10 arch/powerpc/kernel/prom_parse.c

83efafb301bc79 Andy Fleming    2006-10-16   9  
2083f681e38983 Anton Blanchard 2013-08-07 @10  void of_parse_dma_window(struct device_node *dn, const __be32 *dma_window,

:::::: The code at line 10 was first introduced by commit
:::::: 2083f681e3898394dcf5fb3285bb385e21facb9a powerpc: of_parse_dma_window should take a __be32 *dma_window

:::::: TO: Anton Blanchard <anton@samba.org>
:::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
