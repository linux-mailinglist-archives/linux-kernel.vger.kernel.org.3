Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732414FFE09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiDMSmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbiDMSmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:42:05 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5612E21D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:39:42 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id m8so3284805ljc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v0uxIEiOGXAVbrPGMXz16+Yl9VteQ3InKsyKHHrbkhY=;
        b=h2OmjY4+49Tg6IGmmKVnS46h0KMF5nJCrpra12ygtmpweIVAW4C9qzxr0IhwZZEkU6
         r7BQKw12FLOi3dtraqvutf6t94HSeOzMa9EC7/DPsC/VPbyvc4sbTONsqSKXVwJrk4NQ
         9/8kCNc4U140teNFFauidckx5eHVIC+7LLlV/7gGC2mz3w9RkSL0OqGvASOKJcj5UyaI
         4EuWcsiT2laec06NvgBB72OnYzCUNr5H31jPErL91bBqJi21Vc3TQnxvmvGILKPbQb8z
         CpXxPbcoe11SYDJsRjyQeXOl3DgYvLfyR0E9zp/So6Uh7gtb5DHrsl/Ybq49TZk4J1sD
         8tzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v0uxIEiOGXAVbrPGMXz16+Yl9VteQ3InKsyKHHrbkhY=;
        b=JcRz2pxntlFPG/8F+qz8sLLOOy22PlDIaL4ai7Khv+fZtL7ESdJT4chZ7RSGCWR81C
         6onpTh9vt+9OI8dy1lEz715T4U9e7HvVlji8deGrFbKaW7NYrEDWF3/F2zfrhF5bZwOt
         fLVfSjBQg3bEQki/my9XYAEW3tUbYdDXAoIxBEpJKiyDn72fpRT8al+iflOncFHsMA4+
         xMMngzOiuo3kPi4OoyqW6wIfcbedhcuOALtOC+Mehy9bRlMaeFFkWe9VazJ4IN9zG32K
         TW1BAGF96cQ9kHmfcdW7hm5Q9vTkEKCmxoOrFu4x7A+GWH45GfkSAl7nC5fR2ACgWZu7
         8tXA==
X-Gm-Message-State: AOAM532Uuy4uaX7IncWoBP0RkWC576g8brYLL6aMOZu+TyA06WtRDDK1
        D65QBbRbeZpSOI9RFME+jwY=
X-Google-Smtp-Source: ABdhPJzhbs3dT23xzQ3oXIyWAhtY4I0DTwhniFJB67OwXphv4OtRYr1uWo06bpQLykfliFtF418d6Q==
X-Received: by 2002:a05:651c:a0e:b0:249:90c8:453d with SMTP id k14-20020a05651c0a0e00b0024990c8453dmr26505188ljq.399.1649875180430;
        Wed, 13 Apr 2022 11:39:40 -0700 (PDT)
Received: from [192.168.1.38] (91-159-150-194.elisa-laajakaista.fi. [91.159.150.194])
        by smtp.gmail.com with ESMTPSA id u3-20020a197903000000b00464f4c76ebbsm2256852lfc.94.2022.04.13.11.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 11:39:39 -0700 (PDT)
Message-ID: <2a2becf1-fc19-a7da-deb7-1c12781d503d@gmail.com>
Date:   Wed, 13 Apr 2022 21:39:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RFC 0/4] mm, arm64: In-kernel support for
 memory-deny-write-execute (MDWE)
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=c4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc:     Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <20220413134946.2732468-1-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.4.2022 16.49, Catalin Marinas wrote:
> Hi,
> 
> The background to this is that systemd has a configuration option called
> MemoryDenyWriteExecute [1], implemented as a SECCOMP BPF filter. Its aim
> is to prevent a user task from inadvertently creating an executable
> mapping that is (or was) writeable. Since such BPF filter is stateless,
> it cannot detect mappings that were previously writeable but
> subsequently changed to read-only. Therefore the filter simply rejects
> any mprotect(PROT_EXEC). The side-effect is that on arm64 with BTI
> support (Branch Target Identification), the dynamic loader cannot change
> an ELF section from PROT_EXEC to PROT_EXEC|PROT_BTI using mprotect().
> For libraries, it can resort to unmapping and re-mapping but for the
> main executable it does not have a file descriptor. The original bug
> report in the Red Hat bugzilla - [2] - and subsequent glibc workaround
> for libraries - [3].
> 
> Add in-kernel support for such feature as a DENY_WRITE_EXEC personality
> flag, inherited on fork() and execve(). The kernel tracks a previously
> writeable mapping via a new VM_WAS_WRITE flag (64-bit only
> architectures). I went for a personality flag by analogy with the
> READ_IMPLIES_EXEC one. However, I'm happy to change it to a prctl() if
> we don't want more personality flags. A minor downside with the
> personality flag is that there is no way for the user to query which
> flags are supported, so in patch 3 I added an AT_FLAGS bit to advertise
> this.

With systemd there's a BPF construct to block personality changes 
(LockPersonality=yes) but I think prctl() would be easier to lock down 
irrevocably.

Requiring or implying NoNewPrivileges could prevent nasty surprises from 
set-uid Python programs which happen to use FFI.

> Posting this as an RFC to start a discussion and cc'ing some of the
> systemd guys and those involved in the earlier thread around the glibc
> workaround for dynamic libraries [4]. Before thinking of upstreaming
> this we'd need the systemd folk to buy into replacing the MDWE SECCOMP
> BPF filter with the in-kernel one.

As the author of this feature in systemd (also similar feature in 
Firejail), I'd highly prefer in-kernel version to BPF protection. I'd 
definitely also want to use this in place of BPF on x86_64 and other 
arches too.

In-kernel version would probably allow covering pretty easily this case 
(maybe it already does):

	fd = memfd_create(...);
	write(fd, malicious_code, sizeof(malicious_code));
	mmap(..., PROT_EXEC, ..., fd);

Other memory W^X implementations include S.A.R.A [1] and SELinux 
EXECMEM/EXECSTACK/EXECHEAP protections [2], [3]. SELinux checks 
IS_PRIVATE(file_inode(file)) and vma->anon_vma != NULL, which might be 
useful additions here too (or future extensions if you prefer).

-Topi

[1] https://smeso.it/sara/
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c#n3708
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c#n3787
