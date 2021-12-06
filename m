Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAAF46A1D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbhLFQym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbhLFQyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:54:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D01DC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:51:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d9so23784565wrw.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 08:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DingI/S8Qqc3Dg1VH72Mlr76sblojllSmCyAojzmGZ4=;
        b=XEM4Zzp2usn327abzdV6m03OBuuKCMHC2cHtf5xBDd6WyHWtNiEGMCVrmfm2pT3fev
         P9GSrUcNvSi0hf3/5R1cuJXb69KwgRGGBkN0iOyAbWNyeqDpWVEX5xVG/b0arV4ouFBo
         2Vi5p/7vZkx447BBecTdkvU/0+Jp7YnmVB7MwTzLdBBA095ndamwdiEX6Wm9M5v5kBzr
         3Rl2irEbj45W8gy4JO3UNSxfubp6qtjvb9RY7ZxbFOwfW+zoeLDp0dTdoQi2uzrNPcUK
         B8BI/NvElqK/rsf694UD0WHwBv17Wh3UYDS0XGuMYrNOYUMJr9OGF3xF6o+H/WbRHlra
         nBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DingI/S8Qqc3Dg1VH72Mlr76sblojllSmCyAojzmGZ4=;
        b=dxQ/RhD7X+55F9/gGcW0bKDD82RcpWSTH7nCsijcnHZUD8eV7gW3RKN4CW7GfFtzmy
         xjuS13BX9nM/ZnBd8DoFWX7uGhCOGSE/kIlUBdXoFk72GBA3n/iX8MDyjAb0LU68ajST
         gEoupe4akyXQWXvefnSDoNmeuXyEDMewrqZ4LtNOLsymc5ixBXyBPLrHneZmz9VBvlYs
         n0nwZikYK/I8buZkmTyucLrGkyw5rAvGXu0L1F/aIc5ZLU6jo0TwPdrpJX2Cd6Lw9hqM
         tyZJo0AwVZ0yE29WempdgMld0yH0hPPrVkZvAZC2CGpD/bzQq3x93MEuyrcO1747TGPm
         vzRw==
X-Gm-Message-State: AOAM530AAqQzzbr5tINa2wc0sQwrG65FYZsNaQCAhTKshR5kfNzOd7Bk
        KjNpyxya9B6UsXTbC5+bybKa4O5WA+iic2s8
X-Google-Smtp-Source: ABdhPJzSV/tJTJP+PxA+DdRVA2W5KyJD0dCNGYBp9pM1X/gNFUOs0u2Wt8gK0FirL0vPla8a/wXA/A==
X-Received: by 2002:a05:6000:1a43:: with SMTP id t3mr44732496wry.555.1638809470894;
        Mon, 06 Dec 2021 08:51:10 -0800 (PST)
Received: from ?IPv6:2a02:6b6d:f804:0:f209:703c:1a57:7e? ([2a02:6b6d:f804:0:f209:703c:1a57:7e])
        by smtp.gmail.com with ESMTPSA id j40sm13942118wms.19.2021.12.06.08.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 08:51:10 -0800 (PST)
Subject: Re: [External] Re: [PATCH] x86/purgatory: provide config to disable
 purgatory
From:   Usama Arif <usama.arif@bytedance.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        fam.zheng@bytedance.com, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>
References: <20211123150508.3397898-1-usama.arif@bytedance.com>
 <YZ0HkaOiKfmgN8zl@zn.tnic> <YaTd4ZID7O+bVRXT@redhat.com>
 <79517d3c-3674-cc21-fbdc-b26946809756@bytedance.com>
 <87o862c396.fsf@email.froward.int.ebiederm.org>
 <433e69ec-3079-b905-b07f-b9c7a910be4f@bytedance.com>
Message-ID: <33d9b711-288c-e5f4-0cc8-365c01861da5@bytedance.com>
Date:   Mon, 6 Dec 2021 16:51:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <433e69ec-3079-b905-b07f-b9c7a910be4f@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have sent a v3 of the patch with a much clearer commit message, please
let me know if there are any comments for the v3 patch or my responses 
below.

