Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E2A53712D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiE2Nxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 09:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiE2Nxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 09:53:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9339941AA
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653832426; x=1685368426;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aGBgP8tDbnc6aAEiSQ3bQiIw0LtgJh2PFC7BqiV4NSA=;
  b=aLrVkxT2NBQKpemSGPfLNHMKL65MUeizTjzccQLQgOqj7Pv1VaVebz8t
   NQsItp8DjnWEIS4Uxe6Qdv4Ys9av0WVyCwLg7XTKrcONjWqWzodP26OIm
   HjspJ0eZt8PyZMWc3+gxQKugTqbQ9thkDYJP0ffAfhqM87k5RyyXv2m/Z
   ZSOdr3uDSGhC4QMn+XnR+hyOA6lwQfbTmaknwdFoXjFl5t5QWPuruzMtU
   19lvRXmgAhQISax3SKy7yoQkUuhmKGoOIcR99oL7QUm0F6ogKt79PMIYU
   KO/o61QH10BYrwlZ5Fw0J9mXvnCOCeTHQBTFSFDIVANArqPzM2Gh0fFbF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="337842083"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="337842083"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 06:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="632286197"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 May 2022 06:53:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvJMV-00013g-Hn;
        Sun, 29 May 2022 13:53:43 +0000
Date:   Sun, 29 May 2022 21:53:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/8xx/cpm1.c:70:24: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202205292154.Fxq4jfGk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   664a393a2663a0f62fc1b18157ccae33dcdbb8c8
commit: acf9e575d889eb8806be2c8451e7ad12bf444b50 powerpc/8xx: Move CPM interrupt controller into a dedicated file
date:   3 weeks ago
config: powerpc-randconfig-s032-20220529 (https://download.01.org/0day-ci/archive/20220529/202205292154.Fxq4jfGk-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=acf9e575d889eb8806be2c8451e7ad12bf444b50
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout acf9e575d889eb8806be2c8451e7ad12bf444b50
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/8xx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/platforms/8xx/cpm1.c:70:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct comm_proc [usertype] *cp @@     got struct comm_proc [noderef] [usertype] __iomem *[addressable] [assigned] [toplevel] cpmp @@
   arch/powerpc/platforms/8xx/cpm1.c:70:24: sparse:     expected struct comm_proc [usertype] *cp
   arch/powerpc/platforms/8xx/cpm1.c:70:24: sparse:     got struct comm_proc [noderef] [usertype] __iomem *[addressable] [assigned] [toplevel] cpmp
>> arch/powerpc/platforms/8xx/cpm1.c:172:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:172:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:172:17: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/platforms/8xx/cpm1.c:172:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:172:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:172:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:174:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:174:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:174:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:174:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:174:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:174:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:177:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:177:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:177:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:177:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:177:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:177:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:179:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:179:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:179:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:179:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:179:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:179:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:190:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:190:25: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:190:25: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:190:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:190:25: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:190:25: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:192:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:192:25: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:192:25: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:192:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:192:25: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:192:25: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/platforms/8xx/cpm1.c:212:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:212:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:212:17: sparse:     got restricted __be16 [noderef] __iomem *
>> arch/powerpc/platforms/8xx/cpm1.c:212:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:212:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:212:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:214:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:214:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:214:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:214:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:214:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:214:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:217:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:217:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:217:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:217:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:217:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:217:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:219:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:219:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:219:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:219:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:219:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:219:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:223:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:223:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:223:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:223:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:223:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:223:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:225:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:225:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:225:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:225:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:225:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:225:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:229:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:229:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:229:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:229:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:229:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:229:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:231:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:231:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:231:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:231:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:231:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:231:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:233:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:233:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:233:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:233:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:233:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:233:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:235:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:235:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:235:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:235:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:235:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:235:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:398:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:398:36: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:398:36: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:409:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:409:28: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:409:28: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:423:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:423:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:423:19: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:458:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:458:9: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:458:9: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:458:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:458:9: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:458:9: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:476:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:476:9: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:476:9: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:476:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:476:9: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:476:9: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:535:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:535:36: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:535:36: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:546:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:546:28: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:546:28: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:560:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:560:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:560:19: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:587:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:587:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:587:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:587:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:587:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:587:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:605:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:605:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:605:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:605:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:605:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:605:9: sparse:     got restricted __be32 [noderef] __iomem *

vim +70 arch/powerpc/platforms/8xx/cpm1.c

f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   68  
fb533d0c5a9783e arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14   69  #ifdef CONFIG_UCODE_PATCH
fb533d0c5a9783e arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  @70  	cpm_load_patch(cpmp);
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   71  #endif
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   72  
4128a89ac80d371 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14   73  	/*
4128a89ac80d371 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14   74  	 * Set SDMA Bus Request priority 5.
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   75  	 * On 860T, this also enables FEC priority 6.  I am not sure
25985edcedea639 arch/powerpc/sysdev/cpm1.c        Lucas De Marchi  2011-03-30   76  	 * this is what we really want for some applications, but the
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   77  	 * manual recommends it.
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   78  	 * Bit 25, FAM can also be set to use FEC aggressive mode (860T).
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   79  	 */
fb533d0c5a9783e arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14   80  	siu_conf = immr_map(im_siu_conf);
501ea76687ef16a arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2016-02-04   81  	if ((mfspr(SPRN_IMMR) & 0xffff) == 0x0900) /* MPC885 */
501ea76687ef16a arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2016-02-04   82  		out_be32(&siu_conf->sc_sdcr, 0x40);
501ea76687ef16a arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2016-02-04   83  	else
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   84  		out_be32(&siu_conf->sc_sdcr, 1);
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   85  	immr_unmap(siu_conf);
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   86  }
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   87  
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26   88  static DEFINE_SPINLOCK(cmd_lock);
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26   89  
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26   90  #define MAX_CR_CMD_LOOPS        10000
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26   91  
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26   92  int cpm_command(u32 command, u8 opcode)
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26   93  {
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26   94  	int i, ret;
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26   95  	unsigned long flags;
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26   96  
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26   97  	if (command & 0xffffff0f)
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26   98  		return -EINVAL;
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26   99  
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  100  	spin_lock_irqsave(&cmd_lock, flags);
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  101  
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  102  	ret = 0;
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  103  	out_be16(&cpmp->cp_cpcr, command | CPM_CR_FLG | (opcode << 8));
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  104  	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  105  		if ((in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG) == 0)
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  106  			goto out;
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  107  
e48b1b452ff6302 arch/powerpc/sysdev/cpm1.c        Harvey Harrison  2008-03-29  108  	printk(KERN_ERR "%s(): Not able to issue CPM command\n", __func__);
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  109  	ret = -EIO;
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  110  out:
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  111  	spin_unlock_irqrestore(&cmd_lock, flags);
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  112  	return ret;
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  113  }
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  114  EXPORT_SYMBOL(cpm_command);
362f9b6fa8c9670 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  115  
4128a89ac80d371 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  116  /*
4128a89ac80d371 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  117   * Set a baud rate generator.  This needs lots of work.  There are
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  118   * four BRGs, any of which can be wired to any channel.
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  119   * The internal baud rate clock is the system clock divided by 16.
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  120   * This assumes the baudrate is 16x oversampled by the uart.
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  121   */
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  122  #define BRG_INT_CLK		(get_brgfreq())
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  123  #define BRG_UART_CLK		(BRG_INT_CLK/16)
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  124  #define BRG_UART_CLK_DIV16	(BRG_UART_CLK/16)
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  125  
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  126  void
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  127  cpm_setbrg(uint brg, uint rate)
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  128  {
fb533d0c5a9783e arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  129  	u32 __iomem *bp;
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  130  
4128a89ac80d371 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  131  	/* This is good enough to get SMCs running..... */
fb533d0c5a9783e arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  132  	bp = &cpmp->cp_brgc1;
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  133  	bp += brg;
4128a89ac80d371 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  134  	/*
4128a89ac80d371 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  135  	 * The BRG has a 12-bit counter.  For really slow baud rates (or
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  136  	 * really fast processors), we may have to further divide by 16.
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  137  	 */
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  138  	if (((BRG_UART_CLK / rate) - 1) < 4096)
fb533d0c5a9783e arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  139  		out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN);
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  140  	else
fb533d0c5a9783e arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  141  		out_be32(bp, (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
fb533d0c5a9783e arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  142  			      CPM_BRG_EN | CPM_BRG_DIV16);
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  143  }
22f8e625ebabd7e arch/powerpc/platforms/8xx/cpm1.c Randy Dunlap     2021-01-21  144  EXPORT_SYMBOL(cpm_setbrg);
f2a0bd3753dad7e arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  145  
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  146  struct cpm_ioport16 {
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  147  	__be16 dir, par, odr_sor, dat, intr;
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  148  	__be16 res[3];
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  149  };
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  150  
dc2380ec8572fcd arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  151  struct cpm_ioport32b {
dc2380ec8572fcd arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  152  	__be32 dir, par, odr, dat;
dc2380ec8572fcd arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  153  };
dc2380ec8572fcd arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  154  
dc2380ec8572fcd arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  155  struct cpm_ioport32e {
dc2380ec8572fcd arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  156  	__be32 dir, par, sor, odr, dat;
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  157  };
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  158  
132f92fdc42782f arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-09-12  159  static void __init cpm1_set_pin32(int port, int pin, int flags)
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  160  {
dc2380ec8572fcd arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  161  	struct cpm_ioport32e __iomem *iop;
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  162  	pin = 1 << (31 - pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  163  
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  164  	if (port == CPM_PORTB)
dc2380ec8572fcd arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  165  		iop = (struct cpm_ioport32e __iomem *)
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  166  		      &mpc8xx_immr->im_cpm.cp_pbdir;
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  167  	else
dc2380ec8572fcd arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  168  		iop = (struct cpm_ioport32e __iomem *)
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  169  		      &mpc8xx_immr->im_cpm.cp_pedir;
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  170  
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  171  	if (flags & CPM_PIN_OUTPUT)
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16 @172  		setbits32(&iop->dir, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  173  	else
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  174  		clrbits32(&iop->dir, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  175  
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  176  	if (!(flags & CPM_PIN_GPIO))
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  177  		setbits32(&iop->par, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  178  	else
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  179  		clrbits32(&iop->par, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  180  
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  181  	if (port == CPM_PORTB) {
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  182  		if (flags & CPM_PIN_OPENDRAIN)
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  183  			setbits16(&mpc8xx_immr->im_cpm.cp_pbodr, pin);
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  184  		else
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  185  			clrbits16(&mpc8xx_immr->im_cpm.cp_pbodr, pin);
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  186  	}
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  187  
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  188  	if (port == CPM_PORTE) {
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  189  		if (flags & CPM_PIN_SECONDARY)
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16 @190  			setbits32(&iop->sor, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  191  		else
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16 @192  			clrbits32(&iop->sor, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  193  
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  194  		if (flags & CPM_PIN_OPENDRAIN)
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  195  			setbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  196  		else
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  197  			clrbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  198  	}
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  199  }
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  200  
132f92fdc42782f arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-09-12  201  static void __init cpm1_set_pin16(int port, int pin, int flags)
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  202  {
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  203  	struct cpm_ioport16 __iomem *iop =
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  204  		(struct cpm_ioport16 __iomem *)&mpc8xx_immr->im_ioport;
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  205  
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  206  	pin = 1 << (15 - pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  207  
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  208  	if (port != 0)
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  209  		iop += port - 1;
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  210  
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  211  	if (flags & CPM_PIN_OUTPUT)
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16 @212  		setbits16(&iop->dir, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  213  	else
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  214  		clrbits16(&iop->dir, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  215  
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  216  	if (!(flags & CPM_PIN_GPIO))
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  217  		setbits16(&iop->par, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  218  	else
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  219  		clrbits16(&iop->par, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  220  
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  221  	if (port == CPM_PORTA) {
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  222  		if (flags & CPM_PIN_OPENDRAIN)
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  223  			setbits16(&iop->odr_sor, pin);
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  224  		else
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  225  			clrbits16(&iop->odr_sor, pin);
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  226  	}
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  227  	if (port == CPM_PORTC) {
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  228  		if (flags & CPM_PIN_SECONDARY)
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  229  			setbits16(&iop->odr_sor, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  230  		else
721c0c8af1a2794 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  231  			clrbits16(&iop->odr_sor, pin);
726bd223105c04f arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2017-05-01  232  		if (flags & CPM_PIN_FALLEDGE)
726bd223105c04f arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2017-05-01  233  			setbits16(&iop->intr, pin);
726bd223105c04f arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2017-05-01  234  		else
726bd223105c04f arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2017-05-01  235  			clrbits16(&iop->intr, pin);
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  236  	}
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  237  }
663edbd2640447d arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  238  

:::::: The code at line 70 was first introduced by commit
:::::: fb533d0c5a9783ecafa9a177bace6384c47282a9 [POWERPC] 8xx: Infrastructure code cleanup.

:::::: TO: Scott Wood <scottwood@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
