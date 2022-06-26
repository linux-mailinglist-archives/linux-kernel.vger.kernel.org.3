Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4C455B448
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 00:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiFZWO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 18:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiFZWOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 18:14:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398E72DC1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656281693; x=1687817693;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OZL7K1mViMb7vr2FfnrJigpA/jVLhC9gESDVflwSfCU=;
  b=enOSqIRyrZo3hmikRuIocc3vU0Bw6kVCJuvnFORuuDZ7h2m2/zlgUPim
   PCNQNfNZjzpK4SW3vQF+5IxKjGKL1jwdnknhvFCTyk1ag+2Rvi9rxBCKB
   HTRw3XHjthbqxyD5peZIp8WvhmuCWHXoK1cngaDkxbl6DVi4zv1odozpN
   F5hpWszVLzFTUmscxlQu4kvBolh6lsi4MeGjs/VuK3GYyOSzW4aDcGx+f
   TXmLUHLqX4rRM+dyI11LEarkJS5GJzip9UIepEKfUTxrHVnaSS0qhV3io
   cOrQB1y8Bl9v/1l48Rs+aS5KgIjivfTPl+vZJl/gO/5zBLwnEZnbOMbp2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="261123567"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="261123567"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 15:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="539880045"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jun 2022 15:14:50 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5aWn-0007sv-R9;
        Sun, 26 Jun 2022 22:14:49 +0000
Date:   Mon, 27 Jun 2022 06:14:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ogabbay:gaudi2 49/54]
 drivers/misc/habanalabs/gaudi2/gaudi2.c:5816:13: error: call to
 __compiletime_assert_449 declared with 'error' attribute: FIELD_PREP: value
 too large for the field
Message-ID: <202206270601.q7mU43HC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git gaudi2
head:   46d258b93c9e6795f366c8b5159b33cfeb7d3bd8
commit: bb6edeab4c9679a00b7bb85fb20fb0a11e015509 [49/54] habanalabs: add gaudi2 asic-specific code
config: x86_64-randconfig-a002-20220627
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b0d6dd3905db145853c7c744ac92d49b00b1fa20)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=bb6edeab4c9679a00b7bb85fb20fb0a11e015509
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay gaudi2
        git checkout bb6edeab4c9679a00b7bb85fb20fb0a11e015509
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/misc/habanalabs/gaudi2/gaudi2.c:1828:6: warning: variable 'hbm_drv_base_offset' set but not used [-Wunused-but-set-variable]
           u64 hbm_drv_base_offset = 0;
               ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:6845:39: warning: variable 'glbl_sts_clr_val' set but not used [-Wunused-but-set-variable]
           u32 i, j, glbl_sts_val, arb_err_val, glbl_sts_clr_val, num_error_causes;
                                                ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9825:6: warning: no previous prototype for function 'gaudi2_set_asic_funcs' [-Wmissing-prototypes]
   void gaudi2_set_asic_funcs(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9825:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_set_asic_funcs(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:672:1: warning: unused variable 'gaudi2_nic_rxb_core_sei_interrupts_cause' [-Wunused-const-variable]
   gaudi2_nic_rxb_core_sei_interrupts_cause[GAUDI2_NUM_OF_NIC_RXB_CORE_SEI_CAUSE] = {
   ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:678:1: warning: unused variable 'gaudi2_nic_rxb_core_spi_interrupts_cause' [-Wunused-const-variable]
   gaudi2_nic_rxb_core_spi_interrupts_cause[GAUDI2_NUM_OF_NIC_RXB_CORE_SPI_CAUSE] = {
   ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:687:27: warning: unused variable 'gaudi2_nic_rxe_sei_interrupts_cause' [-Wunused-const-variable]
   static const char * const gaudi2_nic_rxe_sei_interrupts_cause[GAUDI2_NUM_OF_NIC_RXE_SEI_CAUSE] = {
                             ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:694:27: warning: unused variable 'gaudi2_nic_rxe_spi_interrupts_cause' [-Wunused-const-variable]
   static const char * const gaudi2_nic_rxe_spi_interrupts_cause[GAUDI2_NUM_OF_NIC_RXE_SPI_CAUSE] = {
                             ^
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:5816:13: error: call to __compiletime_assert_449 declared with 'error' attribute: FIELD_PREP: value too large for the field
           mon_arm |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_MASK_MASK, mask);
                      ^
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^
   include/linux/bitfield.h:68:3: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
                   ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:53:1: note: expanded from here
   __compiletime_assert_449
   ^
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:5816:13: error: call to __compiletime_assert_449 declared with 'error' attribute: FIELD_PREP: value too large for the field
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^
   include/linux/bitfield.h:68:3: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
                   ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:53:1: note: expanded from here
   __compiletime_assert_449
   ^
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:5816:13: error: call to __compiletime_assert_449 declared with 'error' attribute: FIELD_PREP: value too large for the field
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^
   include/linux/bitfield.h:68:3: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
                   ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:53:1: note: expanded from here
   __compiletime_assert_449
   ^
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:5816:13: error: call to __compiletime_assert_449 declared with 'error' attribute: FIELD_PREP: value too large for the field
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^
   include/linux/bitfield.h:68:3: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
                   ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:53:1: note: expanded from here
   __compiletime_assert_449
   ^
   7 warnings and 4 errors generated.


vim +/error +5816 drivers/misc/habanalabs/gaudi2/gaudi2.c

  5794	
  5795	static void gaudi2_arm_cq_monitor(struct hl_device *hdev, u32 index, u32 cq_id,
  5796							u32 mon_payload, u32 sync_value)
  5797	{
  5798		int offset = index * 4;
  5799		u32 sync_group_id, mask, mode, mon_arm;
  5800	
  5801		/* Reset the SOB value */
  5802		WREG32(mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + offset, 0);
  5803	
  5804		/* Configure this address with CQ_ID 0 because CQ_EN is set */
  5805		WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0 + offset, cq_id);
  5806	
  5807		/* Configure this address with CS index because CQ_EN is set */
  5808		WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_DATA_0 + offset, mon_payload);
  5809	
  5810		sync_group_id = index / 8;
  5811		mask = ~(1 << (index & 0x7));
  5812		mode = 1; /* comparison mode is "equal to" */
  5813	
  5814		mon_arm = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SOD_MASK, sync_value);
  5815		mon_arm |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SOP_MASK, mode);
> 5816		mon_arm |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_MASK_MASK, mask);
  5817		mon_arm |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SID_MASK, sync_group_id);
  5818		WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_ARM_0 + offset, mon_arm);
  5819	}
  5820	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
