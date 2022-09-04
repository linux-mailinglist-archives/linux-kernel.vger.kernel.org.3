Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5715AC221
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 05:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiIDDJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 23:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIDDJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 23:09:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF9A765D
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 20:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662260967; x=1693796967;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jkMdshiKs9XrIuJlcAFkAPcMEg3w2+8GzDrvRzklfJ4=;
  b=Hdh4D3N4FjDzkPOvK4vZna6T1BnPt8Id4eRZZpzkOvKEe3ZEV0RIkDP7
   D2NKu3w3GofLZA63mF/HbJ8wuArwCA14s+bsunzMQDJ4EeXwTA5rAE3fs
   HMiggM34g1Eq/XAtIDm+fxNvs4tUCukTQmPO7lO3HEYCHZTSLC4eGHcfq
   u8pGBRUGYd/Z20LDLxb+1esmkqtQBLR3805MQNfYZHh7c3M6/gAyTseKX
   J0fit6ABsE6asWDyyLtLw4Iw/BpUFm1vlpac2NgHmvYJZXrYZFiTPRzPs
   4K650voTFgbOnIOqhn7mAz6VhAZiyC6qilFiZBpfJSHkHzUvrhNlaUB3k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="297504251"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="297504251"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 20:09:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="590503626"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 03 Sep 2022 20:09:25 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUg0j-0002UH-0j;
        Sun, 04 Sep 2022 03:09:25 +0000
Date:   Sun, 4 Sep 2022 11:08:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpoimboe:s390 2/2] make[2]: *** No rule to make target 'relocs'.
Message-ID: <202209041142.KeGy3btD-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git s390
head:   0784ee2ec1b58527a764182f48cf5fdf4f64f12c
commit: 0784ee2ec1b58527a764182f48cf5fdf4f64f12c [2/2] s390: Compile relocatable kernel without -fPIE
config: s390-randconfig-r006-20220904 (https://download.01.org/0day-ci/archive/20220904/202209041142.KeGy3btD-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=0784ee2ec1b58527a764182f48cf5fdf4f64f12c
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe s390
        git checkout 0784ee2ec1b58527a764182f48cf5fdf4f64f12c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> make[2]: *** No rule to make target 'relocs'.
   make[1]: *** [arch/s390/Makefile:154: archprepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
