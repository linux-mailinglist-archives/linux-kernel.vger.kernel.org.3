Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9866E50B330
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445605AbiDVItc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445577AbiDVItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:49:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55F5532E3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650617198; x=1682153198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s/DO6I1ZNkwiSDyuYRpJh3Y8axFQM3avrVgktjkcA/4=;
  b=EgJ/aRf9I/oNZUYUaSIkNnzeBHUna6MDVa2NpjhrweUCOmmkn36EWnLf
   pe9iIAn74/fi8yhokxVbz/7sedjRjSGRpbqByS03rVjWiqd+xxQ1PkQLV
   SSrTmCeb+sjr9HQ1PdD2EFssy+zIpdV5P8UzSUMfeS6ujdRdvgIYSzGdd
   EB/NkaM+i5+5fWGypOQbNzc4Zmd5NG1n9El55e5dX/hdu2i6do4qDqq6D
   ugfDrvO+uYgYoNYMFFJ+7N1t3buUk8SO2Qq4btfZsYyi8+Oai0GQ38aV3
   6wz3QRYFuKbtQFK0VagPQTA8yBRJs2kStqRLsVK3ormQfIaOXGHu5aKek
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325073436"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="325073436"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 01:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="530741233"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2022 01:46:37 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhow0-0009wY-Ix;
        Fri, 22 Apr 2022 08:46:36 +0000
Date:   Fri, 22 Apr 2022 16:46:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1632/2579]
 drivers/gpu/drm/i915/gt/intel_lrc.h:96:49: error: implicit declaration of
 function 'GENMASK'
Message-ID: <202204221638.zaC4nU9r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 1486cbbdf88b0bede470bd74183443b6d29bf637 [1632/2579] headers/deps: Optimize <linux/kernel.h>
config: x86_64-randconfig-c002 (https://download.01.org/0day-ci/archive/20220422/202204221638.zaC4nU9r-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=1486cbbdf88b0bede470bd74183443b6d29bf637
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 1486cbbdf88b0bede470bd74183443b6d29bf637
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/gpu/drm/i915/gt/intel_lrc.h: In function 'lrc_desc_priority':
>> drivers/gpu/drm/i915/gt/intel_lrc.h:96:49: error: implicit declaration of function 'GENMASK' [-Werror=implicit-function-declaration]
      96 | #define GEN12_CTX_PRIORITY_MASK                 GENMASK(10, 9)
         |                                                 ^~~~~~~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CHECK'
     114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_lrc.h:97:49: note: in expansion of macro 'FIELD_PREP'
      97 | #define GEN12_CTX_PRIORITY_HIGH                 FIELD_PREP(GEN12_CTX_PRIORITY_MASK, 2)
         |                                                 ^~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_lrc.h:97:60: note: in expansion of macro 'GEN12_CTX_PRIORITY_MASK'
      97 | #define GEN12_CTX_PRIORITY_HIGH                 FIELD_PREP(GEN12_CTX_PRIORITY_MASK, 2)
         |                                                            ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_lrc.h:116:24: note: in expansion of macro 'GEN12_CTX_PRIORITY_HIGH'
     116 |                 return GEN12_CTX_PRIORITY_HIGH;
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/GENMASK +96 drivers/gpu/drm/i915/gt/intel_lrc.h

f4c1fdb93992ff Matt Roper 2022-03-01   88  
f4c1fdb93992ff Matt Roper 2022-03-01   89  #define CTX_GTT_ADDRESS_MASK			GENMASK(31, 12)
f4c1fdb93992ff Matt Roper 2022-03-01   90  #define GEN8_CTX_VALID				(1 << 0)
f4c1fdb93992ff Matt Roper 2022-03-01   91  #define GEN8_CTX_FORCE_PD_RESTORE		(1 << 1)
f4c1fdb93992ff Matt Roper 2022-03-01   92  #define GEN8_CTX_FORCE_RESTORE			(1 << 2)
f4c1fdb93992ff Matt Roper 2022-03-01   93  #define GEN8_CTX_L3LLC_COHERENT			(1 << 5)
f4c1fdb93992ff Matt Roper 2022-03-01   94  #define GEN8_CTX_PRIVILEGE			(1 << 8)
f4c1fdb93992ff Matt Roper 2022-03-01   95  #define GEN8_CTX_ADDRESSING_MODE_SHIFT		3
adfadb5638bf32 Matt Roper 2022-03-01  @96  #define GEN12_CTX_PRIORITY_MASK			GENMASK(10, 9)
adfadb5638bf32 Matt Roper 2022-03-01   97  #define GEN12_CTX_PRIORITY_HIGH			FIELD_PREP(GEN12_CTX_PRIORITY_MASK, 2)
adfadb5638bf32 Matt Roper 2022-03-01   98  #define GEN12_CTX_PRIORITY_NORMAL		FIELD_PREP(GEN12_CTX_PRIORITY_MASK, 1)
adfadb5638bf32 Matt Roper 2022-03-01   99  #define GEN12_CTX_PRIORITY_LOW			FIELD_PREP(GEN12_CTX_PRIORITY_MASK, 0)
f4c1fdb93992ff Matt Roper 2022-03-01  100  #define GEN8_CTX_ID_SHIFT			32
f4c1fdb93992ff Matt Roper 2022-03-01  101  #define GEN8_CTX_ID_WIDTH			21
f4c1fdb93992ff Matt Roper 2022-03-01  102  #define GEN11_SW_CTX_ID_SHIFT			37
f4c1fdb93992ff Matt Roper 2022-03-01  103  #define GEN11_SW_CTX_ID_WIDTH			11
f4c1fdb93992ff Matt Roper 2022-03-01  104  #define GEN11_ENGINE_CLASS_SHIFT		61
f4c1fdb93992ff Matt Roper 2022-03-01  105  #define GEN11_ENGINE_CLASS_WIDTH		3
f4c1fdb93992ff Matt Roper 2022-03-01  106  #define GEN11_ENGINE_INSTANCE_SHIFT		48
f4c1fdb93992ff Matt Roper 2022-03-01  107  #define GEN11_ENGINE_INSTANCE_WIDTH		6
f4c1fdb93992ff Matt Roper 2022-03-01  108  #define XEHP_SW_CTX_ID_SHIFT			39
f4c1fdb93992ff Matt Roper 2022-03-01  109  #define XEHP_SW_CTX_ID_WIDTH			16
f4c1fdb93992ff Matt Roper 2022-03-01  110  #define XEHP_SW_COUNTER_SHIFT			58
f4c1fdb93992ff Matt Roper 2022-03-01  111  #define XEHP_SW_COUNTER_WIDTH			6
f4c1fdb93992ff Matt Roper 2022-03-01  112  

:::::: The code at line 96 was first introduced by commit
:::::: adfadb5638bf32e97326ec05ae379be561e13677 drm/i915/xehp: Define context scheduling attributes in lrc descriptor

:::::: TO: Matt Roper <matthew.d.roper@intel.com>
:::::: CC: Matt Roper <matthew.d.roper@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
