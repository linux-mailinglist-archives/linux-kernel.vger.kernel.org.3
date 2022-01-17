Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA61490C50
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbiAQQPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiAQQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:15:30 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEACC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:15:29 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c2so15975589wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYgJDH5u7Y8YeoWfDuM56T17Gv5aMOQMmqg9a2t5daA=;
        b=XAfW47a9vaxUgIYAmMI0z64awv1LqMJOffb8Lkma0SSON3eU5IBq3uyRA22ZewNF+b
         tKt9WpHikvnHJ4eDzh9nEHGx3UWP3uSqfRei68f43QWt9RA8f99UP0keKwdoyjTOb0r7
         m6Yei+v31ShI6iwLSGjhpS5Z3yA/VlCEDVc4Krf9H00pEJX2jWWwFUzRu5N7vpttUACs
         DGEa3hxLjS0MhAyQN6/2seqyrrLzM+LBVn9wDfyptQcklnKGlNTNxvdW6Q+s0tSqM1x5
         rSTNZ0xP3nXIwqI3DKJZmxBb4LLgV+LmnsRanXPQ0i/jp/jUanFn+OQ6mTqkKFucBKXc
         D97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYgJDH5u7Y8YeoWfDuM56T17Gv5aMOQMmqg9a2t5daA=;
        b=q/HZEAhbUF/HB4hjNX01lm2lFcuyvwuTYkMqjxhiplppeQYfktHMd4tNWX8g9EINON
         2gUr2TQ0OpJaVte7/smCwrTjSMvnxvIZlxMWSVrVRPENIq7OrIt1i5oqOWwB0hEon2+K
         GrR7b5RdTIKzBOeTDjyl61jP1iRQOVHDr8jco3o5C9f/X1VYWTDrVzxG51F03ZWvxY7Q
         ul33hm6YGA6MeA+kbx48buxYKNuSbH2zJ7Q7bsOnFB00I4eNtBVnOBR/hdOJyourggRz
         HgZBCafxB79xsFoIJh7JNYu9/whCSRsTGmbrII7898uPLpqb6PgmvrKnjdcXAlG+8+PY
         mMLA==
X-Gm-Message-State: AOAM530uOdSPYhg92RTs3l6CkyJqexlPJ8dwtsRuitz1Lsfh2ZveCpFD
        KOMfXMVDvUyOMEnFOPiW9quAt+a8NthYyHxDDkNBcA==
X-Google-Smtp-Source: ABdhPJxiSeb6uUNrxNczt/tQerhk4fkXTOtS8o7B2ljt8+VSYZYAK7NpcYEIzgbm/2mSJbETKBZ+JoXmAsrqyCxJ1y8=
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr18002851wma.137.1642436128338;
 Mon, 17 Jan 2022 08:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20211225054647.1750577-1-atishp@rivosinc.com> <20211225054647.1750577-6-atishp@rivosinc.com>