Thanks,
Usama

On 01/12/2021 10:29, Usama Arif wrote:
> Hi,
> 
> (Resending the reply as my email client had updated and inserted html 
> code and caused a bounceback from the mailing list, sorry about that.)
> 
> Thanks for your reply, I have responded with further comments/questions 
> inline below, and also have provided some context for the patch at the 
> start:
> 
> The patch is not introducing a new CONFIG option, as can be seen in the 
> v2 patch diff. It is converting an existing CONFIG option that only 
> enabled purgatory for specific architectures in which it has been 
> implemented (x86, powerpc and s390) to an option that can that allow 
> purgatory to be disabled (with default enabled) and only provides code 
> to disable purgatory for x86 only. From what i see, purgatory is 
> currently not yet implemented in other architectures like arm64 
> kexec_file case and riscv, so this would on a high level,
> provide only the option to make kexec on x86 similar to other the other 
> architectures.
> 
> As a background to the discussion, the usecase we are aiming is to 
> update the host kernel with kexec in servers which is managing multiple 
> VMs, to cut down the downtime of servers as much as possible so that its 
> not noticeable to VMs. The patch is aimed at x86 purgatory code 
> specifically. We are targetting other optimizations as well in other 
> areas in boot path to cut down the 600ms time much further, so that cut 
> down of 200ms downtime is significant in the usecase described. I did 
> have a few comments/questions about your reply, please see my responses 
> below:
> 
> 
> On 29/11/2021 16:53, Eric W. Biederman wrote:
>> Usama Arif <usama.arif@bytedance.com> writes:
>>
>>> Hi,
>>>
>>> Thanks for your replies. I have submitted a v2 of the patch with a
>>> much more detailed commit message including reason for the patch and 
>>> timing values.
>>>
>>> The time taken from reboot to running init process was measured
>>> with both purgatory enabled and disabled over 20 runs and the
>>> averages are:
>>> Purgatory disabled:
>>> - TSC = 3908766161 cycles
>>> - ktime = 606.8 ms
>>> Purgatory enabled:
>>> - TSC = 5005811885 cycles (28.1% worse)
>>> - ktime = 843.1 ms (38.9% worse)
>>>
>>>
>>> Our reason for this patch is that it helps reduce the downtime of 
>>> servers when
>>> the host kernel managing multiple VMs needs to be updated via kexec,
>>> but it makes reboot with kexec much faster so should be a general 
>>> improvement in
>>> boot time if purgatory is not needed and could have other usecases as 
>>> well.
>>> I believe only x86, powerpc and s390 have purgatory supported, other 
>>> platforms
>>> like arm64 dont have it implemented yet, so with the reboot time 
>>> improvement seen,
>>> it would be a good idea to have the option to disable purgatory 
>>> completely but set default to y.
>>> We also have the CONFIG_KEXEC_BZIMAGE_VERIFY_SIG which can be enabled 
>>> to verify the next
>>> kernel image to be booted and purgatory can be completely skipped if
>>> not required.
>>
>> CONFIG_KEXEC_BZIMAGE_VERIFY_SIG is something totally and completely
>> different.  It's job is to verify that the kernel to be booted comes
>> from a trusted source.   The sha256 verification in purgatory's job
>> is to verify that memory the kernel cares about was not corrupted
>> during the kexec process.
>>
> 
> Thanks, acknowledged.
> 
>> I believe when you say purgatory you are really talking about that
>> sha256 checksum.  It really is not possible to disable all of
>> the code that runs between kernels, as the old and the new kernel may
>> run at the same addresses.  Anything that runs between the two kernels
>> is what is referred to as purgatory.  Even if it is just a small
>> assembly stub.
>>
>  >
> 
> With this patch, i am trying to give an option (with default purgatory 
> enabled)to disable purgatory completely on x86 only, i.e. no code 
> running between 2 kernels on x86. From my understanding there is no 
> purgatory in arm64 kexec_file case, in riscv and in some other archs as 
> well, so I am not sure why its not possible to disable purgatory (all 
> code running between 2 kernels) in x86? Unless i misunderstood something 
> about the working of other platforms? In x86 case, from what i see 
> relocate_kernel is still part of the older kernel and not purgatory, and 
> with my patch, purgatory.ro is not built and kexec does execute 
> successfully with purgatory disabled.
> 
> About your point for the old and the new kernel may run at the same 
> addresses,i dont think that can happen as in bzImage64_load function its 
> loaded using the kbuf struct. This doesnt happen in other architectures 
> (for e.g. arm64) that dont implement purgatory and any of the tests I 
> conducted with the patch applied due to the use of kbuf struct.
> 
>  From what i see in the code, purgatory in x86 specifically, has 2 main 
> functions, sha256 verification and loading the %rsi register for 
> bootparam_load_addr. In this patch purgatory was disabled, which 
> resulted in sha256 verification disabled and bootparam_load_addr moved 
> to relocate_kernel. Our analysis revealed that most of the time is spent 
> in the sha256 verification, so I would be ok to reformat the patch
> to make the sha verification optional and keep purgatory enabled if 
> thats preferred? Although in my opinion the current patch of only 
> providing an option to disable purgatory seems much better.
> 
> 
>> That sha256 verification is always needed for kexec on panic, there are
>> by the nature of a kernel panic too many unknowns to have any confidence
>> the new kernel will not be corrupted in the process of kexec before it
>> gets started.
>>
>> For an ordinary kexec it might be possible to say that you have a
>> reliable kernel shutdown process and you know for a fact that something
>> won't come along and corrupt the kernel.  I find that a questionable
>> assertion.  I haven't seen anyone yet whose focus when getting an
>> ordinary kexec to work as anything other than making certain all of the
>> drivers are shutdown properly.
>>
>> I have seen countless times when a network packet comes in a the wrong
>> time and the target kernel's memory is corrupted before it gets far
>> enough to initialize the network driver. >
> 
> I agree that when doing testing and research, there are things that can
> go wrong during kexec process, but i assume that the expectation is that
> in production environment, when for e.g. updating a kernel with kexec in 
> servers,the expectation is that kexec will execute successfully as long 
> as there is nothing wrong in the old kernel and the new kernel.
> 
> Maybe I didn't understand this correctly, but if a network packet comes 
> in and corrupts the kernel memory, wont it also cause a problem even 
> when purgatory is enabled? I agree that issue like these would be caught 
> earlier with purgatory, but then if something like this breaks the kexec 
> process in a production environment where the old and new kernel are 
> well tested, trusted and expected to work, wouldn't there be a much more 
> fundamental issue with the reliability of the current kexec process.
> 
>> For a 0.2s speed up you are talking about disabling all of the safety
>> checks in a very dangerous situation.  How much can you can in
>> performance by optimizing the sha256 implementation instead of using
>> what is essentially a reference implementation in basic C that I copied
>> from somewhere long ago.
>>
>> Optimize the sha256 implementation and the memory copy loop and then
>> show how the tiny bit of time that is left is on a mission critical path
>> and must be removed.  Then we can reasonably talk about a config option
>> for disabling the sha256 implementation in the kexec in not-panic case.
>>
> Thanks for this, I assume that over here you are suggesting for e.g. in 
> x86 to replace the existing sha verification implementation in purgatory 
> with the one in arch/x86/crypto/sha256_ssse3_glue.c? Also could you 
> point to the memory copy loop to optimize? I can have a look at these 2 
> options.
> 
> Even with these optimizations, i think the v2 patch should still be 
> considered. The patch in the end is providing only an option to disable 
> purgatory on x86 only, with the default value of keeping it enabled and 
> not changing kexec behaviour. The CONFIG already existed, it is just 
> renamed and now provides user the option to select to disable purgatory 
> for x86, rather than it being architecture dependent.
> 
> Thanks again for the review and comments,
> Usama
> 
> 
>> That sha256 implementation in part so that we can all sleep at night
>> because we don't have to deal with very very strange heizenbugs.
>>
>> Eric
>>
