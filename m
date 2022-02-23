Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801CF4C1524
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbiBWOKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiBWOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:09:56 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE99B0D21
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 06:09:29 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v5-20020a17090ac90500b001bc40b548f9so2330268pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 06:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=vd/BQny+U9Mjs2NLdiMyj2jf8SFnVPtXtnefChlq/MI=;
        b=axGDHsonfgTcPQr/K819KUb6VzuB1mmBnK6yymjXHdnDVO97Ltt8WX819PGKXhSdod
         QsMLUrFTJiErDVEx22i5HdtOvPFx57xAX90jwckg8xWyvVBBARR7eozUdfqHlxGSBg4Q
         Ai11MKDBOWCPh9JUMVVPnu6Lzv75mN2K1VbwgOCW1xgYbV8mOxQ0PGPPr3ybwZV/j8qq
         M86zXJp379Z87sy85Odolr0zUyjOjol3xRl0BBglqVbZXvF8Pja6URpQGtGezXqoRtSn
         lTvdBVV527Ex05ctMnUnsXCGjLhEp05zxkCQKE5jGsc5XcG1fUkxK/w016bG5jkJuCtO
         xuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=vd/BQny+U9Mjs2NLdiMyj2jf8SFnVPtXtnefChlq/MI=;
        b=AgnnCKUe7/3DejJf7z5hXJMBw63A1HWLgYU92x8dMvkaUlmFR40Y+mL3wlWdAr0qk9
         mu/gDydFEdY4oPvGWRjzxawQNE1TOjPTWUxaO9CSFWp23B/eCB3poFuOzNcVjrNdirp1
         V4voVBrzeAnAnDn6mHgqZvyIGKYZHMrmkKRDuEHpM34271H2mEvU7RATySyNq+0eX/6r
         T5Rgve4XTNz+Pp+wOC7BQsIHSjkV6cRKV623AaoeNIMGpMeU30BFnen6Z0w+XjAvMPzU
         sVjNjES80t1tWAscDc1Wx9Nxmr7bbrYv/TJPBrUrh160UL96vuzwsNAe3mcGi/Z0z7Fk
         IvBA==
X-Gm-Message-State: AOAM530XjegbJkEtj/KXcA3gIQnJT9Le/+ILanQAI9zVQFwbvq3ziEWt
        6BhsaRU+Yz5gD8rhn1vJFxE=
X-Google-Smtp-Source: ABdhPJxFjk17KmE2fXNygU/V6sIbx8zi4XBUnTc80kHewZmukthkM7UyqBL/ocEmEApmd8RwyGkR/A==
X-Received: by 2002:a17:90a:b396:b0:1bc:588a:c130 with SMTP id e22-20020a17090ab39600b001bc588ac130mr9273846pjr.97.1645625368664;
        Wed, 23 Feb 2022 06:09:28 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:18:efec::754])
        by smtp.gmail.com with ESMTPSA id z15sm3261300pjf.31.2022.02.23.06.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 06:09:28 -0800 (PST)
Message-ID: <a34587e5-a144-c4a5-56f0-235da22ebce5@gmail.com>
Date:   Wed, 23 Feb 2022 22:09:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
From:   Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH 1/4] x86/hyperv: Add missing ARCH_HAS_CC_PLATFORM
 dependency
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Wei Liu <wei.liu@kernel.org>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
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
 <YhVCoveTwsDZXE5G@zn.tnic> <4769a3c0-449b-184a-5c61-a0e155f9c5b4@gmail.com>
 <YhYPPHKZFsGzaI2U@zn.tnic> <bcdbd534-a077-3bb3-3d37-c9eb2a048854@gmail.com>
 <YhYS00FywnE8g4Um@zn.tnic> <b172898d-0464-054a-9182-1110297f3629@gmail.com>
 <20220223114724.4luaemfi3tyedlvh@black.fi.intel.com>
Content-Language: en-US
In-Reply-To: <20220223114724.4luaemfi3tyedlvh@black.fi.intel.com>
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



On 2/23/2022 7:47 PM, Kirill A. Shutemov wrote:
> On Wed, Feb 23, 2022 at 07:02:49PM +0800, Tianyu Lan wrote:
>> On 2/23/2022 6:56 PM, Borislav Petkov wrote:
>>> On Wed, Feb 23, 2022 at 06:43:40PM +0800, Tianyu Lan wrote:
>>>> Hyper-V code check cpuid during runtime and there is no Hyper-V
>>>> isolation VM option.
>>>
>>> So how does "Current Hyper-V Isolation VM requires AMD_MEM_ENCRYPT" work
>>> exactly?
>>>
>>> Please explain in detail and not in piecemeal sentences.
>>>
>> The kernel in the image needs to select AMD_MEM_ENCRYPT option
>> otherwise the kernel can't boot up due to missing SEV support and
>> sev_es_ghcb_hv_call() always return error.
> 
> If kernel boots under SEV, doesn't it mean we have 'sme_me_mask'
> initialized? If it is non zero hv_is_isolation_supported() check in
> cc_platform_has() has zero effect as it checked after 'sme_me_mask'.
> 
> I still have no idea what is going on.
> 
> How SEV related to HyperV isolation? How detection happens? Could you
> give full picture?
> 

Hi Kriil:
      Current Hyper-V Isolation VM is unenlightened VM design. Hyper-V 
hides SEV capability from Linux guest and expose Hyper-V cpuid to show 
Hyper-V isolation VM capability. So sme_me_mask is zero in this case 
because SEV capability cpuid returns not-support.
      Hyper-V Isolation VM code uses some SEV API sev_es_ghcb_hv_call() 
to share code and so it's necessary to select AMD_MEM_ENCRYPT option for
Hyper-V Isolation VM.
