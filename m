Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F44B4E7560
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359411AbiCYOtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359412AbiCYOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:49:12 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52379D95FD;
        Fri, 25 Mar 2022 07:47:38 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id qa43so15807077ejc.12;
        Fri, 25 Mar 2022 07:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gz56oH53VZzDFL9nwMqJ3OglB/4woq4lsr+4YJOuZKU=;
        b=0SFkkXQReq6RLDkwh55DXRVZQpE0+ze7/q4GF7/nRRlxITzxAEgHM5U5zI9/1y7L72
         wDnspmyrBrnGZ7s1ZPU19xAZMwBY0wVUcASlkO3iF3DXaVaulVjj+JucViN/qjj0Dz17
         St4fyeHr7gyZKCIDeEPGO0P+i0H6Xe8zNWpEZ6wrVcx1N1WKxxQ9YJvgYCwFyz+2g3+D
         7Wiy8ukCdJ9GOyeFuphdXzha/Rg+txUUe+YWq2bbjwZ612eVQgRTupx9Qm/yNwUMxo7T
         cnNhfxFgjQ6nuJp6AVr1S+al63ZLc5vQ8UFC5T2fXyg1NhvF1iSfq3xVa8vPJM/reUlU
         nY+g==
X-Gm-Message-State: AOAM531wPCrdaQ03m5jXQ5tTTyfiT3aFBHqIQnsWita4gdmNia+AgP0n
        crTbXksn9vY+9T1sdhaOkpWP168XIwU=
X-Google-Smtp-Source: ABdhPJwXRVSwpOkobO6nEICiwK3wRz6+Vh1WARLyW5Q8v14KrABwoldZYqhmD3OcSJAoCMuypqgJBQ==
X-Received: by 2002:a17:907:6d9d:b0:6da:7d4c:287f with SMTP id sb29-20020a1709076d9d00b006da7d4c287fmr11459847ejc.741.1648219656785;
        Fri, 25 Mar 2022 07:47:36 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id i30-20020a1709067a5e00b006df6f0d3966sm2347967ejo.189.2022.03.25.07.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 07:47:36 -0700 (PDT)
Message-ID: <e4a15ceb-c013-96be-48d1-e65267400463@kernel.org>
Date:   Fri, 25 Mar 2022 15:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-3-git-send-email-u0084500@gmail.com>
 <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
 <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 15:10, ChiYuan Huang wrote:
> Krzysztof Kozlowski <krzk@kernel.org> 於 2022年3月25日 週五 下午8:17寫道：
>>
>> On 25/03/2022 02:06, cy_huang wrote:
>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>
>>> Add support for Richtek RT5759 high-performance DCDC converter.
>>>
>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>> ---
>>>  drivers/regulator/Kconfig            |  10 +
>>>  drivers/regulator/Makefile           |   1 +
>>>  drivers/regulator/rt5759-regulator.c | 372 +++++++++++++++++++++++++++++++++++
>>>  3 files changed, 383 insertions(+)
>>>  create mode 100644 drivers/regulator/rt5759-regulator.c
>>>
>>
>> (...)
>>
>>> +static int rt5759_init_device_property(struct rt5759_priv *priv)
>>> +{
>>> +     unsigned int val = 0;
>>> +     bool wdt_enable;
>>> +
>>> +     /*
>>> +      * Only RT5759A support external watchdog input
>>> +      */
>>> +     if (priv->chip_type != CHIP_TYPE_RT5759A)
>>> +             return 0;
>>> +
>>> +     wdt_enable = device_property_read_bool(priv->dev,
>>> +                                            "richtek,watchdog-enable");
>>> +     if (wdt_enable)
>>
>> No need for separate wdt_enable variable.
>>
> Ack in next.
>>> +             val = RT5759A_WDTEN_MASK;
>>> +
>>> +     return regmap_update_bits(priv->regmap, RT5759A_REG_WDTEN,
>>> +                               RT5759A_WDTEN_MASK, val);
>>> +}
>>> +
>>> +static int rt5759_manufacturer_check(struct rt5759_priv *priv)
>>> +{
>>> +     unsigned int vendor;
>>> +     int ret;
>>> +
>>> +     ret = regmap_read(priv->regmap, RT5759_REG_VENDORINFO, &vendor);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     if (vendor != RT5759_MANUFACTURER_ID) {
>>> +             dev_err(priv->dev, "vendor info not correct (%d)\n", vendor);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static bool rt5759_is_accessible_reg(struct device *dev, unsigned int reg)
>>> +{
>>> +     struct rt5759_priv *priv = dev_get_drvdata(dev);
>>> +
>>> +     if (reg <= RT5759_REG_DCDCSET)
>>> +             return true;
>>> +
>>> +     if (priv->chip_type == CHIP_TYPE_RT5759A && reg == RT5759A_REG_WDTEN)
>>> +             return true;
>>> +
>>> +     return false;
>>> +}
>>> +
>>> +static const struct regmap_config rt5759_regmap_config = {
>>> +     .reg_bits = 8,
>>> +     .val_bits = 8,
>>> +     .max_register = RT5759A_REG_WDTEN,
>>> +     .readable_reg = rt5759_is_accessible_reg,
>>> +     .writeable_reg = rt5759_is_accessible_reg,
>>> +};
>>> +
>>> +static int rt5759_probe(struct i2c_client *i2c)
>>> +{
>>> +     struct rt5759_priv *priv;
>>> +     int ret;
>>> +
>>> +     priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
>>> +     if (!priv)
>>> +             return -ENOMEM;
>>> +
>>> +     priv->dev = &i2c->dev;
>>> +     priv->chip_type = (unsigned long)of_device_get_match_data(&i2c->dev);
>>> +     i2c_set_clientdata(i2c, priv);
>>> +
>>> +     priv->regmap = devm_regmap_init_i2c(i2c, &rt5759_regmap_config);
>>> +     if (IS_ERR(priv->regmap)) {
>>> +             ret = PTR_ERR(priv->regmap);
>>> +             dev_err(&i2c->dev, "Failed to allocate regmap (%d)\n", ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     ret = rt5759_manufacturer_check(priv);
>>> +     if (ret) {
>>> +             dev_err(&i2c->dev, "Failed to check device (%d)\n", ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     ret = rt5759_init_device_property(priv);
>>> +     if (ret) {
>>> +             dev_err(&i2c->dev, "Failed to init device (%d)\n", ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     return rt5759_regulator_register(priv);
>>> +}
>>> +
>>> +static const struct of_device_id __maybe_unused rt5759_device_table[] = {
>>
>> I don't think this can be __maybe_unused. It is always referenced via
>> of_match_table, isn't it?
>>
> I think it can declared as '__maybe_unused'.
> If 'of_device_id' is unused, then in probe stage,
> 'of_device_get_match_data' will return NULL.

But your of_device_id cannot be unused. It is always referenced.

> priv->chip_type will get zero as the return value. And it will be
> treated as rt5759, not rt5759a.
> The difference between these two are only watchdog function supported or not.


Best regards,
Krzysztof
