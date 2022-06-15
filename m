Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B703C54C29E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbiFOHaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiFOHaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:30:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D139E35ABD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655278206; x=1686814206;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oJhwgduglW2gSNuC/lHAqS10Yt1YgHiV4JJ04xDXpvY=;
  b=Hp50Jjf+PjnJbGpmu4b49nwpbm2d/jX5SXvaCnUqN9xySOv35+BqoxhD
   eMfsyEQ+DhscgdmqMWeTkzFREAgGpwUGFYuD1+bklx3reouAi7tsAJW0H
   B78RcBiYOlhFn6C2pbkn0511UoR8p+NFtEWUTwLfnFV1PBfnwBKpP6bRT
   KPijBEw8wsU8EnKPw7iYrclXQiO/sKqYV312MBFPlcYom75K18P04z+cz
   Roibv25BG1gBR6XWQO/8rx7QI7WY9IqStvj2YzK3Rz3nzFuNTTz1H/VdI
   L5pHQoUGLKz8MMv7T319hpVwBDqxfUnamqvjFGtHjRnBPVSYR6kRrnXsY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="258719096"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="258719096"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 00:30:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="687151244"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2022 00:30:05 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1NTY-000MfN-MI;
        Wed, 15 Jun 2022 07:30:04 +0000
Date:   Wed, 15 Jun 2022 15:29:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/book3s_hv_rm_xics.c:482:15: warning: no previous
 prototype for 'xics_rm_h_xirr_x'
Message-ID: <202206151538.1X8LPqy9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   018ab4fabddd94f1c96f3b59e180691b9e88d5d8
commit: b22af9041927075b82bcaf4b6c7a354688198d47 KVM: PPC: Book3s: Remove real mode interrupt controller hcalls handlers
date:   4 weeks ago
config: powerpc64-randconfig-r021-20220615 (https://download.01.org/0day-ci/archive/20220615/202206151538.1X8LPqy9-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b22af9041927075b82bcaf4b6c7a354688198d47
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b22af9041927075b82bcaf4b6c7a354688198d47
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/powerpc/kvm/book3s_hv_rm_xics.c:482:15: warning: no previous prototype for 'xics_rm_h_xirr_x' [-Wmissing-prototypes]
     482 | unsigned long xics_rm_h_xirr_x(struct kvm_vcpu *vcpu)
         |               ^~~~~~~~~~~~~~~~


vim +/xics_rm_h_xirr_x +482 arch/powerpc/kvm/book3s_hv_rm_xics.c

   481	
 > 482	unsigned long xics_rm_h_xirr_x(struct kvm_vcpu *vcpu)
   483	{
   484		vcpu->arch.regs.gpr[5] = get_tb();
   485		return xics_rm_h_xirr(vcpu);
   486	}
   487	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
