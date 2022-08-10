Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E023658E973
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiHJJTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiHJJTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:19:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA5BAE23D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:19:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id q1-20020a05600c040100b003a52db97fffso669909wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=JUyNoU818egRObOa/IMHniG7D9eOIpIdC03VDFYcljo=;
        b=zPk2H2DcpAOIYrazdg5bocpCKj1TZ3T3x+hhVv9dnfP4Jx3oGOh9mHo9HsNC+03Nlq
         q1ovvctKiPUJ2e7+qAkpQIS730msh6rm5ux9rGj/XAWEIzBnCC3AZvzLJRDkcj7AY8jb
         jm96gfWZDelrWicO5yWtIn3mFno+QROX1N1iTUarMx18UQnYj/LHCrUGblCpHr0xxIY/
         pVPdYgCwUhHy4Jo5mpM5gvqVxAp9J9iOwlzoj8Jj8bbh/30gW3KRCh6rXScOIisb6EHp
         HG6/KKVxxLy07xtHVrsWwy66h2wpw0qkWBcfvb3QYaB3a5p+ayBeHcPzklZ6Shbu4csV
         fhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=JUyNoU818egRObOa/IMHniG7D9eOIpIdC03VDFYcljo=;
        b=GZ6juocJ70GOW9tZgCVI+Mhc7IBPcpICgKOweh35PkWrPet6BKW00HVNkF/Mj9RxxV
         9/BVh18hJ4Rd1tuEP9zjcGrXTvcyaIeLgOBH5r0aSKMW603Rc7seAVYIKc06KFWiywOE
         8HnSLe8lx3jIrG23pCvmvM56OMoyXtj64qOpJy6V6vLQ140YvZEcqm5sGBOwc73BvfMg
         BLrIMsp4ozt+IqlTewKdh6Be0tBqvvuXWbUy5UQCXJjuAjleRPFOontx6oyB+kPk+JWL
         nyV+wU/Zii4eSwqMXMe5W2xNWRarv/kQ4dzXin7KrelnD/iIWoux14Nz3zXVNji4UgtE
         LLpQ==
X-Gm-Message-State: ACgBeo1NBAlM6881wA6U8M8Ai3S8s+zejuVQ61gfRC0W/33qt6Ol/d/v
        GMXDcFliVyexljFe6OEy5a1Wwg==
X-Google-Smtp-Source: AA6agR7pdGtejWvZTPsUk04vSJYrK2KdnyxThzcDnl1Dr3dCImUqcIN6rBQFOift4AReX0i5XvuZww==
X-Received: by 2002:a1c:218b:0:b0:3a5:b5d4:9741 with SMTP id h133-20020a1c218b000000b003a5b5d49741mr908113wmh.28.1660123168886;
        Wed, 10 Aug 2022 02:19:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cb4c:4cd5:c6b6:8b12? ([2a01:e0a:982:cbb0:cb4c:4cd5:c6b6:8b12])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c274200b003a54f1d007csm1781685wmw.10.2022.08.10.02.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 02:19:28 -0700 (PDT)
Message-ID: <f5720289-6d12-24a5-82bf-f8538d348252@baylibre.com>
Date:   Wed, 10 Aug 2022 11:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] spi: meson-spicc: Use pinctrl to drive CLK line when
 idle
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Da Xue <da@libre.computer>
References: <20220809172017.215412-1-aouledameur@baylibre.com>
 <20220809172017.215412-3-aouledameur@baylibre.com>
 <1jsfm4xymu.fsf@starbuckisacylon.baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <1jsfm4xymu.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2022 10:52, Jerome Brunet wrote:
> 
> On Tue 09 Aug 2022 at 19:20, Amjad Ouled-Ameur <aouledameur@baylibre.com> wrote:
> 
>> Between SPI transactions, all SPI pins are in HiZ state. When using the SS
>> signal from the SPICC controller it's not an issue because when the
>> transaction resumes all pins come back to the right state at the same time
>> as SS.
>>
>> The problem is when we use CS as a GPIO. In fact, between the GPIO CS
>> state change and SPI pins state change from idle, you can have a missing or
>> spurious clock transition.
>>
>> Set a bias on the clock depending on the clock polarity requested before CS
>> goes active, by passing a special "idle-low" and "idle-high" pinctrl state
>> and setting the right state at a start of a message
>>
>> Reported-by: Da Xue <da@libre.computer>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 14 ++++++++
>>   drivers/spi/spi-meson-spicc.c              | 39 +++++++++++++++++++++-
> 
> These 2 changes should not be in the same patch.
> 
>>   2 files changed, 52 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
>> index c3ac531c4f84..04e9d0f1bde0 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> 
> Does the problem applies only the gxl ? not gxbb, g12, axg ?

