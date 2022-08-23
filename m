Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5651059D1A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240824AbiHWHB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240804AbiHWHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:01:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0C961B18
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661238079; x=1692774079;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aZypyCjFzyTXB8yyU6iCIEXYn2kcxBHcOlnvkN2wxx4=;
  b=DzJaXVv/TrdemfLiaBIo7O6SJ7NAVVqMeA+M3kfF+aNz7RJskc2FDimq
   IRTyNQrb0R1+0WEKo+XCxvRN6V1yVA1Z7JUfLaNIRpnr+hKYV/OI+FdCm
   //qEuQPid/YDXGp7T6zEVbCOrOP2b6eIbR5NYGpxRnJPfjfzntNMjB5jL
   UJobe2x1VKcDGsVTtCgIszzoVRGvEUwIxxokunXHJZZAIqpXzNNH7Y33C
   +jB+JywraFVBjPoTqdozdlXgI+zkJCvGQcrQ17lY9tqCcXR4ysESSX2s1
   GQdybcB9IKrMpPL5ghMJR6BukJxnJztypvpkQVHVOIY/otlNxX78z4j+w
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294399456"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="294399456"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:01:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="735383095"
Received: from lkp-server01.sh.intel.com (HELO 5b31f6010e99) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2022 00:01:17 -0700
Received: from kbuild by 5b31f6010e99 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQNuW-00009t-2k;
        Tue, 23 Aug 2022 07:01:16 +0000
Date:   Tue, 23 Aug 2022 15:00:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 49/314]
 usr/include/asm/kvm.h:606:22: warning: field 'cpuid' with variable sized
 type 'struct kvm_cpuid2' not at the end of a struct or class is a GNU
 extension
Message-ID: <202208231439.fY8AdaYo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   552dd80c48f67ca01bcdd10667e0c11efd375177
commit: 1a5eb8b1aafbbb1015198bb2d2caf0e1a7557673 [49/314] KVM: TDX: initialize VM with TDX specific parameters
config: i386-randconfig-r031-20220822 (https://download.01.org/0day-ci/archive/20220823/202208231439.fY8AdaYo-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/1a5eb8b1aafbbb1015198bb2d2caf0e1a7557673
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 1a5eb8b1aafbbb1015198bb2d2caf0e1a7557673
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from <built-in>:1:
   In file included from ./usr/include/linux/kvm.h:15:
>> usr/include/asm/kvm.h:606:22: warning: field 'cpuid' with variable sized type 'struct kvm_cpuid2' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
                           struct kvm_cpuid2 cpuid;
                                             ^
   1 warning generated.
--
   In file included from <built-in>:1:
>> ./usr/include/asm/kvm.h:606:22: warning: field 'cpuid' with variable sized type 'struct kvm_cpuid2' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
                           struct kvm_cpuid2 cpuid;
                                             ^
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
