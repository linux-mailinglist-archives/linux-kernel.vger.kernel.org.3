Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D69598BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345089AbiHRSrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345544AbiHRSqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:46:47 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0880BD1C1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:46:22 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11cab7d7e0fso1617275fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=6Z6uEqxwpDOfnuK+UVMCWoACLsRd2/9qi+DqixTXtxw=;
        b=iVNTuDR5I+ytb+s4rAAhFaglQPC3WfvEqoAhtAff0x1FWbwybR8rgiCGh1lXQLM8kI
         KA+gO4pHbgJLaAbzCOqNwjqfY+6rbvRJYG0GnzxKJWr3uPzs3Flw6P3u4MrwObvicT7H
         2SH5Noomu406flNjt6iXBe45b7cMnNAAlSB6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=6Z6uEqxwpDOfnuK+UVMCWoACLsRd2/9qi+DqixTXtxw=;
        b=FbLbfk2tL/ir15GJRVmjrDPKtqYNFSoW2vMgS1KkF/yMS+r4zVCeAIXaiYCU/0GHrx
         TC81OzhRvFHa4FuvFLdkYTmRCINRx3/XR5dga8kJcCqtfZL6z1OgvMcA0SBlklnye3me
         m7BlVEEXJwwPkc9xL/JlHCAUvL26PEgdt3KAYtqZfkjobf6unT0mLujhPG+MgEQ/+z9R
         2QAJgi7W5UaHOquAaNPkqKfuJgePeYVuSpA4G5flQY7e3q4BprLImSy1x/Ne6ThAMA8I
         MtVOxzad9RSAVUJ/CPuWLGRz+N0rYsH5gXBk8F6uKX1bzA/pQ0tb2AQqH0rA76ZyZjvS
         dkGQ==
X-Gm-Message-State: ACgBeo1/VY9MCpNvzV/F6Lil4P40PjNetW5liphWeG8oSAM4UKv42Qv4
        LTnjN9wpG/YVZv4OEUDv8wrSJ55C1een366xvcDRPg==
X-Google-Smtp-Source: AA6agR4dMbyjRV88dk8t32ajw/6ITJWQfxQNrPR5mCJrsf6fvga0+ETZsEHDFqqJyHIpfwU9aAQ+qWzTCRrcGVWZTg4=
X-Received: by 2002:a05:6870:e408:b0:11c:37ad:773a with SMTP id
 n8-20020a056870e40800b0011c37ad773amr2042704oag.44.1660848382277; Thu, 18 Aug
 2022 11:46:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Aug 2022 13:46:21 -0500
MIME-Version: 1.0
In-Reply-To: <20220818084216.1.I5c2b6fea19c4c0dec67fd4931f03df8e5ccaca95@changeid>
References: <20220818084216.1.I5c2b6fea19c4c0dec67fd4931f03df8e5ccaca95@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 18 Aug 2022 13:46:21 -0500
Message-ID: <CAE-0n52GzxXEsToWzfU1TMuASuC6TKK7NXxYbBQWxNmM74FxZA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add sleep state for alc5682 codec
To:     "Joseph S. Barrera III" <joebar@chromium.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Alexandru Stan <amstan@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joseph S. Barrera III (2022-08-18 08:42:19)
> Add sleep state to acl5682. In default, gpio28 (HP_IRQ) is bias-pull-up.
> To save power, in the new sleep state, gpio28 is bias-disable.
>
> sleeping, /sys/kernel/debug/gpio shows gpio28 as "no pull". When codec

Is something missing? The sentence starts with 'sleeping'.

> is awake (microphone plugged in and in use), it shows gpio28 as "pull up".
>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index b5f534db135a..94dd6c34d997 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -755,8 +755,9 @@ hp_i2c: &i2c9 {
>         alc5682: codec@1a {
>                 compatible = "realtek,rt5682i";
>                 reg = <0x1a>;
> -               pinctrl-names = "default";
> +               pinctrl-names = "default", "sleep";
>                 pinctrl-0 = <&hp_irq>;
> +               pinctrl-1 = <&hp_sleep>;
>
>                 #sound-dai-cells = <1>;
>
> @@ -1336,6 +1337,18 @@ pinconf {
>                 };
>         };
>
> +       hp_sleep: hp-sleep {
> +               pinmux {
> +                       pins = "gpio28";
> +                       function = "gpio";
> +               };
> +
> +               pinconf {
> +                       pins = "gpio28";
> +                       bias-disable;
> +               };

Does removing the bias cause an irq to trigger? I'm worried that this
change may cause a spurious irq upon entering or exiting sleep, maybe
both actually. The irq is double edged so we really want it to stay
stable at one level whenever the gpio interrupt hardware is sensing the
line.

From what I can tell the pin is powered by AVDD-supply and I can't tell
if that is ever powered off while the driver is probed. Probably not? If
the power to the pin on the codec is never turned off then there isn't a
power leak from what I can tell.
