Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EDC52DF9C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245288AbiESVym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbiESVyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:54:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E755379
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652997279; x=1684533279;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/I5NJ+54RWKMStEMU2hGQt0cBAW0ada/XIy6RjOXe6A=;
  b=E0f7slXccTkeByovYg3DrTZ//Aq6pvh83kQXK2PhxzVFrrOqah7NN3e5
   YFdNR73eWESBdkvGxKYdJgWjXkq+x/bq9sjhz16ZBPUdwolA3nCzbny+0
   SOb4I7sSsMB/n6Yw31yIpnGxwmVMMic+S1pU1R29aWOOfecrMLAuUC6HH
   13K1nMfeas03BfpWGtRSAP2nU7GUO3XnvJQy1Yn5mLLVn9lWSMHLYXCp3
   lxqn7XhR2wv7iMDVjdpBjPnjnNPrTJ482CG4/o1xfVuA08DUAuNr8hAYN
   enn+PKDhtDllxjHwfEbXwhypKvnL2jdIX8zmyhUy5vWRfwmRwyKJW3GUb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="252284141"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="252284141"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="701386593"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 May 2022 14:54:37 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nro6O-0003yn-G7;
        Thu, 19 May 2022 21:54:36 +0000
Date:   Fri, 20 May 2022 05:54:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [netfilter-nf-next:testing 9/12] ld.lld: error: undefined symbol:
 nf_hook_bpf_create
Message-ID: <202205200527.2rAxKhM6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
head:   4456ac35299c131e2ac26b4dc025b257d810277b
commit: 11b2910d788799e8c68df305994260fd79a61e10 [9/12] netfilter: add bpf base hook program generator
config: mips-bmips_stb_defconfig (https://download.01.org/0day-ci/archive/20220520/202205200527.2rAxKhM6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=11b2910d788799e8c68df305994260fd79a61e10
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next testing
        git checkout 11b2910d788799e8c68df305994260fd79a61e10
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: nf_hook_bpf_create
   >>> referenced by core.c
   >>>               netfilter/core.o:(nf_hook_entries_grow) in archive net/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
