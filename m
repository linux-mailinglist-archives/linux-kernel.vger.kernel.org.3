Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC374CB085
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245043AbiCBVAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245017AbiCBVAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:00:22 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC63D206B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:59:38 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id d3so2530442qvb.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mUjbtpCCtsOG9jYKgJxNZISxNazpeqTfffY69y8STE=;
        b=aavMfozFmXfin3ehGCM8/cbJ45gjcXA92LUIHvpXcrPFXksrvC/pAH/jfvGXai4FFU
         ocGOv6ED9Yo92B+9cv5uRySx8W76NvdLsdd+an8GuVsUp8UsyWQWuk4Fu1WiyVV6hay3
         8WMCK36dr/G68oEUEQruwQX6r2ZFZWQf3TlcTHhmfK7ciULdgYxfDEofhXOhIItGXVjO
         t4H86M42+EGuAhcr94NUcW1h68cuSzyG2ZFjHbUBOa1GYbuY5C1/BI7M8GbE5OafZqJh
         vvzyAa4IzAvS63bD+8vlcs2zZEiyGcYQxOLjFvcoVJXH3u2PREZc4O1v1KJAHnyzSAF6
         ypmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mUjbtpCCtsOG9jYKgJxNZISxNazpeqTfffY69y8STE=;
        b=Vy+ZLhTZCRIok850blz8VT8MuLLFGA6FT+Ckd3LO32ebiD05KPaGW/Sk7h0ztdtZR3
         VHSKZYiMXbRnJGLcyhzQaplmulKIZzky2XYs8yxnAGFIIaqjGf/UFvOUBCNR/RDJ2sc8
         nHoprwFrA82orm0+PUoz66B7bgBumHIsZnalqSJyDaZIlCZbFOy6avmTE1MmYFnSiMU/
         4Zy0UrUO/AWF7toZ8Y2lZbgYmZKRT+QEW3sor8upxsVFxQZYC6AhmK90YfuE7p2dBQeE
         UYSJ6rRFgBc3CtNPwkYM2nHhayQyjOFmQ60UX7XjNxDGPZ2k3dWhBoCA2TPfTifNUwxW
         wtgg==
X-Gm-Message-State: AOAM532Vf+17dfvxkF2lOj5NspuYyTLsdyPyOT4GQWjT/FQSOCefFLxS
        3NzKnWn5l3vvKZQ8KBLgmhrjeRlpZJgNsJFzeTHb/g==
X-Google-Smtp-Source: ABdhPJx9v0p/md2jydNCQ6XCgdb9TFM9VczTiKrSjtKaCqAuPjqYf5f3eAI8AFE+zTL1zbzO1qaq4dBXim2UgWtVyHg=
X-Received: by 2002:ad4:5883:0:b0:432:b007:962b with SMTP id
 dz3-20020ad45883000000b00432b007962bmr20943794qvb.55.1646254778062; Wed, 02
 Mar 2022 12:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20220302203045.184500-1-bhupesh.sharma@linaro.org> <20220302203045.184500-8-bhupesh.sharma@linaro.org>
In-Reply-To: <20220302203045.184500-8-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 2 Mar 2022 23:59:27 +0300
Message-ID: <CAA8EJpqEy+669gpDsy-zGp2NpDP-d7ZxNf7RVo=OQZdvGdZOvQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: sa8155: Enable PCIe nodes
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
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

On Wed, 2 Mar 2022 at 23:31, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> SA8155p ADP board supports the PCIe0 controller in the RC
> mode (only). So add the support for the same.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 42 ++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index 8756c2b25c7e..3f6b3ee404f5 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -387,9 +387,51 @@ &usb_2_qmpphy {
>         vdda-pll-supply = <&vdda_usb_ss_dp_core_1>;
>  };
>
> +&pcie0 {
> +       status = "okay";
> +};
> +
> +&pcie0_phy {
> +       status = "okay";
> +       vdda-phy-supply = <&vreg_l18c_0p88>;
> +       vdda-pll-supply = <&vreg_l8c_1p2>;
> +};
> +
> +&pcie1_phy {
> +       vdda-phy-supply = <&vreg_l18c_0p88>;
> +       vdda-pll-supply = <&vreg_l8c_1p2>;
> +};
> +
>  &tlmm {
>         gpio-reserved-ranges = <0 4>;
>
> +       bt_en_default: bt_en_default {
> +               mux {
> +                       pins = "gpio172";
> +                       function = "gpio";
> +               };
> +
> +               config {
> +                       pins = "gpio172";
> +                       drive-strength = <2>;
> +                       bias-pull-down;
> +               };
> +       };
> +
> +       wlan_en_default: wlan_en_default {
> +               mux {
> +                       pins = "gpio169";
> +                       function = "gpio";
> +               };
> +
> +               config {
> +                       pins = "gpio169";
> +                       drive-strength = <16>;
> +                       output-high;
> +                       bias-pull-up;
> +               };
> +       };
> +

Not related to PCIe

>         usb2phy_ac_en1_default: usb2phy_ac_en1_default {
>                 mux {
>                         pins = "gpio113";
> --
> 2.35.1
>


-- 
With best wishes
Dmitry
