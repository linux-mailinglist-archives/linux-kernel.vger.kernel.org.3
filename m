Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363D1524774
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbiELHyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351245AbiELHyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:54:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F106D488B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:54:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ch13so8463365ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xHJnnT01z1m5/aS07o3xcwpyjm9ng8j7p+h8cghz0mg=;
        b=A/SBKtUr3KfywtKWmieS20zAHGuZFnDIpJbiOl8aFAoL4TK0+DjjJ2fxYk1rGmB6ZK
         ub1rbkQft+iCWKy4ygN/kwmCKlgGIp5Ks4CVAzNf6gtgDd7Ih4oRrpeSlVnqPsvRLO0/
         Uy24pj8IOZ4lIMr1FQzTcBQJtndvDBSpYU1bvfmbNZxpFFC3/gGwIquh1qGTgEf8CQtj
         duWUm4a2OBbc8pPMC5ViPPghhWvDNAr1FkMoO5+yTnCjzbD/nRv2cKEGR8OBfm0Bf0kh
         M3op9yni3ODEvrTX14yYbJQjoyy7G0FFHNakiO2K9pEkTJjIIHuz3HzfMV0vgVRzpyQn
         wtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xHJnnT01z1m5/aS07o3xcwpyjm9ng8j7p+h8cghz0mg=;
        b=kPf86kVaXDH0DrZDaUt+6LK+MU4B6dUt4Ru+RlySD66XW5WbfadAH56voIvV6sdOCD
         jG7zJQiZ4ti1H5utm4Qm2kv8KtxifHShtCpBiKYRktIfA84Whuz1743F5t06ron7v9mH
         buvlKvZfMya3QR9IdVbtZZC+/OA6BY8wqvbMDxoDxpLqYs/1581FR5ccMK6kFqfm/8wz
         KjBG2h6SF7SF1xpSNcPtPDrA0BMjXfZ4BQRSod8cOImBV5M7ztMoW8ksq8Q6Pr9AKa3p
         1cqo8BT5hKXumcKNKUsZh2d77ISY/VrRqgtzmOAa447KRsaxStledrBRyHD3eBF3rKfX
         BgMg==
X-Gm-Message-State: AOAM531QlD2GdR0THTaq7jdNl4aP+YPxX25ac/sMD1cloQpdW4PM0G8v
        +qZIpcI0ygOip/0o2GuIjAX5Jg==
X-Google-Smtp-Source: ABdhPJxoSxUbbatzMqng37xCHJror9sIbQPy+9nCPXyfbJ+QGbiKsRtJNf0mmfRO7Uf5x69zPreAnw==
X-Received: by 2002:a17:907:3f26:b0:6f4:dc59:3cfe with SMTP id hq38-20020a1709073f2600b006f4dc593cfemr28828663ejc.528.1652342045468;
        Thu, 12 May 2022 00:54:05 -0700 (PDT)
Received: from [192.168.0.156] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j29-20020a508a9d000000b0042617ba63d1sm2205862edj.91.2022.05.12.00.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 00:54:05 -0700 (PDT)
Message-ID: <b5c586de-a3ae-0774-e0bf-e21852b65fa9@linaro.org>
Date:   Thu, 12 May 2022 09:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: microchip-otpc: document Microchip OTPC
Content-Language: en-US
To:     Claudiu.Beznea@microchip.com, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220510094457.4070764-1-claudiu.beznea@microchip.com>
 <20220510094457.4070764-2-claudiu.beznea@microchip.com>
 <75ce6291-77c7-c932-e8bb-a8bbae02431d@linaro.org>
 <c840c598-0413-5f40-0807-e3c314531f0a@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c840c598-0413-5f40-0807-e3c314531f0a@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 09:17, Claudiu.Beznea@microchip.com wrote:
>>
>>> +
>>> +#ifndef _DT_BINDINGS_NVMEM_MICROCHIP_OTPC_H
>>> +#define _DT_BINDINGS_NVMEM_MICROCHIP_OTPC_H
>>> +
>>> +/*
>>> + * Need to have it as a multiple of 4 as NVMEM memory is registered with
>>> + * stride = 4.
>>> + */
>>> +#define OTP_PKT(id)                  ((id) * 4)
>>
>> Do I get it correctly - the offset or register address is now part of a
>> binding? You write here "id", however you use it as part of "reg", so
>> it's confusing.
> 
> I agree that reg should describe the offset in OTP memory and its the
> length for a cell.
> 
> However this OTP memory is organized into packets (this is how hardware is
> designed), the 1st one being the boot configuration packet, the 2nd one
> being temperature calibration data. At the moment Microchip provides only
> these 2 packets in OTP memory. Boot configuration packet may vary in length
> thus it may change the offset the temperature calibration packet resides
> to. If this happen and we use offset based addressing in device trees then
> the solution will not work all the time.
> 
> OTP hardware is designed to work with packets. For a packet being in memory
> at offset 0x0E as follows:
> 
> offset  OTP Memory layout
> 
>          .           .
>          .    ...    .
>          .           .
> 0x0E     +-----------+	<--- packet X
>          | header  X |
> 0x12     +-----------+
>          | payload X |
> 0x16     |           |
>          |           |
> 0x1A     |           |
>          +-----------+
>          .           .
>          .    ...    .
>          .           .
> 
> requesting from software data at address 0x16 (through OTP control
> registers) will return the whole packet starting at offset 0x0E. Same
> things happens when requesting data at offset 0x0E, 0x12, 0x1A.
> 
> Thus, as underlying hardware returns to software chunks of 4 bytes though
> data registers the driver has been registered with stride = 4. The
> OTP_PKT() macro expects packet identifier (starting from 0), multiplies it
> by 4 to be able to pass the NVMEM subsystem accordingly, then the driver
> which manages a list of the available packets divides this value by 4 and
> gets the packet ID and the proper offset in memory for the requested packet ID.
> 
> The intention was to have the OTP_PKT() macro here to be used in device
> trees for simpler way of describing different cells in this OTP memory.
> Also, using OTP_PKT() abstraction looked to me closer to the reality
> (although the computed value is not reflecting this, it is only an
> abstraction to be able to pass the NVMEM subsystem).
> 
> Would you prefer to have raw values instead of using this macro?

Macro is a nice idea if it can be stable. I understood that length of
packets depends on hardware, so this part could be stable. But what
about number of packets, so the OTP_PKT_SAMA7G5_TEMP_CALIB_LEN below?
You wrote "Boot configuration packet may vary in length", so it could be
changed by Microchip?

Once this value is stored in the bindings, it is not supposed to change.

> 
> Adapting the subsystem for this kind of devices is also an option if
> Srinivas thinks like this.
> 
>>
>>> +
>>> +/*
>>> + * Temperature calibration packet length for SAMA7G5: 1 words header,
>>> + * 18 words payload.
>>> + */
>>> +#define OTP_PKT_SAMA7G5_TEMP_CALIB_LEN       (19 * 4)
>>
>> Length of some memory region also does not look like job for bindings.
> 
> I added it here to be able to have the same macro in DT and consumer
> drivers taking as example iio drivers that uses this approach to describe
> IIO channel identifiers. I can remove it and use necessary macros in the
> consumer drivers, if it's better this way.



Best regards,
Krzysztof
