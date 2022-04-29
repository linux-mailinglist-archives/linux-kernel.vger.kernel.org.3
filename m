Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2F0514C47
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377219AbiD2OJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376904AbiD2OJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:09:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A7538BA;
        Fri, 29 Apr 2022 07:00:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c11so1088414wrn.8;
        Fri, 29 Apr 2022 07:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UXw9dRUog+dEg/XP99Hw1iqvRPucaZ7bzcG1rwJHhio=;
        b=YBd0+nTmzcoM2bp3hiXsuMNdPweajYXNtZrZPbniRjboy65K24zviiuLtMl5mJj60Y
         lGp3dU3D8okBn+ixe9o2sRzIW+TV+YaQp2DH7qI5AbiMQ5NPw044NSExSv8Wi8f+OyrT
         mm2TpGZewa0FjO4w6wneZ7n7gckwh1FVfTOWtx4grI94mq8uZhPbMjkEgbWyfE3+Pzb2
         HX3ZpJviFMo4mVpYilbLYEogCNK92s/Y1ll50Xv/GRNdgn3OTx/5Pp8+8HmBjg4tsCN8
         OHCH0rIySZ1wVcH4CI1ny32UzRDqzLISbA6fsM4hRJdAx4A2tleff3aa4juuguNGAYeN
         ieLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UXw9dRUog+dEg/XP99Hw1iqvRPucaZ7bzcG1rwJHhio=;
        b=3c6bNlt4ZMtiC3PUA2slX2wicgxEnxV5mOGg5eosJu4HEs/Tg5Yo8fzqfj6Fbm/DKM
         2MTItMOtlH1fogZaLj9DNMcYK4BrkQP9uKS8lQ782VANo10nMeECPIhhW2wRPQYeiBKH
         Z1W9ZEFYesRf4qRNdZvaJVID++TPZDfTzsk/pW5QvyANAsC61WIMzsaCpenlJbXTp+/t
         vZ1HxwJsc8hFvHPoK/aG408OCQltqQ+pTSva5O1FqTIRzCA+eqh+LU2dvQw3+TryhGs9
         5uC9TCliJ2VgTQn9R+vDDH5ReIfLJBCcsmeksnai7bjM0qCd0pTxKx1IMrO6wbBNhpAt
         t51A==
X-Gm-Message-State: AOAM531mhBbQeK2o6BH9+Khmr55mT7mLDNBlH2Ezh+bi+cdwfe5h1UJ2
        aoasH4/4501JJbTFz3nMjsk=
X-Google-Smtp-Source: ABdhPJzUbO5VBiVmnymikmHFglcyLkJ2PMGYgcMmAt5zqGiCuS9Z+l25Ny/E4zFagkiIjHOEMjVlwQ==
X-Received: by 2002:adf:e8c1:0:b0:20a:e116:408a with SMTP id k1-20020adfe8c1000000b0020ae116408amr17196519wrn.672.1651240834295;
        Fri, 29 Apr 2022 07:00:34 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id m6-20020a1c2606000000b00393fbf75a56sm2631655wmm.29.2022.04.29.07.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 07:00:33 -0700 (PDT)
Message-ID: <f4256b5e-e6b8-f9de-fe97-3e9c6cdcb00c@gmail.com>
Date:   Fri, 29 Apr 2022 16:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/7] arm64: dts: mediatek: mt8195-demo: enable ethernet
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220426134106.242353-1-fparent@baylibre.com>
 <20220426134106.242353-6-fparent@baylibre.com>
 <c0cf89c05ee708ec3648b267c1c0a0baa1331836.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <c0cf89c05ee708ec3648b267c1c0a0baa1331836.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/04/2022 08:25, Macpaul Lin wrote:
