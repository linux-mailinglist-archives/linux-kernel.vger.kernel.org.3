Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E454FF395
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiDMJgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiDMJgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:36:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ED754196
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:33:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bv19so2720255ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=kxSrHKVFH1QXMjvyuKXvr1FpxSh/pLZOJ8vsJhHQk/k=;
        b=unVJxO1zGnsrPr7gTwaCqLZWg19RzXyWMIaYcvM3e7Y54n6X2Pi5/inrJZLaFLhUST
         Ezh4hznSzTDpeft0jvk0vSr9uh9DVSL+PpSRpMOSbG9NXOlL6Owy7tpRf658vzcgXlRY
         HmWC/U7LmBUfzuc9u3cacjIIuN2Xvdlhjrs46Kq99KZQK5rAWZG8wJp5kq+ZRjsgIPkd
         QsJZs9rBf//kN9dPybPRM4y0Z89C5yA5JUf+M+tqvhEVZaM236KLDv1ZtuyQy4NGu5KC
         t6+Ot0D6OxzF/F7K8zWBKefFMfMzALc7rHMksMDs4TwGeKpOqvmuAwGNkYnfDdJd8Ngh
         U4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kxSrHKVFH1QXMjvyuKXvr1FpxSh/pLZOJ8vsJhHQk/k=;
        b=DsvQK2z4mwSS2XCFf0815N0qodFhnZnFiuRbwnmjYzyR0FZyfS8Urs1GZrqasdZeda
         2WIMA4bWhEc1QWY4zCBBs1c/U3SOAoWBKk9fe4j5auDrpLyQZqm6KNejitWFbtZZccBM
         UDVStxHLPylp4xe8jDbmco1QwyfS+vmY0J34nSxESRfJIrU+LrBgS+9tryHVUDNLJMCS
         sdFoD4nNle98C0l4YvgutJZHWWjNFL+XGKata51ZAZ1Trw2wOoWKEiJce1CHwFB5kb6j
         Y+4GSKukRIhuzN3dp+8hWQb+t0gzMKXHp5Th+AuA9G4s8yX9zCmKOpc7tJPTsgAcWd28
         v5Fg==
X-Gm-Message-State: AOAM5338i6gLohtPMG+UiNihKoABsqqx7xI+RdVZCqBHdSaHVnjMmBOJ
        GfAUhQuDgTiRqrZwPRgW/AZWxQ==
X-Google-Smtp-Source: ABdhPJyyet/tlElQG2QHa5ATj43qNsbiw4rEFAnMNGkgydczXJ96HxPZZeyw0UJ6lxWNVnpQ/ON4sw==
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id mp9-20020a1709071b0900b006d8faa84a06mr38060541ejc.701.1649842435354;
        Wed, 13 Apr 2022 02:33:55 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906128e00b006e4b67514a1sm14111965ejb.179.2022.04.13.02.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 02:33:54 -0700 (PDT)
Message-ID: <824c3322-ff79-d123-4769-4fb6527ad467@linaro.org>
Date:   Wed, 13 Apr 2022 11:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] ARM: dts: at91: align SPI NOR node name with dtschema
Content-Language: en-US
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        Lars Povlsen - M31675 <Lars.Povlsen@microchip.com>,
        Steen Hegelund - M31857 <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver <UNGLinuxDriver@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220407143223.295344-1-krzysztof.kozlowski@linaro.org>
 <8eb6621b-78ca-e5f9-def9-47809dab9bb4@microchip.com>
 <1d67baa4-48d1-67dd-7d9e-60a8ecbea3f4@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1d67baa4-48d1-67dd-7d9e-60a8ecbea3f4@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 11:21, Nicolas Ferre wrote:
> On 12/04/2022 at 12:32, Tudor Ambarus - M18064 wrote:
>> On 4/7/22 17:32, Krzysztof Kozlowski wrote:
>>> The node names should be generic and SPI NOR dtschema expects "flash".
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> I think that without this patch, errors are generated while checking DT, 
> so I would put this patch in my "fixes" branch for 5.18: tell me if you 
> disagree.

These are schema warnings, so except our checking tools, no real
user-visible issue. Fixes are ok, though.


Best regards,
Krzysztof
