Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7AE521202
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbiEJKWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbiEJKWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:22:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EC72550B0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652177906; x=1683713906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4qztxUNqMycjP1rsDWfTqDBziA+dcRualG3jFrdIOxA=;
  b=WsXvmYd7vS/IyOGV5ISPrdNFrvXOZZndc28v9fdRMyDXioJRxRsk7Wlz
   WYvOEUp/m0RS7QO75BQKFC7MxjTCi5lt5J5sejRjUUFhkYSsfL6PLbq8G
   I+Fo5ScUQQhzMoJahh95jNOkSWPJ5YorqEds0nXdVICUNx/p2igLU/zb4
   X/odPTN2kOh0xD+07Iho9OoCAMT0/AnPa7kD17u0UwFFM5aUmlu5GBqLb
   6lX9vs6ttpgyAQupLt1ONjWzOB/FhUhM2lHtnbF+qtBwmmMD1oNeuagPq
   mCvYKSFOdXVTAxbtfQqSaBs4otjLtwEaA1vEt1oOn8KbsDsi+q3WIsr8u
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="329923119"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="329923119"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 03:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="697010384"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 May 2022 03:18:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noMwh-000Hgc-Nz;
        Tue, 10 May 2022 10:18:23 +0000
Date:   Tue, 10 May 2022 18:17:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: arch/x86/kvm/svm/sev.c:1605:30: warning: parameter 'role' set but
 not used
Message-ID: <202205101815.8y6CWm3q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9be9ed2612b5aedb52a2c240edb1630b6b743cb6
commit: 0c2c7c069285374fc8feacddc0498f8ab7627117 KVM: SEV: Mark nested locking of vcpu->lock
date:   4 days ago
config: x86_64-buildonly-randconfig-r001-20220509 (https://download.01.org/0day-ci/archive/20220510/202205101815.8y6CWm3q-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c2c7c069285374fc8feacddc0498f8ab7627117
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0c2c7c069285374fc8feacddc0498f8ab7627117
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/svm/sev.c:1605:30: warning: parameter 'role' set but not used [-Wunused-but-set-parameter]
                                           enum sev_migration_role role)
                                                                   ^
   1 warning generated.


vim +/role +1605 arch/x86/kvm/svm/sev.c

  1603	
  1604	static int sev_lock_vcpus_for_migration(struct kvm *kvm,
> 1605						enum sev_migration_role role)
  1606	{
  1607		struct kvm_vcpu *vcpu;
  1608		unsigned long i, j;
  1609		bool first = true;
  1610	
  1611		kvm_for_each_vcpu(i, vcpu, kvm) {
  1612			if (mutex_lock_killable_nested(&vcpu->mutex, role))
  1613				goto out_unlock;
  1614	
  1615			if (first) {
  1616				/*
  1617				 * Reset the role to one that avoids colliding with
  1618				 * the role used for the first vcpu mutex.
  1619				 */
  1620				role = SEV_NR_MIGRATION_ROLES;
  1621				first = false;
  1622			} else {
  1623				mutex_release(&vcpu->mutex.dep_map, _THIS_IP_);
  1624			}
  1625		}
  1626	
  1627		return 0;
  1628	
  1629	out_unlock:
  1630	
  1631		first = true;
  1632		kvm_for_each_vcpu(j, vcpu, kvm) {
  1633			if (i == j)
  1634				break;
  1635	
  1636			if (first)
  1637				first = false;
  1638			else
  1639				mutex_acquire(&vcpu->mutex.dep_map, role, 0, _THIS_IP_);
  1640	
  1641	
  1642			mutex_unlock(&vcpu->mutex);
  1643		}
  1644		return -EINTR;
  1645	}
  1646	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
