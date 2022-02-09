Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9714AE98C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiBIFxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:53:21 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiBIFvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:51:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A68E01CCB5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644385898; x=1675921898;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dUg1/Jd14BxPmNM9mo3d/a+YYW5uGqlEpxIse3Mcv8A=;
  b=UYtevw4ET9El4quslo4jDZUzqcy5oYAI3UTcO/D+MO8GWPzXoncstDQx
   omMCjNMUnfwhYgvpF12JJx+6vfah1K+WrLOjNcJFmIpn9/ft9d0JZFECc
   0gOpn1mldsm+yLtnVViFH+H3DiXxd01IjGt7oMqShOg4dsvJDANevTTjx
   He/RpH92WAeq7hzQc5/RcBUezxc25pt3Cr/lLOsisfL2WEpOEkThpgX52
   mgeTw+kaToT0qDbnDUFc7e9+/ad56OLoW+qFA4K9zPrgBEHVXTQFFH1zF
   bxhPzdc2oxh+oLuNeIOYhsUu3zw8GdHEIfFFSqeqxvA/oiM1PySBA33o+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="273661051"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="273661051"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 21:51:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="485106089"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2022 21:51:28 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHft1-0001IF-KI; Wed, 09 Feb 2022 05:51:27 +0000
Date:   Wed, 9 Feb 2022 13:51:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 37/141]
 arch/x86/kvm/vmx/tdx_stubs.c:9:5: warning: no previous prototype for
 'tdx_module_setup'
Message-ID: <202202091337.hA7jAV2B-lkp@intel.com>
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

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   58f28b2fcc73d05d6a5a9f70a8fdacefa99acb85
commit: c3655d888b8950b33970012d3359b9e3921e36c6 [37/141] KVM: TDX: Add helper function to initialize TDX module
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20220209/202202091337.hA7jAV2B-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/c3655d888b8950b33970012d3359b9e3921e36c6
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout c3655d888b8950b33970012d3359b9e3921e36c6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/vmx/tdx_stubs.c:9:5: warning: no previous prototype for 'tdx_module_setup' [-Wmissing-prototypes]
       9 | int tdx_module_setup(void) { return -EOPNOTSUPP; };
         |     ^~~~~~~~~~~~~~~~


vim +/tdx_module_setup +9 arch/x86/kvm/vmx/tdx_stubs.c

     5	
     6	void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
     7				unsigned int *vcpu_align, unsigned int *vm_size) {}
     8	
   > 9	int tdx_module_setup(void) { return -EOPNOTSUPP; };

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
