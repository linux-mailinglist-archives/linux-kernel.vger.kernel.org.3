Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCDA5488AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352800AbiFMMYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348009AbiFMMWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:22:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A604557B15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 04:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655118211; x=1686654211;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I0+AQdJdP0W9uMbzGijxcDYistK8Ld2UH8HmZHjvd38=;
  b=NTTcVcTeAXZDv3MLrWhiLxEhI/ecERZ0G1tp3Ho8MsSO2CJ00v6lqKEB
   EPJE4DTN7UJG5KWg89DMxFvaPkP8qmyrsiTFMOEMoUkgcNfiBZqgDHbNX
   cLJ6dD6WWOLmHKpdhMr6OEVyQ/OPhaN88pXesImmzJOHyUZn/smHu/53m
   MdCvxY/NcExYekKo27KjFr0dHNz05eslts+/7s/kIUm8+pjixqJvZjsuV
   ZdW+bCOKq42r+QrJc5KMQj3yDetbTpraHxOZfFTUK6pxcWO2NLuWItjNg
   lC6tGbNTkuVpAutWtWLfNOXCyVK382ggpiKKTeeYLb3QOPwlvNbd1Dtlp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="342220115"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="342220115"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 04:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="829742491"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2022 04:03:28 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0hqy-000KkH-4J;
        Mon, 13 Jun 2022 11:03:28 +0000
Date:   Mon, 13 Jun 2022 19:03:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: arch/x86/kvm/svm/sev.c:1605:30: warning: parameter 'role' set but
 not used
Message-ID: <202206131853.x4KJwC5Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
commit: 0c2c7c069285374fc8feacddc0498f8ab7627117 KVM: SEV: Mark nested locking of vcpu->lock
date:   5 weeks ago
config: x86_64-buildonly-randconfig-r005-20220613 (https://download.01.org/0day-ci/archive/20220613/202206131853.x4KJwC5Q-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d378268ead93c85803c270277f0243737b536ae7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c2c7c069285374fc8feacddc0498f8ab7627117
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0c2c7c069285374fc8feacddc0498f8ab7627117
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/ drivers/media/platform/qcom/camss/

If you fix the issue, kindly add following tag where applicable
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
