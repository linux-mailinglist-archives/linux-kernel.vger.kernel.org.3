Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E4D5A44FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiH2IYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiH2IYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:24:34 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB0A5754D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:24:30 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-33dc31f25f9so176843537b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YPHIWOX2j4Thy92e9g+SOxrZzDKa/VoFDvQX9IM02Q0=;
        b=LLJn43kPMQL6fuG/Un8h1/tyLwxfoVF3QhiRENBT6jcSfQH+1BwXrdv0POEAgfYrt8
         TuvgZwLgODhG7/ZQZRYoPhqWSP4GBqf5A50NkGF18hurl8L1FAYXYzxa8YhSmwlY5lcP
         A+7l20SkRb5V81m11RKjHtTbmoWam4n47PUJiXRjV6Q7bnCLpBqio6O1ixoZiVsY0nOT
         1X+6ugXN9nVHs/iX4Rkw7InDhFIQeH/kgbwAba4iw7sibBxMnKclr4TEE5fJs9A+tBkJ
         vApvxXKQYwJcZ8SfLsPyqXEIbdnYKz3LhJFnPZGXg9EbqPvL7Pmp4Lkd+3vUoysReO3L
         Dt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YPHIWOX2j4Thy92e9g+SOxrZzDKa/VoFDvQX9IM02Q0=;
        b=MLuTo6pzi3wSpIt+Qqsogo7dYVcI4GPK9vPrT67E5Ao4z7BX58YymvRMFnaQVBxGxJ
         AwnYUJHui+dFjeKipz01NPDmIERzc7wKEXLG4Zz49cVO7xbnab8jTRDxhdeWfGz9KqMV
         EEv1NBl9V6Q8GJPxDCipxlBLE0f3xJy66oSMVPLUTZKw4h8dpRKHjxfecTJQXxwqZQJr
         4FJzUKpU3vKIJ0SyK/DbjMJhEGKLsxpoKQDkxb0sphMpxxAjv8Saz3taNm9B3NWnPZRi
         1MZfB3KPklXcrM48C2ckAvH6lib2sr8+8cKij3TCwTXgn6W5DxkhCJuU72rH/nP2RiaZ
         MfZA==
X-Gm-Message-State: ACgBeo1BcfRQdKGnppBzyOYp5MUpVFLIGnW85GHxeLWJyarcBRBvI8jF
        J7YL8jAZiIuK2fMMehqTWb82+t9ha8iPtcLqEb6eNzug6oY=
X-Google-Smtp-Source: AA6agR43iFuWAJqgEnfEHFE5RxxlI+v8+Y/+POQSHkEXBl+x+VKgeCZf6Tjz5wvhB9r7HOhttvi+oD+9H2c+86DlhcI=
X-Received: by 2002:a25:d1c6:0:b0:695:d2c9:2ff0 with SMTP id
 i189-20020a25d1c6000000b00695d2c92ff0mr7237106ybg.442.1661761469116; Mon, 29
 Aug 2022 01:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220819140250.3892995-1-ajones@ventanamicro.com> <20220819140250.3892995-2-ajones@ventanamicro.com>
In-Reply-To: <20220819140250.3892995-2-ajones@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Aug 2022 13:54:17 +0530
Message-ID: <CAAhSdy3C_4tNQ42XEtc+cHW-ArubPxoSEmmBnj2mCdYi04JHjg@mail.gmail.com>
Subject: Re: [PATCH 1/4] riscv: Add X register names to gpr-nums
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

On Fri, Aug 19, 2022 at 7:32 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> When encoding instructions it's sometimes necessary to set a
> register field to a precise number. This is easiest to do using
> the x<num> naming.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
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
> 2.37.1
>
