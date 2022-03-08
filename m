Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D364D2210
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiCHT4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiCHT4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:56:35 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C107249F09
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646769338; x=1678305338;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=77smXlLC49hopeE5Uo+Imc0RIdaT3/W3JX9z5ObQpiM=;
  b=h9V6fU1Ki1edJ2JA8BxwmG10zBdHKBehAo9BXFydx5vPtIDRfLu2/81q
   ddZodtlr+6Tb0CATOo9UokHU3k56Q+Ac3gT5r5ocyJT928NEWOgLNPAVM
   v1OdF8+HuhDEO5a3mMTsj9vIfoojqZXVOLfDKQbWzvtVdu8jx/Sw+6KEv
   PnZt6X1R1DyyFQN5ND9vpr4BB4Wp8DTvF4ywzSWAhDHUhjJ57CFfzEhTU
   aIgP4YcHHUn22YmQeGG8xANbwbZdmQoma47BSmjoT4R0d2Kk8zQ4hn4kf
   0Mwdn89i6wbQ13aolbMbp/SFRGHwzN/GEspeqap2fYaH9ld8BRclw2c3l
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254738735"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="254738735"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 11:55:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="495582417"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 11:55:37 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRfvk-0001tW-Eg; Tue, 08 Mar 2022 19:55:36 +0000
Date:   Wed, 9 Mar 2022 03:55:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [hverkuil-media-tree:cec 333/345] undefined reference to `__divdi3'
Message-ID: <202203090312.NuviVLvG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git cec
head:   5a31a11af68144fdafb493ac9c2e7e9af5fc4ba8
commit: 42356ecbdb69e49cffd0c1df791280965f9f90e1 [333/345] media: amphion: add amphion vpu entry in Kconfig and Makefile
config: microblaze-allyesconfig (https://download.01.org/0day-ci/archive/20220309/202203090312.NuviVLvG-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree cec
        git checkout 42356ecbdb69e49cffd0c1df791280965f9f90e1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/media/platform/amphion/vpu_windsor.o: in function `vpu_windsor_pack_cmd':
>> (.text+0x45c): undefined reference to `__divdi3'
>> microblaze-linux-ld: (.text+0x47c): undefined reference to `__moddi3'
   microblaze-linux-ld: drivers/media/platform/amphion/vpu_malone.o: in function `vpu_malone_pack_cmd':
   (.text+0x1ad4): undefined reference to `__divdi3'
   microblaze-linux-ld: (.text+0x1af8): undefined reference to `__moddi3'
   microblaze-linux-ld: drivers/media/platform/amphion/vdec.o: in function `vdec_get_debug_info':
>> vdec.o:(.text+0x1a00): undefined reference to `__moddi3'
>> microblaze-linux-ld: vdec.o:(.text+0x1a24): undefined reference to `__divdi3'
>> microblaze-linux-ld: vdec.o:(.text+0x1a48): undefined reference to `__moddi3'
   microblaze-linux-ld: vdec.o:(.text+0x1a74): undefined reference to `__divdi3'
   microblaze-linux-ld: vdec.o:(.text+0x1aa0): undefined reference to `__moddi3'
   microblaze-linux-ld: vdec.o:(.text+0x1acc): undefined reference to `__divdi3'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
