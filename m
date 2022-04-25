Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FCB50DAD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiDYIEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiDYIEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:04:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4024816584
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:01:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i27so27990845ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vUPD6VhzeB7zQVubYjnWfebnf/uKU9eOqTOFGR1Ibsc=;
        b=lvCvkXXeSMP0tsuNy/214D6eqt9aD4AP4kyhlANYk6wvP/lfyVKxMOKuupaMEawFHW
         e7XYuzXCH6SetnjxuswZtomM+a4U9wp1eLRzOvM1OAiLy421XGtZFX4rL1lv2SUrfKZF
         jt1BZzSupgtwCYaaUCoK/RDDfoxh3mgcvI0Wf7eDKK1BFOkHogXmTCxFCAtrx1AxgFo4
         mWIIPYe2dC6JSucSpJd4VRVTlRQKGfSYrHMTMkGGaCm7m654XI9AMfJymeUr77hXZlOl
         9AGSaTOp3dUUsc8xlE2F35q+P4+qHEMXPMzxAHJhFWjBCef0mzEh0UeZSu45AvV23xSa
         3XiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vUPD6VhzeB7zQVubYjnWfebnf/uKU9eOqTOFGR1Ibsc=;
        b=4rilcZCPyoErIIl50Rkb2VjwfBm4xxtcghHxWh/F4w5yD22Q9oGFqGzwyTDYAzRTYn
         pbe165gAs3PnKot0ybrtpEBg4dsTRXC5uUQhi+RB2GQV/4yetEpH8VbUvcfjEGPyBOhc
         fjgIUshULv0g9wq0OQPPtUtFlCmp8b4wrcuNpw3s3PjV8S2UVysu3vCBRuY1D94psfu7
         ZDg931JMJLCEiX8RWRpqSCExyaC3EmG0hnXF2n4kZZYpNe6rkGYKDl2OlEmyZeJIi26Q
         /SaHqHLuNNm2cqAb/WhEGZ5t8DWtoRw5tx3OU5GncPHX26r7J75ww1tu0zteUQ4Zfbsy
         pJPA==
X-Gm-Message-State: AOAM530gknA0C3mbuZ/hroX0rcxWY3lKtN/AKZRNv88BNWlvDd1HPGzQ
        LG9/i4C4wQe/mJH1OJtvZEgAiQ==
X-Google-Smtp-Source: ABdhPJz/QT1MiqhW4PVFNiEaRMSLsnIjsG6Zz64ueE1ZdzHZK45v/bDUNqYA5+0xSFwuO/sBTSEO0w==
X-Received: by 2002:a17:907:1b05:b0:6f0:18d8:7be0 with SMTP id mp5-20020a1709071b0500b006f018d87be0mr15148939ejc.561.1650873685852;
        Mon, 25 Apr 2022 01:01:25 -0700 (PDT)
Received: from [192.168.0.240] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906521000b006d58773e992sm3351837ejm.188.2022.04.25.01.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:01:25 -0700 (PDT)
Message-ID: <fe4b42c9-f747-145a-5fce-9be6fc3e19af@linaro.org>
Date:   Mon, 25 Apr 2022 10:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/2] regulator: richtek,rt4801: parse GPIOs per
 regulator
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220425072455.27356-1-krzysztof.kozlowski@linaro.org>
 <20220425072455.27356-3-krzysztof.kozlowski@linaro.org>
 <20220425075812.GA29439@cyhuang-hp-elitebook-840-g3.rt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425075812.GA29439@cyhuang-hp-elitebook-840-g3.rt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 09:58, ChiYuan Huang wrote:
>>  
>> -	priv->enable_gpios = devm_gpiod_get_array_optional(&i2c->dev, "enable", GPIOD_OUT_HIGH);
>> -	if (IS_ERR(priv->enable_gpios)) {
>> -		dev_err(&i2c->dev, "Failed to get gpios\n");
>> -		return PTR_ERR(priv->enable_gpios);
>> +	for (i = 0; i < DSV_OUT_MAX; i++) {
>> +		priv->enable_gpios[i] = devm_gpiod_get_index_optional(&i2c->dev,
>> +								      "enable",
>> +								      i,
>> +								      GPIOD_OUT_HIGH);
>> +		if (IS_ERR(priv->enable_gpios[i])) {
>> +			dev_err(&i2c->dev, "Failed to get gpios\n");
>> +			return PTR_ERR(priv->enable_gpios[i]);
>> +		}
>>  	}
> You can directly removed all about 'enable-gpios' in probe phase.
> Just keep of_parse_cb to get per regulator 'enable' gpio. 

We cannot, it would break the ABI and make the change backwards
incompatible.


Best regards,
Krzysztof
