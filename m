Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C82B4CA419
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241576AbiCBLrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241537AbiCBLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:47:10 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E7B12F5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:46:25 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id w27so2325953lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 03:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lc6+sFLH4xgHpUfpAkTWrsxSemAv/j1QkEWdwDqUEeo=;
        b=rWAUr8KkXUHG5RY6SBczeSb9azLIJEyGi92k21TcCreY01VxIChitbz3qG4MU9dZr0
         bGEcYijFMW5qjwMcoONcN3mJa3wy5bXNgo6+967xaSTewvJmGldP2BAieMxji3BSpI6k
         ba4/q4AXnWwmw0l245cxJwVmc1ChwG1Ijb7r6R+IFXHatiHjz4r/RMCZsdtpjpb+KMsw
         nIL7Hl4MnIxNW0mDBYOM8OWmRT+c09kgKLXHqtwj5LagPsFKs/Au6Vot4xhv5avljpub
         Uv3JmyjEOmzie2DSyTZf90vQfwN+XN4Rt8zj1iQbm9PUP/6WWrqBsjInfxTUVJWmKkSw
         z8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lc6+sFLH4xgHpUfpAkTWrsxSemAv/j1QkEWdwDqUEeo=;
        b=OAnVaPsJD7yVVaRXftCfSBIWTm+I0PKfJRcaAu2gQrusUIt00loH15E82MiN4pQdAP
         /L9jCk21PMlYGzIMFLc6PaHwfwQBfutzqi35hAlsWZq8ZErsglsXzW1bX4ZChUqIwaug
         7iYFjtfvw5WHwzmy5IH+svr8uHRauYoRvk14QkjV+TtUS4oURLlNS8Iz0cpx316rFaoW
         h9rb2mrxPm8YAPfJ1irLMN4y33MBMUfzgH5z+/3Fk0aLCK7YyGB3pf1Fgafmf+mJePmW
         rVMexR+zPx8o81C49zTViTcYPSaBbr5LQqL/gUouWPjbCFH2RbzVgermrydZBF+97L8P
         E99Q==
X-Gm-Message-State: AOAM531gNTv5wx8MStDynu4XFOXK4FqX4QsbI7jN0s+bufjmO8W+9E8L
        fOzvcqqfU9V59WovUdNSZCRK2EUT56pOBESksFyG8g==
X-Google-Smtp-Source: ABdhPJw2DdnCG5o0Y7GjgeTud67zBTcDtQAwPjNtvYX1CcxMGtJbrcbmH7J7HcvSVfqcdfIJ8Ve49YJlO8jq7j6HCSU=
X-Received: by 2002:a19:2d11:0:b0:445:65c7:5f1e with SMTP id
 k17-20020a192d11000000b0044565c75f1emr18221775lfj.184.1646221584059; Wed, 02
 Mar 2022 03:46:24 -0800 (PST)
