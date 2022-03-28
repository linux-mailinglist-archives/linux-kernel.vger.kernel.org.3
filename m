Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECE84EA2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiC1WQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiC1WQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:16:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6658141FDD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:12:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id pv16so31531724ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+f5sHPzIyRA/MIuxJyTwVB4qA3W/MyALnESwv4ntqwI=;
        b=WTFv5UiDQYG6xE5yTybsKvbeJpeKOjrRBj9Dxr1y880o4uh3YSustFXzNJx8+RFbkf
         cvObHuLVEc3hHlLnQvT48ZeGBJZe/Lkl+rgHbce6fVPNF+Z9tjVs/oFk0vOSQUmdarFr
         QGBM1nRjcVEnRtVEoyXE6dX56ZD5+rDGcFuBwQZ7cf44dhsHg0ayY0PgmfSNXcF/Di1u
         X5k1FTX+ajHAThYDht5AxbtNpbcjq24P5ISLzLMjInoecEYBwjEagsaOt9WGPmmls6Nf
         oEYc24sfzDXjMv191Y009Vh5ZOh3aSwtUfW736JH+mtYkxV99isWQXfMi9Ml9xKNiITV
         xB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+f5sHPzIyRA/MIuxJyTwVB4qA3W/MyALnESwv4ntqwI=;
        b=iobfNpm9SwhGlEbPEVOILSiSYAyTthzmowgECMtDV5HWEEDpJS68DAoEOizvFK7g1R
         0/8YyeGpv++LND8zQ4kUuNBqv3ixmfIWLuO5VPtC/BTTtQq6o0NLCxxH13jMIXU42M5L
         3zQ4pufEUIVM8BASjDlszd2Xb5AZTN2Mny8hcqHhBb5C//rhrSMEiA4qlZwEq5r4Uv7y
         kbNo2Nlw8D21f7UgJYbaqFjBgFOxANQ8+CBy8HW2jpdj8wMP+wlYq1cte9plPHt57jLO
         GkdSZ8r/P3ZngagzSnUbQLG5F3Y4YXeebe5KLSvunrc6Kc3+Noi565dMeGORzlDQIF/L
         SyTw==
X-Gm-Message-State: AOAM533ba5TfPuLy7JH2SV9VD5LskpTmLT3WdbYFrhL475kB0dIaLxyy
        R47Cm4gxnKsEYp7XSqsscXqO5O7aXkc34FWM906hsQ==
X-Google-Smtp-Source: ABdhPJxRk6LttYtk3D6Ak848ibfIBA9+kBv8Wa0FQFx4Em8F4rGAbvB7rtgf9Y5xENqqPfPRvlXqHKdzvmXy4Eh+8iU=
X-Received: by 2002:a17:907:9621:b0:6d7:355d:6da5 with SMTP id
 gb33-20020a170907962100b006d7355d6da5mr30577979ejc.195.1648505539301; Mon, 28
 Mar 2022 15:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220328220417.25675-1-rdunlap@infradead.org>
In-Reply-To: <20220328220417.25675-1-rdunlap@infradead.org>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Mon, 28 Mar 2022 15:12:08 -0700
Message-ID: <CAHBxVyHxRY2Ni7Do64cv2n2=WK9kkrkybZmb27UzCvRe7J09Xg@mail.gmail.com>
Subject: Re: [PATCH] riscv: cpu.c: don't use kernel-doc markers for comments
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 3:04 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Repair kernel-doc build warnings caused by using "/**" kernel-doc
> markers for comments that are not in kernel-doc format:
>
> cpu.c:89: warning: cannot understand function prototype: 'struct riscv_isa_ext_data isa_ext_arr[] = '
> cpu.c:114: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Atish Patra <atishp@rivosinc.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/kernel/cpu.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20220328.orig/arch/riscv/kernel/cpu.c
> +++ linux-next-20220328/arch/riscv/kernel/cpu.c
> @@ -69,7 +69,7 @@ int riscv_of_parent_hartid(struct device
>                 .uprop = #UPROP,                                \
>                 .isa_ext_id = EXTID,                            \
>         }
> -/**
> +/*
>   * Here are the ordering rules of extension naming defined by RISC-V
>   * specification :
>   * 1. All extensions should be separated from other multi-letter extensions
> @@ -110,7 +110,7 @@ static void print_isa_ext(struct seq_fil
>         }
>  }
>
> -/**
> +/*
>   * These are the only valid base (single letter) ISA extensions as per the spec.
>   * It also specifies the canonical order in which it appears in the spec.
>   * Some of the extension may just be a place holder for now (B, K, P, J).

Thanks. I was just working on sending this patch after seeing the
kernel test report.
Reviewed-by: Atish Patra <atishp@rivosinc.com>
