Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5EA50D992
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiDYGnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiDYGn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:43:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D518F3AF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:40:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gh6so3611125ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZxDN99DsMdeWDUQb3YnJGd9yFr62BDXdahJpPEPfvZU=;
        b=mFyAA+uA0owTruZnR1mSzyOgNSO+63QnyMdGzm9KwA/iIKAKFxDr4gppYxQ9PqYtQx
         g2DM9fkerGDw7S2sihn0PEryupukVXjT4v5QOqFmkOBTZrcdmusqgbQqDAsWQSy+irjp
         yeKpqTuyY/29fDoK/ejva/mZphjMfhyosAwhYNs18MkeeuEVASP5y4M2KAS1a7Tedi/I
         uBAADAs8VfWkyD+QL34Vc8ZhcAzdiyE/cs7gGsOhVtsgfv6YttCvLy1031GPFLooJEp3
         5MayDj+ACG1U22Af4X77qISlldNiGf6wJBbgKmAs5kWnPHwl4qTdH+aGrXU1ThKxaNt+
         60Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZxDN99DsMdeWDUQb3YnJGd9yFr62BDXdahJpPEPfvZU=;
        b=GStR8gBj0xZeG0h3vKMqrm7mpmT1gvuDCZ086/qP5esyGvXuzdkMGKkAgGcRZ2oc+l
         kqSl/4saC5IfxvZLylopkob4XH54JVEBfq4/EBMh0sFP0+Z9LiQMgzGMeOgsxaEuTslF
         GmVNv+k7F5traS8zb9GFp7biKQW7oA+lUJZ16G/Mx9vQrbNny1dbxFm03VhopE12QMs4
         vddQhpER5Ku4jIAwTp0Ob652OYDcfhE0fnzLT4Mvccd8Ez854bWLQdEsAXsTL9zL+NUq
         ZIv3pmcfZYLYWLX8gl7hwcoEbVAFPajajKH8OqDo/LnplqWSoUoa5nK+MkyQMeE0oVbs
         wOHw==
X-Gm-Message-State: AOAM5309kecIO6cJAqF0wFZ44FQRRLtLv5uc3Dpua+hYNBZkFRATnbNx
        RlAK9AmoQPGO6+TjMvj+sMDE0g==
X-Google-Smtp-Source: ABdhPJyjwLqCqlXPZ19oxRSNgInaH3+Gi8+LCWYr5XunqklUtVVtyRsGR5flMRT7Gmx+HUn45+O0xQ==
X-Received: by 2002:a17:907:62a2:b0:6e0:e201:b94e with SMTP id nd34-20020a17090762a200b006e0e201b94emr15024324ejc.730.1650868820405;
        Sun, 24 Apr 2022 23:40:20 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z7-20020a17090665c700b006efb9a33ca5sm3285023ejn.164.2022.04.24.23.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 23:40:19 -0700 (PDT)
Message-ID: <b35968c4-bba4-59cc-f569-1537e82539c2@linaro.org>
Date:   Mon, 25 Apr 2022 08:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] regulator: richtek,rt4801: use existing ena_gpiod
 feature
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220423181419.19397-1-krzysztof.kozlowski@linaro.org>
 <20220423181419.19397-3-krzysztof.kozlowski@linaro.org>
 <20220425054943.GA3993@cyhuang-hp-elitebook-840-g3.rt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425054943.GA3993@cyhuang-hp-elitebook-840-g3.rt>
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

On 25/04/2022 07:49, ChiYuan Huang wrote:
>> +static int rt4801_of_parse_cb(struct device_node *np,
>> +			      const struct regulator_desc *desc,
>> +			      struct regulator_config *config)
>> +{
>> +	struct rt4801_priv *priv = config->driver_data;
>> +
>> +	if (priv->enable_gpios) {
>> +		dev_warn(priv->dev, "duplicated enable-gpios property\n");
>> +		return 0;
>> +	}
>> +	config->ena_gpiod = fwnode_gpiod_get_index(of_fwnode_handle(np),
>> +						   "enable-gpios",
> 'enable' only, gpiod API will automatically concat it to 'enable-gpios'.

Right.

>> +						   0,
>> +						   GPIOD_OUT_HIGH |
>> +						   GPIOD_FLAGS_BIT_NONEXCLUSIVE,
>> +						   "rt4801");

(...)

>>  static const struct regulator_ops rt4801_regulator_ops = {
>>  	.list_voltage = regulator_list_voltage_linear,
>>  	.set_voltage_sel = rt4801_set_voltage_sel,
>> @@ -122,6 +168,7 @@ static const struct regulator_desc rt4801_regulator_descs[] = {
>>  		.name = "DSVP",
>>  		.ops = &rt4801_regulator_ops,
>>  		.of_match = of_match_ptr("DSVP"),
>> +		.of_parse_cb = rt4801_of_parse_cb,
>>  		.type = REGULATOR_VOLTAGE,
>>  		.id = DSV_OUT_POS,
>>  		.min_uV = MIN_UV,
>> @@ -135,6 +182,7 @@ static const struct regulator_desc rt4801_regulator_descs[] = {
>>  		.name = "DSVN",
>>  		.ops = &rt4801_regulator_ops,
>>  		.of_match = of_match_ptr("DSVN"),
>> +		.of_parse_cb = rt4801_of_parse_cb,
>>  		.type = REGULATOR_VOLTAGE,
>>  		.id = DSV_OUT_NEG,
>>  		.min_uV = MIN_UV,
> 
> There's one problem.
> If 'ena_gpiod' is specified, it cannot be conexisted with ops
> 'enable/disable/is_enabled' by regulator framework.
> It will cause no one to recover the voltage back.
> You can check the original 'enable' ops.

You mean that regulator voltage is being reset after disabling it?

> 
> How about to only parse gpio in 'of_parse_cb' and put it all into the
> driver data, not to use regulator framework 'ena_gpiod'?

In such case that's the only option. Thanks for the review.


Best regards,
Krzysztof
