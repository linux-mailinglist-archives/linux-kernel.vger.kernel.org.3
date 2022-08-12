Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E343D590EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbiHLKIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiHLKIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:08:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20070A5723
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:08:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f20so686280lfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=UDjS6AexQdXaIvibc5yOeF+EeelAKtXnPyFXYUtQcWg=;
        b=JrTZ5KVr1mAILn0zm06cVNNGHv9xxZMs08fiREm2uVQPbHiFlL1Yzp/lwdwtZIZG/2
         NssM13/IfJPCWxoUpA9JIYtGBwqQvAZk8pi+mngIK3UqOdGffd+qUeyylKOROJvdv5+8
         XGpv8SOyGPjj6vDb7WMf5VsJo8Nt/7uBYqNg01Ri5nJ4teX8AhH3uB92uvYnlYmWWozv
         1QH3F7GW067nYYLJkd+48GSela4Ohy9waKWNXpnUUPt7Sg3ciXexFpEOBSoV0wd1/6IG
         dLoypaqbmiDKCXTKDOpGs4YqG728aphJ0tKARlokhQXsvzrppBh3y5kCn9vV7dusnCTu
         TMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=UDjS6AexQdXaIvibc5yOeF+EeelAKtXnPyFXYUtQcWg=;
        b=kL0+UeI4r+lFf+UFiDi9vx1aK3Xtu6knyIETRyKA4zfoBqLX2RP+DB9DgLyNodIo1l
         dH3EGHcnxDKBV9T97xD59SFRNBFrqcY7BmQHOaXutUv90OYnLCP/D/oUqVX0nl35aMtR
         m9vpxLu2opO32WHB/ROyXUviXIm+vU0axFyFeaXPc1x92id0J+L0MCWzXx2R92P/nSy3
         mXwPVN2sPSZhV+7RYtQACo2TGV2huagJ3J3sTPv3apRYP+yA/qKZrVaNKwPqUc53+gd+
         LAOKGdmXDdKb+YIHIsDOzp6NCkaM7ljRGVJxs/Ov4AlmehysX6yhmacsq9Zb1STwP3le
         87gA==
X-Gm-Message-State: ACgBeo23nSpVrKeiCpC/7/LyYTbMgVvJVni4zEvR7O3WX+dxbr6fkohh
        5ZKE0/iOwhLu09j/TIUAKpD8mA==
X-Google-Smtp-Source: AA6agR4RCEGGKe3R7i5g/Ttw02sbkgywyFOvpGqNiPoMgDT7ksUpRY1Ge4e3nWhk0m2bjhfd4GtWzg==
X-Received: by 2002:a05:6512:158b:b0:48b:38:cff8 with SMTP id bp11-20020a056512158b00b0048b0038cff8mr973853lfb.100.1660298881449;
        Fri, 12 Aug 2022 03:08:01 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id a20-20020a056512201400b0048aeff37812sm152834lfb.308.2022.08.12.03.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:08:00 -0700 (PDT)
Message-ID: <ccf4194e-e8b5-d229-b060-864d1b3b2cd4@linaro.org>
Date:   Fri, 12 Aug 2022 13:07:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/7] arm64: dts: imx93: add s4 mu node
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
References: <20220812074609.53131-1-peng.fan@oss.nxp.com>
 <20220812074609.53131-4-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812074609.53131-4-peng.fan@oss.nxp.com>
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
> Add s4 mu node for sentinel communication
> 
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 26d5ce4a5f2c..dd76472ced46 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -342,5 +342,15 @@ gpio1: gpio@47400080 {
>  			clock-names = "gpio", "port";
>  			gpio-ranges = <&iomuxc 0 0 32>;
>  		};
> +
> +		s4muap: mailbox@47520000 {
> +			compatible = "fsl,imx93-mu-s4";
> +			reg = <0x47520000 0x10000>;
> +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "txirq", "rxirq";
> +			#mbox-cells = <2>;
> +			status = "okay";

No need for status.

Best regards,
Krzysztof
