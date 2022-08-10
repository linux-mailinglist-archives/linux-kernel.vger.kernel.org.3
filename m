Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5AD58E3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 02:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiHJANI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 20:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHJANG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 20:13:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FD67B1C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 17:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660090385; x=1691626385;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DQhMvMICXUFT5koyUKFr8/F0Gq+7FiyW/GukWCEjD0w=;
  b=WkSB02ys/NK9SQsGy6YSiC33b/1XBmpGwTZJpkDJP/lcsPn0cyqdga7T
   SH2HNK00ceC5JxgofOqEAi2BwQTmuRmv55piSzvpF8RTYAnC+ZBE7OqXh
   znlvQuXHGn+/DBgUFz8zFDM6KRf7mV8rQ1dsIidwfO6h5QMbs4yCh7n3Y
   ldX6GcPJLE7l6WkFJCyqndF7sDsVkFec/MtrloIXo3RWczf84KUTvH2gC
   11gMe1xtwX+Pa0k9axTa2vz+YlhLKXxmxLybmzjptd5tzDY2uvDZ16z6g
   2HCCnC60vI3XIowl1umAev+kTGT9uZjwhgvw94q+hf1IgyjFoN5FB0//2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="316905703"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="316905703"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 17:13:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="664653743"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2022 17:13:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLZLK-000NMj-36;
        Wed, 10 Aug 2022 00:13:02 +0000
Date:   Wed, 10 Aug 2022 08:12:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Fuad Tabba <tabba@google.com>
Subject: arch/arm64/kvm/hyp/nvhe/stacktrace.c:46:6: warning: no previous
 prototype for function 'kvm_nvhe_prepare_backtrace'
Message-ID: <202208100837.3PuoDcEv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   15205c2829ca2cbb5ece5ceaafe1171a8470e62b
commit: 879e5ac7b2e4db05799a905b5a07fc9e5dedf651 KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
date:   2 weeks ago
config: arm64-randconfig-r034-20220810 (https://download.01.org/0day-ci/archive/20220810/202208100837.3PuoDcEv-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=879e5ac7b2e4db05799a905b5a07fc9e5dedf651
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 879e5ac7b2e4db05799a905b5a07fc9e5dedf651
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/hyp/nvhe/ drivers/vfio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/hyp/nvhe/stacktrace.c:46:6: warning: no previous prototype for function 'kvm_nvhe_prepare_backtrace' [-Wmissing-prototypes]
   void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)
        ^
   arch/arm64/kvm/hyp/nvhe/stacktrace.c:46:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)
   ^
   static 
   1 warning generated.


vim +/kvm_nvhe_prepare_backtrace +46 arch/arm64/kvm/hyp/nvhe/stacktrace.c

    36	
    37	/*
    38	 * kvm_nvhe_prepare_backtrace - prepare to dump the nVHE backtrace
    39	 *
    40	 * @fp : frame pointer at which to start the unwinding.
    41	 * @pc : program counter at which to start the unwinding.
    42	 *
    43	 * Saves the information needed by the host to dump the nVHE hypervisor
    44	 * backtrace.
    45	 */
  > 46	void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
