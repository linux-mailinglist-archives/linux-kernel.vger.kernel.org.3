Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DBE47D831
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 21:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345394AbhLVUMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 15:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbhLVUMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 15:12:53 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E625DC061401
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 12:12:52 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id h5so3314327qvh.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 12:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k5N1/esYCEDn29RiWcJJVEVjL90ityOcCHjdNFxVFyg=;
        b=aor16RabIeezECAOLLa2We2cjAXYaCi6sVsS9Hl4ALFvKBsb6wIkU2KA3qskH2Oxbb
         6oehevJyUP73NgywPrP0C2ytQGXEoz0kje1nfvHUmd6hhy9gNzrAI9MAqLMRMugwCAvh
         S8/r5w4qPhq9o+5q2cy5Lxw8FgqUZt1+MQDTrCQep38RdLkv1tcs2LaCmRReh/+DXraX
         3H4UvEwJcL0wv6RGS1LulpQj/1qHodyp4NpntNtYfQ4mqQpQ6LzLX7XLbRmCWnqCBL6D
         vMO9z+laFhTjyh0RImpTqdkYS4wWnISM2rYb/64xuIxML1bBuhzVlcG0V/lr8y1uQ2ns
         Z/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5N1/esYCEDn29RiWcJJVEVjL90ityOcCHjdNFxVFyg=;
        b=TgaNvZNB7RsVvaGDkvIcwnDaO+72STIw8X/whbyIZL/p2AcNfkAp75YUj9uo6aTk0b
         +gz6wp47JdWlaR4up8yGL+Ie2WPLos5vmE1xbVslvpA7+LbYoptD8XUtPBnAOYqnr9Xw
         s3x0GWbxyBNKStvDOMvWyw2+xMtU0WbN7L7+Of8GIGInv8iPKyC+4hgybJmpLh57sjVE
         8an9+QkGz80mdKSE5NLuHCtEOfN/wlOgHXv576BaDsZ/i9AIL7S4jep+3yTIOfepVM3T
         mF1K1mZIZtN80kMLQZ4HpnnJdwEPOU7bOh5QZvclyyjT+TscBJYDC6Nyu6rqlgON5/VU
         EDzg==
X-Gm-Message-State: AOAM531ln/fQvbF3/CH2+XYss1k0dw5TRoo0LPm0daAE7jB5tPvAm+hW
        emAwuaokR+x+m83Cne5Jm7XRSwG7Sf34+AujZCI82Q==
X-Google-Smtp-Source: ABdhPJzFeRQddBLWKunGDjun00HCMHkaUwPfjOdtM0Fq6o7WLcE0nM0BbVJ1cKBeLXsDYRn2YG8LzUMB3nOb29UCBqs=
X-Received: by 2002:a05:6214:260b:: with SMTP id gu11mr3848157qvb.55.1640203972126;
 Wed, 22 Dec 2021 12:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20211222162058.3418902-1-bjorn.andersson@linaro.org>
In-Reply-To: <20211222162058.3418902-1-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 22 Dec 2021 23:12:41 +0300
Message-ID: <CAA8EJppAOVtGZojQ7UDmSxz_nwXWFmqQb3Mm_HZn-V+xjYdR=w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8350: Correct UFS symbol clocks
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 at 19:19, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The introduction of '9a61f813fcc8 ("clk: qcom: regmap-mux: fix parent
> clock lookup")' broke UFS support on SM8350.
>
> The cause for this is that the symbol clocks have a specified rate in
> the "freq-table-hz" table in the UFS node, which causes the UFS code to
> request a rate change, for which the "bi_tcxo" happens to provide the
> closest rate.  Prior to the change in regmap-mux it was determined
> (incorrectly) that no change was needed and everything worked.
>
> The rates of 75 and 300MHz matches the documentation for the symbol
> clocks, but we don't represent the parent clocks today. So let's mimic
> the configuration found in other platforms, by omitting the rate for the
> symbol clocks as well to avoid the rate change.
>
> While at it also fill in the dummy symbol clocks that was dropped from
> the GCC driver as it was upstreamed.
>
> Fixes: 59c7cf814783 ("arm64: dts: qcom: sm8350: Add UFS nodes")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

We've had more or less the same change for sm8450 after adding my
regmap-mux fix (with the only difference that on sm8450 symbol clocks
are provided by the phy).

> ---
>
> Changes since v1:
> - Updated commit message to clarify that the removed numbers are correct.
>
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index bc176c252bca..ceb064a83038 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -38,6 +38,24 @@ sleep_clk: sleep-clk {
>                         clock-frequency = <32000>;
>                         #clock-cells = <0>;
>                 };
> +
> +               ufs_phy_rx_symbol_0_clk: ufs-phy-rx-symbol-0 {
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <1000>;
> +                       #clock-cells = <0>;
> +               };
> +
> +               ufs_phy_rx_symbol_1_clk: ufs-phy-rx-symbol-1 {
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <1000>;
> +                       #clock-cells = <0>;
> +               };
> +
> +               ufs_phy_tx_symbol_0_clk: ufs-phy-tx-symbol-0 {
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <1000>;
> +                       #clock-cells = <0>;
> +               };
>         };
>
>         cpus {
> @@ -606,9 +624,9 @@ gcc: clock-controller@100000 {
>                                  <0>,
>                                  <0>,
>                                  <0>,
> -                                <0>,
> -                                <0>,
> -                                <0>,
> +                                <&ufs_phy_rx_symbol_0_clk>,
> +                                <&ufs_phy_rx_symbol_1_clk>,
> +                                <&ufs_phy_tx_symbol_0_clk>,
>                                  <0>,
>                                  <0>;
>                 };
> @@ -2079,8 +2097,8 @@ ufs_mem_hc: ufshc@1d84000 {
>                                 <75000000 300000000>,
>                                 <0 0>,
>                                 <0 0>,
> -                               <75000000 300000000>,
> -                               <75000000 300000000>;
> +                               <0 0>,
> +                               <0 0>;
>                         status = "disabled";
>                 };
>
> --
> 2.33.1
>


-- 
With best wishes
Dmitry
