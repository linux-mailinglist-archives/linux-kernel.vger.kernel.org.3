Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6DE5ABFEC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiICQ6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 12:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiICQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 12:57:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9694BA7C
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662224274; x=1693760274;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FgwLo0OSaqWGwSmvO4HdjqqQr9wo29Wa/BNgzi0H7Fo=;
  b=ZRe/XhRrNBkWGM9wzLEiUUMIeDdzkpeXlrl43aUYkhSG5NkR1Nl6WY82
   22oUCKZoS2wIsH2v2V+EBdlAda4gMA/hcdI2Kjbfoy5/ByP1B9NLUWVf9
   GI3wsJVP0kNJ+YjrXMmnJdLkqF+xWf5O8tfmEkot/geXIGUPZ2vVs7jfJ
   HLTR18O2kQiumstrO1aPfEjHe3YgC1YNctdaCt3AkOE/M4D53pZ4sT1zn
   vI4odXV4kVGSrX++fKMcEdsxlo7y/lbKXZCh0c2wSABw3MnC/XKaYVQIt
   JX9zDq2wp7uaF+aoIyyjYI0yZct9ZhyTnMvSI2jKd1ai45MsimqcoG49A
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="357886276"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="357886276"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 09:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="643301140"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2022 09:57:53 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUWSu-0001wO-1M;
        Sat, 03 Sep 2022 16:57:52 +0000
Date:   Sun, 4 Sep 2022 00:57:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/insn/rework 17/17] arch/arm64/lib/insn.c:37:6: warning:
 no previous prototype for 'test__insn_imm_insn__unsigned_N'
Message-ID: <202209040035.zoHGzSIk-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/insn/rework
head:   e7a596adf2e7a4ff7e585c053b93d81730d605a7
commit: e7a596adf2e7a4ff7e585c053b93d81730d605a7 [17/17] HACK: arm64: insn: add immediate tests
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220904/202209040035.zoHGzSIk-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=e7a596adf2e7a4ff7e585c053b93d81730d605a7
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/insn/rework
        git checkout e7a596adf2e7a4ff7e585c053b93d81730d605a7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:79:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      79 | IMM_ROUNDTRIP(imm6_15);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:37:6: warning: no previous prototype for 'test__insn_imm_insn__unsigned_imm6_10' [-Wmissing-prototypes]
      37 | bool test__insn_imm_insn__unsigned_##imm(const u32 old_insn)            \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:80:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      80 | IMM_ROUNDTRIP(imm6_10);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:45:6: warning: no previous prototype for 'test__insn_imm_insn__signed_imm6_10' [-Wmissing-prototypes]
      45 | bool test__insn_imm_insn__signed_##imm(const u32 old_insn)              \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:80:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      80 | IMM_ROUNDTRIP(imm6_10);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:53:6: warning: no previous prototype for 'test__imm_insn_imm__unsigned_imm6_10' [-Wmissing-prototypes]
      53 | bool test__imm_insn_imm__unsigned_##imm(const u64 imm)                  \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:80:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      80 | IMM_ROUNDTRIP(imm6_10);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:60:6: warning: no previous prototype for 'test__imm_insn_imm__signed_imm6_10' [-Wmissing-prototypes]
      60 | bool test__imm_insn_imm__signed_##imm(const s64 imm)                    \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:80:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      80 | IMM_ROUNDTRIP(imm6_10);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:37:6: warning: no previous prototype for 'test__insn_imm_insn__unsigned_immr' [-Wmissing-prototypes]
      37 | bool test__insn_imm_insn__unsigned_##imm(const u32 old_insn)            \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:81:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      81 | IMM_ROUNDTRIP(immr);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:45:6: warning: no previous prototype for 'test__insn_imm_insn__signed_immr' [-Wmissing-prototypes]
      45 | bool test__insn_imm_insn__signed_##imm(const u32 old_insn)              \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:81:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      81 | IMM_ROUNDTRIP(immr);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:53:6: warning: no previous prototype for 'test__imm_insn_imm__unsigned_immr' [-Wmissing-prototypes]
      53 | bool test__imm_insn_imm__unsigned_##imm(const u64 imm)                  \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:81:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      81 | IMM_ROUNDTRIP(immr);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:60:6: warning: no previous prototype for 'test__imm_insn_imm__signed_immr' [-Wmissing-prototypes]
      60 | bool test__imm_insn_imm__signed_##imm(const s64 imm)                    \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:81:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      81 | IMM_ROUNDTRIP(immr);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:37:6: warning: no previous prototype for 'test__insn_imm_insn__unsigned_imms' [-Wmissing-prototypes]
      37 | bool test__insn_imm_insn__unsigned_##imm(const u32 old_insn)            \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:82:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      82 | IMM_ROUNDTRIP(imms);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:45:6: warning: no previous prototype for 'test__insn_imm_insn__signed_imms' [-Wmissing-prototypes]
      45 | bool test__insn_imm_insn__signed_##imm(const u32 old_insn)              \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:82:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      82 | IMM_ROUNDTRIP(imms);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:53:6: warning: no previous prototype for 'test__imm_insn_imm__unsigned_imms' [-Wmissing-prototypes]
      53 | bool test__imm_insn_imm__unsigned_##imm(const u64 imm)                  \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:82:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      82 | IMM_ROUNDTRIP(imms);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:60:6: warning: no previous prototype for 'test__imm_insn_imm__signed_imms' [-Wmissing-prototypes]
      60 | bool test__imm_insn_imm__signed_##imm(const s64 imm)                    \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:82:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      82 | IMM_ROUNDTRIP(imms);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:37:6: warning: no previous prototype for 'test__insn_imm_insn__unsigned_hw' [-Wmissing-prototypes]
      37 | bool test__insn_imm_insn__unsigned_##imm(const u32 old_insn)            \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:83:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      83 | IMM_ROUNDTRIP(hw);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:45:6: warning: no previous prototype for 'test__insn_imm_insn__signed_hw' [-Wmissing-prototypes]
      45 | bool test__insn_imm_insn__signed_##imm(const u32 old_insn)              \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:83:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      83 | IMM_ROUNDTRIP(hw);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:53:6: warning: no previous prototype for 'test__imm_insn_imm__unsigned_hw' [-Wmissing-prototypes]
      53 | bool test__imm_insn_imm__unsigned_##imm(const u64 imm)                  \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:83:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      83 | IMM_ROUNDTRIP(hw);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:60:6: warning: no previous prototype for 'test__imm_insn_imm__signed_hw' [-Wmissing-prototypes]
      60 | bool test__imm_insn_imm__signed_##imm(const s64 imm)                    \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:83:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      83 | IMM_ROUNDTRIP(hw);
         | ^~~~~~~~~~~~~
