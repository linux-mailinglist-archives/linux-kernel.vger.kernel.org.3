Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B9257C851
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiGUJ6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiGUJ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:58:14 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB6820C9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:58:13 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10c0430e27dso1699196fac.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sB5+VFg26y53vqC/8MRmL6RVPSMPo+AiiM8Gm3tkc5I=;
        b=DpM33J/meqDpm/cC0Fst4MfLsktLCbHt60MbQA7Ft0z/s315GwSGwjCSkhbqSMdmmY
         CeUnaja1sQhfgPKcSU/Lk9M6cPdAsmvAv5tnXbpO085Oqw6Qe1mDTFJxYDzuzkJFczYJ
         TA40gFokhgf7/+q0gbQ4RYD5ac/0wTBaXypFKkJRhOULDcM3IBEHi1zF01rrBQCtOUyC
         7IpgpmZkUDiPGvXFYFUN80kMKMT1Fxsx+KH6WO/niHoWVAMqhu1mzuQ4pXP2kmxjdp/F
         hXfdqEsqPIHbeNuxzy5v79CGC8h44k8BGCQx36AFeagdG3v7aM945fsCFNA9uavNztfE
         IQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sB5+VFg26y53vqC/8MRmL6RVPSMPo+AiiM8Gm3tkc5I=;
        b=GcPzfDzj+m/qmQ9ut9v++wptorEL8tFxx8MnMMPcMBV8kwxrR8BvGzAkKJbyNeh6YP
         Ls1qFyRSgYWBXp/daHrvhUsxiqQDFuUra7lGXFRNo4/FM+dqysuCRtHLBlsaalyZXTW6
         24sLCnsDSHuqK5MEMuQE33/mbtnAWsu8Yuqjgcuwh/GnO/5cCpJu5Y1YPc5KEfTa7yWF
         9PP0jgarNNA7CdmKAJSQjVraKyBAKOkrKa/xIUHwP3LW/FLqLMnon0z9ryTNjA2wB72W
         XBncjvW6LxJwQy5TGcJVm/wTAkMw45rH73zr0wRG8kJ50299PPQtsy4Ovjv1XSIPSPup
         KFiQ==
X-Gm-Message-State: AJIora8NQnM1G84itfkX4t2cI13YqkrIbNT+bSjreqLqeYsT5Wl6/z0k
        9hBTIxYLWYn33Vnegx7UKLrraek54lU9Xj6B2ASEdQ==
X-Google-Smtp-Source: AGRyM1v17gff8o19t6yFCbZorc8LVOpXY1I3uCydpXbcgQefIXMnlFa8G4NkPgmWCDlzsSNE/lKD4q6x7q+LckMFFkU=
X-Received: by 2002:a05:6870:2303:b0:10c:2ed1:6326 with SMTP id
 w3-20020a056870230300b0010c2ed16326mr4422385oao.146.1658397492622; Thu, 21
 Jul 2022 02:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com> <20220721055728.718573-7-kaleshsingh@google.com>
In-Reply-To: <20220721055728.718573-7-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 21 Jul 2022 10:57:36 +0100
Message-ID: <CA+EHjTxqNOU9cjA1Gnur9wp4W4nt9ZXC+y6N9HCEzf4BmPc60w@mail.gmail.com>
Subject: Re: [PATCH v5 06/17] arm64: stacktrace: Add description of stacktrace/common.h
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Thu, Jul 21, 2022 at 6:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Add brief description on how to use stacktrace/common.h to implement
> a stack unwinder.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>
> Changes in v5:
>   - Add short description of each required function, per Fuad and Marc
>   - Add Reviewed-by tag from Fuad

Actually it's missing :)

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


>
>  arch/arm64/include/asm/stacktrace/common.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> index 7807752aaab1..be7920ba70b0 100644
> --- a/arch/arm64/include/asm/stacktrace/common.h
> +++ b/arch/arm64/include/asm/stacktrace/common.h
> @@ -2,6 +2,21 @@
>  /*
>   * Common arm64 stack unwinder code.
>   *
> + * To implement a new arm64 stack unwinder:
> + *     1) Include this header
> + *
> + *     2) Provide implementations for the following functions:
> + *          on_overflow_stack():   Returns true if SP is on the overflow
> + *                                 stack.
> + *          on_accessible_stack(): Returns true is SP is on any accessible
> + *                                 stack.
> + *          unwind_next():         Performs validation checks on the frame
> + *                                 pointer, and transitions unwind_state
> + *                                 to the next frame.
> + *
> + *         See: arch/arm64/include/asm/stacktrace.h for reference
> + *              implementations.
> + *
>   * Copyright (C) 2012 ARM Ltd.
>   */
>  #ifndef __ASM_STACKTRACE_COMMON_H
> --
> 2.37.0.170.g444d1eabd0-goog
>
