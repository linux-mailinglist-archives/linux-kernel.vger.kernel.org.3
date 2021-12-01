Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F0E464BA4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348686AbhLAKd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348677AbhLAKdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:33:19 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8C7C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 02:29:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l16so51068996wrp.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 02:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=//+dfE93ZZmvMCrDlyACZK9oOicfdPiqdxisT9tlyY8=;
        b=3eTScEiR0DUW/gbj8d7hI2hPU1IJpZhrqWEjhUtCIZd0Q7fv0XNtrXnRA4q07lSnyJ
         a5A0UjnUiH21M8Zvdxe6nqsdA1hho4LEDSsdr1+LFbdZV6nA4KAPoYT+QFvvDgeag19t
         idaX2GSXrMrBSxjoJffhqeSK9qdoJRNYuJHNGFBqSt4FpVH2bvaSn/I6bne49kn7MRHO
         aCdWW0YWMOlGg0OpheGOHnUq/H8lYuG6g/yjKhIRGfSiV9msziNu+EdpgvQgMHuVA6hL
         WlW3ABCIfLonPqeCb25flabBC0xBOlm/aETkzdcafqGsC8GBKDnrVqjI5/PPUuveJpwd
         W+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=//+dfE93ZZmvMCrDlyACZK9oOicfdPiqdxisT9tlyY8=;
        b=UQ48GNYlUf+Yh9pChAbGYaFLpyegu6KoU6ZwarwkZbl16+i7q9A9C60r7pjTNwFKsY
         1xzm7D7tlA5/RlHy790SfpAOSQuSmyTpYGAiVvlUl9BoAZcMQL/iF2nBuE0tpXfi3O5D
         sO5oM/8UWUuSK8D8PGUHkuT/qfBQlU7trE9n7PFvJsxVPQYNOPIAUw4ugs7zKOg79Jfp
         ezGCqVt06hWZm8lM+u6+5L4iAVt/DLIYscc7t7fo0Zf6NCJfcK8eLmkJirsUmbyf3ImI
         q2CJnUL1Tz7RC+jqSQtreaL6IBTB6c5ihbFGHYynCEudqMLhGD0WnDG1wDX7IgEBgbbh
         OhKQ==
X-Gm-Message-State: AOAM532oME9QAxm+yvM5+lprrjBgYKUloJFe38Ami1NbfiLVL8yc2Obp
        X5WUCRasNBlRVBB5Fdi1hapMTw==
X-Google-Smtp-Source: ABdhPJyYpGRVRmr8ZHENzuaqRBrUBBE6CcxFUnZSprKd2ydbqJb1744R1+4xXx0AzpKyLxmt52KBWg==
X-Received: by 2002:adf:df0b:: with SMTP id y11mr5515796wrl.181.1638354597189;
        Wed, 01 Dec 2021 02:29:57 -0800 (PST)
Received: from ?IPv6:2a02:6b6d:f804:0:cb78:17b3:7a45:45ff? ([2a02:6b6d:f804:0:cb78:17b3:7a45:45ff])
        by smtp.gmail.com with ESMTPSA id f15sm855656wmg.30.2021.12.01.02.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 02:29:56 -0800 (PST)
Subject: Re: [External] Re: [PATCH] x86/purgatory: provide config to disable
 purgatory
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        fam.zheng@bytedance.com, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>
References: <20211123150508.3397898-1-usama.arif@bytedance.com>
 <YZ0HkaOiKfmgN8zl@zn.tnic> <YaTd4ZID7O+bVRXT@redhat.com>
 <79517d3c-3674-cc21-fbdc-b26946809756@bytedance.com>
 <87o862c396.fsf@email.froward.int.ebiederm.org>
From:   Usama Arif <usama.arif@bytedance.com>
Message-ID: <433e69ec-3079-b905-b07f-b9c7a910be4f@bytedance.com>
Date:   Wed, 1 Dec 2021 10:29:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87o862c396.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(Resending the reply as my email client had updated and inserted html 
code and caused a bounceback from the mailing list, sorry about that.)

Thanks for your reply, I have responded with further comments/questions 
inline below, and also have provided some context for the patch at the 
start:

The patch is not introducing a new CONFIG option, as can be seen in the 
v2 patch diff. It is converting an existing CONFIG option that only 
enabled purgatory for specific architectures in which it has been 
implemented (x86, powerpc and s390) to an option that can that allow 
purgatory to be disabled (with default enabled) and only provides code 
to disable purgatory for x86 only. From what i see, purgatory is 
currently not yet implemented in other architectures like arm64 
kexec_file case and riscv, so this would on a high level,
provide only the option to make kexec on x86 similar to other the other 
architectures.

As a background to the discussion, the usecase we are aiming is to 
update the host kernel with kexec in servers which is managing multiple 
VMs, to cut down the downtime of servers as much as possible so that its 
not noticeable to VMs. The patch is aimed at x86 purgatory code 
specifically. We are targetting other optimizations as well in other 
areas in boot path to cut down the 600ms time much further, so that cut 
down of 200ms downtime is significant in the usecase described. I did 
have a few comments/questions about your reply, please see my responses 
below:


