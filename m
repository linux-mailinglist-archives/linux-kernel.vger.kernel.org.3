Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACFF525C88
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377880AbiEMHtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377869AbiEMHtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:49:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA2F134E22
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:49:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v12so10243876wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T7SkTWtVcaUJFA1inMQxmGveqj+WUmVd9hfsAIt4rws=;
        b=vXVP6SybAcGRcWHaJGwl1QW04uMH1U/m0KcFa33zCRPfo0VGsYZqM0Ah7f8NawjAnW
         HBlAocyjLH8ZDlJNKr1PBhbI82/pvNmjdhTZrkFJTgxNl25KwHiu0wW2x6DmEk0D/6JN
         k0cfQ9PEfmlbCYsn1U5M0lkyGhKhhg1j7c8Cu1ndo89yEDJFKIJdelcpMnORf+NhOlFr
         hHV5z2lE3v5FSyBWeiL4tn7/F0G/bBrulnBjgA2NPoOnkM0Pge7r5nxlMg31RmhSXBfD
         w/5h57v8YfkdI13YntDUaHUIiEPgtAaJLZHxgVIAVg/vq95hqLIQ+XCtFZGelYa5RWDX
         6QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T7SkTWtVcaUJFA1inMQxmGveqj+WUmVd9hfsAIt4rws=;
        b=n+IxKqqvqkMS9bAZUoP00dTwAJWGHlyB2wW+T/qqsPWaR5xvjaPe81JmystwN+NMXQ
         5Wa/uZPqD2H+P0cKT2KByblyc+dw3Vb0oYRFmI0//ITrYtlneUb/ou157IZWXqhwsOJr
         gir3nan1YQSycqAfMNw+drWJybJ+Fk6TJ6bzEaycP0hLxrUS9qn+4IZ3xW6q6uYHAOCN
         jEcGeStiwqQYwxaTxhJStaNzLC58SIIXC5QHT4Xy8JCA/lRANXu4fZV/5Tc55W1wPzUc
         sbIRKwABS2ywindnVNEWeJJ+69IEwUmEwIGxGlHzgYKrD5FFfHxOIbBdghw+kXOccMXA
         MUHg==
X-Gm-Message-State: AOAM530Swp2TdxPRetPprDfucUB5dR05267iOdPoBbxPRib0D9dU6aRd
        tHS3f8Fhr4Azw/dnwPDyOfMefRTL4CMiKXNw
X-Google-Smtp-Source: ABdhPJzEyrDYVt4SxO7Q7S2buSlfZjJ64PyX80Z/Ig4fSi0Sw/E1SgosR6/O2NnLKFwnj9lR2J/p1w==
X-Received: by 2002:a05:6000:716:b0:20c:4cda:b38c with SMTP id bs22-20020a056000071600b0020c4cdab38cmr2813646wrb.226.1652428162609;
        Fri, 13 May 2022 00:49:22 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d3-20020a1c7303000000b003942a244ee6sm1601972wmb.43.2022.05.13.00.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 00:49:21 -0700 (PDT)
Message-ID: <04a95089-cd39-2628-f333-0da24e55a967@linaro.org>
Date:   Fri, 13 May 2022 09:49:20 +0200
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
 <b5c586de-a3ae-0774-e0bf-e21852b65fa9@linaro.org>
 <59b47f0b-6201-3814-e17f-1435ce5c2dad@microchip.com>
 <6ce3c0b1-3f6a-24f6-bcf2-4d4125a97604@linaro.org>
 <706eb7b4-07ce-ffd2-3366-5656ddba21d6@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <706eb7b4-07ce-ffd2-3366-5656ddba21d6@microchip.com>
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

On 12/05/2022 18:04, Claudiu.Beznea@microchip.com wrote:
> On 12.05.2022 18:35, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 12/05/2022 17:31, Claudiu.Beznea@microchip.com wrote:
>>
>>>>
>>>> Macro is a nice idea if it can be stable. I understood that length of
>>>> packets depends on hardware, so this part could be stable. But what
>>>> about number of packets, so the OTP_PKT_SAMA7G5_TEMP_CALIB_LEN below?
>>>
>>> The OTP_PKT_SAMA7G5_TEMP_CALIB_LEN here is the length of thermal
>>> calibration packet. This length is fixed and will not be changed.
>>>
>>> After these 2 packets (provided by Microchip) user may further flash any
>>> number of packets and use them as they wish.
>>>
>>> Driver is in charge of scanning the NVMEM for the available packets and
>>> prepare a list with their IDs and their starting offsets in NVMEM memory
>>> such that when it receives a read request it will be able to decode the
>>> packet offset based on packet identifier.
>>>
>>> In case different number of packets are available in NVMEM for different
>>> kind of setups (boards) these could also be referenced in board specific DT
>>> using OTP_PKT() macro and with proper length (which will depend on what
>>> user flashed).
>>>
>>>> You wrote "Boot configuration packet may vary in length", so it could be
>>>> changed by Microchip?
>>>
>>> Yes, between chip revisions its length could be changed.
>>
>> Chip revisions like different board compatibles thus different
>> bindings/macro values?
> 
> Not necessarily. It may happen that only ROM code to be updated (1st stage
> bootloader) end everything else on Linux side to be able to run as is. Or
> to just fix some bugs in different IPs. Things that will not necessarily
> need adding new compatibles for the new chip. And it may happen that new
> chip revisions to be populated on previous board revisions.
> 
>> Chip revisions like different board compatibles thus different
>> *macro* values?
> 
> If you're referring to the OTP_PKT_SAMA7G5_TEMP_CALIB_LEN macro, this is
> established that will remain fixed b/w revisions. This is the length of the
> 2nd packet in NVMEM (that is of interest for thermal management).
> 
> Only the length of the 1st packet may change. And addressing the NVMEM with
> packet id based index should take care of temperature calibration NVMEM DT
> binding to work all the time.
> 
>> If not, then maybe better skip the length out of
>> bindings and just provide the first macro.
> 
> As far as I know the length is part of the way the NVMEM cells are
> described in DT: it needs the offset in memory (for the data to be
> retrieved) and its length.

In DT yes, but now you put the length in the bindings. It means DTS must
have exactly that value and cannot use anything more. It's the same as
hard-coding unit addresses in the bindings.


Best regards,
Krzysztof
