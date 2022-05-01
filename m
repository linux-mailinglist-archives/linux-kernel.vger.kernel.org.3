Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065F251681D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 23:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355326AbiEAVmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 17:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiEAVmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 17:42:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CCC43AD1
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 14:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651441160; x=1682977160;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yqXtKM6SAhUbEx4YQlfI9bk2W+7ys7y+aKqJhnOA0EM=;
  b=l51zx816lSv32P+K8TmvS0inG6ozdgit13l6lkQtSBEL2OnoEL8aIqF7
   1kRoPuv9v2mN2o/aPijsSmLjn5glxGL3XUKXsX2ZEdjfpZW3qU4jn7EkN
   WVTl8yhhRkrkvyFtAta1iscgR4jvy8WXWD+VaVa0Jwv9LBDkv1AIHaHTi
   D3cw6lvARpHwfe0qXe/Fw4JWblP9fbvMejInq3r3Yx6nS2UeljE4Un3h8
   kI4fZNmYAk1nkD0JZHJNQeo2nk5fQsnw5+48bKJoe3IeFEpgaK10qFkCu
   ZyQucIOrLGaGf9wCao8r2rNfu1vyKtVY34T0taHI111XhGi0XXc3f67QZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="353491484"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="353491484"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 14:39:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="598352113"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 May 2022 14:39:18 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlHHi-00094t-1O;
        Sun, 01 May 2022 21:39:18 +0000
Date:   Mon, 2 May 2022 05:38:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [masahiroy:lto-cleanup-v2 48/55] s390-linux-ld: .tmp_vmlinux.btf:
 warning: allocated section `.rodata' not in segment
Message-ID: <202205020509.gCxo3JWK-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git lto-cleanup-v2
head:   0f0c2c6e09ad55e3c5ddb69915460ee54eb913e4
commit: 58024b1713c48e2cc450f3301fc48077638298cc [48/55] kbuild: embed symbol versions at final link of vmlinux or modules
config: s390-defconfig (https://download.01.org/0day-ci/archive/20220502/202205020509.gCxo3JWK-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=58024b1713c48e2cc450f3301fc48077638298cc
        git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
        git fetch --no-tags masahiroy lto-cleanup-v2
        git checkout 58024b1713c48e2cc450f3301fc48077638298cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> s390-linux-ld: .tmp_vmlinux.btf: warning: allocated section `.rodata' not in segment
   s390-linux-objcopy: stSX2pj5: warning: allocated section `.rodata' not in segment
   s390-linux-ld: .tmp_vmlinux.kallsyms1: warning: allocated section `.rodata' not in segment
>> s390-linux-ld: .tmp_vmlinux.kallsyms2: warning: allocated section `.rodata' not in segment
>> s390-linux-ld: vmlinux: warning: allocated section `.rodata' not in segment

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