MIME-Version: 1.0
References: <1646117728-28085-1-git-send-email-quic_c_sbhanu@quicinc.com>
In-Reply-To: <1646117728-28085-1-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Mar 2022 12:45:47 +0100
Message-ID: <CAPDyKFpmR35dZj5VGPdKOp58VanUL7it3buN9yAvF+ObiSb32A@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     adrian.hunter@intel.com, asutoshd@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        cang@codeaurora.org, rampraka@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 at 07:55, Shaik Sajida Bhanu
<quic_c_sbhanu@quicinc.com> wrote:
>
> Reset GCC_SDCC_BCR register before every fresh initilazation. This will
> reset whole SDHC-msm controller, clears the previous power control
> states and avoids, software reset timeout issues as below.
>
> [ 5.458061][ T262] mmc1: Reset 0x1 never completed.
> [ 5.462454][ T262] mmc1: sdhci: ============ SDHCI REGISTER DUMP
> ===========
> [ 5.469065][ T262] mmc1: sdhci: Sys addr: 0x00000000 | Version:
> 0x00007202
> [ 5.475688][ T262] mmc1: sdhci: Blk size: 0x00000000 | Blk cnt:
> 0x00000000
> [ 5.482315][ T262] mmc1: sdhci: Argument: 0x00000000 | Trn mode:
> 0x00000000
> [ 5.488927][ T262] mmc1: sdhci: Present: 0x01f800f0 | Host ctl:
> 0x00000000
> [ 5.495539][ T262] mmc1: sdhci: Power: 0x00000000 | Blk gap: 0x00000000
> [ 5.502162][ T262] mmc1: sdhci: Wake-up: 0x00000000 | Clock: 0x00000003
> [ 5.508768][ T262] mmc1: sdhci: Timeout: 0x00000000 | Int stat:
> 0x00000000
> [ 5.515381][ T262] mmc1: sdhci: Int enab: 0x00000000 | Sig enab:
> 0x00000000
> [ 5.521996][ T262] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int:
> 0x00000000
> [ 5.528607][ T262] mmc1: sdhci: Caps: 0x362dc8b2 | Caps_1: 0x0000808f
> [ 5.535227][ T262] mmc1: sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
> [ 5.541841][ T262] mmc1: sdhci: Resp[0]: 0x00000000 | Resp[1]:
> 0x00000000
> [ 5.548454][ T262] mmc1: sdhci: Resp[2]: 0x00000000 | Resp[3]:
> 0x00000000
> [ 5.555079][ T262] mmc1: sdhci: Host ctl2: 0x00000000
> [ 5.559651][ T262] mmc1: sdhci_msm: ----------- VENDOR REGISTER
> DUMP-----------
> [ 5.566621][ T262] mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:
> 0x6000642c |
> DLL cfg2: 0x0020a000
> [ 5.575465][ T262] mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:
> 0x00010800 | DDR cfg: 0x80040873
> [ 5.584658][ T262] mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 :
> 0xf88218a8 Vndr func3: 0x02626040
>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>

If this is this a regression, then please try to add a fixes tag too.

I assume we should tag this for stable kernels?

> ---
>  drivers/mmc/host/sdhci-msm.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 50c71e0..f10b3c7 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -17,6 +17,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/interconnect.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/reset.h>
>
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> @@ -284,6 +285,7 @@ struct sdhci_msm_host {
>         bool uses_tassadar_dll;
>         u32 dll_config;
>         u32 ddr_config;
> +       struct reset_control *core_reset;
>         bool vqmmc_enabled;
>  };
>
> @@ -2482,6 +2484,45 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>         of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
>  }
>
> +static int sdhci_msm_gcc_reset(struct platform_device *pdev,
> +              struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       int ret = 0;
> +
> +       msm_host->core_reset = devm_reset_control_get(&pdev->dev, "core_reset");
> +       if (IS_ERR(msm_host->core_reset)) {
> +               ret = PTR_ERR(msm_host->core_reset);
> +               dev_err(&pdev->dev, "core_reset unavailable (%d)\n", ret);
> +               msm_host->core_reset = NULL;

Looks like we should use devm_reset_control_get_optional_exclusive() instead.

> +       }
> +       if (msm_host->core_reset) {
> +               ret = reset_control_assert(msm_host->core_reset);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "core_reset assert failed (%d)\n",
> +                                               ret);
> +                       goto out;
> +               }
> +               /*
> +                * The hardware requirement for delay between assert/deassert
> +                * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
> +                * ~125us (4/32768). To be on the safe side add 200us delay.
> +                */
> +               usleep_range(200, 210);

Isn't this supposed to be taken care of by the reset driver?

Or is this more an mmc controller specific thing? In that case, could
this delay vary, depending on the variant of the controller?

> +
> +               ret = reset_control_deassert(msm_host->core_reset);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "core_reset deassert failed (%d)\n",
> +                                               ret);
> +                       goto out;
> +               }
> +               usleep_range(200, 210);

Ditto?

> +       }
> +
> +out:
> +       return ret;
> +}
>
>  static int sdhci_msm_probe(struct platform_device *pdev)
>  {
> @@ -2529,6 +2570,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>
>         msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
>
> +       ret = sdhci_msm_gcc_reset(pdev, host);
> +       if (ret) {
> +               dev_err(&pdev->dev, "core_reset assert/deassert failed (%d)\n",
> +                                       ret);
> +               goto pltfm_free;
> +       }
> +
>         /* Setup SDCC bus voter clock. */
>         msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
>         if (!IS_ERR(msm_host->bus_clk)) {

Kind regards
Uffe
