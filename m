Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FE55AA85A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbiIBGwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiIBGwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:52:03 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73930A2DB9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:52:02 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g5so1844517ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 23:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Wj7rwDEHIUvAdD/PS9G4uEt058e/aJElYMpCPRmWxnM=;
        b=RMhDjLH+q4GyBtGrIfOWZsxarTb9p5zBL9PM/I9+xMA5VAtX+q2vhDdUkUSKnIaVId
         VCHctB2fPYv7J3jYEcRYYXdKw/3TeOcHGoxwm2IaZC/2hsoA0wveaM0/vS4pKUgA4DUM
         E6uHOSqsNZ8o9r+P1kJoNIgo7lHE7M2Vx7KkJ5yrGLFBGlYL4qO4109aEfvWeV/72HEg
         sWR2j5XVJSaAw2IBRdtn22+nFqv9HX5Touf66IldvpyxaIO5SG2Betz+VmIZlFKNe5Aw
         6dkjdUVBRio+ypOXZYV2+Rr20PZ8pdWqR8uXRxS5LyBuy79XaAc50YB1GipRlwx6642r
         3Hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Wj7rwDEHIUvAdD/PS9G4uEt058e/aJElYMpCPRmWxnM=;
        b=ibNNLrWlP1CwicvxxioCUP2oT/o1YTS/vY2Ov2f7ir6vTfUYrIYKtdeJX6WQHfD/X4
         Lk1qXvXLICiW7m/zz5P7q6CX94L08e3AmNYwjApP1zmJULrasBTUSWuxkLdU4dym3wpJ
         FGls9Y+PUFbWetF72tHM5ct8KOO50HDjw/pyPFBHhYT/xUiFbNr2XqHS4nNS2aBHP3hm
         J3fbGfw0dh3tXVelYgW+69mpq8v9ncOru/8yF0/lV9NL3wYFrvD0Bv1fAu+Bb3uxKOCv
         OqzM8d8SCv8nFHIRQXD/hdVvNERHe6Sp3ktumVHq+HdHS6GTeu5m8UqBdP1vuwPMOFno
         cFYg==
X-Gm-Message-State: ACgBeo2xqmlc9QBPAFZNrbYnLUanTEVNABvJLuLfSQo9cDdwka5LSZRv
        nDTWQmqMITuz01Ug376eWqiuKa63bfwvo5WL7uMoqQ==
X-Google-Smtp-Source: AA6agR53rFA7+dY6Kz/imFK+JQbciKfQA4yj9Jc5MOpmzuX76XzyuEfGQeVQS7WAdjNCqpORZpW5fGDY6Qbkp/St3/Q=
X-Received: by 2002:a25:234a:0:b0:696:435f:df06 with SMTP id
 j71-20020a25234a000000b00696435fdf06mr21647862ybj.180.1662101521591; Thu, 01
 Sep 2022 23:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220831172500.752195-1-ajones@ventanamicro.com> <20220831172500.752195-2-ajones@ventanamicro.com>
In-Reply-To: <20220831172500.752195-2-ajones@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 2 Sep 2022 12:21:49 +0530
Message-ID: <CAAhSdy2uVFr7-hrxC9DbrSLSytnZLTs4D4j1s=cdmaqwo-Jq8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] riscv: Add X register names to gpr-nums
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        mchitale@ventanamicro.com, heiko@sntech.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:55 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> When encoding instructions it's sometimes necessary to set a
> register field to a precise number. This is easiest to do using
> the x<num> naming.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>

I have queued this patch for Linux-6.1

Thanks,
Anup

> ---
>  arch/riscv/include/asm/gpr-num.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/riscv/include/asm/gpr-num.h b/arch/riscv/include/asm/gpr-num.h
> index dfee2829fc7c..efeb5edf8a3a 100644
> --- a/arch/riscv/include/asm/gpr-num.h
> +++ b/arch/riscv/include/asm/gpr-num.h
> @@ -3,6 +3,11 @@
>  #define __ASM_GPR_NUM_H
>
>  #ifdef __ASSEMBLY__
> +
> +       .irp    num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
> +       .equ    .L__gpr_num_x\num, \num
> +       .endr
> +
>         .equ    .L__gpr_num_zero,       0
>         .equ    .L__gpr_num_ra,         1
>         .equ    .L__gpr_num_sp,         2
> @@ -39,6 +44,9 @@
>  #else /* __ASSEMBLY__ */
>
>  #define __DEFINE_ASM_GPR_NUMS                                  \
> +"      .irp    num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31\n" \
> +"      .equ    .L__gpr_num_x\\num, \\num\n"                    \
> +"      .endr\n"                                                \
>  "      .equ    .L__gpr_num_zero,       0\n"                    \
>  "      .equ    .L__gpr_num_ra,         1\n"                    \
>  "      .equ    .L__gpr_num_sp,         2\n"                    \
> --
> 2.37.2
>
