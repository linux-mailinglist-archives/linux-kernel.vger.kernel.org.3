Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F9D4DA6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352816AbiCPAcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352807AbiCPAcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:32:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF3454F9C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647390686; x=1678926686;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ozBhxSvZRl6et6M2hZTigDrb+Z4k/dQSvmlnqJrd+4c=;
  b=grWoI/Zt5KEcUdIvEeEejuUePmRMYvxYZseeTXwr6Pxd/G09DhFBFXTh
   EqHAr7zFQ4+UcT3yQYbgeSdKMWHC0rU04fevJMW9Pl04kqzZ4v9sNmKcg
   v4//MrSm+tCgABaHTyUZitr5JFjh69XxtsKjPsFH/DCo8VPTosZTtVG1J
   kz/vkW8Jcmw2y+0aaKhcv4iYJmlQkl/q8Pqnadg652kpZqJMKyUkXeXNX
   cgtik6dcqqiXbtTwfnbXyudYAmiPxH5bcEoGBZ59LR1IMFCPodZv+1rPh
   eCOe7Uy61ikeOlTBrwJfiQdu92SAtz0rlSGm7TRZoteBwIhMwHBNsUDbX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255284210"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="255284210"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="516099900"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2022 17:31:23 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUHZT-000BhU-3o; Wed, 16 Mar 2022 00:31:23 +0000
Date:   Wed, 16 Mar 2022 08:30:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Alistair Strachan <astrachan@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-q-release
 5202/7636] ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line
 argument '-stack-alignment=8'.  Try: 'ld.lld --help'
Message-ID: <202203160848.kydLIYip-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-q-release
head:   1a3500dc59324a85c20f025cfa6485a1a0debbdf
commit: 205cde74877d624ef7d24a6692e6e9337b19a541 [5202/7636] ANDROID: x86: add support for CONFIG_LTO_CLANG
config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220316/202203160848.kydLIYip-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/205cde74877d624ef7d24a6692e6e9337b19a541
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-q-release
        git checkout 205cde74877d624ef7d24a6692e6e9337b19a541
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument '-stack-alignment=8'.  Try: 'ld.lld --help'
   ld.lld: Did you mean '--stackrealign=8'?
--
   lib/irq_regs.o: no symbols
>> ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument '-stack-alignment=8'.  Try: 'ld.lld --help'
   ld.lld: Did you mean '--stackrealign=8'?

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
