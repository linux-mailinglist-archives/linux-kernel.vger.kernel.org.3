Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45DD4E493B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbiCVWkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiCVWkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:40:39 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2979E403E0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:39:11 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2d07ae0b1c0so207734857b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNSeafrE1nmbZ7HSkTix7SZpM+7OtfLvB9wwfIPQnVU=;
        b=YfpG3zrHM4XGX58Gp4i9zVcqKUf/p4wAvaNN8+2adT/ZK1z44LeJlwbwUZfZP7QZMe
         zalNYKjApH4UDG2bKi0T7Z5TO/uQ2kVTGInsCSUDFuuYZSp7ebjPiPufFKPNZfvn1Y+J
         QKhSXFaqR3FYw2fbkbwUiYAarv4MPfDJyHZh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNSeafrE1nmbZ7HSkTix7SZpM+7OtfLvB9wwfIPQnVU=;
        b=CcPZvS/0JWDw2UXEa2dacEgOJ4vhJOU9qWuFTUtcb9lgkQ7mtmiGaucVK1nhYI2t7G
         t7QeJH81Z6ZHj1vOsNiRDZ5BGdFMzDPMz8UvfNVG2GnJgRyd26yigYTLbYS+Qb5jQrvy
         9b0lnTt9lvQ7rb4m7MVhRkHK5vnBa5caGy2LFCpwQ0ejaTommmC2rknSTefSCUg34sIC
         en9QkGaClZrg4lQVu340RCFcxORqHRnKD2kLS4TjoX6nZSndxvsSxOwPjBgqXyMBJNVG
         r749SQ2KPgjVL3H9heqCosWxUBorALWn78JA4zvLIgLmQk8fTTp9PkqABAFptiZzVeTU
         8XZQ==
X-Gm-Message-State: AOAM533BoD87LXD7HKo1QaegTYiWv5voBEvMIM6gSy2960/ADbjA2bWQ
        sOUFpHCVCvXByHsRIr4izaPCAQluQ/mHaGoqVC9E
X-Google-Smtp-Source: ABdhPJwGylMq9FNbaaZRwaP1kpc9KskXKzv38UDmB8eQIrg0xAGndakGfimL3QxqgIpkVpmFTD66yyPZkKin3+e4wzE=
X-Received: by 2002:a0d:d757:0:b0:2e5:beac:5b48 with SMTP id
 z84-20020a0dd757000000b002e5beac5b48mr29717878ywd.478.1647988750394; Tue, 22
 Mar 2022 15:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220322220147.11407-1-palmer@rivosinc.com>
In-Reply-To: <20220322220147.11407-1-palmer@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 22 Mar 2022 15:38:59 -0700
Message-ID: <CAOnJCU+udBVYwoaaB-UOUY2owrCrrLfSRJW7p=vjAkhOF8bt7Q@mail.gmail.com>
Subject: Re: [PATCH] perf: RISC-V: Remove non-kernel-doc ** comments
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 3:02 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> This will presumably trip up some tools that try to parse the comments
> as kernel doc when they're not.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> --
>
> These recently landed in for-next, but I'm trying to avoid rewriting
> history as there's a lot in flight right now.
> ---
>  drivers/perf/riscv_pmu_sbi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index a1317a483512..dca3537a8dcc 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -35,7 +35,7 @@ union sbi_pmu_ctr_info {
>         };
>  };
>
> -/**
> +/*
>   * RISC-V doesn't have hetergenous harts yet. This need to be part of
>   * per_cpu in case of harts with different pmu counters
>   */
> @@ -477,7 +477,7 @@ static int pmu_sbi_get_ctrinfo(int nctr)
>
>  static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
>  {
> -       /**
> +       /*
>          * No need to check the error because we are disabling all the counters
>          * which may include counters that are not enabled yet.
>          */
> @@ -494,7 +494,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>                   cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
>  }
>
> -/**
> +/*
>   * This function starts all the used counters in two step approach.
>   * Any counter that did not overflow can be start in a single step
>   * while the overflowed counters need to be started with updated initialization
> @@ -563,7 +563,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>         /* Overflow status register should only be read after counter are stopped */
>         overflow = csr_read(CSR_SSCOUNTOVF);
>
> -       /**
> +       /*
>          * Overflow interrupt pending bit should only be cleared after stopping
>          * all the counters to avoid any race condition.
>          */
> --
> 2.34.1
>

Sorry for the fallout on linux-next. I just realized that these came
in with the BUILD_SUCCESS subject line from lkp for me.
I was filtering those out to a separate folder and missed the
"warning" part in the subject line. I have fixed that.

Reviewed-by: Atish Patra <atishp@rivosinc.com>



--
Regards,
Atish
