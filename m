Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094F24E930B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbiC1LMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiC1LM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:12:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582454A918;
        Mon, 28 Mar 2022 04:10:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u16so19845511wru.4;
        Mon, 28 Mar 2022 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YO5Ybs7Z8BiVv4Kteu2ySFfAWcGUm1ja/kydyOFD7Lg=;
        b=CKEsQTLqEPzq7MUVFUaoxlvKXGwAhnE1F7Y+/DcQg0ZaGnS8BOvynke/Wy+JfmqqjZ
         zzzdxZvLMEEbqabznWzGTrzJBRVDaI63vAwHRpV+g6tORgc9QOW30PPsd9ANuHFaeIDz
         vfmKYz9p9i08+PDK5Mnp16ajjhLiTeoLW/CfRML9RWqSGG9dkYZ6+Y2eXuAkYaq9oj1F
         Tw45Fmb86AgV2C2EE76qszAWfB3KXH49uRpsfJhl4OgnI2+VHFbI+gwvjBFFsjZdBm+g
         BRxTV3W0PA7zGdLbk7rhdZg4cqlmYzzg7beFXVaaxnFikxYOGFUwAxjEBN/YAUGDInKv
         YDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YO5Ybs7Z8BiVv4Kteu2ySFfAWcGUm1ja/kydyOFD7Lg=;
        b=DS8LB7f+9+eNrQdnwmc4OC9K5P1OAsY201DCTHY/1G4kuF5MnyeReTRprHfQ2jtPHN
         Hz6rglCy9Ye5its9Ep4E9impLbk17pkKM7g40zzhf0B3bkO2Tr0TFNOwzYzKSq7jmYiC
         c5Ta0XXqXJaDSx+1cQTqbGd4Ng1mvl25yYhkzVXPtA4+lldIzOwibYrqNfawoeyRosPa
         RCujKHPLdak6UVAnpR5JLMOJFTQAU83aK+jDe/iGtxE238mlMQDYVAIAz/yOLEzsmM7m
         tKmZr3yOx6aICQsI12EjbPvj9V/e84IT23cUazzrTR7Xh/kAFPCkynqa7GsgIAjYrPsQ
         H/2g==
X-Gm-Message-State: AOAM5318VkpnN4MpHFtHS0Gsm1pBHgfgVgoQBZTpOCJS8/VsjaO1C51j
        bAjURqEJccUwj6cqtV11veg=
X-Google-Smtp-Source: ABdhPJzaAxJbsNW/3r4U3icUncEmZem0++QDKaBkIhG8tcgajESrnxuVR3yF/nCbwWz4+TMjtqn6fQ==
X-Received: by 2002:adf:d1e7:0:b0:205:8909:a67f with SMTP id g7-20020adfd1e7000000b002058909a67fmr22485894wrd.66.1648465847967;
        Mon, 28 Mar 2022 04:10:47 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id r13-20020adfbb0d000000b00203e0efdd3bsm12270763wrg.107.2022.03.28.04.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 04:10:46 -0700 (PDT)
Message-ID: <51f8baea-6562-1d6b-c409-9c362f0b2fc5@gmail.com>
Date:   Mon, 28 Mar 2022 13:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 22/22] arm64: dts: mt8192: Add pwm node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-23-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-23-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/03/2022 15:45, Allen-KH Cheng wrote:
> Add pwm node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index f0f0f067c023..ea98b2230f18 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -625,6 +625,17 @@
>   			status = "disabled";
>   		};
>   
> +		pwm0: pwm@1100e000 {
> +			compatible = "mediatek,mt8183-disp-pwm";
> +			reg = <0 0x1100e000 0 0x1000>;
> +			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>;

Binding description is missing interrupt property. Remeber that the DT should 
describe the HW, so we need to update the binding description.
I just wonder what the IRQ signals, as it is not used by the driver. Definitely 
a good candidate to make the commit message more sound. So please add it there.

Thanks!
Matthias

> +			#pwm-cells = <2>;
> +			clocks = <&topckgen CLK_TOP_DISP_PWM_SEL>,
> +				 <&infracfg CLK_INFRA_DISP_PWM>;
> +			clock-names = "main", "mm";
> +			status = "disabled";
> +		};
> +
>   		spi1: spi@11010000 {
>   			compatible = "mediatek,mt8192-spi",
>   				     "mediatek,mt6765-spi";