>> arch/arm64/lib/insn.c:37:6: warning: no previous prototype for 'test__insn_imm_insn__unsigned_N' [-Wmissing-prototypes]
      37 | bool test__insn_imm_insn__unsigned_##imm(const u32 old_insn)            \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:84:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      84 | IMM_ROUNDTRIP(N);
         | ^~~~~~~~~~~~~
>> arch/arm64/lib/insn.c:45:6: warning: no previous prototype for 'test__insn_imm_insn__signed_N' [-Wmissing-prototypes]
      45 | bool test__insn_imm_insn__signed_##imm(const u32 old_insn)              \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:84:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      84 | IMM_ROUNDTRIP(N);
         | ^~~~~~~~~~~~~
>> arch/arm64/lib/insn.c:53:6: warning: no previous prototype for 'test__imm_insn_imm__unsigned_N' [-Wmissing-prototypes]
      53 | bool test__imm_insn_imm__unsigned_##imm(const u64 imm)                  \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:84:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      84 | IMM_ROUNDTRIP(N);
         | ^~~~~~~~~~~~~
>> arch/arm64/lib/insn.c:60:6: warning: no previous prototype for 'test__imm_insn_imm__signed_N' [-Wmissing-prototypes]
      60 | bool test__imm_insn_imm__signed_##imm(const s64 imm)                    \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:84:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      84 | IMM_ROUNDTRIP(N);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:37:6: warning: no previous prototype for 'test__insn_imm_insn__unsigned_sf' [-Wmissing-prototypes]
      37 | bool test__insn_imm_insn__unsigned_##imm(const u32 old_insn)            \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:85:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      85 | IMM_ROUNDTRIP(sf);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:45:6: warning: no previous prototype for 'test__insn_imm_insn__signed_sf' [-Wmissing-prototypes]
      45 | bool test__insn_imm_insn__signed_##imm(const u32 old_insn)              \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:85:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      85 | IMM_ROUNDTRIP(sf);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:53:6: warning: no previous prototype for 'test__imm_insn_imm__unsigned_sf' [-Wmissing-prototypes]
      53 | bool test__imm_insn_imm__unsigned_##imm(const u64 imm)                  \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:85:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      85 | IMM_ROUNDTRIP(sf);
         | ^~~~~~~~~~~~~
   arch/arm64/lib/insn.c:60:6: warning: no previous prototype for 'test__imm_insn_imm__signed_sf' [-Wmissing-prototypes]
      60 | bool test__imm_insn_imm__signed_##imm(const s64 imm)                    \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:85:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      85 | IMM_ROUNDTRIP(sf);
         | ^~~~~~~~~~~~~
