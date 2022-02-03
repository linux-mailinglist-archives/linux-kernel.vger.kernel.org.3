Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36E54A8F98
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354250AbiBCVJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240351AbiBCVJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:09:10 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF321C06173E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:09:10 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id m10so6118061oie.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=WlXSPyshRFclLsUmWCIEz+XunV5G/A4UJamN2kRUK+g=;
        b=X10F6y8TbRqadN5k1/ebOR1L6hzUOz+4NBW3NBUqzfF5y7j48+BuhY3eUBSX2VBVIy
         7WI8cG2Y1RAqMhtzmZzhCuguH+1m8C2mFBXjdjOcj2wMlzZoWQb3f3cfjas0MBjtNc7A
         6QqDEzXwtS9S2q1X0kGhEAkRL1GcLV3usIW10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=WlXSPyshRFclLsUmWCIEz+XunV5G/A4UJamN2kRUK+g=;
        b=z69MMxH+kjCXFTQX8WjRS6Le/d21CaveiBRj66NBv79z+cxEYgzADuN5jkWFw+XZEW
         cMjFWNFGNzIhhPKefAAzwRML3NX0v3w4Yi3Z+qSy/Pcv0zREfX497TsD/rhszdVy3me9
         aPRj9nxhqI/WIq8wblNXt2wF5eZx0zoFKTHv1rGwbEEJoAbvCuUtxBnQ7YYceFqNE9AY
         VpWy2Qjp3z9qmLP7ti7O47txJoaYFDkKSGPYRhQpw4b0NefRCitKC3SbRRP+ZUr1sn9e
         VrXRu63oGwsSDiOiD4biQ5u68R2jHdr+tA3raPJ8WcRiTrEB/0xmlX/I6cRVtxbyCguG
         CzhQ==
X-Gm-Message-State: AOAM532BsFv6hrqGibqMtD55tMQu2RD7MMShwkU58toFcphnDabck8/Z
        PN2tbjfBdcyYmNlfAXh2X9ma/9RQ5k7ZPILTTinL6A==
X-Google-Smtp-Source: ABdhPJzARb38uT6d2OBJyBS0AdfLQIqHnLim6tiJz+2O+5mqhm1zInOUAPKcCGzaQbZSldxLSHXHOX6MP9vYUwTXbZ0=
X-Received: by 2002:a05:6808:190f:: with SMTP id bf15mr8666309oib.40.1643922550025;
 Thu, 03 Feb 2022 13:09:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Feb 2022 21:09:09 +0000
MIME-Version: 1.0
In-Reply-To: <1643790082-18417-1-git-send-email-quic_pmaliset@quicinc.com>
References: <1643790082-18417-1-git-send-email-quic_pmaliset@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Feb 2022 21:09:09 +0000
Message-ID: <CAE-0n51+-+-NRAFbnvZnGH_nq+P7cxyUuSgSD992G=joumMA1A@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Fix pcie gpio entries
To:     Prasad Malisetty <quic_pmaliset@quicinc.com>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, kw@linux.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2022-02-02 00:21:22)
> Current gpio's in IDP file are not mapping properly,
> seeing device timedout failures.

What's the problem exactly?

>
> Corrected pcie gpio entries in dtsi files.
>
> Fixes: 4e24d227aa77 ("arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board")
>
> Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 35 ++++++++++++++------------------
>  arch/arm64/boot/dts/qcom/sc7280.dtsi     | 10 ++++++++-
>  2 files changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 78da9ac..84bf9d2 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -243,9 +243,6 @@
>         perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
>
>         vddpe-3v3-supply = <&nvme_3v3_regulator>;
> -
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
>  };
>
>  &pcie1_phy {
> @@ -360,6 +357,21 @@
>
>  /* PINCTRL - additions to nodes defined in sc7280.dtsi */
>
> +&pcie1_reset_n {
> +       pins = "gpio2";
> +
> +       drive-strength = <16>;

Is drive-strength of 16 actually necessary?

> +       output-low;
> +       bias-disable;
> +};
> +
> +&pcie1_wake_n {
> +       pins = "gpio3";
> +
> +       drive-strength = <2>;
> +       bias-pull-up;
> +};
> +
>  &pm7325_gpios {
>         key_vol_up_default: key-vol-up-default {
>                 pins = "gpio6";
> @@ -436,23 +448,6 @@
>                 function = "gpio";
>         };
>
> -       pcie1_reset_n: pcie1-reset-n {
> -               pins = "gpio2";
> -               function = "gpio";
> -
> -               drive-strength = <16>;
> -               output-low;
> -               bias-disable;
> -       };
> -
> -       pcie1_wake_n: pcie1-wake-n {
> -               pins = "gpio3";
> -               function = "gpio";
> -
> -               drive-strength = <2>;
> -               bias-pull-up;
> -       };
> -
>         qup_uart7_sleep_cts: qup-uart7-sleep-cts {
>                 pins = "gpio28";
>                 function = "gpio";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index d4009cc..2e14c37 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1640,7 +1640,7 @@
>                         phy-names = "pciephy";
>
>                         pinctrl-names = "default";
> -                       pinctrl-0 = <&pcie1_clkreq_n>;
> +                       pinctrl-0 = <&pcie1_clkreq_n>, <&pcie1_reset_n>, <&pcie1_wake_n>;
>
>                         iommus = <&apps_smmu 0x1c80 0x1>;
>
> @@ -3272,6 +3272,14 @@
>                                 bias-pull-up;
>                         };
>
> +                       pcie1_reset_n: pcie1-reset-n {
> +                               function = "gpio";
> +                       };
> +
> +                       pcie1_wake_n: pcie1-wake-n {
> +                               function = "gpio";
> +                       };
> +
>                         dp_hot_plug_det: dp-hot-plug-det {
>                                 pins = "gpio47";
>                                 function = "dp_hot";
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
