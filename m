Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3F6591D5E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 02:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbiHNAwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 20:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiHNAwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 20:52:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D313E7C763;
        Sat, 13 Aug 2022 17:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660438357; x=1691974357;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t/Kr7vbAOxroJS0nxXYzdXzdU5QWoRsKPlUj2y09cGQ=;
  b=D0yTTFtVzTAVCEoWf36RBAiN4wtyt/ooGDSW4g+pxu4On+WYrJur/xyQ
   CUQ7FlA4dA1DzSMq5QcNX5ZL3yXCMd0ZgkUvfG3o9+cH2ZDJGXqFmrCGH
   e5NJj5rlhAU0Macj88uIG1QsefIQHe7dIK7yfQAiyeDl9bmAs8OuOcaFX
   l8nKykf3DQaO3bWteESCwymSLy1GKCfBp7PyXwbGivxicYYiZQTQsks7f
   AQGcLtzdHkHYdEVphT3x0Zsng+ociXcHffeVluPUBZA2iltKidf69oNh/
   FtKdk53Vgkda21jELlvrH1v0DNDxfP15kHhHFuY83gpmGc6XVhDpjiyOO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="355795135"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="355795135"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 17:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="602845114"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Aug 2022 17:52:35 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN1rn-0002FT-0X;
        Sun, 14 Aug 2022 00:52:35 +0000
Date:   Sun, 14 Aug 2022 08:52:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:1175:34:
 warning: unused variable 'c8sectpfe_match'
Message-ID: <202208140854.Q1rRgjPy-lkp@intel.com>
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

Hi Mauro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f6eb0fed6a3957c0b93e3a00c1ffaad84d4ffc31
commit: e7b8153e2a4f0c9c8d1450aa7328d54ea64fe8b2 media: platform: place stm32/ and sti/ under st/ dir
date:   5 months ago
config: arm-buildonly-randconfig-r006-20220814 (https://download.01.org/0day-ci/archive/20220814/202208140854.Q1rRgjPy-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 3329cec2f79185bafd678f310fafadba2a8c76d2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e7b8153e2a4f0c9c8d1450aa7328d54ea64fe8b2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e7b8153e2a4f0c9c8d1450aa7328d54ea64fe8b2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/media/platform/st/sti/c8sectpfe/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:18:
   include/uapi/linux/dvb/frontend.h:805:2: warning: field  within 'struct dtv_stats' is less aligned than 'union dtv_stats::(anonymous at include/uapi/linux/dvb/frontend.h:805:2)' and is usually due to 'struct dtv_stats' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
>> drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:1175:34: warning: unused variable 'c8sectpfe_match' [-Wunused-const-variable]
   static const struct of_device_id c8sectpfe_match[] = {
                                    ^
   2 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
   Selected by [y]:
   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]


vim +/c8sectpfe_match +1175 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c

c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1174  
c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30 @1175  static const struct of_device_id c8sectpfe_match[] = {
c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1176  	{ .compatible = "st,stih407-c8sectpfe" },
c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1177  	{ /* sentinel */ },
c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1178  };
c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1179  MODULE_DEVICE_TABLE(of, c8sectpfe_match);
c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1180  

:::::: The code at line 1175 was first introduced by commit
:::::: c5f5d0f99794cfb675ecacfe37a1b33b352b9752 [media] c8sectpfe: STiH407/10 Linux DVB demux support

:::::: TO: Peter Griffin <peter.griffin@linaro.org>
:::::: CC: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
