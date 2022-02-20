Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EE64BD0F0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244626AbiBTT3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:29:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243180AbiBTT3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:29:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E27A42EDA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645385330; x=1676921330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZNTxLnInzRPOL9byPHU761uCXcQd9HmP+TtxyzEk25A=;
  b=OmKUD+Fyef2gC774X4BsGNx4u9b4Ftax+gfa5cQngNxcZoMqsOgi2LlL
   hMBiBZPMPO86szO/Pa18J1koKmdHW8T5auOQXz4Vn3R+nep6HlhFEFqaW
   BDhKTbC783QoS1H7tasIxDBnQkWI+8AI62Zl4WAuejW50P0nCnWTzGxFJ
   A4a05tV12zxGmR9OwnLbBD/Ugcd97Zmr1rwIausq1EPFFOJE5rWSTtSV9
   vm29WdzgG3cAvRsNbMN8CSmrtOhcjpKUsqFbVIaZTvpdOSKbDKdEbK3zi
   edhjwWSKTVwEipzPqCTWsuOfZdDj6khEeq/2wHB319PDKK0+eDueyvrnp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="250216176"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="250216176"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 11:28:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="531594440"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Feb 2022 11:28:48 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLrt1-0000eF-S4; Sun, 20 Feb 2022 19:28:47 +0000
Date:   Mon, 21 Feb 2022 03:28:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm64-ro-page-tables-pkvm-v5.17 19/28]
 arch/arm64/kvm/hyp/nvhe/pgtable_protect.c:21:17: warning: suggest braces
 around empty body in an 'if' statement
Message-ID: <202202210301.qC026510-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-ro-page-tables-pkvm-v5.17
head:   1faeabde0ba3c81ad666ab924ab79ef64843d40d
commit: 93742345aee5c8a33d625f8e7b9357ddba534392 [19/28] arm64: kvm: use HYP helpers to perform page table updates
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220221/202202210301.qC026510-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=93742345aee5c8a33d625f8e7b9357ddba534392
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-ro-page-tables-pkvm-v5.17
        git checkout 93742345aee5c8a33d625f8e7b9357ddba534392
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/hyp/nvhe/pgtable_protect.c: In function 'inject_external_abort':
>> arch/arm64/kvm/hyp/nvhe/pgtable_protect.c:21:17: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
      21 |                 ; // TODO
         |                 ^


vim +/if +21 arch/arm64/kvm/hyp/nvhe/pgtable_protect.c

    15	
    16	static void inject_external_abort(struct kvm_cpu_context *host_ctxt)
    17	{
    18		struct kvm_vcpu *vcpu = host_ctxt->__hyp_running_vcpu;
    19	
    20		if (vcpu)
  > 21			; // TODO
    22	
    23		write_sysreg_el2(read_sysreg_el2(SYS_ELR) - 1, SYS_ELR);
    24	}
    25	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
