Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7144B68F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiBOKO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:14:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiBOKOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:14:23 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6690C10DA66
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 02:14:14 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso1074223wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 02:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSCtsd3fzrUKJIHAZet+tjs87CCWa1yDtr7CzSuhxDE=;
        b=4P9S1itgLjR+WLtU0yKgH6geqBsZAQDIyLWXmwIAemApD0tzz70VbQnpUarv4j9Skc
         Dd9sRJdtdSAWdwvA71LxPJxQR0ld/p4WNxBuHz4G6jmUYcNlmvH6jwGje4S198KK3zRB
         sru5PO7Itxq4Auwd+uKtL6prn5yneWmZPzRmAMR9cJIlUYOCF91rZ98QvsLjEYt8qFpJ
         jsOjg7urvQVsmjYMM/r0zGx+9xLexJoxSx30wzY/y9sNbL8SbMZVFZ+AizWCQ6VKKibE
         SuPFd9Od2yUmIlBUyeVKrggPDxCvz1rbI4F1dvZPCK2XUqLYRInf+I1K8hJwbgPf5+6a
         bPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSCtsd3fzrUKJIHAZet+tjs87CCWa1yDtr7CzSuhxDE=;
        b=f0NpJvzRLr9iZYccmKQEpLhhiQ5VF2MkNREKD07FoIkXWs9lZuoBM8vKIKbte8BydV
         mKWJPzJb+08sbunpknAZIJEaIglJtio5xQzXvXTcWMlzyqBMFtLF+MHsyEYQ4vbi/kJw
         DVgqlZXhM/wotoawckW4Y4qDSUfO5v/F7yhSN4X2sxs7z8mM0bFp4p5AIVAOt03jbjQz
         NO5RdtOSjVTJNBqKQUHKvlFq/GQ97GpMbPoCbc/rY5bT1s99Fc7AysevCvZMkX5/EMlT
         jBMItmircLjKs7YM5rKinhgxCo9jTSRoGsJmsqnzP1TiNnKP/a3M1yk/jswZBA70TqhK
         X8Kg==
X-Gm-Message-State: AOAM532Cl3QgwZKo6Xzi6Sp33mzovl5E1tP9zJBZrXkKeYL9ZUH/7eDx
        r7V7bhl9e5SPcoMrGOTAl7U8AZQJ/pJSNfAWRsr2wQ==
X-Google-Smtp-Source: ABdhPJwNWDxqimLiGPW3n0xj1IdnK8izeD/YPdGs8aF5FxCduWcL5ipg17QyPI0oH+gExeSy9a0tK6vxUt/OTD/sfCI=
X-Received: by 2002:a1c:750f:: with SMTP id o15mr2399030wmc.137.1644920052860;
 Tue, 15 Feb 2022 02:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20220215090211.911366-1-atishp@rivosinc.com> <20220215090211.911366-4-atishp@rivosinc.com>
In-Reply-To: <20220215090211.911366-4-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 15 Feb 2022 15:44:00 +0530
Message-ID: <CAAhSdy3ved0OWUEeYUvjpjs=UrtPyFj3O+2Xcc2sUNBsm=AsMQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] RISC-V: Extract multi-letter extension names from
 "riscv, isa"
To:     Atish Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 2:32 PM Atish Patra <atishp@rivosinc.com> wrote:
>
> From: Tsukasa OI <research_trasio@irq.a4lg.com>
>
> Currently, there is no usage for version numbers in extensions as
> any ratified non base ISA extension will always at v1.0.
>
> Extract the extension names in place for future parsing.
>
> Signed-off-by: Tsukasa OI <research_trasio@irq.a4lg.com>
> [Improved commit text and comments]
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/kernel/cpufeature.c | 38 ++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 9d5448542226..cd9eb34f8d11 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -119,9 +119,28 @@ void __init riscv_fill_hwcap(void)
>                                 ext_long = true;
>                                 /* Multi-letter extension must be delimited */
>                                 for (; *isa && *isa != '_'; ++isa)
> -                                       if (!islower(*isa) && !isdigit(*isa))
> +                                       if (unlikely(!islower(*isa)
> +                                                    && !isdigit(*isa)))
>                                                 ext_err = true;
> -                               /* ... but must be ignored. */
> +                               /* Parse backwards */
> +                               ext_end = isa;
> +                               if (unlikely(ext_err))
> +                                       break;
> +                               if (!isdigit(ext_end[-1]))
> +                                       break;
> +                               /* Skip the minor version */
> +                               while (isdigit(*--ext_end))
> +                                       ;
> +                               if (ext_end[0] != 'p'
> +                                   || !isdigit(ext_end[-1])) {
> +                                       /* Advance it to offset the pre-decrement */
> +                                       ++ext_end;
> +                                       break;
> +                               }
> +                               /* Skip the major version */
> +                               while (isdigit(*--ext_end))
> +                                       ;
> +                               ++ext_end;
>                                 break;
>                         default:
>                                 if (unlikely(!islower(*ext))) {
> @@ -131,6 +150,7 @@ void __init riscv_fill_hwcap(void)
>                                 /* Find next extension */
>                                 if (!isdigit(*isa))
>                                         break;
> +                               /* Skip the minor version */

This comment should be moved to PATCH2

>                                 while (isdigit(*++isa))
>                                         ;
>                                 if (*isa != 'p')
> @@ -139,20 +159,20 @@ void __init riscv_fill_hwcap(void)
>                                         --isa;
>                                         break;
>                                 }
> +                               /* Skip the major version */

Same applies to this comment as well.

>                                 while (isdigit(*++isa))
>                                         ;
>                                 break;
>                         }
>                         if (*isa != '_')
>                                 --isa;
> -                       /*
> -                        * TODO: Full version-aware handling including
> -                        * multi-letter extensions will be added in-future.
> -                        */
> -                       if (ext_err || ext_long)
> +
> +                       if (unlikely(ext_err))
>                                 continue;
> -                       this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
> -                       this_isa |= (1UL << (*ext - 'a'));
> +                       if (!ext_long) {
> +                               this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
> +                               this_isa |= (1UL << (*ext - 'a'));
> +                       }
>                 }
>
>                 /*
> --
> 2.30.2
>

Otherwise it looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
