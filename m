Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546A554FFC2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiFQWOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiFQWOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:14:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83E655377
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655504038; x=1687040038;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gbOy4vnu3/QzrLKXTymMj0U2mUDfzMPdYghScJqPtZs=;
  b=NRHBWQARRW1dLGssvPUhQFZfYrT8FYyFKVOmN25aVL5EwWBxN4Y+pQa8
   cKaG0uVajA9DytiHCvDZMtxMgTQHoQ39CnR/HeTAP0eoa3F2X65cUyr4u
   RYzYR2DfJDevlbm/L2KwldIKvJrEEF+UOFqvjsoc5WBRcsIOq5cMoLUPX
   lCQEuA8aAgRu027cTy8dXfAnhxxC8gb42mTKpqwiwbUYRKtqeijOvMaSU
   w+tUg+4w3zJGu9qpG4+ipWQ/MwY6B5n3fKDKCIM/CO93kLYdndNMxmGvh
   6/cS4vU4MnYcl5Vn1MNikD341UJOvZeMNZ2OyhBk5JAtSQKbcX+TqCNJu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280656980"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280656980"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 15:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="590286318"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jun 2022 15:13:57 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2KE0-000Pnx-O4;
        Fri, 17 Jun 2022 22:13:56 +0000
Date:   Sat, 18 Jun 2022 06:13:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/meta4 2/2] ld.lld: error: undefined symbol:
 sch_prog_attach_kern
Message-ID: <202206180627.1kpqC1Jb-lkp@intel.com>
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

tree:   https://github.com/cilium/linux.git pr/meta4
head:   dcea837b60f0d9f8f3cdae284680659042f560d1
commit: dcea837b60f0d9f8f3cdae284680659042f560d1 [2/2] bpf: Add fd-based API to attach tc BPF programs
config: arm-randconfig-r023-20220617 (https://download.01.org/0day-ci/archive/20220618/202206180627.1kpqC1Jb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d764aa7fc6b9cc3fbe960019018f5f9e941eb0a6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/cilium/linux/commit/dcea837b60f0d9f8f3cdae284680659042f560d1
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/meta4
        git checkout dcea837b60f0d9f8f3cdae284680659042f560d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: sch_prog_attach_kern
   >>> referenced by sch_ingress.c
   >>> sched/sch_ingress.o:(ingress_init) in archive net/built-in.a
   >>> referenced by sch_ingress.c
   >>> sched/sch_ingress.o:(clsact_init) in archive net/built-in.a
   >>> referenced by sch_ingress.c
   >>> sched/sch_ingress.o:(clsact_init) in archive net/built-in.a
--
>> ld.lld: error: undefined symbol: sch_prog_detach_kern
   >>> referenced by sch_ingress.c
   >>> sched/sch_ingress.o:(ingress_destroy) in archive net/built-in.a
   >>> referenced by sch_ingress.c
   >>> sched/sch_ingress.o:(clsact_destroy) in archive net/built-in.a
   >>> referenced by sch_ingress.c
   >>> sched/sch_ingress.o:(clsact_destroy) in archive net/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