Only on GXL, starting from AXG the pins mode output state can be kept between bursts.

> 
>> @@ -429,6 +429,20 @@ mux {
>>   			};
>>   		};
>>   
>> +		spi_idle_high_pins: spi-idle-high-pins {
>> +			mux {
>> +				groups = "spi_sclk";
>> +				bias-pull-up;
>> +			};
>> +		};
>> +
>> +		spi_idle_low_pins: spi-idle-low-pins {
>> +			mux {
>> +				groups = "spi_sclk";
>> +				bias-pull-down;
> 
> Would it be safer to properly drive the pin in push-pull mode ?
> Like using gpio pinumux mode and output-high/output-low pinconf ?

The pins mux must be kept in the SPI function, thus only a bias can be applied.

> 
>> +			};
>> +		};
>> +
>>   		spi_ss0_pins: spi-ss0 {
>>   			mux {
>>   				groups = "spi_ss0";
>> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
>> index 0bc7daa7afc8..d42171ee1d61 100644
>> --- a/drivers/spi/spi-meson-spicc.c
>> +++ b/drivers/spi/spi-meson-spicc.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/types.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/reset.h>
>> +#include <linux/pinctrl/consumer.h>
>>   
>>   /*
>>    * The Meson SPICC controller could support DMA based transfers, but is not
>> @@ -166,14 +167,31 @@ struct meson_spicc_device {
>>   	unsigned long			tx_remain;
>>   	unsigned long			rx_remain;
>>   	unsigned long			xfer_remain;
>> +	struct pinctrl			*pinctrl;
>> +	struct pinctrl_state		*pins_idle_high;
>> +	struct pinctrl_state		*pins_idle_low;
>>   };
>>   
>>   static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
>>   {
>>   	u32 conf;
>>   
>> -	if (!spicc->data->has_oen)
>> +	if (!spicc->data->has_oen) {
>> +		/* Try to get pinctrl states for idle high/low */
>> +		spicc->pins_idle_high = pinctrl_lookup_state(spicc->pinctrl,
>> +							     "idle-high");
>> +		if (IS_ERR(spicc->pins_idle_high)) {
>> +			dev_warn(&spicc->pdev->dev, "can't get idle-high pinctrl\n");
>> +			spicc->pins_idle_high = NULL;
>> +		}
>> +		spicc->pins_idle_low = pinctrl_lookup_state(spicc->pinctrl,
>> +							     "idle-low");
>> +		if (IS_ERR(spicc->pins_idle_low)) {
>> +			dev_warn(&spicc->pdev->dev, "can't get idle-low pinctrl\n");
>> +			spicc->pins_idle_low = NULL;
>> +		}
>>   		return;
>> +	}
>>   
>>   	conf = readl_relaxed(spicc->base + SPICC_ENH_CTL0) |
>>   		SPICC_ENH_MOSI_OEN | SPICC_ENH_CLK_OEN | SPICC_ENH_CS_OEN;
>> @@ -438,6 +456,16 @@ static int meson_spicc_prepare_message(struct spi_master *master,
>>   	else
>>   		conf &= ~SPICC_POL;
>>   
>> +	if (!spicc->data->has_oen) {
>> +		if (spi->mode & SPI_CPOL) {
>> +			if (spicc->pins_idle_high)
>> +				pinctrl_select_state(spicc->pinctrl, spicc->pins_idle_high);
>> +		} else {
>> +			if (spicc->pins_idle_low)
>> +				pinctrl_select_state(spicc->pinctrl, spicc->pins_idle_low);
>> +		}
>> +	}
>> +
>>   	if (spi->mode & SPI_CPHA)
>>   		conf |= SPICC_PHA;
>>   	else
>> @@ -482,6 +510,9 @@ static int meson_spicc_unprepare_transfer(struct spi_master *master)
>>   
>>   	device_reset_optional(&spicc->pdev->dev);
>>   
>> +	if (!spicc->data->has_oen)
>> +		pinctrl_select_default_state(&spicc->pdev->dev);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -733,6 +764,12 @@ static int meson_spicc_probe(struct platform_device *pdev)
>>   		goto out_core_clk;
>>   	}
>>   
>> +	spicc->pinctrl = devm_pinctrl_get(&pdev->dev);
>> +	if (IS_ERR(spicc->pinctrl)) {
>> +		ret = PTR_ERR(spicc->pinctrl);
>> +		goto out_clk;
>> +	}
>> +
>>   	device_reset_optional(&pdev->dev);
>>   
>>   	master->num_chipselect = 4;
> 

