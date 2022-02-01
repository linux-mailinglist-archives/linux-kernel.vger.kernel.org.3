Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D4E4A6765
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiBAV4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiBAV4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:56:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F84BC061714;
        Tue,  1 Feb 2022 13:56:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n12-20020a05600c3b8c00b0034eb13edb8eso1980963wms.0;
        Tue, 01 Feb 2022 13:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xb5//VV+UhPwJA9hX0ZJUb2PQg8S4OcGDLc618x0zmE=;
        b=amL7hcJFyYH09BRYh/aSGohFr1L2/REvnwtc6NWsuRGsrR5NeShNmFMdyc3m4cpwBb
         mjgHha5Q9qxFMFaeTJIagenbq+ZMnRFypU3YfPatq9kYNFrsbbifRUBnpfmxRwpFN+ZA
         PB1aQQ0HYAlEGNhU8Di9YRE1ZGo2QgRh+ikw/B2n3fTflnYyktomqoyyBLRb3OmQB4Ns
         vC3yRSjbR+B6ZoLa3bJXusXAkCga/qjEm/5ekwznmr1o2TCf03x3TuoUbbstvUrWPaAB
         9ZDb+PVAwc6QVhS84yYfwKjR/GghvnD7ZxUES+B9sIgIs8p7l6oMS6rYXEpsQIHNRWd9
         ex2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xb5//VV+UhPwJA9hX0ZJUb2PQg8S4OcGDLc618x0zmE=;
        b=6MsbwwkPC31bZ82/2IUNwLoOSanIA8MuhRdfuzWWRcA/Dh5uS/8VL3vNrzosA8l/mh
         6xo7Lbs98FRoKKn1hmkT7ieEhz7D3muVSla7shn3ppyWmwFcIpdNCjB/peRn9pWyRfju
         su/Axq/gXPusbzrQQZWIrSFOD5zNtIjvxXL+jaGdgdB2srCCAFhUhMD5ax7/WTS5MxQ8
         d2NVJPBTA2JfIuekFoswL6yU0w5/c00NGBSkQijYt7DX5pT3M5YGhRMoQxFvXA6F3Zid
         OFTyDXCf3FagsSOjpnFhDimOe7Vy4VhSikfvhkC0nIqtaybrW12d5ViWXyvkdJWUKB+W
         fy6Q==
X-Gm-Message-State: AOAM533cYuycXg9OK8uf8gDdD36CBGucSDlpVTGA1X0mD6U1DPEL4YuE
        8z+I46sqMvRD4UdjxUHDP1M=
X-Google-Smtp-Source: ABdhPJzzHGv03CAgZ2xZ5AybLgybynRD1mI6/Y88XV0wtPijVttoRJXRPqHc/dpOoX5Z1B0XmpOFVg==
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr3393775wmq.167.1643752595409;
        Tue, 01 Feb 2022 13:56:35 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id n2sm18074753wrw.63.2022.02.01.13.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:56:35 -0800 (PST)
Date:   Tue, 1 Feb 2022 22:56:23 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/17] ARM: dts: qcom: add opp table for cpu and l2 for
 ipq8064
Message-ID: <Yfmshx1TemGl6yjn@Ansuel-xps.localdomain>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
 <20220118012051.21691-13-ansuelsmth@gmail.com>
 <YfhnY1K7gXtYT5fb@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfhnY1K7gXtYT5fb@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 04:49:07PM -0600, Bjorn Andersson wrote:
> On Mon 17 Jan 19:20 CST 2022, Ansuel Smith wrote:
> 
> > Add opp table for cpu and l2 cache. The l2 cache won't work as it would
> > require a dedicated cpufreq driver to scale cache with core.
> > 
> 
> Are you saying that the L2 cache frequency scaling doesn't work so you
> put it there for completeness sake, or that it doesn't work without this
> patch?
>

I put it here for completeness sake. A driver should use the opp table
anyway, so I case I manage to make the cpufreq accepted upstream this is
already present and can be used directly.

> Could you please rewrite this to make it clear in the git history?
> 

Hope it's not a problem, in theory should be correct to put it anyway as
it does describe how the device works.

