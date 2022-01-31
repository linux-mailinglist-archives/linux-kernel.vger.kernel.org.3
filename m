Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DBA4A529B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiAaWtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiAaWtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:49:10 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA2EC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:49:10 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id u13so13536601oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zH4G8FhpzwG8vGycg/3LNRhJPRrFcCye+DMKHFi6Thc=;
        b=Z+C/vr5aIT6/wwUd35zbTynl7Zjos1sT4ON9OT/iWsN0kEYqucV9ox33Y40BneFydQ
         dM3FT60gJJHfBT/EmqlnlRdOfUprmHRPwV0rdHvcY9d/2uYuZoMKqwTbikDk0Jb9GpfJ
         eLuE93gYe4As+VR1uZftkEUzNXk/afrj6wQFUf9YrxGMgSdHN703HBMeeh/ko1fuSJKL
         96GMoCu9HaiG1QIBH86JAf4T/yJzcJNHcQeBk2wvKkB7jTR8btCtWkvRQPdJ7aaeKL90
         7GbePG6Es9zFE5oTZPBeh6xOoLZWX+RRLrMS8uXEfl4XXrSxB1XuCFfkcifkBl3HpzEH
         T+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zH4G8FhpzwG8vGycg/3LNRhJPRrFcCye+DMKHFi6Thc=;
        b=ds1aXPCW6unIi/bb9G2s4g+Um6eMHze/BI2lB0e4xibb1oTmC/kKlTNspEP7+2DjRo
         93WuUUjLtdiJ3OMQ2QpM6iQyfM2uKeqfc2wS3LjzhwB37B1q43JlSqhkDvTX+or2SfTN
         fzpm5cjQJ5CKopVz5KZ7BPTYeaCZDznVXfL9UlHrok3MhRN1IjXKI7cFMjjS/DlNdA6p
         cxVPENQ4ANOwrql6wkXvpNrA8qaT24emv0T8poS/Dlf4JqMSWCG/A6hNambmO4primxA
         leksUG2AR64PTo88a3Kj3OekKeldM9woAHYztrx0tGH63OtdMQS7+WQK7H2UBp8w3rua
         wN8Q==
X-Gm-Message-State: AOAM532th4+0NeVMKs/P4VuBontj4kCAoxhm/kMr/2QfJoVFolNc2ZIp
        UcREPgE89stCePXnLnxBgL26mA==
X-Google-Smtp-Source: ABdhPJxuZlYoI8KM9zf3D0JjhRwI1p4aqNYZezGEaZ+/GCbAPwG/LQABbp3SdE61/B5emMDHIBguug==
X-Received: by 2002:a05:6808:f8d:: with SMTP id o13mr14653449oiw.250.1643669349914;
        Mon, 31 Jan 2022 14:49:09 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id a15sm17882083oil.13.2022.01.31.14.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:49:09 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:49:07 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/17] ARM: dts: qcom: add opp table for cpu and l2 for
 ipq8064
Message-ID: <YfhnY1K7gXtYT5fb@builder.lan>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
 <20220118012051.21691-13-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118012051.21691-13-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Jan 19:20 CST 2022, Ansuel Smith wrote:

> Add opp table for cpu and l2 cache. The l2 cache won't work as it would
> require a dedicated cpufreq driver to scale cache with core.
> 

Are you saying that the L2 cache frequency scaling doesn't work so you
put it there for completeness sake, or that it doesn't work without this
patch?

Could you please rewrite this to make it clear in the git history?

Thanks,
Bjorn

> Opp-level is set based on the logic of
> 0: idle level
> 1: normal level
> 2: turbo level
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 99 +++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 6f9075489e58..1e6297d6f302 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -48,6 +48,105 @@ L2: l2-cache {
>  		};
>  	};
>  
> +	opp_table_l2: opp_table_l2 {
> +		compatible = "operating-points-v2";
> +
> +		opp-384000000 {
> +			opp-hz = /bits/ 64 <384000000>;
> +			opp-microvolt = <1100000>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <0>;
> +		};
> +
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <1100000>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <1>;
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <1150000>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <2>;
> +		};
> +	};
> +
> +	opp_table0: opp_table0 {
> +		compatible = "operating-points-v2-kryo-cpu";
> +		nvmem-cells = <&speedbin_efuse>;
> +
> +		/*
> +		 * Voltage thresholds are <target min max>
> +		 */
> +		opp-384000000 {
> +			opp-hz = /bits/ 64 <384000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1000000 950000 1050000>;
> +			opp-microvolt-speed0-pvs1-v0 = <925000 878750 971250>;
> +			opp-microvolt-speed0-pvs2-v0 = <875000 831250 918750>;
> +			opp-microvolt-speed0-pvs3-v0 = <800000 760000 840000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <0>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1050000 997500 1102500>;
> +			opp-microvolt-speed0-pvs1-v0 = <975000 926250 1023750>;
> +			opp-microvolt-speed0-pvs2-v0 = <925000 878750 971250>;
> +			opp-microvolt-speed0-pvs3-v0 = <850000 807500 892500>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <1>;
> +		};
> +
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1100000 1045000 1155000>;
> +			opp-microvolt-speed0-pvs1-v0 = <1025000 973750 1076250>;
> +			opp-microvolt-speed0-pvs2-v0 = <995000 945250 1044750>;
> +			opp-microvolt-speed0-pvs3-v0 = <900000 855000 945000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <1>;
> +		};
> +
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1150000 1092500 1207500>;
> +			opp-microvolt-speed0-pvs1-v0 = <1075000 1021250 1128750>;
> +			opp-microvolt-speed0-pvs2-v0 = <1025000 973750 1076250>;
> +			opp-microvolt-speed0-pvs3-v0 = <950000 902500 997500>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <1>;
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1200000 1140000 1260000>;
> +			opp-microvolt-speed0-pvs1-v0 = <1125000 1068750 1181250>;
> +			opp-microvolt-speed0-pvs2-v0 = <1075000 1021250 1128750>;
> +			opp-microvolt-speed0-pvs3-v0 = <1000000 950000 1050000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <2>;
> +		};
> +
> +		opp-1400000000 {
> +			opp-hz = /bits/ 64 <1400000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1250000 1187500 1312500>;
> +			opp-microvolt-speed0-pvs1-v0 = <1175000 1116250 1233750>;
> +			opp-microvolt-speed0-pvs2-v0 = <1125000 1068750 1181250>;
> +			opp-microvolt-speed0-pvs3-v0 = <1050000 997500 1102500>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <2>;
> +		};
> +	};
> +
>  	thermal-zones {
>  		sensor0-thermal {
>  			polling-delay-passive = <0>;
> -- 
> 2.33.1
> 
