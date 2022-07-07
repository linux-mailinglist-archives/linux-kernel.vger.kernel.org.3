Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51B9569AED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiGGG57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiGGG5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:57:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959B82DAA0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:57:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q8so8631978ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dLVc/y+TZpb35OvYPkixah5RQK18EK/PdsEEB601kEw=;
        b=jlV6O1ySJQF0jT1QiGhPY8aljt/fnYk+/UZbgEn2NAtdvShcbS1x0fEd6aA4no1Xhj
         Z200O0/x3gfVQMVlhofE+rbIwCnZDOcWdZQ0/Eu9yTsOwdmmQ3Wb4Uns8gv9ZRlD9EhX
         +hQzzmgq/hN7rFGS9anbUfunmuiM5o4xW0TfbcTXbOZ/TWZRdh26paGJX6m53Tlkgir4
         hG+M1mqWm3rVRgaeBicuHCTYQl15zdb5Ghw43SdkLZCiaWhpU5u+kvl8S+g6JVIr96qs
         EWQOx3gNy7AXc8Rwhva2/cjtxKh9dLDv2lDyQa5W62Pd9G5dA0M8iAiYqdGIioV0TxrB
         TO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dLVc/y+TZpb35OvYPkixah5RQK18EK/PdsEEB601kEw=;
        b=IvnWBRsWF2idrGDI3+etJZ0K8mLwrOh3Ufpo+Ak2iVDOz4XNP5N7X0Pzm/KlVOv9JA
         94Gp8w2RuY3TinLpNk56TzSNSOCir+2mHMpGA7KOqaDkh/3b6zXvgL/drN5C0cE5te2L
         pRxZSeR3CreKewC0Umrnf9VFM4P94jyQL/5zGenMJ8+eqFvTDUvMFfhnVhEbo2L8QqEk
         lxhycikaNJ/YXD9AzkVZA0X+RwASGYUhZlRWr2R4fKXZZTE+Sn+MxpTxtaZFYFFYm22M
         8HFnTiTAZcIjKgngtmIScCOCJc0qCBvVamStp909ImZnEpvLQ40MTzcGVlbZENxOSmPf
         mz2A==
X-Gm-Message-State: AJIora/y2Cnr4DLVaDt3nB/ZOlKY9wd3XHVA4hujzFZdmDCxKG1v6MSP
        wMb3pW/VMykYH38Qbeos6d22ZQ==
X-Google-Smtp-Source: AGRyM1v3FG4E8k8niB/k9KEIJZ79AwhdkauFvPD9fXIplu4BMioNH1xO5JqhmyjtVoVp5FbYuVZgDQ==
X-Received: by 2002:a2e:bc20:0:b0:25a:8b8c:8f32 with SMTP id b32-20020a2ebc20000000b0025a8b8c8f32mr25736535ljf.114.1657177070963;
        Wed, 06 Jul 2022 23:57:50 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id 19-20020ac25f53000000b004795cda636asm6674195lfz.98.2022.07.06.23.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 23:57:50 -0700 (PDT)
Message-ID: <e86663f1-032e-8839-b286-18d4b23c4879@linaro.org>
Date:   Thu, 7 Jul 2022 08:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Content-Language: en-US
To:     Kavyasree.Kotagiri@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        UNGLinuxDriver@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220706110619.71729-1-kavyasree.kotagiri@microchip.com>
 <20220706110619.71729-2-kavyasree.kotagiri@microchip.com>
 <fca15370-f977-687a-ff62-22ae43046b58@linaro.org>
 <PH0PR11MB487299A211568CC3614682BC92839@PH0PR11MB4872.namprd11.prod.outlook.com>
 <PH0PR11MB4872FE079CBF99E39F894E9D92839@PH0PR11MB4872.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR11MB4872FE079CBF99E39F894E9D92839@PH0PR11MB4872.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2022 08:54, Kavyasree.Kotagiri@microchip.com wrote:
> Could you please tell if child nodes can be added as below?
> -----------
> +patternProperties:
> +  "^serial@[0-9a-f]+$":
> +    description: See atmel-usart.txt for details of USART bindings.
> +    type: object
> +
> +  "^spi@[0-9a-f]+$":
> +    description: See ../spi/spi_atmel.txt for details of SPI bindings.
> +    type: object
> +
> +  "^i2c@[0-9a-f]+$":
> +    description: See ../i2c/i2c-at91.txt for details of I2C bindings.
> +    type: object

Yes, this is good.

Best regards,
Krzysztof