> On Tue, 2022-04-26 at 15:41 +0200, Fabien Parent wrote:
>> Enable ethernet on the MT8195 demo board.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 108
>> +++++++++++++++++++
>>   1 file changed, 108 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>> b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>> index 08cab3b3943b..0b7985486e2a 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>> @@ -80,6 +80,30 @@ optee_reserved: optee@43200000 {
>>   	};
>>   };
>>   
>> +&eth {
>> +	phy-mode = "rgmii-rxid";
>> +	phy-handle = <&eth_phy>;
>> +	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
>> +	snps,reset-delays-us = <0 10000 10000>;
>> +	mediatek,tx-delay-ps = <2030>;
>> +	pinctrl-names = "default", "sleep";
>> +	pinctrl-0 = <&eth_default_pins>;
>> +	pinctrl-1 = <&eth_sleep_pins>;
>> +	status = "okay";
>> +
>> +	mdio {
>> +		compatible = "snps,dwmac-mdio";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		eth_phy: phy@1 {
>> +			compatible = "ethernet-phy-id001c.c916";
>> +			#phy-cells = <0>;
>> +			reg = <0x1>;
>> +		};
>> +	};
>> +};
>> +
>>   &i2c6 {
>>   	clock-frequency = <400000>;
>>   	pinctrl-0 = <&i2c6_pins>;
>> @@ -260,6 +284,90 @@ &mt6359_vsram_others_ldo_reg {
>>   };
>>   
>>   &pio {
>> +	eth_default_pins: eth-default-pins {
>> +		pins-cc {
>> +			pinmux = <PINMUX_GPIO85__FUNC_GBE_TXC>,
>> +				 <PINMUX_GPIO88__FUNC_GBE_TXEN>,
>> +				 <PINMUX_GPIO87__FUNC_GBE_RXDV>,
>> +				 <PINMUX_GPIO86__FUNC_GBE_RXC>;
>> +			drive-strength = <MTK_DRIVE_8mA>;
>> +		};
>> +
>> +		pins-mdio {
>> +			pinmux = <PINMUX_GPIO89__FUNC_GBE_MDC>,
>> +				 <PINMUX_GPIO90__FUNC_GBE_MDIO>;
>> +			input-enable;
>> +		};
>> +
>> +		pins-phy-reset {
>> +			pinmux = <PINMUX_GPIO93__FUNC_GPIO93>;
>> +		};
>> +
>> +		pins-power {
>> +			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
>> +				 <PINMUX_GPIO92__FUNC_GPIO92>;
>> +			output-high;
>> +		};
>> +
>> +		pins-rxd {
>> +			pinmux = <PINMUX_GPIO81__FUNC_GBE_RXD3>,
>> +				 <PINMUX_GPIO82__FUNC_GBE_RXD2>,
>> +				 <PINMUX_GPIO83__FUNC_GBE_RXD1>,
>> +				 <PINMUX_GPIO84__FUNC_GBE_RXD0>;
>> +		};
>> +
>> +		pins-txd {
>> +			pinmux = <PINMUX_GPIO77__FUNC_GBE_TXD3>,
>> +				 <PINMUX_GPIO78__FUNC_GBE_TXD2>,
>> +				 <PINMUX_GPIO79__FUNC_GBE_TXD1>,
>> +				 <PINMUX_GPIO80__FUNC_GBE_TXD0>;
>> +			drive-strength = <MTK_DRIVE_8mA>;
>> +		};
>> +	};
>> +
>> +	eth_sleep_pins: eth-sleep-pins {
>> +		pins-cc {
>> +			pinmux = <PINMUX_GPIO85__FUNC_GPIO85>,
>> +				 <PINMUX_GPIO88__FUNC_GPIO88>,
>> +				 <PINMUX_GPIO87__FUNC_GPIO87>,
>> +				 <PINMUX_GPIO86__FUNC_GPIO86>;
>> +		};
>> +
>> +		pins-mdio {
>> +			pinmux = <PINMUX_GPIO89__FUNC_GPIO89>,
>> +				 <PINMUX_GPIO90__FUNC_GPIO90>;
>> +			input-disable;
>> +			bias-disable;
>> +		};
>> +
>> +		pins-phy-reset {
>> +			pinmux = <PINMUX_GPIO93__FUNC_GPIO93>;
>> +			input-disable;
>> +			bias-disable;
>> +		};
>> +
>> +		pins-power {
>> +			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
>> +				 <PINMUX_GPIO92__FUNC_GPIO92>;
>> +			input-disable;
>> +			bias-disable;
>> +		};
>> +
>> +		pins-rxd {
>> +			pinmux = <PINMUX_GPIO81__FUNC_GPIO81>,
>> +				 <PINMUX_GPIO82__FUNC_GPIO82>,
>> +				 <PINMUX_GPIO83__FUNC_GPIO83>,
>> +				 <PINMUX_GPIO84__FUNC_GPIO84>;
>> +		};
>> +
>> +		pins-txd {
>> +			pinmux = <PINMUX_GPIO77__FUNC_GPIO77>,
>> +				 <PINMUX_GPIO78__FUNC_GPIO78>,
>> +				 <PINMUX_GPIO79__FUNC_GPIO79>,
>> +				 <PINMUX_GPIO80__FUNC_GPIO80>;
>> +		};
>> +	};
>> +
>>   	gpio_keys_pins: gpio-keys-pins {
>>   		pins {
>>   			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;
> 
> Tested-by: Macpaul Lin <macpaul.lin@mediatek.com>
> 

I get the following error:
Error: arch/arm64/boot/dts/mediatek/mt8195.dtsi:582.26-27 syntax error



How did you test?

Regards,
Matthias
