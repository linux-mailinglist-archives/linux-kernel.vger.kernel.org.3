Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F54C4EC852
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348264AbiC3PfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244592AbiC3PfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:35:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB360F9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648654395; x=1680190395;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=99A4Nmd7ECn/+N9elV+Nmgmh3RzNoBsfM0MSKCJINYE=;
  b=REqoI5VVmkoFpeJ8pVAKNaaHmZ9uPBcnVVyMlMs5uaFOSwv4SnleLysd
   VryXsM2bKujEQrCVBrikvL+4o3lEogN8Dvx3rMmXVt4oaauidqWdyN8Pf
   vAMs+gMK6k693TdmrFyl8K4NPsO4RDCzQ9Wg5ya2g6JYTmFFHWt5oe2iT
   lRhEVUtYYcUdjxMULwqlvOZTugfapwhDI8KoqKIqsrU9MXHgFfPGfHjpL
   tnS79KaFyCPLGD3/+AoVKDgHS1PQVKEHj/mNGudJlOzMbO6FUcpAE91IG
   PzVqMSpOKL314QXgpo+drLk/PUyuV1qjg09RkDM/0K+9GDFCWR7zOAhy/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259544443"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259544443"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:33:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="519722996"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2022 08:33:13 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZaJs-00008C-Uy;
        Wed, 30 Mar 2022 15:33:12 +0000
Date:   Wed, 30 Mar 2022 23:33:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:arm64/linux/devel/kmalloc-minalign 10/11]
 arch/arm64/kernel/cacheinfo.c:101:14: warning: no previous prototype for
 'arch_kmalloc_minalign'
Message-ID: <202203302330.5gG68JEu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block arm64/linux/devel/kmalloc-minalign
head:   2810d5be00a60d5996cd955c2485c17ef1e1e7af
commit: 6c3838f40cf6a9b31bbb3d78059a81ca03fb2cfc [10/11] arm64: Enable dynamic kmalloc() minimum alignment
config: arm64-randconfig-s032-20220330 (https://download.01.org/0day-ci/archive/20220330/202203302330.5gG68JEu-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/6c3838f40cf6a9b31bbb3d78059a81ca03fb2cfc
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block arm64/linux/devel/kmalloc-minalign
        git checkout 6c3838f40cf6a9b31bbb3d78059a81ca03fb2cfc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/cacheinfo.c:101:14: warning: no previous prototype for 'arch_kmalloc_minalign' [-Wmissing-prototypes]
     101 | unsigned int arch_kmalloc_minalign(void)
         |              ^~~~~~~~~~~~~~~~~~~~~


vim +/arch_kmalloc_minalign +101 arch/arm64/kernel/cacheinfo.c

   100	
 > 101	unsigned int arch_kmalloc_minalign(void)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