> Thanks,
> Bjorn
> 
> > Opp-level is set based on the logic of
> > 0: idle level
> > 1: normal level
> > 2: turbo level
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 99 +++++++++++++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index 6f9075489e58..1e6297d6f302 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -48,6 +48,105 @@ L2: l2-cache {
> >  		};
> >  	};
> >  
> > +	opp_table_l2: opp_table_l2 {
> > +		compatible = "operating-points-v2";
> > +
> > +		opp-384000000 {
> > +			opp-hz = /bits/ 64 <384000000>;
> > +			opp-microvolt = <1100000>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <0>;
> > +		};
> > +
> > +		opp-1000000000 {
> > +			opp-hz = /bits/ 64 <1000000000>;
> > +			opp-microvolt = <1100000>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <1>;
> > +		};
> > +
> > +		opp-1200000000 {
> > +			opp-hz = /bits/ 64 <1200000000>;
> > +			opp-microvolt = <1150000>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <2>;
> > +		};
> > +	};
> > +
> > +	opp_table0: opp_table0 {
> > +		compatible = "operating-points-v2-kryo-cpu";
> > +		nvmem-cells = <&speedbin_efuse>;
> > +
> > +		/*
> > +		 * Voltage thresholds are <target min max>
> > +		 */
> > +		opp-384000000 {
> > +			opp-hz = /bits/ 64 <384000000>;
> > +			opp-microvolt-speed0-pvs0-v0 = <1000000 950000 1050000>;
> > +			opp-microvolt-speed0-pvs1-v0 = <925000 878750 971250>;
> > +			opp-microvolt-speed0-pvs2-v0 = <875000 831250 918750>;
> > +			opp-microvolt-speed0-pvs3-v0 = <800000 760000 840000>;
> > +			opp-supported-hw = <0x1>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <0>;
> > +		};
> > +
> > +		opp-600000000 {
> > +			opp-hz = /bits/ 64 <600000000>;
> > +			opp-microvolt-speed0-pvs0-v0 = <1050000 997500 1102500>;
> > +			opp-microvolt-speed0-pvs1-v0 = <975000 926250 1023750>;
> > +			opp-microvolt-speed0-pvs2-v0 = <925000 878750 971250>;
> > +			opp-microvolt-speed0-pvs3-v0 = <850000 807500 892500>;
> > +			opp-supported-hw = <0x1>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <1>;
> > +		};
> > +
> > +		opp-800000000 {
> > +			opp-hz = /bits/ 64 <800000000>;
> > +			opp-microvolt-speed0-pvs0-v0 = <1100000 1045000 1155000>;
> > +			opp-microvolt-speed0-pvs1-v0 = <1025000 973750 1076250>;
> > +			opp-microvolt-speed0-pvs2-v0 = <995000 945250 1044750>;
> > +			opp-microvolt-speed0-pvs3-v0 = <900000 855000 945000>;
> > +			opp-supported-hw = <0x1>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <1>;
> > +		};
> > +
> > +		opp-1000000000 {
> > +			opp-hz = /bits/ 64 <1000000000>;
> > +			opp-microvolt-speed0-pvs0-v0 = <1150000 1092500 1207500>;
> > +			opp-microvolt-speed0-pvs1-v0 = <1075000 1021250 1128750>;
> > +			opp-microvolt-speed0-pvs2-v0 = <1025000 973750 1076250>;
> > +			opp-microvolt-speed0-pvs3-v0 = <950000 902500 997500>;
> > +			opp-supported-hw = <0x1>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <1>;
> > +		};
> > +
> > +		opp-1200000000 {
> > +			opp-hz = /bits/ 64 <1200000000>;
> > +			opp-microvolt-speed0-pvs0-v0 = <1200000 1140000 1260000>;
> > +			opp-microvolt-speed0-pvs1-v0 = <1125000 1068750 1181250>;
> > +			opp-microvolt-speed0-pvs2-v0 = <1075000 1021250 1128750>;
> > +			opp-microvolt-speed0-pvs3-v0 = <1000000 950000 1050000>;
> > +			opp-supported-hw = <0x1>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <2>;
> > +		};
> > +
> > +		opp-1400000000 {
> > +			opp-hz = /bits/ 64 <1400000000>;
> > +			opp-microvolt-speed0-pvs0-v0 = <1250000 1187500 1312500>;
> > +			opp-microvolt-speed0-pvs1-v0 = <1175000 1116250 1233750>;
> > +			opp-microvolt-speed0-pvs2-v0 = <1125000 1068750 1181250>;
> > +			opp-microvolt-speed0-pvs3-v0 = <1050000 997500 1102500>;
> > +			opp-supported-hw = <0x1>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <2>;
> > +		};
> > +	};
> > +
> >  	thermal-zones {
> >  		sensor0-thermal {
> >  			polling-delay-passive = <0>;
> > -- 
> > 2.33.1
> > 

-- 
	Ansuel
