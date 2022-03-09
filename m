Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA364D2953
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiCIHRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCIHRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:17:48 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE9EECC57
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646810209; x=1678346209;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=S3XRHSJKzuuW7MgeDFbEbO3iEfp5XAbSH5qHFORabzQ=;
  b=izYIye68I102CqdHnRdm23OxPsNc2CuJ/7VfMDHxFAzBs/EWFtYhxwtk
   ae1Ko3Ml+Z47Iz+djZodfUNYBoJ7wV3lhswGUJthCMkjcwGyHOYz05jUp
   0mcqjo8oBHNxwMDlnXVOQo/BHUSPhngYK3Y9PIC+JcYM3P1qvOJc4ZwRb
   B7nMdYC9RS6LV6WEIf+etRkgIHExFBKQBM1pBPKA4VOiCtQAl3Hb36e8U
   MAiKEAICuS7CdbuEH8306sbPKqjnTkhNkWaJGneKmcfGYW0sqXDB5Z6oX
   JffTt29UB6EpkmEiYbx7WFS96jFJHHHrM9Zklla73+AmiR4OLjDWxjEjJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="255097795"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="255097795"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 23:16:49 -0800
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="554001382"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.54]) ([10.255.28.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 23:16:47 -0800
Subject: Re: [kbuild-all] Re: [masahiroy:kbuild 9/9]
 include/linux/byteorder/big_endian.h:8:2: error: #warning inconsistent
 configuration, needs CONFIG_CPU_BIG_ENDIAN
To:     Masahiro Yamada <masahiroy@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Kolpackov <boris@codesynthesis.com>
References: <202203032027.8qFpOWlq-lkp@intel.com>
 <CAK7LNASwGU=-KWfYbcHjEP=pyRvcwY5rmWk_X0a6wMz20s2Pqw@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <cf9f09bc-7fb3-2471-b347-51dd20b1109e@intel.com>
Date:   Wed, 9 Mar 2022 15:16:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNASwGU=-KWfYbcHjEP=pyRvcwY5rmWk_X0a6wMz20s2Pqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/2022 12:19 AM, Masahiro Yamada wrote:
> On Thu, Mar 3, 2022 at 9:33 PM kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kbuild
>> head:   55de8686df7ed2b5237867b130e30c728bbd9db4
>> commit: 55de8686df7ed2b5237867b130e30c728bbd9db4 [9/9] kconfig: change .config format to use =n instead of "is not set"
>> config: arc-randconfig-r005-20220302 (https://download.01.org/0day-ci/archive/20220303/202203032027.8qFpOWlq-lkp@intel.com/config)
>> compiler: arceb-elf-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=55de8686df7ed2b5237867b130e30c728bbd9db4
>>          git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
>>          git fetch --no-tags masahiroy kbuild
>>          git checkout 55de8686df7ed2b5237867b130e30c728bbd9db4
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash lib/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from arch/arc/include/uapi/asm/byteorder.h:14,
>>                      from include/asm-generic/bitops/le.h:6,
>>                      from arch/arc/include/asm/bitops.h:192,
>>                      from include/linux/bitops.h:33,
>>                      from include/linux/log2.h:12,
>>                      from include/asm-generic/div64.h:55,
>>                      from ./arch/arc/include/generated/asm/div64.h:1,
>>                      from include/linux/math.h:5,
>>                      from include/linux/math64.h:6,
>>                      from include/linux/time.h:6,
>>                      from include/linux/stat.h:19,
>>                      from include/linux/module.h:13,
>>                      from lib/test_bitops.c:9:
>>>> include/linux/byteorder/big_endian.h:8:2: error: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Werror=cpp]
>>         8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
>>           |  ^~~~~~~
>>     cc1: all warnings being treated as errors
>>
>>
>> vim +8 include/linux/byteorder/big_endian.h
>>
>> ^1da177e4c3f41 Linus Torvalds 2005-04-16   6
>> e9ef073a0796e4 Babu Moger     2017-09-08   7  #ifndef CONFIG_CPU_BIG_ENDIAN
>> e9ef073a0796e4 Babu Moger     2017-09-08  @8  #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
>> e9ef073a0796e4 Babu Moger     2017-09-08   9  #endif
>> e9ef073a0796e4 Babu Moger     2017-09-08  10
>>
>> :::::: The code at line 8 was first introduced by commit
>> :::::: e9ef073a0796e46c24f037237291efe56fc28ad9 include: warn for inconsistent endian config definition
>>
>> :::::: TO: Babu Moger <babu.moger@oracle.com>
>> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> I cannot reproduce this.
> 
> Maybe, this was a bug in make.cross
> (but already fixed??)
> 
> 
> 

Hi Masahiro,

Sorry for the inconvenience, it's a false positive,
there's a bug in the CI was triggered by this commit.

Best Regards,
Rong Chen
