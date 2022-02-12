Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B434B370D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiBLSSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:18:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBLSSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:18:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B30B5E765
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644689892; x=1676225892;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C+vdn617bS0AINDJqzWzSHtTaxBy9iS/YJUXrg/FMP4=;
  b=MjWhEWpPO9UzF5y+uv7RGgfNF3PinXlHbnrLEB81B+sKvISOCO9M/wg0
   0PcmgXrRJ8NLw2O0Jtd3ZL3eqkIvck6pYboxl+7Afe/yWV0oaSxQJQbfP
   T/KKMQKKNcsewYiditfP8CPxJ25PSZEXtsGqBmEm2DH7k+A75Dj16c6oc
   zQoQZ8oSRpVheHw1llH/g265ZDuVltpfJKGvyKE2cp9RTi6m9RSGDLyRF
   NBHpA+M+qW8N1/Wke2lPD82mxbDi08fj4kH84XzWkdHWpsqPga5JbPfFJ
   ohT/RCJnX6TqC3FeagfdI9qiY0Fu0nQ40Wp5fMA9YGH8bAfocf8VDE/Yo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="313177324"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="313177324"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 10:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="569361066"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2022 10:18:10 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIwyI-0006Uk-5C; Sat, 12 Feb 2022 18:18:10 +0000
Date:   Sun, 13 Feb 2022 02:17:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Subject: curve25519-selftest.c:undefined reference to `__crypto_memneq'
Message-ID: <202202122304.0hOfjJGJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   83e396641110663d3c7bb25b9bc0c6a750359ecf
commit: e56e18985596617ae426ed5997fb2e737cffb58b lib/crypto: add prompts back to crypto libraries
date:   4 weeks ago
config: ia64-randconfig-r005-20220212 (https://download.01.org/0day-ci/archive/20220212/202202122304.0hOfjJGJ-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e56e18985596617ae426ed5997fb2e737cffb58b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e56e18985596617ae426ed5997fb2e737cffb58b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: lib/crypto/curve25519-selftest.o: in function `curve25519':
>> curve25519-selftest.c:(.text.unlikely+0x42): undefined reference to `__crypto_memneq'
   ia64-linux-ld: lib/crypto/curve25519-selftest.o: in function `curve25519_selftest':
>> curve25519-selftest.c:(.init.text+0x1b2): undefined reference to `__crypto_memneq'
>> ia64-linux-ld: curve25519-selftest.c:(.init.text+0x202): undefined reference to `__crypto_memneq'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
