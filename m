Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBDD59C482
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiHVRBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiHVRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:01:06 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F842CE17;
        Mon, 22 Aug 2022 10:01:05 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id d63-20020a4a5242000000b0044880019622so2025409oob.13;
        Mon, 22 Aug 2022 10:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=vllOTj75NMj9Xtj4lVknt1y4y0/yrOawPpDzQK1s7XY=;
        b=DWmuac1Mp8762LLTb28EB8pNoFqzDeZMJ0ttvYZKhTQxL6Zi85IPKVBU8L/FTiaXC7
         SsO662yBsPKP7foSC7tmV9m7gMaffxPJUsdxvD0be9KcAR6EZaih0WJariFg7f/US8I3
         gOoLSqFKpUal88QGSApF8Ge3lJoQcNL7JRZL6lc60D2hs+PuJENCT+rI+RZvhUTfpNeK
         jUDw55yCrTB1CrSUeQLKD5XE0F2WQ4lnqzzkdKA/scFbzY/sBnYR7mIjj0w9geWhwW/c
         Wr5mic0TNjcRML7/SrxH3oI7OITuZA2tRE4p86qFLBCxOH+cuP9OPXAK1GHtfCEzQ7Ma
         BatQ==
X-Gm-Message-State: ACgBeo254yXGryClkIsEmPGjUwLVRPiP0/RxzSt1DZ5hhI1a5qge2rXl
        B1siS4KynaPtx1IjY29tJA==
X-Google-Smtp-Source: AA6agR7f7iG5WZv9hUN29PKotnQLZ188Y9PJABNFzMfCJeDdQBw7SZ57RoQtRac3zi8ntAyYvNRADQ==
X-Received: by 2002:a4a:abcf:0:b0:428:47bc:4bc0 with SMTP id o15-20020a4aabcf000000b0042847bc4bc0mr7000784oon.15.1661187664664;
        Mon, 22 Aug 2022 10:01:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q12-20020a9d630c000000b0061c80e20c7dsm3019384otk.81.2022.08.22.10.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:00:59 -0700 (PDT)
Received: (nullmailer pid 4151205 invoked by uid 1000);
        Mon, 22 Aug 2022 17:00:56 -0000
Date:   Mon, 22 Aug 2022 12:00:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/85xx: DTS: Add CPLD definitions for P1021RDB
 Combo Board CPL Design
Message-ID: <20220822170056.GA4135542-robh@kernel.org>
References: <20220819084433.26011-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220819084433.26011-1-pali@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 10:44:33AM +0200, Pali Rohár wrote:
> P1021RDB Combo Board CPLD Design is used on following Freescale boards:
> P1021RDB-PC, P1020RDB-PD, P1020MBG-PC, P1020UTM-PC and P2020RDB-PCA.
> 
> Add CPLD definitions for all these boards for which already exist DTS file.
> 
> CPLD has bank size 128kB, it is connected via CS3 on LBC and mapped to
> memory range 0xFFA00000~0xFFA1FFFF.
> 
> As CPLD firmware is common on all these boards, use just one compatible
> string "fsl,p1021rdb-pc-cpld".
> 
> In some DTS files is CPLD already defined, but definition is either
> incomplete or wrong. So fix it.
> 
> All these boards have via CPLD connected max6370 watchdog at offset 0x2
> with GPIO 11, status led at offset 0x8 and reset controller at offset 0xd.
> Additionally P1020MBG-PC and P1020RDB-PD boards have FXO led at offset 0x9
> and FXS leds at offset 0xa.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi    | 92 +++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dts |  6 +-
>  arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dts |  6 +-
>  arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts     | 44 +++++++--
>  arch/powerpc/boot/dts/fsl/p1020utm-pc.dtsi    | 37 ++++++++
>  arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dts |  4 +-
>  arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dts |  4 +-
>  arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi    | 37 ++++++++
>  arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dts |  5 +-
>  arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dts |  5 +-
>  arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi    | 33 ++++++-
>  11 files changed, 251 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi b/arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi
> index a24699cfea9c..c73996dcd809 100644
> --- a/arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi
> @@ -83,6 +83,95 @@
>  		compatible = "vitesse-7385";
>  		reg = <0x2 0x0 0x20000>;
>  	};
> +
> +	cpld@3,0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,p1021rdb-pc-cpld", "simple-bus", "syscon";
> +		reg = <0x3 0x0 0x20000>;
> +		ranges = <0x0 0x3 0x0 0x20000>;
> +
> +		watchdog@2 {
> +			compatible = "maxim,max6370";
> +			reg = <0x2 0x1>;
> +			gpios = <&gpio 11 1>;
> +		};
> +
> +		led@8 {

The register-bit-led schema says this should be 'led@8,0'. Did you 
run 'dtbs_check'? 

But that's going to conflict with what simple-bus schema says. I don't 
know that 'simple-bus' is really appropriate here. The CPLD isn't really 
just a bus. 'simple-mfd' is what's more commonly used with 'syscon'.


> +			compatible = "register-bit-led";
> +			reg = <0x8 0x1>;
> +			offset = <0x8>;
> +			mask = <0x1>;
> +			active-low;
> +			default-state = "keep";
> +			label = "status";
> +			function = "status";
> +			color = <6>; /* LED_COLOR_ID_YELLOW */
> +		};

