Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E60B489FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243023AbiAJTDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbiAJTDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:03:48 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675B7C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:03:48 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id v124so12713839oie.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y16qkHkmMgHKa/qlQyvw80tWKaz+7fnpKnVdmj4S/8c=;
        b=X+GPSmQD3Zrq45sIoMCWgpLgJOjHekms6/ZMEeD6FskaA9IdsHzwI6xF5sMs/aELjR
         7/Mj5BYK5iJauOy4OpTCjhaKlXrsKeYqNdWYoyppe5YKDPC3v1adKckjQ/G5CZdMKZSK
         pqqvPrmuaWhBQDKyv5gfEF8Q7fkrR7rxk+Y7Ne7ZTIMkUFtpS16kkIe9T+W9/3viEHcY
         vTAl73Y2S25o1fvxYW7/gAWAU2D+VtUzYDSMrYUPPn7vTgMeNRAYxQjKRah4YCatM7mB
         baNOTr/1rEsTjrB7n1EoyBWBgEYCVzkUJA0f+7Z1ZwfuilNc9Send2Bs+5RCXjG0t14h
         mdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y16qkHkmMgHKa/qlQyvw80tWKaz+7fnpKnVdmj4S/8c=;
        b=3c6LT5v/QrCMNrsS0dWG/JqDqIkWpztPlRoljvtFg+trDNqDYxuLAxY8ykvrtZT7Ug
         K8Chiyo4duF+azWApbB0J2Rmc3qQneQ3lClHkHK7Rx11CnaK0gTigIHtOTNxnGkuswP5
         epG7zXp8x6Xrv3YVgtPLgk6KsqdTtM8aJckv9nFejoHoGZ0PYC9r2XdpOEUQ2b4/Wuqu
         TcbXYsYzUjKVfbvbvYFLjiZtcaWukIYlGf/wybjCWsbHlXxPfUd+jxthClWfUrY3VsfD
         GmDNnjjjN6Yeygafp7Qoa9ayaXOYdgHtLbQ+7Vn61GNUXK16HDYdqAZU9IGLW3vAIsay
         1w2g==
X-Gm-Message-State: AOAM532LML3P3tYahM7GkpDZJxCzvO40eo9VAO0RfyOdireT4h4J7Zg7
        kUR/JBnZt0jSb1B7k/BwCb6ygg==
X-Google-Smtp-Source: ABdhPJzU96q+WoahiaFezz1nwyszlSfmra0cuq4XBj9AHQdCk6lCFnoCGiKmZMe46+7TH+X0lg8T1g==
X-Received: by 2002:a05:6808:15a5:: with SMTP id t37mr12164342oiw.124.1641841427684;
        Mon, 10 Jan 2022 11:03:47 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k101sm1585041otk.60.2022.01.10.11.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 11:03:47 -0800 (PST)
Date:   Mon, 10 Jan 2022 11:04:31 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: msm8960: Sort out rpm node duplication
Message-ID: <YdyDPwYh6xJbco2F@ripper>
References: <20220109200332.41474-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109200332.41474-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09 Jan 12:03 PST 2022, David Heidelberg wrote:

> On other platforms are usually regulators enumerated in platform and
> used in devices, follow the pattern on MSM8960 too.

I used to be a proponent of this, but as we grew the number of devices
supported we noticed that not everyone uses the same set of PMICs.
And then we have cases where non-Qualcomm people drew the schematics and
picked different names for the regulator lines - which we want to be
able to represent in the labels.

As such, I would prefer if we moved those other platforms towards
specifying the regulators in the board dts instead of platform dtsi.
Even though it does imply that there's some level of duplication.

Regards,
Bjorn

