Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4FC4C0CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbiBWHFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiBWHFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:05:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ED769289
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:04:50 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gi6so1858894pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ycvtQ3x+tBOLnQe9ohfzJwRCt8EjV3T3oRPVQXF6STA=;
        b=cpgNQE/BRM3yZTYUpl03605SF32dLy7M/gmg85oXPDcZOaPzGbdsVZv3+zVLx/iEFg
         zJNnVXHAu0CSdsSx4Kgi+7rCUgOcltZKjkLg3/u6/ID2l5ughOVdCu7x3mSylEPTS6Jp
         XYdtMZBoUi83TgL2mEklS73IoolSJWqYhZtydEHopZKmcikOqetMw5et8IvOORHWDNCg
         tXNvtDnNOzHo6wm5VaRiNPTBpAYevSYovspQP9IuMv7yFOBcdUD75U+A8sxalO/W5j9M
         k/FroIn3VAIXVdInGv+PSgWy8J0PPmpRLvXouPSExaXoDYMv9IFLPok5xkxpvCuateEP
         GsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ycvtQ3x+tBOLnQe9ohfzJwRCt8EjV3T3oRPVQXF6STA=;
        b=GE9+mfAqu0fRSwDhV+YoRMspsda/JNHjrmBBxHtcHjdN2dIJYYOWCHNM+GPphs+5Nq
         YKJ7LY7s1uXNjxvHt4eolGRkpCnHaIBCotC6RhhAUMbNT2oDrDAhyC0MQyh2f+7atFeV
         FcLC8woAn4vD6tygYJF7IUC+zRJYsehYCPmWo/XxCeQEYX5Wsy2GrZEoTComqE6kfsAJ
         rJGtRxw9Xm9rgeDNKTvPO5m+DHHNSFBddR+z8d+sTGXhbpz1Tn4vGIdhljdQ56bwT+Lb
         9RaP9IBzy5dAeYr0DLsFRACcv0xO8doMjuCEM8i3T7JorpMBpbLarO58xcDTB2514+yZ
         fUhQ==
X-Gm-Message-State: AOAM530wkNlVK8JPgzTXXoRIT/za6moBQ6W3MMVJc2g+8oDFn6OXKk5k
        4Hgd802BgEasSIKHsE5p7w8=
X-Google-Smtp-Source: ABdhPJyGGk1NoYjxfEEKrSndnykQVTVFRve15Weat2XR+qkKJv9NaAmYPiYaGWLX44piJ2W6sSMS7A==
X-Received: by 2002:a17:90a:2e0e:b0:1bc:dbe:2d04 with SMTP id q14-20020a17090a2e0e00b001bc0dbe2d04mr7842136pjd.74.1645599890222;
        Tue, 22 Feb 2022 23:04:50 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:1a:efea::754])
        by smtp.gmail.com with ESMTPSA id q13sm20290774pfj.44.2022.02.22.23.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 23:04:49 -0800 (PST)
Message-ID: <4769a3c0-449b-184a-5c61-a0e155f9c5b4@gmail.com>
Date:   Wed, 23 Feb 2022 15:04:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/4] x86/hyperv: Add missing ARCH_HAS_CC_PLATFORM
 dependency
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
References: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
 <20220222185740.26228-2-kirill.shutemov@linux.intel.com>
 <YhVCoveTwsDZXE5G@zn.tnic>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YhVCoveTwsDZXE5G@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/2022 4:08 AM, Borislav Petkov wrote:
> On Tue, Feb 22, 2022 at 09:57:37PM +0300, Kirill A. Shutemov wrote:
>> On x86, cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) supposes to return
>> true for HyperV if isolation is supported. But it only does it if the
>> kernel is compiled with AMD_MEM_ENCRYPT enabled.
>>
>> It happens due to missed ARCH_HAS_CC_PLATFORM dependency. Without
>> ARCH_HAS_CC_PLATFORM enabled, cc_platform_has() always returns false.
>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>> Cc: Haiyang Zhang <haiyangz@microsoft.com>
>> Cc: Stephen Hemminger <sthemmin@microsoft.com>
>> Cc: Wei Liu <wei.liu@kernel.org>
>> Cc: Dexuan Cui <decui@microsoft.com>
>> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>>   drivers/hv/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index 0747a8f1fcee..424d3f0751dc 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -8,6 +8,7 @@ config HYPERV
>>   		|| (ARM64 && !CPU_BIG_ENDIAN))
>>   	select PARAVIRT
>>   	select X86_HV_CALLBACK_VECTOR if X86
>> +	select ARCH_HAS_CC_PLATFORM if x86
>>   	select VMAP_PFN
>>   	help
>>   	  Select this option to run Linux as a Hyper-V client operating
>> -- 
> 
> Good catch.
> 
> I'm guessing this needs
> 
> Fixes: c789b90a6904 ("x86/hyper-v: Add hyperv Isolation VM check in the cc_platform_has()")
> 
> which added hyperv_cc_platform_has() and which needs to go to Linus now,
> as an urgent fix for 5.17 as that patch came into 5.17-rc1.
> 
> Wei?
> 

Hi Borias, wei and Kill:
       Current Hyper-V Isolation VM requires AMD_MEM_ENCRYPT option 
which selects ARCH_HAS_CC_PLATFORM. Linux guest can't boot up without 
AMD_MEM_ENCRYPT option. So this is why not select ARCH_HAS_CC_PLATFORM
here.