In-Reply-To: <20211225054647.1750577-6-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 17 Jan 2022 21:45:17 +0530
Message-ID: <CAAhSdy0RU_tZKz=6aDxEt50h2kr96+UTskDE1HURYyFzXmmtXg@mail.gmail.com>
Subject: Re: [v5 5/9] RISC-V: Add RISC-V SBI PMU extension definitions
To:     Atish Patra <atishp@atishpatra.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 11:17 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> From: Atish Patra <atish.patra@wdc.com>
>
> This patch adds all the definitions defined by the SBI PMU extension.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 97 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 0d42693cb65e..afb29ee1f230 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -27,6 +27,7 @@ enum sbi_ext_id {
>         SBI_EXT_IPI = 0x735049,
>         SBI_EXT_RFENCE = 0x52464E43,
>         SBI_EXT_HSM = 0x48534D,
> +       SBI_EXT_PMU = 0x504D55,
>  };
>
>  enum sbi_ext_base_fid {
> @@ -70,6 +71,99 @@ enum sbi_hsm_hart_status {
>         SBI_HSM_HART_STATUS_STOP_PENDING,
>  };
>
> +

Unwanted newline here.

> +enum sbi_ext_pmu_fid {
> +       SBI_EXT_PMU_NUM_COUNTERS = 0,
> +       SBI_EXT_PMU_COUNTER_GET_INFO,
> +       SBI_EXT_PMU_COUNTER_CFG_MATCH,
> +       SBI_EXT_PMU_COUNTER_START,
> +       SBI_EXT_PMU_COUNTER_STOP,
> +       SBI_EXT_PMU_COUNTER_FW_READ,
> +};
> +
> +#define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(55, 0)
> +#define RISCV_PMU_RAW_EVENT_IDX 0x20000
> +
> +/** General pmu event codes specified in SBI PMU extension */
> +enum sbi_pmu_hw_generic_events_t {
> +       SBI_PMU_HW_NO_EVENT                     = 0,
> +       SBI_PMU_HW_CPU_CYCLES                   = 1,
> +       SBI_PMU_HW_INSTRUCTIONS                 = 2,
> +       SBI_PMU_HW_CACHE_REFERENCES             = 3,
> +       SBI_PMU_HW_CACHE_MISSES                 = 4,
> +       SBI_PMU_HW_BRANCH_INSTRUCTIONS          = 5,
> +       SBI_PMU_HW_BRANCH_MISSES                = 6,
> +       SBI_PMU_HW_BUS_CYCLES                   = 7,
> +       SBI_PMU_HW_STALLED_CYCLES_FRONTEND      = 8,
> +       SBI_PMU_HW_STALLED_CYCLES_BACKEND       = 9,
> +       SBI_PMU_HW_REF_CPU_CYCLES               = 10,
> +
> +       SBI_PMU_HW_GENERAL_MAX,
> +};
> +
> +/**
> + * Special "firmware" events provided by the firmware, even if the hardware
> + * does not support performance events. These events are encoded as a raw
> + * event type in Linux kernel perf framework.
> + */
> +enum sbi_pmu_fw_generic_events_t {
> +       SBI_PMU_FW_MISALIGNED_LOAD      = 0,
> +       SBI_PMU_FW_MISALIGNED_STORE     = 1,
> +       SBI_PMU_FW_ACCESS_LOAD          = 2,
> +       SBI_PMU_FW_ACCESS_STORE         = 3,
> +       SBI_PMU_FW_ILLEGAL_INSN         = 4,
> +       SBI_PMU_FW_SET_TIMER            = 5,
> +       SBI_PMU_FW_IPI_SENT             = 6,
> +       SBI_PMU_FW_IPI_RECVD            = 7,
> +       SBI_PMU_FW_FENCE_I_SENT         = 8,
> +       SBI_PMU_FW_FENCE_I_RECVD        = 9,
> +       SBI_PMU_FW_SFENCE_VMA_SENT      = 10,
> +       SBI_PMU_FW_SFENCE_VMA_RCVD      = 11,
> +       SBI_PMU_FW_SFENCE_VMA_ASID_SENT = 12,
> +       SBI_PMU_FW_SFENCE_VMA_ASID_RCVD = 13,
> +
> +       SBI_PMU_FW_HFENCE_GVMA_SENT     = 14,
> +       SBI_PMU_FW_HFENCE_GVMA_RCVD     = 15,
> +       SBI_PMU_FW_HFENCE_GVMA_VMID_SENT = 16,
> +       SBI_PMU_FW_HFENCE_GVMA_VMID_RCVD = 17,
> +
> +       SBI_PMU_FW_HFENCE_VVMA_SENT     = 18,
> +       SBI_PMU_FW_HFENCE_VVMA_RCVD     = 19,
> +       SBI_PMU_FW_HFENCE_VVMA_ASID_SENT = 20,
> +       SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD = 21,
> +       SBI_PMU_FW_MAX,
> +};
> +
> +/* SBI PMU event types */
> +enum sbi_pmu_event_type {
> +       SBI_PMU_EVENT_TYPE_HW = 0x0,
> +       SBI_PMU_EVENT_TYPE_CACHE = 0x1,
> +       SBI_PMU_EVENT_TYPE_RAW = 0x2,
> +       SBI_PMU_EVENT_TYPE_FW = 0xf,
> +};
> +
> +/* SBI PMU event types */
> +enum sbi_pmu_ctr_type {
> +       SBI_PMU_CTR_TYPE_HW = 0x0,
> +       SBI_PMU_CTR_TYPE_FW,
> +};
> +
> +/* Flags defined for config matching function */
> +#define SBI_PMU_CFG_FLAG_SKIP_MATCH    (1 << 0)
> +#define SBI_PMU_CFG_FLAG_CLEAR_VALUE   (1 << 1)
> +#define SBI_PMU_CFG_FLAG_AUTO_START    (1 << 2)
> +#define SBI_PMU_CFG_FLAG_SET_VUINH     (1 << 3)
> +#define SBI_PMU_CFG_FLAG_SET_VSNH      (1 << 4)
> +#define SBI_PMU_CFG_FLAG_SET_UINH      (1 << 5)
> +#define SBI_PMU_CFG_FLAG_SET_SINH      (1 << 6)
> +#define SBI_PMU_CFG_FLAG_SET_MINH      (1 << 7)
> +
> +/* Flags defined for counter start function */
> +#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
> +
> +/* Flags defined for counter stop function */
> +#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> +
>  #define SBI_SPEC_VERSION_DEFAULT       0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> @@ -82,6 +176,9 @@ enum sbi_hsm_hart_status {
>  #define SBI_ERR_INVALID_PARAM  -3
>  #define SBI_ERR_DENIED         -4
>  #define SBI_ERR_INVALID_ADDRESS        -5
> +#define SBI_ERR_ALREADY_AVAILABLE -6
> +#define SBI_ERR_ALREADY_STARTED -7
> +#define SBI_ERR_ALREADY_STOPPED -8
>
>  extern unsigned long sbi_spec_version;
>  struct sbiret {
> --
> 2.33.1
>

Apart from a minor comment above, it looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
