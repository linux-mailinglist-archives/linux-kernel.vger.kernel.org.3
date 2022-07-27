Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C9058338D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiG0T2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiG0T2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:28:03 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9E112ABF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:27:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m9so20825238ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QUpIPecUdiYY40MTmdpO1+SnHNouBaV+j/a+J43Hp88=;
        b=HJmoKwobwzpuXAlJlnYbvgLn1R7b/bo1cN0BPbL1hGSny3KJULLrKzaQRyH46eoID2
         LQHH0mci22V2NjkSMXyiSN5bZ267/VN1VQ2tNRX1EBeJRxwEAHMKRZvC0BHeGwcFmNMq
         C8DfX3KOOgID3HMi9RNuMgLf0nCyMi0TLoCQKcYzreTuA2KgfU5ZcmfDgMTssP9TUfdq
         L06MYIeQZybxaOk9j6qfaADIZC48FjKidiH6A/xj+DVfNvNMhFRvRVoh5jeSLHn6ERsM
         ZI8rG+D9pelC/JWnbSmzWYWMatIPIxVmW/FQMOOkapcCsINGQJo5z2njLOeMPdDoLdMr
         5Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QUpIPecUdiYY40MTmdpO1+SnHNouBaV+j/a+J43Hp88=;
        b=GfZqt2AxHMgXmIKWL+4mFyAxm4U91Os/mTyOWqHWBcj33fAEM8mX6C3b3iEEqqMz71
         hbsNKNYSl8xwfmWB6AUPa6Zj923ReUFTABlenrgnk58glEYPfcRzFDoEP7C+AXi78WNC
         XJYXPlExko/MWlhJVNTsd7jxC60o0nimMEFZz7Oqo1unG5yLY20TFbNl0vyGsSYY76TC
         bh3JlEk7QQc6OXzt0TKyHmoohD5NcRG9sB121+6P5Guby4yYC0sUzgtikEOZwhwbiPBV
         rNRp1U2ix4EZ5WXf+SEzqCS08UexZEMj9OL4yDWgHLx1aXBNBw3mribBG3I40T2lWRPO
         GnCw==
X-Gm-Message-State: AJIora9yyOs00cHB1yEw4yAGT8GHoHI3ud3c/2L8iupVX6I9R1Bgntd/
        PBtiRrwZaJ29WsVgLO7eoqScUw==
X-Google-Smtp-Source: AGRyM1t5hP789QT8LTu9OPUuFrIZ/+J2OPK6GM38PWdY4M1g6HiO9Z8NvD4IoqZFfQ6LfAvk+9RUgQ==
X-Received: by 2002:a05:651c:154a:b0:25e:886:23e5 with SMTP id y10-20020a05651c154a00b0025e088623e5mr5170933ljp.465.1658950075989;
        Wed, 27 Jul 2022 12:27:55 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048910301774sm3436876lfz.307.2022.07.27.12.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 12:27:55 -0700 (PDT)
Message-ID: <16035c69-f283-ea40-5db2-d99d0e932fc1@linaro.org>
Date:   Wed, 27 Jul 2022 21:27:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: fpga: microchip,mpf-spi-fpga-mgr: use
 spi-peripheral-props.yaml
Content-Language: en-US
To:     Conor.Dooley@microchip.com, i.bornyakov@metrotek.ru,
        mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220727164347.386398-1-krzysztof.kozlowski@linaro.org>
 <80eeee3d-ff1c-393f-f894-5f0f32cd4112@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <80eeee3d-ff1c-393f-f894-5f0f32cd4112@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2022 18:57, Conor.Dooley@microchip.com wrote:
> Hey Krzysztof,
> 
> On 27/07/2022 17:43, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Instead of listing directly properties typical for SPI peripherals,
>> reference the spi-peripheral-props.yaml schema.  This allows using all
>> properties typical for SPI-connected devices, even these which device
>> bindings author did not tried yet.
>>
>> Remove the spi-* properties which now come via spi-peripheral-props.yaml
>> schema, except for the cases when device schema adds some constraints
>> like maximum frequency.
>>
>> While changing additionalProperties->unevaluatedProperties, put it in
>> typical place, just before example DTS.
> 
> This is probably just me missing something about dt-schema norms,
> but how come you added the $ref just above the example rather than
> above the properties list?

AFAIU, the location is purely by convention so far. allOf with refs go
before properties, but with "if:then" they go after required. This is a
bit confusing and causes unneeded code move when someone adds "if:" to
such allOf. Additionally the spi-peripheral-props.yaml ref is actually
not that important, unlike other refs (e.g. panels referencing
panel-common.yaml, watchdog -> watchdog.yaml).

Therefore for consistency with all other SPI slave devices I put it at
the end, but if you find it inconsistent/messing up, I can move it
before properties.

Best regards,
Krzysztof
