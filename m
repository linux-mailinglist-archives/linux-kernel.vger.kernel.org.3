Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B865B2C53
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 05:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiIIDBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 23:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiIIDBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:01:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCA5115CC0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 20:01:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l65so375987pfl.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 20:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=HZ7iHA7xMAEoAPtblB3FVSlF1lX9PITPk5qO4yPymKg=;
        b=L0O3+0bxx2+Tc0FIjMnfn2Xw4PEOeZ+bdp5+Eflv7jmcsarFtLdNBXHVh2am3EqYPl
         bnbE7/0yEctzVHuNaTmlht4vM0uYQI4i8+w8pyfVG/HrTYv3xFfrisYO8MI2YurSTnIh
         dSQVaXsWArbr+nJi1ulqYaTRu+kwLYTKu5lcGrHr/ge593LmGhrQoPmttfcH4RwE5VsA
         wacuAr1tJxYfQxQHMw7dm46j1RdLh+W8U4DCLolWu6miBpfuqp3MbzAYJV/5adVf8FGc
         Wja4E5Oa5ns25CIDRzOYp0jveZbOgBucVdiJB9WyoOaqwCCuCTStF31X0cFwFhGzuGj0
         YQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HZ7iHA7xMAEoAPtblB3FVSlF1lX9PITPk5qO4yPymKg=;
        b=LqFNkP1x5k2lylQ1gKfW6N0l+eRNWn21kMUp+iBDOMk514japBT0FiIPvUqKYXOoP9
         TVYp9OeANNZRUOl+ZjafxtT9qCV/4qwdcscvDWsGQOv1SxVaP4SVsuehwdaX+pif69rf
         aWAGDA4bPy1DeKedG537Amd3uWlmsNpRcZBovsek6RVZr+VioB7nDZR+JI8RDTmjlXQf
         AT7rDXBuQV5HL/QbGOiNTUMCX31kyVbd0QDXD6YbHcjdgsW+hxV9ufAqmXOkB0wBPsr2
         glmUeXmUxXcnuvLshM4ZDpLcmpM54fQeisIf7neyhfNOsVv0BhrXZLkQAc2GD1WKDk8G
         JIMw==
X-Gm-Message-State: ACgBeo0/1/POGZqV8lGkPDZ/DKfhn+bBaNDrF+vAa8qXAW0lmS+jZuyQ
        YRZbGgpHyNEzFh6r41TaCzlKHyF66QgUIg==
X-Google-Smtp-Source: AA6agR6nAQK4qAIe6WVZ/X6taIbU4yO4AI1xV8TV1YrPX18GR2HGEA0bfFRXqpjRQkVetow3XzDvyA==
X-Received: by 2002:a63:1051:0:b0:434:b4ff:11e9 with SMTP id 17-20020a631051000000b00434b4ff11e9mr10362090pgq.377.1662692492281;
        Thu, 08 Sep 2022 20:01:32 -0700 (PDT)
Received: from [127.0.0.1] ([38.94.111.108])
        by smtp.gmail.com with ESMTPSA id v15-20020a65460f000000b00434bead2a8csm208402pgq.13.2022.09.08.20.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 20:01:31 -0700 (PDT)
Message-ID: <2f5059f6-b024-1ee8-b961-5aa0b4e4c116@gmail.com>
Date:   Fri, 9 Sep 2022 11:01:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Andrew Bresticker <abrestic@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220908170133.1159747-1-abrestic@rivosinc.com>
 <20220908185006.1212126-1-abrestic@rivosinc.com>
From:   Celeste Liu <coelacanthushex@gmail.com>
Subject: Re: [PATCH v2] riscv: Make mmap() with PROT_WRITE imply PROT_READ
In-Reply-To: <20220908185006.1212126-1-abrestic@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/9 02:50, Andrew Bresticker wrote:
> Commit 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is
> invalid") made mmap() return EINVAL if PROT_WRITE was set wihtout
> PROT_READ with the justification that a write-only PTE is considered a
> reserved PTE permission bit pattern in the privileged spec. This check
> is unnecessary since RISC-V defines its protection_map such that PROT_WRITE
> maps to the same PTE permissions as PROT_WRITE|PROT_READ, and it is
> inconsistent with other architectures that don't support write-only PTEs,
> creating a potential software portability issue. Just remove the check
> altogether and let PROT_WRITE imply PROT_READ as is the case on other
> architectures.
> 
> Note that this also allows PROT_WRITE|PROT_EXEC mappings which were
> disallowed prior to the aforementioned commit; PROT_READ is implied in
> such mappings as well.
> 
> Fixes: 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is invalid")
> Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> ---
> v1 -> v2: Update access_error() to account for write-implies-read
> ---
>  arch/riscv/kernel/sys_riscv.c | 3 ---
>  arch/riscv/mm/fault.c         | 3 ++-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 571556bb9261..5d3f2fbeb33c 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -18,9 +18,6 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>  	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
>  		return -EINVAL;
>  
> -	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
> -		return -EINVAL;
> -
>  	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
>  			       offset >> (PAGE_SHIFT - page_shift_offset));
>  }
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index f2fbd1400b7c..d86f7cebd4a7 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -184,7 +184,8 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
>  		}
>  		break;
>  	case EXC_LOAD_PAGE_FAULT:
> -		if (!(vma->vm_flags & VM_READ)) {
> +		/* Write implies read */
> +		if (!(vma->vm_flags & (VM_READ | VM_WRITE))) {
>  			return true;
>  		}
>  		break;

Hi, this did solve the problem and achieved consistency between
architectures, but I have a question.

Such a change specifies behavior for a state that should not exist,
and if, in the future, RISC-V spec specifies a different behavior
for that state (I mean, RVI itself has a history of not caring about
downstream, like Zicsr and Zifencei), it will create inconsistencies,
which is bad.

If we reject the "write but not read" state, the user gets the most direct
response: the state is not allowed so that they do not and cannot rely
on the behavior of the state. This will bring better time consistency
to the application if the spec specifies the behavior in the future.
But it lost architecture consistency.

How do you think this situation should be handled properly?

Yours,
Celeste Liu
