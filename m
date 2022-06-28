Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2169355F1E2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiF1XY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiF1XY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:24:26 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3059344FC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:24:24 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id n15so22315231qvh.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=me-ssier-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M0nki+uCChscthyLMQ6QNGmV2cW9q6IchOxRXIsdC00=;
        b=d6LPlHjOsM9+C5KucjjVtBjf+Ru7GOPy+avibTwB7JZEDgCtgBXwgODeOVv0dWpLUI
         WwvaoNURHjytlyzJvDMFT7NnRBr3KJkGHp7lTu+ln+IUltX1DfQkvYSWzsQBaWhR9skC
         SX5qbEDB6iAoq01xFLfAoSgce+Je8MqS1v1FA7AX5Pl25GlaeUfJodhEocaDqnGW1+5a
         V+ceh+ZKCuTlgPpJwocq3a7BKbT2Bye7xU/Z6i9jpIYbgsvXZpmBXpTDFz3wJttoovrU
         hkV+B1pF8ZDo2N+aMmNjJwpwfX98k7aLr4bigK5F9m2xW21YOdAOxaKFku1TcGtzbtCW
         Mw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M0nki+uCChscthyLMQ6QNGmV2cW9q6IchOxRXIsdC00=;
        b=w9GsoZ+VNg/Ff6wMoe7mdprC6k+cBK3prgTEGzqn0kkiUjFh2S0L5sIOdjAvH4E6KT
         gNpM8zW3JsK6YKEIwC9xg592M9+KwzsIG74+hFMKjpoY9zr5A3Se2EVPxvF22k4muGaJ
         aNhN6vmODvFk1Hqa3wsSNmCCeulfXxQL0H+Qzeg61PY5C3PC3b/g53dxbR2rQ2wSJp31
         2nqAYHtexgz6s0ZGNg+5Qjn/2TGgL7HTC/3/YSqxgj5St6rBFJJPOntJjpw0Ue0rGxdf
         /93YV+S97NxYA+HFjkX+3uVLWC00Tnh8Uhwzxc5Jq9Ls78tcnYiJjA6o4pCcm04Wu7Dh
         svbg==
X-Gm-Message-State: AJIora8iTezEvlGhLRsyGMxPKOX3mE8/34Vyf5z73++IRcCUp7cwAXd6
        bg5QuBkaHEn8XFkR3OBmVx6Plw==
X-Google-Smtp-Source: AGRyM1vmTYhzCfX+ItVDdY0kse5nPhiILbqYBIAGUKv17WSCPdf3NMlhk/4d9U3MxWXunqttb0cliQ==
X-Received: by 2002:ac8:598d:0:b0:305:25ad:2f1e with SMTP id e13-20020ac8598d000000b0030525ad2f1emr384222qte.237.1656458663797;
        Tue, 28 Jun 2022 16:24:23 -0700 (PDT)
Received: from [192.168.2.14] (bras-base-stggpq3702w-grc-11-142-115-210-184.dsl.bell.ca. [142.115.210.184])
        by smtp.gmail.com with ESMTPSA id bw20-20020a05622a099400b00304bc2acc25sm9839238qtb.6.2022.06.28.16.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 16:24:23 -0700 (PDT)
Message-ID: <a63bba3a-583b-603a-0a4b-2b329b6af1e6@me.ssier.org>
Date:   Tue, 28 Jun 2022 19:24:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [REGRESSION] Unable to unlock encrypted disk starting with kernel
 5.19-rc1+
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Andrew.Cooper3@citrix.com,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        regressions@lists.linux.dev
References: <6025678c-e94a-6966-e298-82fad658a889@me.ssier.org>
 <YrrHwxtD2dpts7PF@zn.tnic>
 <19f8897b-c445-4e66-49b2-9ceca738a263@me.ssier.org> <874k04e6o4.ffs@tglx>
From:   Alexandre Messier <alex@me.ssier.org>
In-Reply-To: <874k04e6o4.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NEUTRAL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-28 18:59, Thomas Gleixner wrote:
> Alexandre,
> 
> On Tue, Jun 28 2022 at 17:31, Alexandre Messier wrote:
>> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>>                   pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
>>                   fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl
>>                   nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq
>>                   monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave
>>                   avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm
>>                   sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce
>>                   topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb
>>                   cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall
>>                   fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a rdseed
>>                   adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1
>>                   xsaves cqm_llc cqm_occup_llc cqm_mbm_total
>>                   cqm_mbm_local
> 
> So this CPU supports XSAVEC and XSAVES which means the kernel uses
> XSAVES as the kernel before that.
> 
>> And here is the dmesg output of 5.19-rc4 without the revert (taken from the
>> initramfs). I put it on a paste service since it is too big for email:
>>
>>   https://paste.debian.net/1245491/
> 
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
> [    0.000000] x86/fpu: Enabled xstate features 0x207, context size is 840 bytes, using 'compacted' format.
> 
> This is correct. Is there any difference on a 5.18 kernel or on 5.19-rc
> with the commit reverted? I doubt that.
> 
> I'm completely puzzled and stared at the commit in question on and off,
> but I can't spot the fail.
> 
>> I setup an unencrypted Debian installation on another drive to be able to run
>> cryptsetup commands in userspace while using rc4, and was able to see the
>> issue. In a up-to-date Debian Sid installation (important, more on this below),
>> running these commands makes it possible to reproduce the issue:
>>
>>   dd if=/dev/zero bs=1M count=20 of=./test.img
>>   sudo cryptsetup luksFormat ./test.img
>>   sudo cryptsetup luksOpen ./test.img test_crypt
>>
>> The "luksOpen" will fail with the same error message I get on my main system.
>>
>> It seems using the latest Debian Sid is important. At first, I was trying with
>> Debian Bullseye, but everything was working, even unlocking my main drive.
>>
>> Could it be a difference due to the cryptsetup version? Sid is using 2.4.3,
>> while Bullseye is based on 2.3.7. I will try to compile cryptsetup 2.4.3 and
>> use it in a Bullseye system with kernel 5.19-rc4, to see if the issue occurs
>> in that setup.
> 
> It might use a different crypto algorithm.
> 
> Still confused....
> 
> I'll have another look tomorrow morning with brain awake.

Thomas, Borislav,

Well this is embarrassing... I ran the test Dave sent in his email, and when
running it on that unencrypted Debian Sid installation with kernel 5.19-rc4, it
failed too, but indicated that "aes-xts" was not available... It was right. 

I forgot to mention I am using a custom kernel config, and indeed CRYPTO_XTS
was not enabled. When I enabled it, the cryptsetup benchmark worked, along with
the test that previously failed with the test file.

So I enabled that option too on my main installation and I am now able to
unlock the drive like before. I don't know why it is needed now, but that fixed
the issue.

Sorry again for the trouble, this was not a kernel regression, but my error.

Thanks,
Alex

#regzbot invalid: Missing kernel config, not kernel regression

> 
> Thanks,
> 
>         tglx

