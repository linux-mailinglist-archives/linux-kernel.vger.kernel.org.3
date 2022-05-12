Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44664525169
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356033AbiELPij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349137AbiELPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:38:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B739525C2A8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652369916; x=1683905916;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+C+zcQ9OMsRKzfxB09v5LYFDyAjdAYn83xmW14cew7Y=;
  b=cY75drnqwgOWz3yXBUOhok/yZI5coV+KMl3APqIwOsyUQy0Wfz5N3Iyi
   QCMQtclB16AGjQUi8GVJ/V2ibneH+AxQNSBPndaWcTBq0OfhU18/ch5aw
   4myzp5DmP8ZFJB72gcyt9xtfXPklNiI43cqyh3KgrmKYOTlfxjGVxHo9e
   evnH/IwW1PVwL2BPz9yoVKcGhtAnszHP9niE/SMJGX9nGIGajYijPvsVO
   15PfZqpipGwzmv6RadFOXsAYIXKvlPtUVbg05ClOGQXt50CrbNrQf0XTc
   q7T/FGWm0sJCWeldKs0KJu3EfybbSQawwMGfDV4XQuapdovynbwgaXTU1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269974072"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="269974072"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 08:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="553814387"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 May 2022 08:38:33 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npAtc-000Kd0-SB;
        Thu, 12 May 2022 15:38:32 +0000
Date:   Thu, 12 May 2022 23:38:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Wei Fu <wefu@redhat.com>,
        Liu Shaohua <liush@allwinnertech.com>,
        Guo Ren <guoren@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Subject: [ammarfaizi2-block:palmer/linux/riscv-d1 9/12]
 arch/riscv/kernel/cpufeature.c:292:6: warning: variable 'cpu_apply_feature'
 set but not used
Message-ID: <202205122310.HMWyrLx7-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-d1
head:   a35707c3d850dda0ceefb75b1b3bd191921d5765
commit: ff689fd21cb13098305bae3f8d0c0065df2e2fc1 [9/12] riscv: add RISC-V Svpbmt extension support
config: riscv-randconfig-r033-20220512 (https://download.01.org/0day-ci/archive/20220512/202205122310.HMWyrLx7-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9519dacab7b8afd537811fc2abaceb4d14f4e16a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/ff689fd21cb13098305bae3f8d0c0065df2e2fc1
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-d1
        git checkout ff689fd21cb13098305bae3f8d0c0065df2e2fc1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/cpufeature.c:292:6: warning: variable 'cpu_apply_feature' set but not used [-Wunused-but-set-variable]
           u32 cpu_apply_feature = 0;
               ^
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   1 warning and 20 errors generated.


vim +/cpu_apply_feature +292 arch/riscv/kernel/cpufeature.c

   286	
   287	void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
   288							  struct alt_entry *end,
   289							  unsigned int stage)
   290	{
   291		u32 cpu_req_feature = cpufeature_probe(stage);
 > 292		u32 cpu_apply_feature = 0;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
