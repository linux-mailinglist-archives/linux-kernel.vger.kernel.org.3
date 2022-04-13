Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A38E4FFB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiDMQfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiDMQfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:35:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C275EDCF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:33:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r13so5089649ejd.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Stltg3D40cZ6I7GZarWumcxRtm5GBdaGxROyvUhluJE=;
        b=JfrzLcvHpnp3Sc00TEJrZpOyaA7pAjSPs71fhZGDHbLeY8tckjedFtpSGryKD3s66H
         Nw8F8blVjdsElO/SBPjRQHupzixEXYv+uf1mFjQ/FF4nGghVBe0z2fW1IdH8bR+txQEu
         X3IHfMTBenQg+MzA48F1fuDtn0are8srovFIorAI12+xi2t2vHueyu6yfvDNYapgYNU3
         ysirEhqCSQC+TaZuzvVc0Uwty1gvoX1O0vbGtC4G707QtC/VJw93MGlpaW3QCPaQabQf
         +TP+l2RUjYbtyVI+CpKqVMZzxW2trI5b7HNNA8YQCNllZuil1uYPXe+5DT+L3oYZohPU
         L6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Stltg3D40cZ6I7GZarWumcxRtm5GBdaGxROyvUhluJE=;
        b=snTOLw4Y59ZsY9YvfUSDPyBdyoZ1GTvBqW/uYboDQTgnhURVeSx6is8SXQqdt7IVpA
         AD9lbHH21Y7to3I958d6OT9U4mnRKXT3ffCHfUtqqN19+yf4HAnzFwnVxdUAe8+ubZVu
         oOyWFBzHAQsEKb8CXZTpBaELDeDpOf+vq3skzXNJAlKq2wupLryXbZy9tBQE+qNGzzyj
         xMK/nb0ckJ/kcNiLydMlRzT+QuykERIhzt6FpjfVoCE7Zw0JD6Q4DR98c/9D7TRgBG0/
         rDRt+LEYiXz2FnCVdhOredaPoHRfn9GRRJaCIz94kWciFs6W1rgSlkJ/yJ/FX9tJ27mI
         udCg==
X-Gm-Message-State: AOAM531jgYfyC3Psuhhvyz7DkMaT2E4PKsOTbsHWmyNyho0BpWHiHs/m
        bkVtafJuWyhMb0GL9mM1nCAk4bZQ0+k=
X-Google-Smtp-Source: ABdhPJyYgumNP49/MS0/t/SwJuLKK2ZeFHev99ai6a8CFmSsu4b+FSt3TorInB44ipln83+GI5aw7w==
X-Received: by 2002:a17:907:7e8c:b0:6e8:92df:1656 with SMTP id qb12-20020a1709077e8c00b006e892df1656mr15130850ejc.386.1649867587915;
        Wed, 13 Apr 2022 09:33:07 -0700 (PDT)
Received: from skbuf ([188.26.57.45])
        by smtp.gmail.com with ESMTPSA id q16-20020a170906145000b006bdaf981589sm142497ejc.81.2022.04.13.09.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:33:07 -0700 (PDT)
Date:   Wed, 13 Apr 2022 19:33:06 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH v3 3/8] arm64: dts: ls1028a: add flextimer based pwm nodes
Message-ID: <20220413163306.hp5qyxxgdlekczet@skbuf>
References: <20211214093240.23320-1-leoyang.li@nxp.com>
 <20211214093240.23320-4-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214093240.23320-4-leoyang.li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 03:32:35AM -0600, Li Yang wrote:
