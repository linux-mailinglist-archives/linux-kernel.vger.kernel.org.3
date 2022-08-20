Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82B59AB85
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 07:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244132AbiHTFue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 01:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243288AbiHTFub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 01:50:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3074B15814
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660974630; x=1692510630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4BJuzLDbU4/mOyvMxVS5s8ewRpjNU+hq0woViZ8mcS0=;
  b=kRE/AdEAelsYSB0T0+n0P8IE6AFsSNHnrAOsujAdZu8i8hkFWuUCYWMq
   X3KhxI4NyjrIwRpqDhblCo8qeDcMjItIYeC2sAN4QrUFTca1rOYm8EJ+f
   EmL+fcpzPLdifHgeBy/qR7pDwAVdlnWm8+xNWf+gCeG3zejSsl/OjY944
   fAX5Cd9tpqdWFC+OPXKo+3U7K/OHmPjHThK+rXyqpPhhk17hl5TeLJ1wn
   /l+/K53IjChDjEghMRQ94BynSB04YBKjyQ11dCdcLFGQe3IKbkBQV3BkI
   +rOJjSndbddL7Mv1bASph9EwJ+JH7buvW+z/72m9GDZlTfSzpFpBgILtC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="319181973"
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="319181973"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 22:50:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="559174930"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Aug 2022 22:50:28 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPHNL-0002EF-2N;
        Sat, 20 Aug 2022 05:50:27 +0000
Date:   Sat, 20 Aug 2022 13:49:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: arch/arm64/kvm/hyp/nvhe/stacktrace.c:15:1: sparse: sparse: symbol
 '__pcpu_scope_kvm_stacktrace_info' was not declared. Should it be static?
Message-ID: <202208201336.FwqRDnuv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50cd95ac46548429e5bba7ca75cc97d11a697947
commit: 879e5ac7b2e4db05799a905b5a07fc9e5dedf651 KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
date:   4 weeks ago
config: arm64-randconfig-s042-20220820 (https://download.01.org/0day-ci/archive/20220820/202208201336.FwqRDnuv-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=879e5ac7b2e4db05799a905b5a07fc9e5dedf651
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 879e5ac7b2e4db05799a905b5a07fc9e5dedf651
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/arm64/kvm/hyp/nvhe/stacktrace.c:12:1: sparse: sparse: symbol '__pcpu_scope_overflow_stack' was not declared. Should it be static?
>> arch/arm64/kvm/hyp/nvhe/stacktrace.c:15:1: sparse: sparse: symbol '__pcpu_scope_kvm_stacktrace_info' was not declared. Should it be static?

vim +/__pcpu_scope_kvm_stacktrace_info +15 arch/arm64/kvm/hyp/nvhe/stacktrace.c

    11	
    12	DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
    13		__aligned(16);
    14	
  > 15	DEFINE_PER_CPU(struct kvm_nvhe_stacktrace_info, kvm_stacktrace_info);
    16	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
