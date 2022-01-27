Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D257C49D78B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiA0Bmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:42:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:33561 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbiA0Bma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643247750; x=1674783750;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BpHj+YBCBBfT/oMrGQIBft5f1zxq7mXZNglyLOshXXM=;
  b=Buwa5uuVeB87DqnuFHD2fxOmDTmvd+D+1yfcTgDAsPTHg+P5BRJMOQqI
   cZS1rk7YxzDWUrtPUopqta5olZCrpgwQf46hR6FAdfHxxW1UP6FyH41b7
   a0kKeDV/odWw6cyP+AXRzoQ0W2yW82WFsSUnHKzDfA1EfSVRr3PDcVjb/
   cG23W7TPqqelRsa/ywPyrgBa0Ohn2Z3fNjyQdxypZiwCT+tma29CMQkjh
   OMu9DoKCspKLNUtCD/fGRbaWDMce90DayfyJh49qcNX6j/TalL93vki5H
   wJI8iKJzbSsJCb8+Wf0YioIyCDDOzygM3AxvWxar2WArYArSjLVzsGyzh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246933887"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="246933887"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 17:42:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="696451487"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2022 17:42:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCtnw-000LwR-OA; Thu, 27 Jan 2022 01:42:28 +0000
Date:   Thu, 27 Jan 2022 09:41:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Quentin Perret <qperret@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10
 981/9999] arch/arm64/kvm/arm.c:1906:6: warning: no previous prototype for
 '_kvm_host_prot_finalize'
Message-ID: <202201270944.zEo8aC9v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10
head:   b0d13db791b8774617b72c9242a7cf49f67720b2
commit: 68bd98a28aa622358c73420792329221c86fbe0c [981/9999] FROMLIST: KVM: arm64: Wrap the host with a stage 2
config: arm64-buildonly-randconfig-r006-20220126 (https://download.01.org/0day-ci/archive/20220127/202201270944.zEo8aC9v-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/68bd98a28aa622358c73420792329221c86fbe0c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10
        git checkout 68bd98a28aa622358c73420792329221c86fbe0c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/arm.c:1906:6: warning: no previous prototype for '_kvm_host_prot_finalize' [-Wmissing-prototypes]
    1906 | void _kvm_host_prot_finalize(void *discard)
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/_kvm_host_prot_finalize +1906 arch/arm64/kvm/arm.c

  1905	
> 1906	void _kvm_host_prot_finalize(void *discard)
  1907	{
  1908		WARN_ON(kvm_call_hyp_nvhe(__pkvm_prot_finalize));
  1909	}
  1910	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
