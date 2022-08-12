Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8E590EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbiHLKKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbiHLKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:10:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79756A9257
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:10:00 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z6so693681lfu.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=DEO8wC5h702OTTQwWrGdkHfWWn0+oQAxRdsLVhTCwiI=;
        b=AboLjkmXykva+zK/zd4qvTzIfqK2fQOhRWO8yqnK9K6iRbOQ9Z3qdcSI5mhg7aFpBx
         hcF4urpsxHi+SHMQdc0gznJuZLqXu/k88YKordv8zx/4H2gIwmeIINFQNSq1SkvXuoI/
         LhAqDWZ0vUT2q5boPVzEkCD9saSa6R31tlViQpT+VRbaxpogeOUnQf/lSrYcNtoVw91d
         HHwawQ0eHmKmmkjvxcSMWQYYWYdXjjLatVViuU1+ol6XkeQgn6CqMGWPzaGBOAkb+P4U
         IMsJtwmRyj4V7cW9pu1TgvCr5QgW3sUWInWAi1+TjpwTDQBwWPBy/x1117sDAvG+avTr
         Hcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DEO8wC5h702OTTQwWrGdkHfWWn0+oQAxRdsLVhTCwiI=;
        b=kckjHjDQHgd93yJV8u+1Mu5uzYyG2NU+yBlHOtJ7jdtXOAjDT/G2irgMXyssWeuc6d
         MvFOY1nkOpBizD6IvypMW8u+Q9FK8254T57DjAywCbMJKVKX6XBUI/FldSR6bQa5ZoLD
         VOMvVRsUd3rDs5u5avvOfIyh/TOwE2B1US0OF840JL1MT1hI5CJz2tSWQ2r2xcLXPmlB
         dK5HAz4vtbn8RpR0hxVvL7R6OG+12D9mNdufKxSGaj/mN4nvmdeHdflXgRQjEqaO04Zm
         oci7xLkbFCZcRzIIiXx8uere5/a2aSI1EQRNmAlhBZXdzoVGCF8wHjdshZKIEMlL/jBV
         Jj/A==
X-Gm-Message-State: ACgBeo0GCSHqm4n3OflH0S23VSi4v04Ur5LEz+KHnwgj24VPnH1f5Fr3
        zTE9mXY8NHnHgfICn8+NFu8myA==
X-Google-Smtp-Source: AA6agR6hzjduxxhjZEl4KAOrmXqgWetxPDAYgfPjYfX3RTOXQwEa3UwvF1xM1L30dGFBot8JKcb8mw==
X-Received: by 2002:a05:6512:3992:b0:48b:3f6c:9222 with SMTP id j18-20020a056512399200b0048b3f6c9222mr960335lfu.561.1660298998887;
        Fri, 12 Aug 2022 03:09:58 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id k11-20020a2ea26b000000b0025dd6c8933csm302994ljm.114.2022.08.12.03.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:09:58 -0700 (PDT)
Message-ID: <ad204120-2e4c-108c-63a8-bde17624a92b@linaro.org>
Date:   Fri, 12 Aug 2022 13:09:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 6/7] arm64: dts: imx93: add lpi2c nodes
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220812074609.53131-1-peng.fan@oss.nxp.com>
 <20220812074609.53131-7-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812074609.53131-7-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2022 10:46, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 lpi2c nodes
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 89 ++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index fd687d78cd03..3d1309d393a4 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -16,6 +16,14 @@ / {
>  	#size-cells = <2>;
>  
>  	aliases {
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		i2c3 = &lpi2c4;
> +		i2c4 = &lpi2c5;
> +		i2c5 = &lpi2c6;
> +		i2c6 = &lpi2c7;
> +		i2c7 = &lpi2c8;

i2c aliases are property of the board.
https://lore.kernel.org/linux-rockchip/CAK8P3a25iYksubCnQb1-e5yj=crEsK37RB9Hn4ZGZMwcVVrG7g@mail.gmail.com/

>  		mmc0 = &usdhc1;
>  		mmc1 = &usdhc2;
>  		mmc2 = &usdhc3;
> @@ -138,6 +146,26 @@ system_counter: timer@44290000 {
>  				clock-names = "per";
>  			};
>  
> +			lpi2c1: i2c@44340000 {
> +				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";

Undocumented compatible.

> +				reg = <0x44340000 0x10000>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_LPI2C1_GATE>,
> +					 <&clk IMX93_CLK_BUS_AON>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +


(...)

> +			lpi2c8: i2c@426e0000 {
> +				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg = <0x426e0000 0x10000>;
> +				interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_LPI2C8_GATE>,
> +					 <&clk IMX93_CLK_BUS_WAKEUP>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +

No need for blank line



Best regards,
Krzysztof
