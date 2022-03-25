Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91704E717F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbiCYKrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244975AbiCYKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:47:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BB56C967
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648205142; x=1679741142;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UD8MmFaum6Iq0L4S/lqF0zGXWod9VwZTnnyRjoN0cRE=;
  b=NIFDVfsEMBHMFLF7E7d4T41ZzIK5ST5mMnqYksN6dXgkpwUIcDl66CL6
   2LDrSEZHP+FAuDKmCpNEh9J6MtFbV7xqZdHYmSZynG8RGy96lfdx2Vw9c
   V3r9ExrhndfFa20v+oyRan4uGEiiwRuB7Ofja9zKdZRAKC9aLhbj76+Ou
   E0rD4pxAqxmIlCC9H3RbYqi7EBYOJYx5cQyqrJ16+ocf7dNVdVGfDpeHs
   q0CW9rrFU9GyyPT10ek0Ql+hT9MMbWTHFcd4b5yE+nv/bDxwMXpG3mncZ
   9lydLio5D04BH0yT0ODxQbW/8AH6JsSmOSFcRMqGQGFmJERNoTRJT3vMd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="345046078"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="345046078"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 03:45:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="561788129"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.29.177]) ([10.255.29.177])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 03:45:39 -0700
Subject: Re: [tip:sched/core] BUILD SUCCESS
 3387ce4d8a5f2956fab827edf499fe6780e83faa
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
References: <6238fde0.Qe5umewxqwiDe2GE%lkp@intel.com>
 <YjkHkb7joeu5GCto@dev-arch.thelio-3990X>
 <24dd031a-8ea7-5f01-4d80-3fb30d212c8a@intel.com>
 <20220324175801.GJ8939@worktop.programming.kicks-ass.net>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <2d37183b-e0d5-dd37-11c7-9b0e415daaf4@intel.com>
Date:   Fri, 25 Mar 2022 18:45:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220324175801.GJ8939@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2022 1:58 AM, Peter Zijlstra wrote:
> On Tue, Mar 22, 2022 at 10:39:41AM +0800, Chen, Rong A wrote:
>> On 3/22/2022 7:17 AM, Nathan Chancellor wrote:
>>> Hello,
>>>
>>> On Tue, Mar 22, 2022 at 06:36:16AM +0800, kernel test robot wrote:
>>>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
>>>> branch HEAD: 3387ce4d8a5f2956fab827edf499fe6780e83faa  headers/prep: Fix header to build standalone: <linux/psi.h>
>>>>
>>>> elapsed time: 730m
>>>>
>>>> configs tested: 114
>>>> configs skipped: 3
>>>>
>>>> The following configs have been built successfully.
>>>> More configs may be tested in the coming days.
>>>>
>>>> gcc tested configs:
>>> ...
>>>> arm                              allyesconfig
>>>> arm                              allmodconfig
>>>
> 
>>> Are you sure these configurations built sucessfully?
> 
> ...
> 
>> Thanks for your reminding, the problem commit is 4ff8f2ca6ccd
>> ("sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h
>> dependencies"),
>> the bot has sent two build reports related to it:
>>
>>    https://lore.kernel.org/all/202203152116.qphmikIZ-lkp@intel.com/
>>    https://lore.kernel.org/all/202203152144.uFQqgVUf-lkp@intel.com/
>>
>> and more reports were stopped to avoid too many noise, like below one:
> 
> ...
> 
>> We'll adjust the strategy avoid blocking some important reports.
> 
> Oh *PLEASE* never report a branch as building if there's errors.
> It could be I (force) push a branch multiple times before I get any
> 0day reports back (0day has gotten *soooo* slow) so I only ever look at
> the latest report -- possibly days later.

Hi Peter,

Sorry for the bad experience, I'm not sure the meaning of "a branch as
building", is there a way to know the branch is not ready, or we can
postpone the test for a branch by a day?


> 
> If you then falsly report the branch as being good, because you're
> suppressing errors, things *will* go bad.
> 
> 

yes, current the summary report only shows the errors that bisected
successfully in a cycle, but it may causes some errors missing
and old errors still in the report, we plan to redesign the report
to present all (may a lot) recent errors.

Best Regards,
Rong Chen
