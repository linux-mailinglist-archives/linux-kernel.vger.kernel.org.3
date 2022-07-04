Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021D75656CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiGDNQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbiGDNPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:15:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A285101E5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:15:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u14so11077910ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kb9oDc0/qCimA4eTDtjmyECpUyrLczMWLZ/Dkj3OyVc=;
        b=aU+kCNBmm66TnAzqhrBSBWanIBuGaDrQsJpHv+Gr2CwvZ48gJPYjIjVWB3I7oR1GYR
         5wSXklqdxsElf7FHlP0oGYDG7YlptuWkQGN28jVvq4305eIjFKgOVNUU3SD3bU0jz9l5
         VLn787/A4p5cbCKGgymBS1yQyNl4gHltumgVvailzrkMxF4IosZYPD6mUFFp1WDntjdI
         B1FaG4HPPPSqh8qpTZcEJ0p0zIHc/hRZjkZOgNuWEVfLS2ph9qECmMFc7ibP/8BpjSa5
         sYDJThp/Oj7esFR1ZF0CHXFNq99LxHmpRFXkAwrk5QWz4GyBTbq0YnfLklkZ90ib7fZW
         4fYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kb9oDc0/qCimA4eTDtjmyECpUyrLczMWLZ/Dkj3OyVc=;
        b=l9axu5scEgrPywtmB57sivIUc4GcUgrh3nqlxUJjr4XqJrYw3iBy2+nIDPRSHvjeA4
         iGoxSov91fMWvUX43Uwu5mxR+tO8SmSPBkXWtE0AiFTZ257hBttOmnJ1tVYalrH77ruo
         OqD/Rz3OScwQIVgqzBnssqOlWTGl1PxnSGzHEQA0VbOfafE+pxq1bqx/CZDiRDc5mgn0
         QB3FxMzRnCJF+63MNHN5UM5PIRPUI9L/G1hIwRsIr6LDIW6JXlzaIY2cZ4lYtxfM0xx5
         aQFPD74EN6AW15SsSmUiBagyzVa+dppRRaXKMkAhRAFuOHdxpgwVUG/WEp1FkHEfWB3A
         F18w==
X-Gm-Message-State: AJIora9Vq6mBlBg/xVcyK9/9elmU6JxLuLN3I0C/jG7rFYzA5VRHDypR
        MlS3pw1lir9GhziXJRInBryzfQ==
X-Google-Smtp-Source: AGRyM1vhvCDtp31WPAeoG/d9KyaVfLxSQb2bo4GHa+z32dTioh0JlZhOZsATAlrHkoDpHdyI7QElFQ==
X-Received: by 2002:a2e:990a:0:b0:25b:b0c8:14ad with SMTP id v10-20020a2e990a000000b0025bb0c814admr17863266lji.290.1656940551333;
        Mon, 04 Jul 2022 06:15:51 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id j7-20020a056512344700b004790b5a0b22sm5121054lfr.239.2022.07.04.06.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:15:50 -0700 (PDT)
Message-ID: <f005fe68-f413-6f45-ff2c-3b4a133c406b@linaro.org>
Date:   Mon, 4 Jul 2022 15:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] spi: atmel: convert spi_atmel to json-schema
Content-Language: en-US
To:     Claudiu.Beznea@microchip.com, Sergiu.Moga@microchip.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kavyasree.Kotagiri@microchip.com, UNGLinuxDriver@microchip.com,
        Tudor.Ambarus@microchip.com
References: <20220704083143.56150-1-sergiu.moga@microchip.com>
 <315d4fd3-4f50-5d3e-ef83-e4c8604814af@linaro.org>
 <7198ee29-95a4-db21-eb25-b5d9e07cd0fe@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7198ee29-95a4-db21-eb25-b5d9e07cd0fe@microchip.com>
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

On 04/07/2022 15:13, Claudiu.Beznea@microchip.com wrote:
> On 04.07.2022 15:52, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 04/07/2022 10:31, Sergiu Moga wrote:
>>> Convert SPI DT binding for Atmel/Microchip SoCs to YAML schema.
>>>
>>> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
>>> ---
>>>
>>> v1 -> v2:
>>> - change subject headline prefix from "dt-bindings: spi" to "spi: atmel"
>>
>> Should be:
>> spi: dt-bindings: atmel,spi: convert to json-schema
>> (or to DT schema)
>>
>>
>>> - change maintainer
>>> - kept the compatbile as items (instead of switching to enums) and at91rm9200
>>> as fallback for sam9x60, since the evolution of IP's is incremental.
>>> - removed unnecessay "cs-gpios" property and descriptions
>>> - added min/max for fifo-size property.
>>>
>>>
>>>  .../devicetree/bindings/spi/atmel,spi.yaml    | 77 +++++++++++++++++++
> 
> Regarding file name, shouldn't it be atmel,at91rm9200-spi.yaml or something
> similar?

Yes, that would be better.


Best regards,
Krzysztof
