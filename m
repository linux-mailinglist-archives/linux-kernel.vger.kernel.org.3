Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5499A4A527E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiAaWjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiAaWjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:39:09 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E0EC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:39:09 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id b12-20020a9d754c000000b0059eb935359eso14502422otl.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I2YeCNPA7JUrutaCl69AyRbHGGFWusCcn2hr3SGCW1s=;
        b=foDZPqDmjYJKTvX6XkRIv+WJyzkPaJu2DQxeqscZqPbLvLmMYwSSLZIZxpUiDkoKGg
         anOqt8nWUzxsywZ1RzvNUZj6UFVrIrsyLyZcAgyq8DcLWkdmuUJMUS/IQBXm51d0qFi7
         ggpkddcxJ4N5F80UlNz8oAXkqLuVxdAFgnLVUDNSuGUsaiS/CXuPvIEFdlr1tZ2kBB9K
         fbtTNlFg2tWvV6zY7UwsFqazV83XlfBPl5QXW/g20crr+jqGqgdJr2hr12/UeQy6Aqo1
         hnq22qK94l1Ui+Z/qUvmwY8Idt2hHe+0uA2dw488uUsD6FC5hy5raxDbwu87Dv11Vpn+
         o8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I2YeCNPA7JUrutaCl69AyRbHGGFWusCcn2hr3SGCW1s=;
        b=YbknGTNijwMluDu1ZGXqKsbpW8DXuRbN7XmY0q5wPCR0pu/Ttz4I5HVGPRNZfAZtwn
         bZIF71beXCl09/kRpuXvMvqzT8QZLi56GUwcWyp4Entji7gD+XWd/3kWaVuf5BQrgbwx
         8+ECOqrwHdoN1iibMQLzcXinr1O20JeQSgf/4jJ+2icvdcrZ1ItXVgmL7vB25Qg1IsMh
         Urj8ZxcMZzZv2qVxmslRh0V6zdnpImVSsTC7Ee+XpUaGNavXUDQp70+1b60jFbiP8axJ
         duoTpzg8L7qXUtNr//qSED9In/zVkEn/xohxQpY2dKnug/H0rwC/H+ShkWgJi5X7fEWY
         t60Q==
X-Gm-Message-State: AOAM530/j6YtG955HA9Pp3r35xlIHm4R+Zj027M/I06eNDri/61z1xwz
        5gCr8JkQ/mtYbtTnnRceQCME5w==
X-Google-Smtp-Source: ABdhPJz3DrrbNejbTueCAz6MmMNxgUOQKSR3d4PLal0CVNEOYgaNKJjs/dRMEoEqJtXTi6yuHVSS/A==
X-Received: by 2002:a9d:12d7:: with SMTP id g81mr12610035otg.82.1643668749113;
        Mon, 31 Jan 2022 14:39:09 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id t4sm13313906oie.14.2022.01.31.14.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:39:08 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:39:06 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] arm64: dts: qcom: Add MSM8953+PM8953 device tree
Message-ID: <YfhlCkb3XUvU8ae1@builder.lan>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-14-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112194118.178026-14-luca@z3ntu.xyz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12 Jan 13:41 CST 2022, Luca Weiss wrote:

> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> The combination MSM8953 + PM8953 is commonly used, so add a
> device tree where common power supplies etc. can be configured.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

I would prefer if we stick with the current scheme and just push this
into the device dts (or possibly some vendor-common dtsi if that's
applicable).

Simply just to follow what we do on other platforms.


PS. I see some patches has been applied, but as you resubmit this
series please split it per maintainer to make it obvious to each
maintainer that they should pick their part(s).

Thanks,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi | 50 ++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi
> new file mode 100644
> index 000000000000..b5f20fc9488e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +
> +&hsusb_phy {
> +	vdd-supply = <&pm8953_l3>;
> +	vdda-pll-supply = <&pm8953_l7>;
> +	vdda-phy-dpdm-supply = <&pm8953_l13>;
> +};
> +
> +&sdhc_1 {
> +	vmmc-supply = <&pm8953_l8>;
> +	vqmmc-supply = <&pm8953_l5>;
> +};
> +
> +&sdhc_2 {
> +	vmmc-supply = <&pm8953_l11>;
> +	vqmmc-supply = <&pm8953_l12>;
> +};
> +
> +&rpm_requests {
> +	smd_rpm_regulators: pm8953-regulators {
> +		compatible = "qcom,rpm-pm8953-regulators";
> +
> +		pm8953_s1: s1 {};
> +		pm8953_s3: s3 {};
> +		pm8953_s4: s4 {};
> +
> +		pm8953_l1: l1 {};
> +		pm8953_l2: l2 {};
> +		pm8953_l3: l3 {};
> +		pm8953_l5: l5 {};
> +		pm8953_l6: l6 {};
> +		pm8953_l7: l7 {};
> +		pm8953_l8: l8 {};
> +		pm8953_l9: l9 {};
> +		pm8953_l10: l10 {};
> +		pm8953_l11: l11 {};
> +		pm8953_l12: l12 {};
> +		pm8953_l13: l13 {};
> +		pm8953_l15: l15 {};
> +		pm8953_l16: l16 {};
> +		pm8953_l17: l17 {};
> +		pm8953_l19: l19 {};
> +		pm8953_l22: l22 {};
> +		pm8953_l23: l23 {};
> +	};
> +};
> -- 
> 2.34.1
> 
