Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85B553D40C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 02:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349808AbiFDAS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 20:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFDASy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 20:18:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B195932C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 17:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654301933; x=1685837933;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lQ5vnFYTCwqGsOTSjrRG39am4oz9xfPDPHb7zVZqTQo=;
  b=LYtIUuxLeAP94JOLGK5V6WMIUoTiwvrn7GbScfngwF11QbRRa6MEUNnP
   YeO/673M+43/4dxH5jWQgQa43OVlye+Pcpp0xI2lAVGvahtF9/jNODfCk
   URTOn6QM+j6UiYqD6Yc4mP6hCg+md6VenKhsvPksAOz3JbxxdpTSMfdDQ
   9d2+bGYs0oCOrVQ5j8hXoNs58eZH0z4ogA8u4i8wo7tz91rNB1Gl0erH3
   SiBlj3lTjlYNzO8iyXWhYJ8nnmDXgF9jb4N/DnCboUVwMJyT3jVQ7Pzq3
   InP4Atx3mX8ZxstVSYtZ7ockAves+GZyRh5AvI//K+kYMXBXcu4jHfoIZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="362740002"
X-IronPort-AV: E=Sophos;i="5.91,276,1647327600"; 
   d="scan'208";a="362740002"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 17:18:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,276,1647327600"; 
   d="scan'208";a="582804510"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jun 2022 17:18:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxHVD-0009fb-LX;
        Sat, 04 Jun 2022 00:18:51 +0000
Date:   Sat, 4 Jun 2022 08:18:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/book3s_hv_rm_xics.c:482:15: error: no previous
 prototype for 'xics_rm_h_xirr_x'
Message-ID: <202206040816.UN8BBdUf-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   744983d8784214c4f184be7448efb216315b48ae
commit: b22af9041927075b82bcaf4b6c7a354688198d47 KVM: PPC: Book3s: Remove real mode interrupt controller hcalls handlers
date:   2 weeks ago
config: powerpc64-defconfig (https://download.01.org/0day-ci/archive/20220604/202206040816.UN8BBdUf-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/kvm/book3s_hv_rm_xics.c:482:15: error: no previous prototype for 'xics_rm_h_xirr_x' [-Werror=missing-prototypes]
     482 | unsigned long xics_rm_h_xirr_x(struct kvm_vcpu *vcpu)
         |               ^~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


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
