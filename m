Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7D64EC63D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346648AbiC3OOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346638AbiC3ON6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:13:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E951CABC9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648649533; x=1680185533;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CIneZa8Evt4lK6ZORksB2jxKsUba2l8PMMBj4EMbv1Q=;
  b=OnIiF87VrN0u1iktmIsq2z9hEywJFMfA6+w3rGKO0GOP3Z2P9/TI70mD
   iMHwqIsWu9yu7DeDIopkIlDFovC89FwRBfaWbz3+99GOxTKdk7kLuzB7h
   2NRwO4yvHexE/b5olPCGXspgqBIKTH6HTSbfYb97tT9QxwUpYDj+t3/7E
   zvnuoMlwPz+8mWa+7tdSOP1o8qdE1c3MNTx3kBY1sjkKQVQmyyfpn7Io8
   C4wZzAHwLPbmONC/UGqzsRZhIepMMFN6YVYfqWlM57Lt1cVblKkgsA2vE
   LJXggTOm1UCGTJ+xdrYThfdQff3p6cR52FLBD+qbPPDy9tl1yCtt5G5Db
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="257130717"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="257130717"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:12:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="586012184"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2022 07:12:11 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZZ3O-00003e-Ad;
        Wed, 30 Mar 2022 14:12:06 +0000
Date:   Wed, 30 Mar 2022 22:11:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:arm64/linux/devel/kmalloc-minalign 8/11]
 mm/slab_common.c:841:21: warning: no previous prototype for
 'arch_kmalloc_minalign'
Message-ID: <202203302227.FiPHL6gt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block arm64/linux/devel/kmalloc-minalign
head:   2810d5be00a60d5996cd955c2485c17ef1e1e7af
commit: 422900daeb39a7d134f9ea3b8f04575dbf00b68a [8/11] mm/slab: Allow dynamic kmalloc() minimum alignment
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220330/202203302227.FiPHL6gt-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/422900daeb39a7d134f9ea3b8f04575dbf00b68a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block arm64/linux/devel/kmalloc-minalign
        git checkout 422900daeb39a7d134f9ea3b8f04575dbf00b68a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/slab_common.c:841:21: warning: no previous prototype for 'arch_kmalloc_minalign' [-Wmissing-prototypes]
     841 | unsigned int __weak arch_kmalloc_minalign(void)
         |                     ^~~~~~~~~~~~~~~~~~~~~


vim +/arch_kmalloc_minalign +841 mm/slab_common.c

   840	
 > 841	unsigned int __weak arch_kmalloc_minalign(void)
   842	{
   843		return ARCH_KMALLOC_MINALIGN;
   844	}
   845	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