On 29/11/2021 16:53, Eric W. Biederman wrote:
> Usama Arif <usama.arif@bytedance.com> writes:
> 
>> Hi,
>>
>> Thanks for your replies. I have submitted a v2 of the patch with a
>> much more detailed commit message including reason for the patch and timing values.
>>
>> The time taken from reboot to running init process was measured
>> with both purgatory enabled and disabled over 20 runs and the
>> averages are:
>> Purgatory disabled:
>> - TSC = 3908766161 cycles
>> - ktime = 606.8 ms
>> Purgatory enabled:
>> - TSC = 5005811885 cycles (28.1% worse)
>> - ktime = 843.1 ms (38.9% worse)
>>
>>
>> Our reason for this patch is that it helps reduce the downtime of servers when
>> the host kernel managing multiple VMs needs to be updated via kexec,
>> but it makes reboot with kexec much faster so should be a general improvement in
>> boot time if purgatory is not needed and could have other usecases as well.
>> I believe only x86, powerpc and s390 have purgatory supported, other platforms
>> like arm64 dont have it implemented yet, so with the reboot time improvement seen,
>> it would be a good idea to have the option to disable purgatory completely but set default to y.
>> We also have the CONFIG_KEXEC_BZIMAGE_VERIFY_SIG which can be enabled to verify the next
>> kernel image to be booted and purgatory can be completely skipped if
>> not required.
> 
> CONFIG_KEXEC_BZIMAGE_VERIFY_SIG is something totally and completely
> different.  It's job is to verify that the kernel to be booted comes
> from a trusted source.   The sha256 verification in purgatory's job
> is to verify that memory the kernel cares about was not corrupted
> during the kexec process.
> 

Thanks, acknowledged.

> I believe when you say purgatory you are really talking about that
> sha256 checksum.  It really is not possible to disable all of
> the code that runs between kernels, as the old and the new kernel may
> run at the same addresses.  Anything that runs between the two kernels
> is what is referred to as purgatory.  Even if it is just a small
> assembly stub.
> 
 >

With this patch, i am trying to give an option (with default purgatory 
enabled)to disable purgatory completely on x86 only, i.e. no code 
running between 2 kernels on x86. From my understanding there is no 
purgatory in arm64 kexec_file case, in riscv and in some other archs as 
well, so I am not sure why its not possible to disable purgatory (all 
code running between 2 kernels) in x86? Unless i misunderstood something 
about the working of other platforms? In x86 case, from what i see 
relocate_kernel is still part of the older kernel and not purgatory, and 
with my patch, purgatory.ro is not built and kexec does execute 
successfully with purgatory disabled.

About your point for the old and the new kernel may run at the same 
addresses,i dont think that can happen as in bzImage64_load function its 
loaded using the kbuf struct. This doesnt happen in other architectures 
(for e.g. arm64) that dont implement purgatory and any of the tests I 
conducted with the patch applied due to the use of kbuf struct.

 From what i see in the code, purgatory in x86 specifically, has 2 main 
functions, sha256 verification and loading the %rsi register for 
bootparam_load_addr. In this patch purgatory was disabled, which 
resulted in sha256 verification disabled and bootparam_load_addr moved 
to relocate_kernel. Our analysis revealed that most of the time is spent 
in the sha256 verification, so I would be ok to reformat the patch
to make the sha verification optional and keep purgatory enabled if 
thats preferred? Although in my opinion the current patch of only 
providing an option to disable purgatory seems much better.


> That sha256 verification is always needed for kexec on panic, there are
> by the nature of a kernel panic too many unknowns to have any confidence
> the new kernel will not be corrupted in the process of kexec before it
> gets started.
> 
> For an ordinary kexec it might be possible to say that you have a
> reliable kernel shutdown process and you know for a fact that something
> won't come along and corrupt the kernel.  I find that a questionable
> assertion.  I haven't seen anyone yet whose focus when getting an
> ordinary kexec to work as anything other than making certain all of the
> drivers are shutdown properly.
> 
> I have seen countless times when a network packet comes in a the wrong
> time and the target kernel's memory is corrupted before it gets far
> enough to initialize the network driver. >

I agree that when doing testing and research, there are things that can
go wrong during kexec process, but i assume that the expectation is that
in production environment, when for e.g. updating a kernel with kexec in 
servers,the expectation is that kexec will execute successfully as long 
as there is nothing wrong in the old kernel and the new kernel.

Maybe I didn't understand this correctly, but if a network packet comes 
in and corrupts the kernel memory, wont it also cause a problem even 
when purgatory is enabled? I agree that issue like these would be caught 
earlier with purgatory, but then if something like this breaks the kexec 
process in a production environment where the old and new kernel are 
well tested, trusted and expected to work, wouldn't there be a much more 
fundamental issue with the reliability of the current kexec process.

> For a 0.2s speed up you are talking about disabling all of the safety
> checks in a very dangerous situation.  How much can you can in
> performance by optimizing the sha256 implementation instead of using
> what is essentially a reference implementation in basic C that I copied
> from somewhere long ago.
> 
> Optimize the sha256 implementation and the memory copy loop and then
> show how the tiny bit of time that is left is on a mission critical path
> and must be removed.  Then we can reasonably talk about a config option
> for disabling the sha256 implementation in the kexec in not-panic case.
> 
Thanks for this, I assume that over here you are suggesting for e.g. in 
x86 to replace the existing sha verification implementation in purgatory 
with the one in arch/x86/crypto/sha256_ssse3_glue.c? Also could you 
point to the memory copy loop to optimize? I can have a look at these 2 
options.

Even with these optimizations, i think the v2 patch should still be 
considered. The patch in the end is providing only an option to disable 
purgatory on x86 only, with the default value of keeping it enabled and 
not changing kexec behaviour. The CONFIG already existed, it is just 
renamed and now provides user the option to select to disable purgatory 
for x86, rather than it being architecture dependent.

Thanks again for the review and comments,
Usama


> That sha256 implementation in part so that we can all sleep at night
> because we don't have to deal with very very strange heizenbugs.
> 
> Eric
> 
