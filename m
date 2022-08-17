Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBA75977EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiHQUYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241216AbiHQUYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:24:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE746613B;
        Wed, 17 Aug 2022 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660767877; x=1692303877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IIOssEjqoV4OTzY2YH29W6lbg95l6doUvPncIkn+X60=;
  b=ime8ws5+moZwlEtYbyCZR2zFl5GwXMDKYZQb/9bwK0eshsv/HswIyMmt
   K0v2lizQSSb76qVRSMAze0m/5i+OGm/7Mu1+GgAvsW/NCJ73qQFrdM1wv
   ORADtK7ql85vDFJxTKPh7GcHqAivi6A00xsml92yBHcHyN/uXlLfGY1kQ
   r07YwlKyuOOEoyPNSk8xn4K5QSs57kDFkytpZZ5rXevL4pmfviPgB0a6Y
   LYLIj/n3oPTJ2R6ji08NH4iXxbcFwW3iPdNXd0fk5uf2pfp7rgEJlVNVd
   HkrxI90C/bHHSiml8BH0BtYTwKkJ0Ow2eK+TAhl75ySKfxtvqTLPdfYGd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="275648382"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="275648382"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 13:24:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="583913548"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2022 13:24:34 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOPab-0001JS-2L;
        Wed, 17 Aug 2022 20:24:33 +0000
Date:   Thu, 18 Aug 2022 04:23:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qin Jian <qinjian@cqplus1.com>, sboyd@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Qin Jian <qinjian@cqplus1.com>
Subject: Re: [PATCH] clk: Add Sunplus SP7021 clock driver
Message-ID: <202208180400.EvwdX195-lkp@intel.com>
References: <20220817070113.415971-1-qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817070113.415971-1-qinjian@cqplus1.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 568035b01cfb107af8d2e4bd2fb9aea22cf5b868]

url:    https://github.com/intel-lab-lkp/linux/commits/Qin-Jian/clk-Add-Sunplus-SP7021-clock-driver/20220817-151010
base:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: arm-randconfig-r013-20220818 (https://download.01.org/0day-ci/archive/20220818/202208180400.EvwdX195-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/5673230d6a56d6c37b8db18d202c0ef526f52b2e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qin-Jian/clk-Add-Sunplus-SP7021-clock-driver/20220817-151010
        git checkout 5673230d6a56d6c37b8db18d202c0ef526f52b2e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/clk-sp7021.c:317:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           r0 |= HWM_FIELD_PREP(MASK_SEL_FRA, clk->p[SEL_FRA]);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:44:15: note: expanded from macro 'HWM_FIELD_PREP'
           (_m << 16) | FIELD_PREP(_m, value);     \
                        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:354:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:342:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:334:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/clk/clk-sp7021.c:318:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           r0 |= HWM_FIELD_PREP(MASK_SDM_MOD, clk->p[SDM_MOD]);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:44:15: note: expanded from macro 'HWM_FIELD_PREP'
           (_m << 16) | FIELD_PREP(_m, value);     \
                        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:354:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:342:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:334:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/clk/clk-sp7021.c:319:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           r0 |= HWM_FIELD_PREP(MASK_PH_SEL, clk->p[PH_SEL]);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:44:15: note: expanded from macro 'HWM_FIELD_PREP'
           (_m << 16) | FIELD_PREP(_m, value);     \
                        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:354:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:342:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:334:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/clk/clk-sp7021.c:320:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           r0 |= HWM_FIELD_PREP(MASK_NFRA, clk->p[NFRA]);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:44:15: note: expanded from macro 'HWM_FIELD_PREP'
           (_m << 16) | FIELD_PREP(_m, value);     \
                        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:354:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:342:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:334:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/clk/clk-sp7021.c:322:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           r1  = HWM_FIELD_PREP(MASK_DIVR, clk->p[DIVR]);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:44:15: note: expanded from macro 'HWM_FIELD_PREP'
           (_m << 16) | FIELD_PREP(_m, value);     \
                        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)


vim +317 drivers/clk/clk-sp7021.c

   310	
   311	static int plltv_set_rate(struct sp_pll *clk)
   312	{
   313		unsigned long flags;
   314		u32 r0, r1, r2;
   315	
   316		r0  = BIT(clk->bp_bit + 16);
 > 317		r0 |= HWM_FIELD_PREP(MASK_SEL_FRA, clk->p[SEL_FRA]);
   318		r0 |= HWM_FIELD_PREP(MASK_SDM_MOD, clk->p[SDM_MOD]);
   319		r0 |= HWM_FIELD_PREP(MASK_PH_SEL, clk->p[PH_SEL]);
   320		r0 |= HWM_FIELD_PREP(MASK_NFRA, clk->p[NFRA]);
   321	
   322		r1  = HWM_FIELD_PREP(MASK_DIVR, clk->p[DIVR]);
   323	
   324		r2  = HWM_FIELD_PREP(MASK_DIVN, clk->p[DIVN] - 1);
   325		r2 |= HWM_FIELD_PREP(MASK_DIVM, clk->p[DIVM] - 1);
   326	
   327		spin_lock_irqsave(&clk->lock, flags);
   328		writel(r0, clk->reg);
   329		writel(r1, clk->reg + 4);
   330		writel(r2, clk->reg + 8);
   331		spin_unlock_irqrestore(&clk->lock, flags);
   332	
   333		return 0;
   334	}
   335	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
