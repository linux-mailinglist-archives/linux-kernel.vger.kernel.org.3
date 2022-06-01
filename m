Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4153A131
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351002AbiFAJsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbiFAJsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:48:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1951A801;
        Wed,  1 Jun 2022 02:48:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s24so1534175wrb.10;
        Wed, 01 Jun 2022 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kTxZMWwr7LUEOg9gLWY8x2sIMUf/wxDHxQjaJvq6sZs=;
        b=HnN0rG4S5mQsx2SRWTyF3ZRhYMFJl7qu0PR+TBLcYCKeWGnMSHRdqJL1WFVSqoDzb1
         NLCtTfI8d5Mdf0WVuCMIbjUU7RUaNe9sCpVBiqW/qT7sZ/MIntlNb3fLB7ijxFd6uqAd
         zP0xyIYvFGW1znEw/iJteZLHfe1XRfEQVZnuN7O4dfTvuAJ1EOl241eU5imHEG4Jl0k6
         laDLO5j8OIY5K/QWB8lL2+Z/hhdWEDByZIX42vwfHOPTmdLd9RNH3FoTFhu4yNRhsP2L
         wdYO4Wh/9ChRS3P3alfXyEQ0ImhdsfM0hIheQFnPw9s+kYzKFQopPDyea2xMOQRhbFev
         yfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kTxZMWwr7LUEOg9gLWY8x2sIMUf/wxDHxQjaJvq6sZs=;
        b=hcrCQ/4G9EAs451wlzSpiwKn9hDEpgyrZTEiTyPnM0COyakzgP9i46LSTdrDO/1Jiz
         XPOZKNS1Eo3pp9f81WyG6bmvJNBQtsZD5wO55uoviPAE69tOxgBpIGNvqUNSxvskIPVq
         lCeSqgcFYCmh5vY17NtYG/R8wZxHT2i8KsZn0FxyUSCuav/Y/CMaTSYkp6TzHsDW+vKN
         TwslWFnn7nnuG8pMcQEXWXK+hUvpQOjT50d5YsYRq9btdTVnsKNeifpDDyxgtgGN58xz
         pG2dmuY/1iSs9xyfst8fhMgP+PzqUnf8vBS89bQBKiOVX+7ixdHtVZcPRJxUiUBMfsjk
         RFQQ==
X-Gm-Message-State: AOAM532tn3I0Je4B96YU3Tn3BgYoW43IQzThEf3F8ibX3RyjWPU8uZpD
        denj4+N3xYAGQSuRrRF/Oo0=
X-Google-Smtp-Source: ABdhPJzZQ7As7AYR1AUIoIrQDAE/gC+kQTWnltJD/9G4pF5VDKlt5ClNiaHaof5EJuvmaHkS+gF6iw==
X-Received: by 2002:a05:6000:1869:b0:211:7f25:89da with SMTP id d9-20020a056000186900b002117f2589damr688495wri.696.1654076913365;
        Wed, 01 Jun 2022 02:48:33 -0700 (PDT)
Received: from [192.168.1.101] ([160.177.66.137])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c290600b00397470a8226sm1382068wmd.15.2022.06.01.02.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:48:32 -0700 (PDT)
Message-ID: <654d35fb-c2e8-630f-be52-3369ea355d3c@gmail.com>
Date:   Wed, 1 Jun 2022 02:48:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/3] ARM64: dts: add dts files for bcmbca SoC bcm6858
Content-Language: en-US
To:     Anand Gore <anand.gore@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        samyon.furman@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220531184615.2836433-1-anand.gore@broadcom.com>
 <20220531114551.v2.1.I66ae43da75911b704f02a759f70d66bc7e542885@changeid>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220531114551.v2.1.I66ae43da75911b704f02a759f70d66bc7e542885@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2022 11:46 AM, Anand Gore wrote:
> Add dts for ARMv8 based broadband SoC BCM6858.
> bcm6858.dtsi is the SoC description dts header
> and bcm96858.dts is a simple dts file for Broadcom
> BCM96858 Reference board that only enables the UART port.
> 
> Signed-off-by: Anand Gore <anand.gore@broadcom.com>
> 
> ---
[snip]

> +	axi@81000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;

See my comment to William, I don't think this is quite what you want, 
you should use #address-cells and #size-cells = 1 here and adjust the 
reg nodes accordingly.
-- 
Florian
