Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234D8537440
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 07:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiE3FSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 01:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiE3FSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 01:18:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C91012AEA
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 22:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653887921; x=1685423921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0a/4uoP4JcOFCvsthsMIxeg4XlUrVnNXIKAS3SNDq2A=;
  b=BAEtF198wIaf1J4lVijAgn5E6XdlKHwCZnX1GuV31euE/DYkIcHMTUqT
   R34Gxny2eD4hpC/LWGdMezeP+wpajQPdNIGNptraiJ1ZcPvMviU9O0PZl
   SIvHMM+suf/xaqFENRYGxbFbWwEzreiNZhehM2HL5c6g7/3zGnNXsrKVt
   VJ9Pn6K8MF1HFXqo7QF/aDTVtp2XUJ82v7PXurtoRJrut61O7T5zg6Xc9
   ARbsrH70HMonalIok4xGFgxb2WcNQdSDFNu4pSyJ4+QKv0Tmth/PuG4vt
   wd/PVkRKn5BuOd2O3DGmc7qHEakHNN03CUqqPhCMk5B98Kda2UKxe0737
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="255383852"
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="255383852"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 22:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="706004498"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 May 2022 22:18:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvXna-0001VG-EG;
        Mon, 30 May 2022 05:18:38 +0000
Date:   Mon, 30 May 2022 13:18:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: drivers/staging/media/hantro/hantro_g2_hevc_dec.c:536:5: warning:
 stack frame size (1232) exceeds limit (1024) in 'hantro_g2_hevc_dec_run'
Message-ID: <202205301302.qQvZPPBF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b00ed48bb0a7c295facf9036135a573a5cdbe7de
commit: 8341dcfbd8dda98a3b2836a421016f7d88e35b1c riscv: Enable Undefined Behavior Sanitizer UBSAN
date:   9 months ago
config: riscv-randconfig-r014-20220530 (https://download.01.org/0day-ci/archive/20220530/202205301302.qQvZPPBF-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0776c48f9b7e69fa447bee57c7c0985caa856be9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8341dcfbd8dda98a3b2836a421016f7d88e35b1c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8341dcfbd8dda98a3b2836a421016f7d88e35b1c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/staging/media/hantro/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/media/hantro/hantro_g2_hevc_dec.c:536:5: warning: stack frame size (1232) exceeds limit (1024) in 'hantro_g2_hevc_dec_run' [-Wframe-larger-than]
   int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx)
       ^
   1 warning generated.


vim +/hantro_g2_hevc_dec_run +536 drivers/staging/media/hantro/hantro_g2_hevc_dec.c

cb5dd5a0fa518d Benjamin Gaignard 2021-06-03  535  
cb5dd5a0fa518d Benjamin Gaignard 2021-06-03 @536  int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx)

:::::: The code at line 536 was first introduced by commit
:::::: cb5dd5a0fa518dff14ff2b90837c3c8f98f4dd5c media: hantro: Introduce G2/HEVC decoder

:::::: TO: Benjamin Gaignard <benjamin.gaignard@collabora.com>
:::::: CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
