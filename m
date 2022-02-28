Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97104C7C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiB1Vbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiB1Vbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:31:48 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559B212F421
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:31:04 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso4629164oop.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=yoMaPQlGCjM+YLX6u6KhQHtsFrVgaY8RNTrWata7rj0=;
        b=lIICTqxS+i1aJeOxZya5N4FwXquttaDbv2c22E7BuvQgmYMFTPNwjwK0w1bYil2G/h
         yIva1K2ajQIVtrtWkFfRTAgWsUxFfcwUOTWykmOIG5ZgYjvgvzcaM+Laibf8WoAuXf1c
         0PGIs/a/CZz3XmCFYKThoUdM7s6Ko8G+V7+2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=yoMaPQlGCjM+YLX6u6KhQHtsFrVgaY8RNTrWata7rj0=;
        b=vlu8FrPL0MMhk2ChKpFyHXbSUgSD4L/v46zdWS3w7VQ5h3creg+u35av+tAherrVkl
         7NMdyqDRbXKE7fOEQ5ZgLt8PZmufUrbYBm/K7MtjOuZZAmIM0mZeg/+r6ljY+/vrt6Cn
         oeY4jUk16sKuZ1vgRcA5SyVi7+ZjQcvS0sOb2JHSs1NHYGB56JV+cEEQMWj77gHG2W87
         KxIHWtnHkDLDs8PB3OvGIrAo/igbNkEljNBTwhZ9qGmi2Pdmw6wdM9EO/Rh2x6cZD6SQ
         ffd4qxc72LUUrs/4os99iRRQzmA7N/tUi7t/N9zH0zL9ZC5z0UgWk1I0fYs926u8VHc5
         MGGA==
X-Gm-Message-State: AOAM532ZGdxSglNbw6BEIVcbR9h2qKOpkl41gTdLESY2KwJ3v+0y5yHj
        n2mx8Zt8Rqf93vMJlj7H6qvjfMcFSXL7OSPm7scnFw==
X-Google-Smtp-Source: ABdhPJyJNCdpfIyvT497exC9CkdkV6Yvl4iEE+b66AqxhRaDBW2veRJunu2yFOEklxGgdHz6y3syEb/LNTMFSQjQbsQ=
X-Received: by 2002:a05:6870:3c18:b0:d7:22ed:20b0 with SMTP id
 gk24-20020a0568703c1800b000d722ed20b0mr3916758oab.32.1646083863673; Mon, 28
 Feb 2022 13:31:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Feb 2022 13:31:03 -0800
MIME-Version: 1.0
In-Reply-To: <1643887981-31011-3-git-send-email-quic_srivasam@quicinc.com>
References: <1643887981-31011-1-git-send-email-quic_srivasam@quicinc.com> <1643887981-31011-3-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 28 Feb 2022 13:31:03 -0800
Message-ID: <CAE-0n53X-+gaspxgdVtnr8FW6S5VhXPJaAxLd+vikCnYf9aF6w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sc7280: Add lpass cpu node
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-02-03 03:33:00)
> Add lpass cpu node for audio on sc7280 based platforms.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 28 +++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi     | 59 ++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 2806888..a76b2d1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -691,3 +691,31 @@
>  &vamacro {
>         vdd-micb-supply = <&vreg_bob>;
>  };
> +
> +&lpass_cpu {
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sec_mi2s_active>;

Is it a reset gpio? If so, make it a reset-gpios property. I couldn't
find the definition.

> +
> +       mi2s-secondary@1 {
> +               reg = <MI2S_SECONDARY>;
> +               qcom,playback-sd-lines = <0>;
> +       };
> +
> +       hdmi-primary@5 {
> +               reg = <LPASS_DP_RX>;
> +       };
> +
> +       wcd-rx@6 {
> +               reg = <LPASS_CDC_DMA_RX0>;
> +       };
> +
> +       wcd-tx@19 {
> +               reg = <LPASS_CDC_DMA_TX3>;
> +       };
> +
> +       va-tx@25 {
> +               reg = <LPASS_CDC_DMA_VA_TX0>;
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 946eb01..c2da5ce 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -17,6 +17,7 @@
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/reset/qcom,sdm845-pdc.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/sound/qcom,lpass.h>
>  #include <dt-bindings/thermal/thermal.h>
>
>  / {
> @@ -1847,6 +1848,64 @@
>                         #size-cells = <0>;
>                 };
>
> +               lpass_cpu: audio-subsystem@3260000 {
> +                       compatible = "qcom,sc7280-lpass-cpu";
> +                       reg = <0 0x3260000 0 0xC000>,
> +                             <0 0x3280000 0 0x29000>,
> +                             <0 0x3340000 0 0x29000>,
> +                             <0 0x336C000 0 0x3000>,
> +                             <0 0x3987000 0 0x68000>,
> +                             <0 0x3B00000 0 0x29000>;

Lowercase hex. Pad out reg to 8 digits.

> +                       reg-names = "lpass-rxtx-cdc-dma-lpm",
> +                                   "lpass-rxtx-lpaif",
> +                                   "lpass-va-lpaif",
> +                                   "lpass-va-cdc-dma-lpm",
> +                                   "lpass-hdmiif",
> +                                   "lpass-lpaif";

That 'lpass' prefix looks very redundant.

> +
> +                       iommus = <&apps_smmu 0x1820 0>,
> +                                <&apps_smmu 0x1821 0>,
> +                                <&apps_smmu 0x1832 0>;
