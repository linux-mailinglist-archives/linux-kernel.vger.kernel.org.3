Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B114F4C5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578298AbiDEXTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452397AbiDEPyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:54:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F22445514
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=IewJ5FbjVkowhuDQ9RQAlMe54keYpdgNViGTWxozKWc=; b=quO14FwJRbcL5PXhvDM7UO5Np8
        PtFikFw6HNTT4VBrn26VikUuxpv/d0fYcF/gCGbgvlkziJu1LFdY58GW5SIo/Pv0T2GCaQH0ovd7B
        XprFHaRU6Lu5djhouvH0bASHSBScaXWPghaeye7xQotILop2kX1t7BIu1P1dRq9RrVgGzUIOnhwoc
        5du3aiiFn+lI8erbF0GxXx3xZ9vq+WLjHRK5DWi+llwGsj2Sp9v9CGKKgamybsPtF+Xu7JbZ2GCOn
        f5IDKUMvxu3E67c5yAfpRfJJBjiFZ9S9GF4ZhijZi6Aox5zKLamm7VtYQS/y0RZ7JGcwxwnR//ylO
        XF2q3NFQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbkZq-001scK-3i; Tue, 05 Apr 2022 14:54:38 +0000
Message-ID: <663906a0-b464-10e9-529f-249eb0214cea@infradead.org>
Date:   Tue, 5 Apr 2022 07:54:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] ARM: vexpress/spc: Fix doxygen comments
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel test robot <lkp@intel.com>
References: <20220404130207.1162445-1-sudeep.holla@arm.com>
 <008aae79-4a6c-721f-7ef5-7b73f6d7e000@infradead.org>
 <20220405140800.baww2wrow3hdp5ho@bogus>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220405140800.baww2wrow3hdp5ho@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/22 07:08, Sudeep Holla wrote:
> Hi Randy,
> 
> On Mon, Apr 04, 2022 at 05:21:39PM -0700, Randy Dunlap wrote:
>> Hi--
>>
>> On 4/4/22 06:02, Sudeep Holla wrote:
>>> Kbuild bot reported the following doxygen build warning:
>>>
>>>   |  arch/arm/mach-versatile/spc.c:231: warning: This comment starts with
>>>   |		'/**', but isn't a kernel-doc comment.
>>>   |		Refer Documentation/doc-guide/kernel-doc.rst
>>>   |  		* ve_spc_cpu_in_wfi(u32 cpu, u32 cluster)
>>>
>>> Fix the issue by dropping the parameters specified in the kernel doc.
>>>
>>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Link: https://lore.kernel.org/linux-doc/202204031026.4ogKxt89-lkp@intel.com
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>  arch/arm/mach-vexpress/spc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
>>> index 1c6500c4e6a1..8f99d47d4b89 100644
>>> --- a/arch/arm/mach-vexpress/spc.c
>>> +++ b/arch/arm/mach-vexpress/spc.c
>>> @@ -228,7 +228,7 @@ static u32 standbywfi_cpu_mask(u32 cpu, u32 cluster)
>>>  }
>>>  
>>>  /**
>>> - * ve_spc_cpu_in_wfi(u32 cpu, u32 cluster)
>>> + * ve_spc_cpu_in_wfi()
>>
>> This line still needs a "function short description," e.g.
>>
>> + * ve_spc_cpu_in_wfi() - fooble the barfloppity
>>
>> similar to what you did in patch 2/2.
> 
> I did this intentionally, I can move only this from the other patch.
> Since I saw few others w/o description, I addressed all at once in the
> second patch and just remove warning reported in this patch. I am fine
> either way.

Oh, my bad. I didn't notice that it was the same function in
both patches.
So no problem there.

>>
>>>   *
>>>   * @cpu: mpidr[7:0] bitfield describing CPU affinity level within cluster
>>>   * @cluster: mpidr[15:8] bitfield describing cluster affinity level
>>
>> and I would s/doxygen/kernel-doc/ for both patches.
>>
> 
> Sure will do.
> 

thanks.
-- 
~Randy
