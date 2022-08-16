Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3A559652A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbiHPWIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbiHPWIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:08:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F2613E2F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 15:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660687703; x=1692223703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rgDFuZeQwMuGSnBvzmdq3JP1KTVaVWKnFt+ZWxja3wk=;
  b=MFRsP/kj1La/JW+NeG4OFjtO4vnqeQZWCR9DsPbJuPrFkuiar0uysfdw
   IiSfLS7lZr+rzkBBzledpfYx5Vlz7y4pET1ELMeFVelUcGhX8Ko3GSIzF
   wAk9mP2PFQlDvy/mpeqBK5HP5NqYj1rBDsIZtw2okbbvBThjPaMO7j75Z
   aWXBkDtxHwd5QqxTWO8OKSclxVxYQm+PLoAjXTI72jM6lV3vl4pc1L7wi
   fkKeuJikZeM8fBO4v4smenkbq/IzT6DhWg9A75C3ef/LFix20rzOBixAi
   5tbQuOH5eEpBPPR9Kx5MS+zKkytV5zuBG7sua77dGdAVMzZtC0BvT1KNd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="356339154"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="356339154"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 15:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="640205516"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Aug 2022 15:08:02 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO4jC-0000Gi-0d;
        Tue, 16 Aug 2022 22:08:02 +0000
Date:   Wed, 17 Aug 2022 06:07:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 49/308]
 ./usr/include/asm/kvm.h:606:22: warning: field 'cpuid' with variable sized
 type 'struct kvm_cpuid2' not at the end of a struct or class is a GNU
 extension
Message-ID: <202208170516.hBUfXo8O-lkp@intel.com>
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

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   85c097fdd1667a842a9e75d8f658fc16bd72981a
commit: b20b2fef887cd148f6997b362c235f72ee971052 [49/308] KVM: TDX: initialize VM with TDX specific parameters
config: x86_64-randconfig-a011-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170516.hBUfXo8O-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/b20b2fef887cd148f6997b362c235f72ee971052
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout b20b2fef887cd148f6997b362c235f72ee971052
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/asm/kvm.h:606:22: warning: field 'cpuid' with variable sized type 'struct kvm_cpuid2' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
                           struct kvm_cpuid2 cpuid;
                                             ^
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
