Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D76751CFEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388889AbiEFEBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 00:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240837AbiEFEBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 00:01:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E5CDF08
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651809483; x=1683345483;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=irEkU5G8paE6uZmtZimquX/jqMHmSWjHyz9PxbAlS2o=;
  b=l+eTalQKFGcCXvCYZbHyvWV3p6I0VWhlzahdLLqVu5FaQhqvAET9kje+
   Y3lICaN6dK1xg6O+DyXlwmxAb1ALwT6R32yHueMqTiZKLjx9et9z1A+Hq
   Xj+OSlZ+TXRA93dEBFneOeooBu2bxZkhTpY7pwSaM/xl+7OyPPwGgsRNw
   l1Xza1jOabCoDh4BR6hfyiZyzv++FUgPfeH7vto/UBTVF/LttMQ9VK7Fh
   OjzTKQD+2XjXOITJNrNi9o8xwRy3r26Lvvg8m+P88U7VgJuxWHt+numwQ
   SHgdCl0pzIHQMSgWjAcVSqK5d2TNgCVcwVrTZayY+5kH0O2OcSAO+Fp2t
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="255820874"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="255820874"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 20:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="621627073"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 May 2022 20:58:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmp6P-000D4s-0C;
        Fri, 06 May 2022 03:58:01 +0000
Date:   Fri, 6 May 2022 11:57:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [linuxppc:next-test 75/91] arch/powerpc/kernel/prom_parse.c:10:6:
 error: no previous prototype for 'of_parse_dma_window'
Message-ID: <202205061125.ClTxwfOg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/linuxppc/linux next-test
head:   1d8abffc14aef88bfe1ad036084070af62f30c03
commit: 34fa52eec206db38399dc9b54f2da2eed4fdad5e [75/91] powerpc: Remove asm/prom.h from all files that don't need it
config: powerpc-mpc837x_rdb_defconfig (https://download.01.org/0day-ci/archive/20220506/202205061125.ClTxwfOg-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/prom_parse.c:10:6: error: no previous prototype for 'of_parse_dma_window' [-Werror=missing-prototypes]
      10 | void of_parse_dma_window(struct device_node *dn, const __be32 *dma_window,
         |      ^~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


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