> From: Biwen Li <biwen.li@nxp.com>
>
> Add pwm nodes using flextimer controller.
>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index f2564faf7067..5a7b26a1bad2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -66,6 +66,13 @@ CPU_PW20: cpu-pw20 {
>  		};
>  	};
>
> +	rtc_clk: rtc-clk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "rtc_clk";
> +	};
> +
>  	sysclk: sysclk {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> @@ -1186,6 +1193,94 @@ ierb@1f0800000 {
>  			reg = <0x01 0xf0800000 0x0 0x10000>;
>  		};
>
> +		pwm0: pwm@2800000 {
> +			compatible = "fsl,vf610-ftm-pwm";
> +			#pwm-cells = <3>;
> +			reg = <0x0 0x2800000 0x0 0x10000>;
> +			clock-names = "ftm_sys", "ftm_ext",
> +				      "ftm_fix", "ftm_cnt_clk_en";
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&rtc_clk>, <&clockgen 4 1>;
> +			status = "disabled";
> +		};
> +
> +		pwm1: pwm@2810000 {
> +			compatible = "fsl,vf610-ftm-pwm";
> +			#pwm-cells = <3>;
> +			reg = <0x0 0x2810000 0x0 0x10000>;
> +			clock-names = "ftm_sys", "ftm_ext",
> +				      "ftm_fix", "ftm_cnt_clk_en";
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&rtc_clk>, <&clockgen 4 1>;
> +			status = "disabled";
> +		};
> +
> +		pwm2: pwm@2820000 {
> +			compatible = "fsl,vf610-ftm-pwm";
> +			#pwm-cells = <3>;
> +			reg = <0x0 0x2820000 0x0 0x10000>;
> +			clock-names = "ftm_sys", "ftm_ext",
> +				      "ftm_fix", "ftm_cnt_clk_en";
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&rtc_clk>, <&clockgen 4 1>;
> +			status = "disabled";
> +		};
> +
> +		pwm3: pwm@2830000 {
> +			compatible = "fsl,vf610-ftm-pwm";
> +			#pwm-cells = <3>;
> +			reg = <0x0 0x2830000 0x0 0x10000>;
> +			clock-names = "ftm_sys", "ftm_ext",
> +				      "ftm_fix", "ftm_cnt_clk_en";
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&rtc_clk>, <&clockgen 4 1>;
> +			status = "disabled";
> +		};
> +
> +		pwm4: pwm@2840000 {
> +			compatible = "fsl,vf610-ftm-pwm";
> +			#pwm-cells = <3>;
> +			reg = <0x0 0x2840000 0x0 0x10000>;
> +			clock-names = "ftm_sys", "ftm_ext",
> +				      "ftm_fix", "ftm_cnt_clk_en";
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&rtc_clk>, <&clockgen 4 1>;
> +			status = "disabled";
> +		};
> +
> +		pwm5: pwm@2850000 {
> +			compatible = "fsl,vf610-ftm-pwm";
> +			#pwm-cells = <3>;
> +			reg = <0x0 0x2850000 0x0 0x10000>;
> +			clock-names = "ftm_sys", "ftm_ext",
> +				      "ftm_fix", "ftm_cnt_clk_en";
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&rtc_clk>, <&clockgen 4 1>;
> +			status = "disabled";
> +		};
> +
> +		pwm6: pwm@2860000 {
> +			compatible = "fsl,vf610-ftm-pwm";
> +			#pwm-cells = <3>;
> +			reg = <0x0 0x2860000 0x0 0x10000>;
> +			clock-names = "ftm_sys", "ftm_ext",
> +				      "ftm_fix", "ftm_cnt_clk_en";
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&rtc_clk>, <&clockgen 4 1>;
> +			status = "disabled";
> +		};
> +
> +		pwm7: pwm@2870000 {
> +			compatible = "fsl,vf610-ftm-pwm";
> +			#pwm-cells = <3>;
> +			reg = <0x0 0x2870000 0x0 0x10000>;
> +			clock-names = "ftm_sys", "ftm_ext",
> +				      "ftm_fix", "ftm_cnt_clk_en";
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&rtc_clk>, <&clockgen 4 1>;
> +			status = "disabled";
> +		};
> +
>  		rcpm: power-controller@1e34040 {
>  			compatible = "fsl,ls1028a-rcpm", "fsl,qoriq-rcpm-2.1+";
>  			reg = <0x0 0x1e34040 0x0 0x1c>;
> --
> 2.25.1
>

arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1210.21-1219.5: Warning (unique_unit_address): /soc/pwm@2800000: duplicate unit-address (also used in node /soc/timer@2800000)
arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1221.21-1230.5: Warning (unique_unit_address): /soc/pwm@2810000: duplicate unit-address (also used in node /soc/timer@2810000)
