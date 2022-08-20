Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092B559AF83
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiHTSQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTSQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3664017071
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661019370; x=1692555370;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TDA1eoaLC9crJK0rIYcZn/hEOf+s0OqEKsBKkN7RcWs=;
  b=CI6ynh2OoTVB9kK8hnKtDQXRut04/71TnI9BuCpge59SHAg3OPD0fgf1
   YYxVHLLwvK5K2bAqjJKG2BQ13EUDPgK5TvQJDCPwww7OapMgHBPoM5zMs
   E9kQRaiY7XEG6WJNKYs2SYd3+XKlXaYVcjSy531qfIAbCvkHJLy+EiV+l
   Ox9BELZsIH04GyYgndngebxJjuh2uX07JvlLJPmfXIFQ4cNdxDibeY9k0
   EeM4eIEnzQ5a132dEVae2At2Nxc/u/XW+/ex83kXPtcba41/K0LBgBRah
   eRAtXoz3E2SWQ71boDoYTJVzdVe2FbgSxQnZhdddahMNwxvcE3Nw7naaU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="294471738"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="294471738"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 11:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="585015778"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Aug 2022 11:16:07 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPT0x-00030V-0T;
        Sat, 20 Aug 2022 18:16:07 +0000
Date:   Sun, 21 Aug 2022 02:15:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: arch/arm64/kvm/hyp/nvhe/stacktrace.c:38:1: sparse: sparse: symbol
 '__pcpu_scope_pkvm_stacktrace' was not declared. Should it be static?
Message-ID: <202208210225.5VNIyPGA-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50cd95ac46548429e5bba7ca75cc97d11a697947
commit: 6928bcc84bc4bd9a24a1cb1986418c3de76e1d99 KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
date:   4 weeks ago
config: arm64-randconfig-s033-20220820 (https://download.01.org/0day-ci/archive/20220821/202208210225.5VNIyPGA-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6928bcc84bc4bd9a24a1cb1986418c3de76e1d99
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6928bcc84bc4bd9a24a1cb1986418c3de76e1d99
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/arm64/kvm/hyp/nvhe/stacktrace.c:12:1: sparse: sparse: symbol '__pcpu_scope_overflow_stack' was not declared. Should it be static?
   arch/arm64/kvm/hyp/nvhe/stacktrace.c:15:1: sparse: sparse: symbol '__pcpu_scope_kvm_stacktrace_info' was not declared. Should it be static?
>> arch/arm64/kvm/hyp/nvhe/stacktrace.c:38:1: sparse: sparse: symbol '__pcpu_scope_pkvm_stacktrace' was not declared. Should it be static?

vim +/__pcpu_scope_pkvm_stacktrace +38 arch/arm64/kvm/hyp/nvhe/stacktrace.c

    11	
  > 12	DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
    13		__aligned(16);
    14	
    15	DEFINE_PER_CPU(struct kvm_nvhe_stacktrace_info, kvm_stacktrace_info);
    16	
    17	/*
    18	 * hyp_prepare_backtrace - Prepare non-protected nVHE backtrace.
    19	 *
    20	 * @fp : frame pointer at which to start the unwinding.
    21	 * @pc : program counter at which to start the unwinding.
    22	 *
    23	 * Save the information needed by the host to unwind the non-protected
    24	 * nVHE hypervisor stack in EL1.
    25	 */
    26	static void hyp_prepare_backtrace(unsigned long fp, unsigned long pc)
    27	{
    28		struct kvm_nvhe_stacktrace_info *stacktrace_info = this_cpu_ptr(&kvm_stacktrace_info);
    29		struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
    30	
    31		stacktrace_info->stack_base = (unsigned long)(params->stack_hyp_va - PAGE_SIZE);
    32		stacktrace_info->overflow_stack_base = (unsigned long)this_cpu_ptr(overflow_stack);
    33		stacktrace_info->fp = fp;
    34		stacktrace_info->pc = pc;
    35	}
    36	
    37	#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
  > 38	#include <asm/stacktrace/nvhe.h>
    39	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
