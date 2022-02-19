Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA304BC4AD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 03:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbiBSCCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 21:02:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241002AbiBSCCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 21:02:19 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470D424637B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:01:57 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id w3-20020a056830060300b005ad10e3becaso3180898oti.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=H1HxUEpXoVQpsG8b03LMRl3OP81XuF90MDBUIM1swkQ=;
        b=eQ5IdMRZJ/DaSRP8WbiioyS35zcy5eh0OoymuYg4k1pbLMXwFPhx6Bp9+3DKPVO1vR
         6shMg4ag19yItVLaQJzXoh57cB9YPbPrdKYsDJDRiQOgmnMfVtRJhOPnKkcYQrJ5Ye29
         wS9+CiZlwWxqD1AOSZqhXXkKmmYf858gzM+C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=H1HxUEpXoVQpsG8b03LMRl3OP81XuF90MDBUIM1swkQ=;
        b=s6AaC8bjhJvewesnnrCn6iAKx/4/BuFpinXiU4I6MEoK9TdF/CgS6vuYyAP/2SBP2K
         JuzihntAwdhTmsxRaI+0yOb0415JqreVas5YS09MPwO7UzHbKQAqk4xLk6H1VTlO92hq
         6TRybsjfH3ObkpRb6dQtHyNmHEf6udmdzFuZf/MP2x59Bt1Od7fL3D0cNxPwChhMhast
         7NAyeo0bKs1lAn4SMELmt0q/C8yIPWTY1ozCYnBIvwzocxXEx0cqN4D9YG0l0Zf0F4/G
         ekmFQFwkFped1fvv7pWVoSMOsIGTMLh/2xHRBdhCgDWk6K5WxSACdls9T/xrfmDLXVeO
         d1rg==
X-Gm-Message-State: AOAM530AL+L+zRT9HIzdgv/W+/r5HdLXEOwHUJytBBK4V8lYjq5pFIBU
        EM/hWWVsZHHtb3QyPpfbPMTpCiu19F4BkUVMLy32iQ==
X-Google-Smtp-Source: ABdhPJxbSl0kE3DczPu6BGX+BY6C0anissA0/n4yKPe0SQQa9W0I7aVBe/cfhUhFKWw4vHqaAMQV+sHfQkhzqIZeMyg=
X-Received: by 2002:a9d:22e9:0:b0:5ac:1754:342c with SMTP id
 y96-20020a9d22e9000000b005ac1754342cmr3333680ota.159.1645236116595; Fri, 18
 Feb 2022 18:01:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Feb 2022 18:01:55 -0800
MIME-Version: 1.0
In-Reply-To: <1645182064-15843-6-git-send-email-quic_c_skakit@quicinc.com>
References: <1645182064-15843-1-git-send-email-quic_c_skakit@quicinc.com> <1645182064-15843-6-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 18 Feb 2022 18:01:55 -0800
Message-ID: <CAE-0n509bg6RzieOtYuUvicU14D7bmgH-u02F1TB+hBZ+xH4CA@mail.gmail.com>
Subject: Re: [PATCH V7 5/5] arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-02-18 03:01:03)
> Add pm8008_infra and pm8008_regulators support for sc7280 idp.
>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---
> Changes in V2:
>  - As per Stephen's comments, replaced '_' with '-' for node names.
>
> Changes in V3:
>  - Changed the regulator node names as l1, l2 etc
>  - Changed "pm8008-regulators" to "regulators"
>  - Changed "qcom,min-dropout-voltage" to "regulator-min-dropout-voltage-microvolt"
>
> Changes in V4:
>  - Moved all common stuff to pm8008.dtsi and added board specific configurations here.
>
> Changes in V5:
>  - Changed the node names as per pm8008.dtsi
>  - Moved supply nodes to chip level (mfd node).
>  - Removed the regulator-mindropout property.
>
> Changes in V6:
>  - No changes.
>
> Changes in V7:
>  - No Changes.
>
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 66 ++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index ecbf2b8..371ad19 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -263,6 +263,62 @@
>         };
>  };
>
> +&i2c1 {

Can we add another phandle?

&pm8008_bus: &i2c1 {

> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       status = "okay";
> +
> +       #include "pm8008.dtsi"
> +};

And then

#include "pm8008.dtsi"

and have the pm8008.dtsi file add itself as a child of &pm8008_bus? Then
we can easily see that pm8008 is a child of pm8008_bus without having to
figure out where the file is included. It also helps avoid polluting the
i2c node with things that shouldn't be there in case we want to include
configuration bits in the pm8008.dtsi file that aren't directly related
to the bus node.

> +
> +&pm8008_infra {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pm8008_active>;
> +};
> +
> +&pm8008_regulators {
> +       vdd_l1_l2-supply = <&vreg_s8b_1p2>;
> +       vdd_l3_l4-supply = <&vreg_s1b_1p8>;
> +       vdd_l5-supply = <&vreg_bob>;
> +       vdd_l6-supply = <&vreg_bob>;
> +       vdd_l7-supply = <&vreg_bob>;
> +};
> +
> +&pm8008_l1 {
> +       regulator-min-microvolt = <950000>;
> +       regulator-max-microvolt = <1300000>;
> +};
> +
> +&pm8008_l2 {
> +       regulator-min-microvolt = <950000>;
> +       regulator-max-microvolt = <1250000>;
> +};
> +
> +&pm8008_l3 {
> +       regulator-min-microvolt = <1650000>;
> +       regulator-max-microvolt = <3000000>;
> +};
> +
> +&pm8008_l4 {
> +       regulator-min-microvolt = <1504000>;
> +       regulator-max-microvolt = <1600000>;
> +};
> +
> +&pm8008_l5 {
> +       regulator-min-microvolt = <2600000>;
> +       regulator-max-microvolt = <3000000>;
> +};
> +
> +&pm8008_l6 {
> +       regulator-min-microvolt = <2600000>;
> +       regulator-max-microvolt = <3000000>;
> +};
> +
> +&pm8008_l7 {
> +       regulator-min-microvolt = <3000000>;
> +       regulator-max-microvolt = <3544000>;
> +};
> +
>  &qfprom {
>         vcc-supply = <&vreg_l1c_1p8>;
>  };
> @@ -375,6 +431,16 @@
>         drive-strength = <2>;
>  };
>
> +&pm8350c_gpios {
> +       pm8008_active: pm8008_active {

No underscore in node names. pm8008_active: pm8008-active {

> +               pins = "gpio4";
> +               function = "normal";
> +               bias-disable;
> +               output-high;

Is this a reset signal? Should the driver be deasserting the reset when
it is ready? That could be the same time the gpio is acquired.

> +               power-source = <0>;
> +       };
> +};
