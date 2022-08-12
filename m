Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00DF590ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiHLKLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbiHLKKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:10:46 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E113B65547
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:10:44 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u6so481804ljk.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=YnO1pHHfHsEauYn5PrVwI+I0to4oCTaqbSSyaQD5RLo=;
        b=WVsn2whuyB88Cve/nDe+ywf+uEa2BJop+sV9sFgjhtG/w1GN32q6ARUvsItjNidHaL
         uc0xM2DKVXHJSXP0pHsO8Yup8ps1JlZRPDZnBNM81S6aM7N/J3QgpQkcY5ZOcJCnOoKt
         pMIqUgkt98Dmp2I66ARBoEG2aFg2cEU/787Cq1MlpC36+OU3jRPa2+YqM9GlJEClxZas
         cWKQxReBIiYNA1/sPzXfcfuxrI9+wsvB4hrvyCPLGRegpi/UlB4TTAaultJc3+itjkGt
         LBueZQnZiJmoI0iP7nN+6OrR+gPUUaaY1GEw57Vv6eXMde8E3yxBvPYSqNcuVnJYmD1z
         mo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=YnO1pHHfHsEauYn5PrVwI+I0to4oCTaqbSSyaQD5RLo=;
        b=dyk8MOOkMaTwEn736NRTSM79789hJAJduLzjdg0uLjKb6OIQxk5fhX6tVpJTmttTiz
         UL1epdYPeAY+btuHiTa3eZA7ti0/JcJAgtgZfFnm2QqyrPtc7K5dGhLPCo/97s9EUJp+
         SI7bpkW2dRC4YEb76+vn5qwq11yFFWAa71mUKMWv8z3MToM1K7KX52rLFC/KIdnLUMi+
         CSw6Vgc1y3ANBm5fDtD6ZEwbTN5zfRdgVbjw4lNEiuvhJrhl+RF2Xb5fY+mfitBbqjlG
         Vq/AJvszzylvzCaTx87fdLfAhnnA0Akzk79dLLNrt2glS1e0kJjPKjRCzfbUuvH0pqq/
         rKwA==
X-Gm-Message-State: ACgBeo2f3JZcEv7sexyyfxeQpFl3XrILaRcs306CPDTvaw30g/TaZui5
        08c8gzfoISXwi/97VuJw3cAh7g==
X-Google-Smtp-Source: AA6agR71WlXo8RsCEA9Nx5arAER4oXqUS6Of5aWMDbEM/uO7zcEMcnui/bpouYwl9Y2gMm59oj7bhA==
X-Received: by 2002:a2e:9884:0:b0:25e:5a7a:42c5 with SMTP id b4-20020a2e9884000000b0025e5a7a42c5mr1014439ljj.2.1660299043268;
        Fri, 12 Aug 2022 03:10:43 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id f11-20020a05651c02cb00b0025a70f7ea3asm300948ljo.138.2022.08.12.03.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:10:42 -0700 (PDT)
Message-ID: <f8a35b0d-593b-2439-585a-34b5d49068b5@linaro.org>
Date:   Fri, 12 Aug 2022 13:10:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 7/7] arm64: dts: imx93: add lpspi nodes
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220812074609.53131-1-peng.fan@oss.nxp.com>
 <20220812074609.53131-8-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812074609.53131-8-peng.fan@oss.nxp.com>
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
> Add i.MX93 lpspi nodes
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 3d1309d393a4..64fae970bfdd 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -166,6 +166,30 @@ lpi2c2: i2c@44350000 {
>  				status = "disabled";
>  			};
>  
> +			lpspi1: spi@44360000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;

First compatible, then reg, then the rest of properties.

> +				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";

Undocumented compatible.

Best regards,
Krzysztof