>> arch/arm64/lib/insn.c:37:6: warning: no previous prototype for 'test__insn_imm_insn__unsigned_sh' [-Wmissing-prototypes]
      37 | bool test__insn_imm_insn__unsigned_##imm(const u32 old_insn)            \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:86:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      86 | IMM_ROUNDTRIP(sh);
         | ^~~~~~~~~~~~~
>> arch/arm64/lib/insn.c:45:6: warning: no previous prototype for 'test__insn_imm_insn__signed_sh' [-Wmissing-prototypes]
      45 | bool test__insn_imm_insn__signed_##imm(const u32 old_insn)              \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:86:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      86 | IMM_ROUNDTRIP(sh);
         | ^~~~~~~~~~~~~
>> arch/arm64/lib/insn.c:53:6: warning: no previous prototype for 'test__imm_insn_imm__unsigned_sh' [-Wmissing-prototypes]
      53 | bool test__imm_insn_imm__unsigned_##imm(const u64 imm)                  \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:86:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      86 | IMM_ROUNDTRIP(sh);
         | ^~~~~~~~~~~~~
>> arch/arm64/lib/insn.c:60:6: warning: no previous prototype for 'test__imm_insn_imm__signed_sh' [-Wmissing-prototypes]
      60 | bool test__imm_insn_imm__signed_##imm(const s64 imm)                    \
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/lib/insn.c:86:1: note: in expansion of macro 'IMM_ROUNDTRIP'
      86 | IMM_ROUNDTRIP(sh);
         | ^~~~~~~~~~~~~


vim +/test__insn_imm_insn__unsigned_N +37 arch/arm64/lib/insn.c

    35	
    36	#define IMM_ROUNDTRIP(imm)						\
  > 37	bool test__insn_imm_insn__unsigned_##imm(const u32 old_insn)		\
    38	{									\
    39		u32 new_insn = old_insn;					\
    40		u64 imm = aarch64_insn_decode_unsigned_##imm(old_insn);		\
    41		if (!aarch64_insn_try_encode_unsigned_##imm(&new_insn, imm))	\
    42			return true;						\
    43		return new_insn == old_insn;					\
    44	}									\
  > 45	bool test__insn_imm_insn__signed_##imm(const u32 old_insn)		\
    46	{									\
    47		u32 new_insn = old_insn;					\
    48		s64 imm = aarch64_insn_decode_signed_##imm(old_insn);		\
    49		if (!aarch64_insn_try_encode_signed_##imm(&new_insn, imm))	\
    50			return true;						\
    51		return new_insn == old_insn;					\
    52	}									\
  > 53	bool test__imm_insn_imm__unsigned_##imm(const u64 imm)			\
    54	{									\
    55		u32 insn = 0;							\
    56		if (!aarch64_insn_try_encode_unsigned_##imm(&insn, imm))	\
    57			return true;						\
    58		return aarch64_insn_decode_unsigned_##imm(insn) == imm;		\
    59	}									\
  > 60	bool test__imm_insn_imm__signed_##imm(const s64 imm)			\
    61	{									\
    62		u32 insn = 0;							\
    63		if (!aarch64_insn_try_encode_signed_##imm(&insn, imm))		\
    64			return true;						\
    65		return aarch64_insn_decode_signed_##imm(insn) == imm;		\
    66	}
    67	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
