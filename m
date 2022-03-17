Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B183A4DD02F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiCQV3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiCQV3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:29:45 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F403B65ED
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:28:26 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id e4so3937045oif.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=UNSHY9stDEkYj4x5uGDPU+/xpghSYFwE9UEK93GK/gM=;
        b=UJ6ChFrD90E+fyCqG323ewJ4CboNt0noYEGXnfAPEfX84YTjFpiHIqWLGryy+REnEl
         m+BeB7MRpK2nOqB4s2Vd8hj6AzSxqmyqCSgGwWoDz4bynPsW6Kd44b2jxUBbqTKRdx5M
         rGSwbd+IxqOivaCpFLd6L9XgHkiW067VR7wP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=UNSHY9stDEkYj4x5uGDPU+/xpghSYFwE9UEK93GK/gM=;
        b=6R58PpfXWtdxuurPUDljbDwvBESGsLE7pGF79ueGW1fDf2XHUbPtH1HzqMKMtjAnxt
         VIYTCH6+vcK6YkVkWGCW1bGnRUPyYwXiIz2NaBXjO4IxlK8uUpzH2AsZOKnR0XRQLA2u
         +nXyy4mD1pTh21kYvghXMNrl0Ntf5vh+nG7VOTIMCCcggO+RQSMTU6kTx0sh6bGD/8jn
         DKLVyD2ffBEyJEr4WciFGMyXDyVtoOgSQZdKSX6cJZy341bwtpexDhJ/WUDhoxIz9ZJE
         knyn9SoA8YHIBVFgD6QOroe9HghDayzCK1psiWzIi2QjtkxAdFs2hlufpiY+lIOobbCs
         ng0w==
X-Gm-Message-State: AOAM533PRC9Tqvf6cM5yOjV4Et+gBn0OB3wto0FctKiDw64ap9dDw+UZ
        cP6y6GB3RdZJyksqfraNkv+pxrn0ikEcMlW1luxwTg==
X-Google-Smtp-Source: ABdhPJyv2KBnd9epOKRH7UvrY9oWjNtBrVHvuV99b+9vkNMSlZzoiR1rQ+l7ignHhDoNDiXp1SY6ndIb2XVw3NaYJjs=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr3029465oif.63.1647552506394; Thu, 17
 Mar 2022 14:28:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Mar 2022 17:28:25 -0400
MIME-Version: 1.0
In-Reply-To: <1647452154-16361-4-git-send-email-quic_sbillaka@quicinc.com>
References: <1647452154-16361-1-git-send-email-quic_sbillaka@quicinc.com> <1647452154-16361-4-git-send-email-quic_sbillaka@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 17 Mar 2022 17:28:25 -0400
Message-ID: <CAE-0n51SCm2HJ4O-DPJy3zKLrbgn9EFQbYPkzJDyqNncnC=4mA@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] arm64: dts: qcom: sc7280: Enable backlight for eDP panel
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     robdclark@gmail.com, seanpaul@chromium.org,
        quic_kalyant@quicinc.com, quic_abhinavk@quicinc.com,
        dianders@chromium.org, quic_khsieh@quicinc.com, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        thierry.reding@gmail.com, sam@ravnborg.org,
        dmitry.baryshkov@linaro.org, quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (2022-03-16 10:35:48)
> Enable backlight support for eDP panel on CRD platform for sc7280.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
>
> Changes in v5:
>   - Separate out backlight nodes
>
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index 2df654e..16d1a5b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -37,6 +37,15 @@
>                 pinctrl-0 = <&edp_panel_power>;
>         };
>
> +       edp_backlight: edp-backlight {

Does this also move to qcard.dtsi? Why can't this be combined with the
previous patch?

> +               compatible = "pwm-backlight";
> +
> +               power-supply = <&vreg_edp_bp>;
> +               pwms = <&pm8350c_pwm 3 65535>;
> +
> +               enable-gpios = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
> +       };
> +
>         vreg_edp_bp: vreg-edp-bp-regulator {
>                 compatible = "regulator-fixed";
>                 regulator-name = "vreg_edp_bp";
> @@ -123,7 +132,9 @@ ap_ts_pen_1v8: &i2c13 {
>                 edp_panel: edp-panel {
>                         compatible = "edp-panel";
>
> +                       backlight = <&edp_backlight>;
>                         power-supply = <&edp_3v3_regulator>;
> +

Nitpick: Remove this newline from this hunk and put it in when
power-supply is introduced.

>                         ports {
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> @@ -172,6 +183,13 @@ ap_ts_pen_1v8: &i2c13 {
>         };
>  };
>
> +&pm8350c_pwm {
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&edp_bl_pwm>;

I see the pinctrl is used now but it would be easier to review this
patch if the pinctrl was in this patch.
