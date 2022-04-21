Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DB650A620
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiDUQvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiDUQvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:51:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BDE49276;
        Thu, 21 Apr 2022 09:48:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w1so9741767lfa.4;
        Thu, 21 Apr 2022 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H01S+Z7PoKhXtthwBx3mI1VVb20IHa0ThHfpXV2OsWk=;
        b=Te5bNS7bK0yTicPlwPilL/FHzAHcCqm56DhGAmSHJVeyNBi761kWJGIb9kl8TOYuck
         BiTT/cBsA/F5VgqiWxOJFnnaOZHoAT4gI5awBPaMEgiyrEJmcMFoF8VPBkGOxFB/SDy4
         qqeDtPW45B92jzLhCXjMqi+0O7pfeh81IUjPs6/oytjFCbtCGr735rxBqlAvms8VYNT0
         Jvb9G02yo002YknsCfyrj5wNC6z46s/QYuddL1MP5fcS9CizCQNamFZpPEZ8NcHpIzT4
         CTDjLKjMhaRGxDTW8Gn5MvVYUXGQN4Ptv7zh47AOnsIAKcNf/WhNZKku9l22WYc3adFD
         kr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H01S+Z7PoKhXtthwBx3mI1VVb20IHa0ThHfpXV2OsWk=;
        b=DykgAvzxpj6H3pt75Q4xkwWo0tzperKN4BGAAKJp89R4uG1Oz18zJRZY4WXFU7hpq2
         e9n3ZkGR8CIBe9Nh6uYN0VdKFJhbeoTFgSYGJx2ebN3xjmLZt1+aPzyBSErwh41b9q/t
         ezT/3OCDSuNvpetqJjn6NpL8CkQBvtQT+hEl3jmj04YCIQQGqKqDM2r4CV+3uSVy6lQK
         S74a4Qi1MWsJRiEkq+30n6P801mHgBphjnFbkash8z61bA873qPn9fmaju7YA8ogOE+r
         jHABpQQg9K1jKMOFpDKTZUmQvCZSIm9w1INlNov0X/ttjmhBjd491y7XQi4wwHde4ZGZ
         SZ/g==
X-Gm-Message-State: AOAM531lGlGb01gKwa6WSRSgWxPx+q3fFBZTVYm8tyK/nTv9Wq1qvup3
        1WUOD9cIRlAYwD8D7F5T4cg=
X-Google-Smtp-Source: ABdhPJw+VLfbypfCSe9stpbubNdMGXl9HD4DhVxLcd/U9wA78sssgaQaPBzfy770WHdBH+UXBFl2ag==
X-Received: by 2002:a05:6512:151f:b0:44a:2508:1d01 with SMTP id bq31-20020a056512151f00b0044a25081d01mr228077lfb.675.1650559710555;
        Thu, 21 Apr 2022 09:48:30 -0700 (PDT)
Received: from [192.168.1.38] (91-159-150-194.elisa-laajakaista.fi. [91.159.150.194])
        by smtp.gmail.com with ESMTPSA id q64-20020a2e2a43000000b0024ee56ec2bbsm310284ljq.3.2022.04.21.09.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:48:29 -0700 (PDT)
Message-ID: <400be309-ef3f-4175-594d-7dc45a43dc36@gmail.com>
Date:   Thu, 21 Apr 2022 19:48:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RFC 0/4] mm, arm64: In-kernel support for
 memory-deny-write-execute (MDWE)
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=c4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net,
        linux-hardening@vger.kernel.org, Jann Horn <jannh@google.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Igor Zhbanov <izh1979@gmail.com>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <202204141028.0482B08@keescook> <YmAEDsGtxhim46UI@arm.com>
 <c62170c6-5993-2417-4143-5a37a98b227c@gmail.com>
 <202204201610.093C9D5FE8@keescook> <YmF5s4KqT5WL4O0G@arm.com>
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <YmF5s4KqT5WL4O0G@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.4.2022 18.35, Catalin Marinas wrote:
> On Wed, Apr 20, 2022 at 04:21:45PM -0700, Kees Cook wrote:
>> On Wed, Apr 20, 2022 at 10:34:33PM +0300, Topi Miettinen wrote:
>>> For systemd, feature compatibility with the BPF version is important so that
>>> we could automatically switch to the kernel version once available without
>>> regressions. So I think PR_MDWX_MMAP (or maybe PR_MDWX_COMPAT) should match
>>> exactly what MemoryDenyWriteExecute=yes as implemented with BPF has: only
>>> forbid mmap(PROT_EXEC|PROT_WRITE) and mprotect(PROT_EXEC). Like BPF, once
>>> installed there should be no way to escape and ELF flags should be also
>>> ignored. ARM BTI should be allowed though (allow PROT_EXEC|PROT_BTI if the
>>> old flags had PROT_EXEC).
> 
> I agree.
> 
>>> Then we could have improved versions (other PR_MDWX_ prctls) with lots more
>>> checks. This could be enabled with MemoryDenyWriteExecute=strict or so.
>>>
>>> Perhaps also more relaxed versions (like SARA) could be interesting (system
>>> service running Python with FFI, or perhaps JVM etc), enabled with for
>>> example MemoryDenyWriteExecute=trampolines. That way even those programs
>>> would get some protection (though there would be a gap in the defences).
>>
>> Yup, I think we're all on the same page. Catalin, can you respin with a
>> prctl for enabling MDWE? I propose just:
>>
>> 	prctl(PR_MDWX_SET, flags);
>> 	prctl(PR_MDWX_GET);
>>
>> 	PR_MDWX_FLAG_MMAP
>> 		disallows PROT_EXEC on any VMA that is or was PROT_WRITE,
>> 		covering at least: mmap, mprotect, pkey_mprotect, and shmat.
> 
> Do we want the "was PROT_WRITE" or we just reject mprotect(PROT_EXEC) if
> the vma is not already PROT_EXEC? The latter is closer to the current
> systemd approach. The former allows an mprotect(PROT_EXEC) if the
> mapping was PROT_READ only for example.
> 
> I'd drop the "was PROT_WRITE" for now if the aim is a drop-in
> replacement for BPF MDWE.
> 

I think we'd want existing installations with MemoryDenyWriteExecute=yes 
not start failing when the implementation is changed to in-kernel 
version. The implementation could be very simple and not even check 
existing PROT_ flags (except for BTI case) to be maximally compatible to 
BPF version. So I'd leave "was PROT_WRITE" and other checks to more 
advanced versions, enabled with a different PR_MDWX_FLAG_.

-Topi
