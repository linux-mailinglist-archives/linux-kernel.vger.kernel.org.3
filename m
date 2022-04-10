Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CBC4FAB67
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiDJBgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiDJBgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:36:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C8930551
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 18:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649554470; x=1681090470;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5ChypJBhMV03l2EADJm3tsah3z6+A8bBezHehHgc8Ww=;
  b=kWG86zTxcEaMQ5haia+JNmafC6Qj3qnDiE3xRFXA1Js/P0DTNOYI7zj+
   7C3AsodsBYPtnPA8FnbdzrbuUBDZjT/a+Ve9N4G1T9x/37I32s46siBjN
   hHuzmh3ELRwzM/QPb7Am9JoTnTgjcv3rL8HHUuj46kOuTPdXbfSzE2h2P
   7qmivFgpBV7q72AOIWHF6B/3bBqZlSKeRMeFY3WgrU9/UYxMqQyvo92mN
   UxHD36IShW2EM1bL0/TBcRn6WfnBVvB3SKTKRem5VlIyKIYEcwfQ4120B
   pmVGwPPO5J56fhyCbhowP1W8UU3WjLhuDgfhlsW55sFbg2oR6XXSOgLci
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="286928754"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="286928754"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 18:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="622410047"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Apr 2022 18:34:29 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndMTE-0000Yx-Lu;
        Sun, 10 Apr 2022 01:34:28 +0000
Date:   Sun, 10 Apr 2022 09:33:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-04 3/12] ld.lld: error: undefined symbol:
 pifo_generic_map_ops
Message-ID: <202204100910.Jgmsmcqk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-04
head:   d67202baf237752a91366c8ba9bd801942e5fdaf
commit: fe606924ca53da2ffef87d4234ef54a5f1b66fbb [3/12] bpf: Add a PIFO map type for queueing packets
config: arm64-randconfig-r014-20220410 (https://download.01.org/0day-ci/archive/20220410/202204100910.Jgmsmcqk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 256c6b0ba14e8a7ab6373b61b7193ea8c0a3651c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=fe606924ca53da2ffef87d4234ef54a5f1b66fbb
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-04
        git checkout fe606924ca53da2ffef87d4234ef54a5f1b66fbb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: pifo_generic_map_ops
   >>> referenced by syscall.c
   >>>               bpf/syscall.o:(bpf_map_types) in archive kernel/built-in.a
   >>> referenced by btf.c
   >>>               bpf/btf.o:(btf_vmlinux_map_ops) in archive kernel/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
