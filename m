Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473865B266A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiIHTGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIHTG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:06:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C82C04F0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662663988; x=1694199988;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MaVMUK1E93E4cSrTgUTxfm01nAflBWnMFxGPTqgGbW4=;
  b=Rv9ZseM9hrGRSHVdb8WRZdpgOiPD2mxce4zKFthWoWbKtIWKtCA3C3wT
   zamMSfKyy/2SpJa5N3JvXaO/+aUv7dPIskPfuJDG8Ifj65Y8IPE8ahyr0
   dFpNE5VoPONcqAOcD5+a8PPeirtnsFXJNQHEriXFFxNxWIfhakjYq3iiR
   yRmP2gfwAVlLjS+8OKnWpDsAFQcl9zaGf6gy8FXIr/BimntEKUFO+JxWM
   QnJ+qLqtMvao70PxPxUWfF5rsRuFJcNrSGxfOACpNLIg2cllI9iCg65Ek
   GloHcUwxzgYrJZk7mnYw5EG2iM0r7coOkVfsT1IM9SfOLYP2Z9RKn/859
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="359028298"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="359028298"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 12:06:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="704129662"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Sep 2022 12:06:27 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWMr4-0000Ez-1E;
        Thu, 08 Sep 2022 19:06:26 +0000
Date:   Fri, 9 Sep 2022 03:06:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:virt-to-pfn-v6.0-rc1 21/24]
 ld:arch/powerpc/kernel/vdso/vdso32.lds:242: syntax error
Message-ID: <202209090232.4oK6VL1h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git virt-to-pfn-v6.0-rc1
head:   bc69ecf9b2a3d1f9699edab614580d6a6e090407
commit: 0c2ea3eeededb1fbf9b27bf96c2f636e660e9bdb [21/24] powerpc: Make virt_to_pfn() a static inline
config: powerpc-eiger_defconfig (https://download.01.org/0day-ci/archive/20220909/202209090232.4oK6VL1h-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=0c2ea3eeededb1fbf9b27bf96c2f636e660e9bdb
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator virt-to-pfn-v6.0-rc1
        git checkout 0c2ea3eeededb1fbf9b27bf96c2f636e660e9bdb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld:arch/powerpc/kernel/vdso/vdso32.lds:242: syntax error
   collect2: error: ld returned 1 exit status
   make[2]: *** [arch/powerpc/kernel/vdso/Makefile:66: arch/powerpc/kernel/vdso/vdso32.so.dbg] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/powerpc/Makefile:392: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
