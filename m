Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492C44B453B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242655AbiBNJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:10:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiBNJKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:10:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C655FF3A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644829832; x=1676365832;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Zvx1p7ukw01mN0RxqZlHJLRTqrQhBmVUPWWAtfX6goc=;
  b=GW57xIFKlyM8zQahYBGxDC10f3rGBG53dVLllVyEnerzCHlBEZYUDo3O
   rjlfNK5RLT50q2L1X76lvV0nQow3Lr73aIOYFGWGIScZw5H9ohDHdjA6I
   MwG3jj0METej/giFiayVQcbquhiqOXgCyiPa+oGbF1PjSYDT2Tzwns0Fw
   3x01Y0Ni76M6BXTNnZJlAIojq2Yz7e9s46xTIN5FWbYQiuAZ6OJRbRIQm
   bUKk/gaTkmofbkdVgvobEJzIq6D/TNrzF0UtK5OwMjhzfvTak8QiRw3WC
   CrR1jchhNaANYG0tE7uGOf5a22TCweJ0oIY9FbrjgyAMdjzCdHgBrW2EU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="274619082"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="274619082"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:10:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="528015440"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.201]) ([10.255.30.201])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:10:30 -0800
Subject: Re: [kbuild-all] Re: include/linux/smp.h:34:33: error: requested
 alignment '20' is not a positive power of 2
To:     Helge Deller <deller@gmx.de>, kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202202131741.c6BPpfzd-lkp@intel.com>
 <1c419d0f-9f37-9a7b-7353-44b6f2f2c11a@gmx.de>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <a99e0842-09a5-878d-3235-ac117fef7403@intel.com>
Date:   Mon, 14 Feb 2022 17:10:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1c419d0f-9f37-9a7b-7353-44b6f2f2c11a@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2022 4:44 AM, Helge Deller wrote:
> On 2/13/22 10:59, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
>> commit: 5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e parisc: Fix compile failure when building 64-bit kernel natively
>> date:   6 months ago
>> config: parisc-randconfig-r004-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131741.c6BPpfzd-lkp@intel.com/config)
>> compiler: hppa64-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All error/warnings (new ones prefixed by >>):
>>
>>     In file included from arch/parisc/include/asm/bitops.h:203,
>>                      from include/linux/bitops.h:32,
>>                      from include/linux/kernel.h:12,
>>                      from arch/parisc/include/asm/bug.h:5,
>>                      from include/linux/bug.h:5,
>>                      from include/linux/page-flags.h:10,
>>                      from kernel/bounds.c:10:
>>     include/asm-generic/bitops/__fls.h: In function '__fls':
>>>> include/asm-generic/bitops/__fls.h:18:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>>        18 |         if (!(word & (~0ul << 32))) {
> 
> 
> This kind of build error usually happens if you use the 64-bit compiler
> (hppa64-linux-gcc) to compile a kernel config for a 32-bit kernel.
> 
> Looking at the config:
>> config: parisc-randconfig-r004-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131741.c6BPpfzd-lkp@intel.com/config)
> CONFIG_64BIT is set to Y, so that's correct here.
> 
> But this is how you call the compiler:
>> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare
> 
> The "ARCH=parisc" is wrong in this case.
> You need:
> "ARCH=parisc64".
> This is starting with Linux kernel 5.14.
> Before "ARCH=parisc" worked for 32- and 64-bit kernels.
> 
> Can you adjust the call command?

Hi Helge,

Thanks for the feedback, we'll update it.

Best Regards,
Rong Chen
