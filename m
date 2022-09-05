Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A85AC8A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 04:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiIECCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 22:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbiIECCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 22:02:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A5222B20
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 19:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662343330; x=1693879330;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vLf2DUrqgD3AasIcaTUxXz9NENttsW0jzONYuURKbuo=;
  b=ZUCEiyYxne3n58C2kZKymwmzCIQn1flHQKAhKUPpkVqmCCjDzW8aIBiX
   KOd6CqbOKjWgWgN3H6COlJinEN88uO6VuCSRNF97CFsIbWKfZD1tbzjJW
   0Teoq0yB3FEdY1bHjSWTRbroz/oRP5a7/+unFPy9HeWGriyJrAJAL74Hn
   FMa+9FDTTnX/a5TzK77D5XsB8N4pyj121VJC0YMH73YOGJE6YRtk12YUQ
   PaCkcWxTMfk/Pn+p6+3WIb2YtGbI3p/kVXLbxWOg6XIjkyvhvxR8qUUE3
   rQdfF9U/ge6/7Y6fNW3VABBhDEcKN3bAfbF9i+Fngjv8VzMRuqxk5IeCB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="283282742"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="283282742"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 19:02:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="643623041"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.208.118]) ([10.254.208.118])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 19:02:07 -0700
Subject: Re: [kbuild-all] Re: mm/khugepaged.c:2046:56: warning: 'struct
 khugepaged_mm_slot' declared inside parameter list will not be visible
 outside of this definition or declaration
To:     Qi Zheng <zhengqi.arch@bytedance.com>,
        kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202209022248.TEjW4Cld-lkp@intel.com>
 <52d6d592-efb6-036b-5390-635913c598f3@bytedance.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <8c7a3be0-ee06-98e0-5825-a2f5cbfb029f@intel.com>
Date:   Mon, 5 Sep 2022 10:02:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <52d6d592-efb6-036b-5390-635913c598f3@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/2022 11:37 PM, Qi Zheng wrote:
> 
> 
> On 2022/9/2 22:23, kernel test robot wrote:
>> tree:   
>> https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220901-154717/Qi-Zheng/add-common-struct-mm_slot-and-use-it-in-THP-and-KSM/20220831-112149 
>>
>> head:   32b787e37af17f7fe75f9b9c9bb22bf044722229
>> commit: 7ad02cf1645071c2bf1ed6ae0e48907aa0a3119e mm: thp: fix build 
>> error with CONFIG_SHMEM disabled
>> date:   30 hours ago
>> config: sparc-randconfig-r023-20220901 
>> (https://download.01.org/0day-ci/archive/20220902/202209022248.TEjW4Cld-lkp@intel.com/config) 
>>
>> compiler: sparc64-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # 
>> https://github.com/intel-lab-lkp/linux/commit/7ad02cf1645071c2bf1ed6ae0e48907aa0a3119e 
>>
>>          git remote add linux-review 
>> https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review 
>> UPDATE-20220901-154717/Qi-Zheng/add-common-struct-mm_slot-and-use-it-in-THP-and-KSM/20220831-112149 
>>
>>          git checkout 7ad02cf1645071c2bf1ed6ae0e48907aa0a3119e
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 
>> make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> mm/khugepaged.c:2046:56: warning: 'struct khugepaged_mm_slot' 
>>>> declared inside parameter list will not be visible outside of this 
>>>> definition or declaration
>>      2046 | static void khugepaged_collapse_pte_mapped_thps(struct 
>> khugepaged_mm_slot *mm_slot)
>>           |                                                        
>> ^~~~~~~~~~~~~~~~~~
>>     mm/khugepaged.c: In function 'khugepaged_scan_mm_slot':
>>     mm/khugepaged.c:2076:45: error: passing argument 1 of 
>> 'khugepaged_collapse_pte_mapped_thps' from incompatible pointer type 
>> [-Werror=incompatible-pointer-types]
>>      2076 |         khugepaged_collapse_pte_mapped_thps(mm_slot);
>>           |                                             ^~~~~~~
>>           |                                             |
>>           |                                             struct mm_slot *
> 
> It looks like the robot tested "mm: thp: fix build error with
> CONFIG_SHMEM disabled" alone without "[PATCH v2 2/7] mm: thp: convert to
> use common struct mm_slot". So this is a false positive.

Hi Qi,

Thanks for the explanation, you are right, the robot was considered this
patch as a replacement of "[PATCH v2 2/7] mm: thp: convert to use common
struct mm_slot".

Best Regards,
Rong Chen

> 
>>     mm/khugepaged.c:2046:76: note: expected 'struct khugepaged_mm_slot 
>> *' but argument is of type 'struct mm_slot *'
>>      2046 | static void khugepaged_collapse_pte_mapped_thps(struct 
>> khugepaged_mm_slot *mm_slot)
>>           |                                                 
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>>     cc1: some warnings being treated as errors
>>
>>
>> vim +2046 mm/khugepaged.c
>>
>>    2045
>>> 2046    static void khugepaged_collapse_pte_mapped_thps(struct 
>>> khugepaged_mm_slot *mm_slot)
>>    2047    {
>>    2048    }
>>    2049    #endif
>>    2050
>>
> 
