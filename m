Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB3457007F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiGKL22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKL1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:27:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B5AAE5D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:05:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n18so6364252lfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=dPrZfAXq7F8ce8t3fuNDg51KlRMukh3iZYk9RgLqoNE=;
        b=Ss7HyQSh+ofbEmUv0VvjsNobh4eJuEu0heIwrqhODc6RsT3ooq+uTYDKAmfXJiLl1g
         lcpPVr6IKvLmIYxxIJxpBgYmaD9ce+ueRFIeW3xkkBS+Mw8BvqtSW6HB5yt7N/GCqR7N
         Dhu0CgbfeUwhJSwtVmNiQHibrjkqYGlOPKjWoKIvEnnoIb5n7KsSeYDAhcW7bRwHrQlV
         HwfLcVKbF5DRSrVXPLdx1xsIEC2c4zUVhBqH6pGqaCRMdpj/h0CDTFMhfpBeAtEjh45r
         2HKdKVbE08UkUyGZtuU8L3chtY+xQrdNQHmNmaPl4QrCTzroaZ+z3Isr/rm5lozyh+HR
         ks6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dPrZfAXq7F8ce8t3fuNDg51KlRMukh3iZYk9RgLqoNE=;
        b=PWsmOHp8H1TiDxogIMPhKMm+8ZZ5lqDKM+wyu+SgutxsKvzedB4Cmn2UqHWMDv/VfM
         Q4zZS2dFLE8Y2xy6yDDwuIO1Ytl7gCl2TblqHqMXbaTaA4gHM8wJWH74ft1IthLTOcFK
         RsxocjCqOM+5E6J3FEjSjmzZZasXjG54np2by6IlVX0uyLEjUt29M2J8PNmCW3f3jh+g
         eAaDa/n1MqoRCyUKJRqli971F3n3KKXv9Pnk024muwIHEzVEaJIZOEVmsNywa6/kmDmj
         W0fwUjAzrSmT6il4FecSb/aQVDLe0vx7iTB/80FqtGeHDbAccq/kINIEZ2MvEV38fmki
         Qg0g==
X-Gm-Message-State: AJIora9K54mgC5YzV25KkBC8dOQYoKQuoQ3JUTwO9L4MrPuzntdHtAN3
        RwUmPv+pk6+4n2ePB3tEDPX4nA==
X-Google-Smtp-Source: AGRyM1u/jw24PhqwPc6UTV/hyxk2KaW3EecjOe9Ez/DY3S2cBKdbASV5EDr17T6xbqPGPzK8st+IRw==
X-Received: by 2002:a05:6512:1310:b0:481:6154:c292 with SMTP id x16-20020a056512131000b004816154c292mr11134909lfu.95.1657537525579;
        Mon, 11 Jul 2022 04:05:25 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id w21-20020a05651c119500b00255500154fasm1681683ljo.52.2022.07.11.04.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:05:25 -0700 (PDT)
Message-ID: <4de38d90-0020-c2db-b283-319b4a0e2ce5@linaro.org>
Date:   Mon, 11 Jul 2022 13:05:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/6] clk: qcom: apss-ipq6018: add MODULE_ALIAS
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, bjorn.andersson@linaro.org,
        agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220711104719.40939-1-robimarko@gmail.com>
 <20220711104719.40939-4-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711104719.40939-4-robimarko@gmail.com>
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

On 11/07/2022 12:47, Robert Marko wrote:
> Add MODULE_ALIAS so that driver will be autoloaded if built as a module.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/clk/qcom/apss-ipq6018.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> index f2f502e2d5a4..963c69f2c0c2 100644
> --- a/drivers/clk/qcom/apss-ipq6018.c
> +++ b/drivers/clk/qcom/apss-ipq6018.c
> @@ -101,5 +101,6 @@ static struct platform_driver apss_ipq6018_driver = {
>  
>  module_platform_driver(apss_ipq6018_driver);
>  
> +MODULE_ALIAS("platform:qcom,apss-ipq6018-clk");

That's not correct alias (no commas) and usually alias is not needed at
all. If you need one, please explain why it is needed. Module
autoloading works fine without aliases...

Best regards,
Krzysztof