> 
> No functional changes.
> 
> Original author: Bjorn Andersson
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm/boot/dts/qcom-msm8960-cdp.dts | 73 +++++++++++++-------------
>  arch/arm/boot/dts/qcom-msm8960.dtsi    | 43 +++++++++++++++
>  2 files changed, 79 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
> index 830703759466..7c4c3cb79d05 100644
> --- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
> +++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
> @@ -49,7 +49,6 @@ sdcc3: mmc@12180000 {
>  
>  		rpm@108000 {
>  			regulators {
> -				compatible = "qcom,rpm-pm8921-regulators";
>  				vin_lvs1_3_6-supply = <&pm8921_s4>;
>  				vin_lvs2-supply = <&pm8921_s4>;
>  				vin_lvs4_5_7-supply = <&pm8921_s4>;
> @@ -62,7 +61,7 @@ regulators {
>  				vdd_l28-supply = <&pm8921_s7>;
>  
>  				/* Buck SMPS */
> -				pm8921_s1: s1 {
> +				s1 {
>  					regulator-always-on;
>  					regulator-min-microvolt = <1225000>;
>  					regulator-max-microvolt = <1225000>;
> @@ -70,21 +69,21 @@ pm8921_s1: s1 {
>  					bias-pull-down;
>  				};
>  
> -				pm8921_s2: s2 {
> +				s2 {
>  					regulator-min-microvolt = <1300000>;
>  					regulator-max-microvolt = <1300000>;
>  					qcom,switch-mode-frequency = <1600000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_s3: s3 {
> +				s3 {
>  					regulator-min-microvolt = <500000>;
>  					regulator-max-microvolt = <1150000>;
>  					qcom,switch-mode-frequency = <4800000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_s4: s4 {
> +				s4 {
>  					regulator-always-on;
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
> @@ -93,14 +92,14 @@ pm8921_s4: s4 {
>  					qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
>  				};
>  
> -				pm8921_s7: s7 {
> +				s7 {
>  					regulator-min-microvolt = <1150000>;
>  					regulator-max-microvolt = <1150000>;
>  					qcom,switch-mode-frequency = <3200000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_s8: s8 {
> +				s8 {
>  					regulator-always-on;
>  					regulator-min-microvolt = <2050000>;
>  					regulator-max-microvolt = <2050000>;
> @@ -109,137 +108,137 @@ pm8921_s8: s8 {
>  				};
>  
>  				/* PMOS LDO */
> -				pm8921_l1: l1 {
> +				l1 {
>  					regulator-always-on;
>  					regulator-min-microvolt = <1050000>;
>  					regulator-max-microvolt = <1050000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l2: l2 {
> +				l2 {
>  					regulator-min-microvolt = <1200000>;
>  					regulator-max-microvolt = <1200000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l3: l3 {
> +				l3 {
>  					regulator-min-microvolt = <3075000>;
>  					regulator-max-microvolt = <3075000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l4: l4 {
> +				l4 {
>  					regulator-always-on;
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l5: l5 {
> +				l5 {
>  					regulator-min-microvolt = <2950000>;
>  					regulator-max-microvolt = <2950000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l6: l6 {
> +				l6 {
>  					regulator-min-microvolt = <2950000>;
>  					regulator-max-microvolt = <2950000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l7: l7 {
> +				l7 {
>  					regulator-always-on;
>  					regulator-min-microvolt = <1850000>;
>  					regulator-max-microvolt = <2950000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l8: l8 {
> +				l8 {
>  					regulator-min-microvolt = <2800000>;
>  					regulator-max-microvolt = <3000000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l9: l9 {
> +				l9 {
>  					regulator-min-microvolt = <3000000>;
>  					regulator-max-microvolt = <3000000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l10: l10 {
> +				l10 {
>  					regulator-min-microvolt = <3000000>;
>  					regulator-max-microvolt = <3000000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l11: l11 {
> +				l11 {
>  					regulator-min-microvolt = <2850000>;
>  					regulator-max-microvolt = <2850000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l12: l12 {
> +				l12 {
>  					regulator-min-microvolt = <1200000>;
>  					regulator-max-microvolt = <1200000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l14: l14 {
> +				l14 {
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l15: l15 {
> +				l15 {
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <2950000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l16: l16 {
> +				l16 {
>  					regulator-min-microvolt = <2800000>;
>  					regulator-max-microvolt = <2800000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l17: l17 {
> +				l17 {
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <2950000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l18: l18 {
> +				l18 {
>  					regulator-min-microvolt = <1300000>;
>  					regulator-max-microvolt = <1300000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l21: l21 {
> +				l21 {
>  					regulator-min-microvolt = <1900000>;
>  					regulator-max-microvolt = <1900000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l22: l22 {
> +				l22 {
>  					regulator-min-microvolt = <2750000>;
>  					regulator-max-microvolt = <2750000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l23: l23 {
> +				l23 {
>  					regulator-always-on;
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l24: l24 {
> +				l24 {
>  					regulator-min-microvolt = <750000>;
>  					regulator-max-microvolt = <1150000>;
>  					bias-pull-down;
>  				};
>  
> -				pm8921_l25: l25 {
> +				l25 {
>  					regulator-always-on;
>  					regulator-min-microvolt = <1250000>;
>  					regulator-max-microvolt = <1250000>;
> @@ -247,35 +246,35 @@ pm8921_l25: l25 {
>  				};
>  
>  				/* Low Voltage Switch */
> -				pm8921_lvs1: lvs1 {
> +				lvs1 {
>  					bias-pull-down;
>  				};
>  
> -				pm8921_lvs2: lvs2 {
> +				lvs2 {
>  					bias-pull-down;
>  				};
>  
> -				pm8921_lvs3: lvs3 {
> +				lvs3 {
>  					bias-pull-down;
>  				};
>  
> -				pm8921_lvs4: lvs4 {
> +				lvs4 {
>  					bias-pull-down;
>  				};
>  
> -				pm8921_lvs5: lvs5 {
> +				lvs5 {
>  					bias-pull-down;
>  				};
>  
> -				pm8921_lvs6: lvs6 {
> +				lvs6 {
>  					bias-pull-down;
>  				};
>  
> -				pm8921_lvs7: lvs7 {
> +				lvs7 {
>  					bias-pull-down;
>  				};
>  
> -				pm8921_ncp: ncp {
> +				ncp {
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
>  					qcom,switch-mode-frequency = <1600000>;
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
> index d9033912c7f3..ffedc60f9ec1 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -154,6 +154,49 @@ rpm@108000 {
>  
>  			regulators {
>  				compatible = "qcom,rpm-pm8921-regulators";
> +
> +				/* Buck SMPS */
> +				pm8921_s1: s1 {};
> +				pm8921_s2: s2 {};
> +				pm8921_s3: s3 {};
> +				pm8921_s4: s4 {};
> +				pm8921_s7: s7 {};
> +				pm8921_s8: s8 {};
> +
> +				/* PMOS LDO */
> +				pm8921_l1: l1 {};
> +				pm8921_l2: l2 {};
> +				pm8921_l3: l3 {};
> +				pm8921_l4: l4 {};
> +				pm8921_l5: l5 {};
> +				pm8921_l6: l6 {};
> +				pm8921_l7: l7 {};
> +				pm8921_l8: l8 {};
> +				pm8921_l9: l9 {};
> +				pm8921_l10: l10 {};
> +				pm8921_l11: l11 {};
> +				pm8921_l12: l12 {};
> +				pm8921_l14: l14 {};
> +				pm8921_l15: l15 {};
> +				pm8921_l16: l16 {};
> +				pm8921_l17: l17 {};
> +				pm8921_l18: l18 {};
> +				pm8921_l21: l21 {};
> +				pm8921_l22: l22 {};
> +				pm8921_l23: l23 {};
> +				pm8921_l24: l24 {};
> +				pm8921_l25: l25 {};
> +
> +				/* Low Voltage Switch */
> +				pm8921_lvs1: lvs1 {};
> +				pm8921_lvs2: lvs2 {};
> +				pm8921_lvs3: lvs3 {};
> +				pm8921_lvs4: lvs4 {};
> +				pm8921_lvs5: lvs5 {};
> +				pm8921_lvs6: lvs6 {};
> +				pm8921_lvs7: lvs7 {};
> +
> +				pm8921_ncp: ncp {};
>  			};
>  		};
>  
> -- 
> 2.34.1
> 
