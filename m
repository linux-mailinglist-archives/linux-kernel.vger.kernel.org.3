Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126705897AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbiHDGOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiHDGON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:14:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7486761131
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 23:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659593652; x=1691129652;
  h=subject:references:to:cc:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=keluER8k9LcEIGCnCE9Rn2VCqT3BmU8FUYIaHG9ODJg=;
  b=Ee+Tin3UmTJKhXRpDLwL5J8UoWzZoh36o6Td+o9YmEOyGmF4ap2NfAq3
   kGWSRLFXlRghCCdb+cYTRhckjF658QApU5mtHW+uOhtsCmq0cpp+74ZFm
   5rAWkriaNDJQLSMAv5EfOHCGbu3/YDv4OugHQollezXMuisYdrRwYRuoH
   mnVscc2fRjU2Sx9cacwoDSxXKbY6u/ZcoO6CXOMDyQmcCxh6/WCdZVdd0
   CRjLPcAlnOQCoX6c2JImSdCWruTovMsMdcsdDl+7gL8GwciAVxtCV+tV8
   T5YcGiyg69so68c7DkUOYcFc/JHcuXABf28z5XO/EmxQQmhA/0gMYUA0/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="269623608"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="269623608"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 23:13:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="578940823"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.36]) ([10.255.28.36])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 23:13:40 -0700
Subject: [mark:arm64/stacktrace/rework-cleanup 3/8]
 arch/arm64/kernel/sdei.c:66:21: error: use of undeclared identifier
 'sdei_stack_normal_ptr'
References: <202208040427.vAzlkXzS-lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Mark Brown <broonie@kernel.org>
From:   kernel test robot <rong.a.chen@intel.com>
X-Forwarded-Message-Id: <202208040427.vAzlkXzS-lkp@intel.com>
Message-ID: <16ba6649-d680-69d4-dbd3-3b1ffb06319b@intel.com>
Date:   Thu, 4 Aug 2022 14:13:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202208040427.vAzlkXzS-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git 
arm64/stacktrace/rework-cleanup
head:   ff57049f8e5ec88c03b804c73bb4dd44ffa88896
commit: 10b1649e7fc666d82f11a5b4463013b3e46a7a53 [3/8] arm64: 
stacktrace: move SDEI stack helpers to stacktrace code
config: arm64-buildonly-randconfig-r003-20220803 
(https://download.01.org/0day-ci/archive/20220804/202208040427.vAzlkXzS-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 
495519e5f8232d144ed26e9c18dbcbac6a5f25eb)
reproduce (this is a W=1 build):
         wget 
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
-O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install arm64 cross compiling tool for clang build
         # apt-get install binutils-aarch64-linux-gnu
         # 
https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=10b1649e7fc666d82f11a5b4463013b3e46a7a53
         git remote add mark 
https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
         git fetch --no-tags mark arm64/stacktrace/rework-cleanup
         git checkout 10b1649e7fc666d82f11a5b4463013b3e46a7a53
         # save the config file
         mkdir build_dir && cp config build_dir/.config
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 
O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/kernel/sdei.c:66:21: error: use of undeclared identifier 'sdei_stack_normal_ptr'
                    _free_sdei_stack(&sdei_stack_normal_ptr, cpu);
                                      ^
>> arch/arm64/kernel/sdei.c:67:21: error: use of undeclared identifier 'sdei_stack_critical_ptr'
                    _free_sdei_stack(&sdei_stack_critical_ptr, cpu);
                                      ^
    arch/arm64/kernel/sdei.c:92:27: error: use of undeclared identifier 
'sdei_stack_normal_ptr'
                    err = _init_sdei_stack(&sdei_stack_normal_ptr, cpu);
                                            ^
    arch/arm64/kernel/sdei.c:95:27: error: use of undeclared identifier 
'sdei_stack_critical_ptr'
                    err = _init_sdei_stack(&sdei_stack_critical_ptr, cpu);
                                            ^
    4 errors generated.


vim +/sdei_stack_normal_ptr +66 arch/arm64/kernel/sdei.c

f5df26961853d6 James Morse 2018-01-08  57  f5df26961853d6 James Morse 
2018-01-08  58  static void free_sdei_stacks(void)
f5df26961853d6 James Morse 2018-01-08  59  {
f5df26961853d6 James Morse 2018-01-08  60  	int cpu;
f5df26961853d6 James Morse 2018-01-08  61  eec3bf6861a870 Will Deacon 
2020-12-01  62  	if (!IS_ENABLED(CONFIG_VMAP_STACK))
eec3bf6861a870 Will Deacon 2020-12-01  63  		return;
eec3bf6861a870 Will Deacon 2020-12-01  64  f5df26961853d6 James Morse 
2018-01-08  65  	for_each_possible_cpu(cpu) {
f5df26961853d6 James Morse 2018-01-08 @66  	 
_free_sdei_stack(&sdei_stack_normal_ptr, cpu);
f5df26961853d6 James Morse 2018-01-08 @67  	 
_free_sdei_stack(&sdei_stack_critical_ptr, cpu);
f5df26961853d6 James Morse 2018-01-08  68  	}
f5df26961853d6 James Morse 2018-01-08  69  }
f5df26961853d6 James Morse 2018-01-08  70
:::::: The code at line 66 was first introduced by commit
:::::: f5df26961853d6809d704cedcaf082c57f635a64 arm64: kernel: Add 
arch-specific SDEI entry code and CPU masking

:::::: TO: James Morse <james.morse@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

