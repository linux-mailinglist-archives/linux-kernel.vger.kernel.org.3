Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748004AAD66
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 02:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381501AbiBFBtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 20:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbiBFBs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 20:48:59 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5449EC043186
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 17:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644112138; x=1675648138;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5gt0BUKC470+HpXo06yNWapEGKxP7JmLvOCYrWhsVhI=;
  b=bcdFFYM4zChIUhgQSZ64ajyoZBGb4eCD4uTk65m4d7YSf2AoYFExjlg+
   kkcNPvB4XvAJJ4mTvLxqB+Y5k3VlOB9BNL9GtVJtx1zcduZeLCPg5vmtw
   Ca7ChMjyhg5j17j1CxsJzp4Nx2QIAiO9Uw0sTV4tYj6k0dcicvd3AB9wP
   xieHhmVnKyxzq+1sUdJrQBc1rILePne/j8iPYtBN3looBGg885GISnd2H
   lOimMZ8NIUpPUAKuaQG2N3HS6BYfwmGsjT5dK+aC7fJ+kHzNurhTlBLkp
   0HqGbNNUgTuEdN2ISkzF64lFv2nd2+7XtXZc2NmB2I6hb/OR+rYFMGQfW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10249"; a="248309735"
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="248309735"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 17:48:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="632079350"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Feb 2022 17:48:56 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGWff-000ZjK-O2; Sun, 06 Feb 2022 01:48:55 +0000
Date:   Sun, 6 Feb 2022 09:48:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: arch/arm64/kvm/pmu-emul.c:453: warning: This comment starts with
 '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202202060606.bblLvJEU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90c9e950c0def5c354b4a6154a2ddda3e5f214ac
commit: 3e58e839150db0857dfcb3a0bb3d4af4c6ac1abf scripts: kernel-doc: add warning for comment not following kernel-doc syntax
date:   10 months ago
config: arm64-buildonly-randconfig-r004-20220206 (https://download.01.org/0day-ci/archive/20220206/202202060606.bblLvJEU-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3e58e839150db0857dfcb3a0bb3d4af4c6ac1abf
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3e58e839150db0857dfcb3a0bb3d4af4c6ac1abf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/pmu-emul.c:219: warning: Function parameter or member 'vcpu' not described in 'kvm_pmu_stop_counter'
>> arch/arm64/kvm/pmu-emul.c:453: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * When perf interrupt is an NMI, we cannot safely notify the vcpu corresponding
   arch/arm64/kvm/pmu-emul.c:469: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * When the perf event overflows, set the overflow status and inform the vcpu.


vim +453 arch/arm64/kvm/pmu-emul.c

b02386eb7dac75 virt/kvm/arm/pmu.c        Shannon Zhao   2016-02-26  451  
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  452  /**
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24 @453   * When perf interrupt is an NMI, we cannot safely notify the vcpu corresponding
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  454   * to the event.
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  455   * This is why we need a callback to do it once outside of the NMI context.
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  456   */
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  457  static void kvm_pmu_perf_overflow_notify_vcpu(struct irq_work *work)
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  458  {
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  459  	struct kvm_vcpu *vcpu;
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  460  	struct kvm_pmu *pmu;
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  461  
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  462  	pmu = container_of(work, struct kvm_pmu, overflow_work);
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  463  	vcpu = kvm_pmc_to_vcpu(pmu->pmc);
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  464  
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  465  	kvm_vcpu_kick(vcpu);
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  466  }
95e92e45a454a1 arch/arm64/kvm/pmu-emul.c Julien Thierry 2020-09-24  467  

:::::: The code at line 453 was first introduced by commit
:::::: 95e92e45a454a10a8114294d0f7aec930fb85891 KVM: arm64: pmu: Make overflow handler NMI safe

:::::: TO: Julien Thierry <julien.thierry@arm.com>
:::::: CC: Will Deacon <will@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
