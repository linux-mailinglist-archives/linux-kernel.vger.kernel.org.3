Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A5A5AD638
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiIEPVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbiIEPVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:21:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC19543D9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:20:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z20so9587543ljq.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wUh3Al7PwmMjM0VU9KK3G3HzxyA6u+B+m2lqTPbNxqc=;
        b=Ds5LlGhy7ALtM48hcbmng41zkEBD3OkJnpDGID8a9rtqWtS7WTHfqAOJL7QHb3KJd7
         p3ctkJRbHTMQ6P+aVPRp1GZ8zAXyxEbN1f9uKGkPxIdNsSKlf0RfTSvBj09HKDlDPY8L
         WpBdiRCCXtimHS0cKWwf2TWx0r693TasdGj0L5CCVXcd2yRk2v8Z5Wne3Tg6St2ozYik
         o8v0AQs4ZOHZP2CNNO5Ige9N0LV5KS9pRpGKqh/i7jE5yeZBmmhwSt/xbFRxYe4WRdEF
         VMXMLya0Zckcm++ZgYnIqb0t5593FXlU/v1Gbi5aU5DE/L224UazGF4gVUpxMBpzoWly
         q6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wUh3Al7PwmMjM0VU9KK3G3HzxyA6u+B+m2lqTPbNxqc=;
        b=VovcGUQd8/iLjLAG1raK7eXQqcufmV8FFXhYk8vuDVGPnx+5HgbyJHH9OfO1aJvKQ9
         qxqRnmsd20W8roplbv/bvBZC/n5uZ+zP7XRnQ1LD+KZ+6aw7ODI+GEn6gCpkBg7hCPeB
         2pqB902CsdOOi/IYgTLiMLeadCGUipVpL0JzcMIC9FENngtarpRvn9Sz4aunxRiCjWYo
         uAJ/FMaNtZJAiopHIHCEgINPGP9KrQh51N9vHu/ADgFbNW0MNwH4htkfSX2GrGtpXuRT
         f/yvdhIH5/fIm6eegLnmq5MffxzjCvvi7aLiRF899JDcfNF0rYWgIafmdFnChnsHBVOV
         wUcQ==
X-Gm-Message-State: ACgBeo3x2cLFk2GF65k0Wb7Q+jdTsd9EB8rqGhDuiv8JCCuq8FqV6b25
        n/mto4DX6C57hCg9MW4msw8weQ==
X-Google-Smtp-Source: AA6agR4HQzE5xeJaiVvQxrn4aWLnqzzhOmMJHC+Goy22vEQaZe0SuJub2muSd+j+2VMLBSzEs1stSg==
X-Received: by 2002:a05:651c:10ba:b0:266:ee76:26a9 with SMTP id k26-20020a05651c10ba00b00266ee7626a9mr8831203ljn.382.1662391249222;
        Mon, 05 Sep 2022 08:20:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a056512210300b004946aef1814sm522090lfr.137.2022.09.05.08.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 08:20:48 -0700 (PDT)
Message-ID: <3ad3fb30-d56f-78be-610d-a02c9609ba42@linaro.org>
Date:   Mon, 5 Sep 2022 17:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 2/2] rtc: maxim: Add Maxim max31329 real time clock.
Content-Language: en-US
To:     Jagath Jog J <jagathjog1996@gmail.com>,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220904044708.7062-1-jagathjog1996@gmail.com>
 <20220904044708.7062-3-jagathjog1996@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220904044708.7062-3-jagathjog1996@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2022 06:47, Jagath Jog J wrote:
> Add real time clock support for Maxim max31329 real time clock.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>

Thank you for your patch. There is something to discuss/improve.

> +	max31329->rtc->ops = &max31329_rtc_ops;
> +	max31329->irq = client->irq;
> +	max31329->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	max31329->rtc->range_max = RTC_TIMESTAMP_END_2199;
> +	max31329->dev = &client->dev;
> +
> +	if (max31329->irq) {
> +		ret = devm_request_threaded_irq(&client->dev, max31329->irq,
> +						NULL, max31329_irq_handler,
> +						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +						"max31329", &client->dev);
> +		if (ret) {
> +			dev_err(&client->dev, "unable to request IRQ\n");
> +			max31329->irq = 0;
> +			return ret;
> +		}
> +
> +		ret = regmap_write(max31329->regmap, MAX31329_RTC_CONFIG2_REG,
> +				   MAX31329_RTC_CONFIG2_ENCLKO);
> +		if (ret) {
> +			dev_err(&client->dev, "unable to configure INT pin");
> +			max31329->irq = 0;
> +			return ret;
> +		}
> +
> +		device_set_wakeup_capable(&client->dev, true);

Probably you should rather respect wakeup-source DT property.

> +		set_bit(RTC_FEATURE_ALARM, max31329->rtc->features);
> +	}
> +
> +	ret = devm_rtc_register_device(max31329->rtc);
> +	if (ret)
> +		return ret;
> +
> +	max31329_trickle_config(&client->dev);
> +
> +	nvmem_cfg.priv = max31329->regmap;
> +	devm_rtc_nvmem_register(max31329->rtc, &nvmem_cfg);
> +
> +#ifdef CONFIG_COMMON_CLK
> +	max31329_clkout_register_clk(max31329, client);
> +#endif
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id max31329_of_match[] = {
> +	{ .compatible = "maxim,max31329", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max31329_of_match);
> +
> +static struct i2c_driver max31329_driver = {
> +	.driver = {
> +		.name = "rtc-max31329",
> +		.of_match_table = of_match_ptr(max31329_of_match),

of_match_ptr without maybe_unused on the table should cause compile test
warnings. You need both or none.


Best regards,
Krzysztof
