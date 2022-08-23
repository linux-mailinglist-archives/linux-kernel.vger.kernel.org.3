Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F17659CE8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbiHWC2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbiHWC23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:28:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A08BC9F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661221705; x=1692757705;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FNgQhLJPllCGPYZrPfGgqJ4GjILt0gZKxOjRsHwUco4=;
  b=gkeVe6uguZJJP4plKqXUnL3mdhi4sy0KtBqC+igM01GM5qoS/ELwx+yd
   QN0dHaZhxPOOCuuiyIRjfOiPRbfFHsALkQEK3o1ffxdtRVfYrJzCkJcDd
   oyS6j3OD9PlAe+Et8DwPiYVQqgQwHlQ1nKqWOQtAcPMPGPVgo4iC2zyBc
   imbkM+2lFD3RdSw0AT8bKUGYyflj9l3/NqJJOqV474z5rgaUwJ3DPDCEl
   gy6JCQN/uXdjB/D5S6fzpqCzTTAgA5WxMTgdet/YeG26kWUcentAaCzIe
   cJeKmnsAMBokiYRvpV6t369f+N3kDRnmOpFLPF7egCo/6jGiTQ9cBmN84
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="291128650"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="291128650"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 19:28:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="559988733"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Aug 2022 19:28:24 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQJeR-00013F-1y;
        Tue, 23 Aug 2022 02:28:23 +0000
Date:   Tue, 23 Aug 2022 10:27:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:arm64/alternatives/rework 10/12]
 arch/arm64/kernel/alternative.c:269:14: warning: no previous prototype for
 function 'patch_apply_nops'
Message-ID: <202208231008.mwF7HrQy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/alternatives/rework
head:   c6f1e900bb0e1c5932f9995feaf4acb70cf6f62e
commit: f1665fd81160e18d4c71f4edcfd25c41e248fb67 [10/12] HACK: nops
config: arm64-buildonly-randconfig-r005-20220822 (https://download.01.org/0day-ci/archive/20220823/202208231008.mwF7HrQy-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project abce7acebd4c06c977bc4bd79170697f1122bc5e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=f1665fd81160e18d4c71f4edcfd25c41e248fb67
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/alternatives/rework
        git checkout f1665fd81160e18d4c71f4edcfd25c41e248fb67
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/alternative.c:269:14: warning: no previous prototype for function 'patch_apply_nops' [-Wmissing-prototypes]
   noinstr void patch_apply_nops(struct alt_instr *alt,
                ^
   arch/arm64/kernel/alternative.c:269:9: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinstr void patch_apply_nops(struct alt_instr *alt,
           ^
           static 
   1 warning generated.


vim +/patch_apply_nops +269 arch/arm64/kernel/alternative.c

   268	
 > 269	noinstr void patch_apply_nops(struct alt_instr *alt,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
