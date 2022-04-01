Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506894EFBB3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352384AbiDAUiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352682AbiDAUh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:37:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B3E137019
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:36:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b24so4284730edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=teWkJ4CoTDO5mMTrqx6InWM0rnqqHmOdFQ5U6F0SH00=;
        b=sslPqovAkCG/x1GpP6Loog5grP3TlZXipIhu/hTWV0pzafGbuGVekkVaUL++Je5ikN
         tM/8QWAWlF6nrNclOfDQEk4QBCecTh50OFxY03V2DXM4AjQfkv+xGM3BkHQExUCxPXHF
         r7aOl5H3nDjIRWyc2yN7FOg73ugzr8pGIL2v09kt8ztmoRfRc9q0axgPi1MnwXFiBNfF
         A43nEClwt1GIJcr3lz9OYSlsEHnj4EWD50yV49YE29idZBMiGJp2XWDnu6xJ6HurOJ7q
         5ZK/SgK44qlFM2PhoRAqr5RQN/NuSAcDM6mYIUjOUsvGdr+KHacS/s7ezYJW/NjS08ux
         h4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=teWkJ4CoTDO5mMTrqx6InWM0rnqqHmOdFQ5U6F0SH00=;
        b=5usr1shnDyg14uE/cCNscwy/oZoZXif1KfGd711y+AkdoDsCJ+h01UH4qwO0vGkmyB
         JjzNQQnvmRxt0+L3qCEdeWoQJqSLReVeS/IxG8d48GXEO/tb4/fARpvpnwywKlyLnQ2+
         HPxNP3JpXrdg+shC2fFQIhGdwHl+gSpReskA4+DHal/9yIStdG0yh2iKnCvQZ+eFP0dV
         aUSzo1eewRg1aaanxc+dCFLbX9A95/0XbWNnqYI5tDtcEADXYUHxviRjqdyTvyRqwk8V
         MTDSzmg2E/rqGPrUupINIXQ5qpjMMHtt/YcEACU6dbY8ZEuVXRcxv+uSznP4Sde7kDfq
         vytQ==
X-Gm-Message-State: AOAM530bQKwzX7tWjt4VOJNf+eBkA5YqCqQ96sp1DRqiv0cDIEpDr1qf
        N//5qjUXyE2OzylXku6Gcs6N2gMVbMZxQDIo
X-Google-Smtp-Source: ABdhPJwveJo4luP3uof9lK/lq+qxgaM5BCB8OpF6wk47aGBGg69GVrOyISr7+SrsCRtn2V8VljTOxQ==
X-Received: by 2002:a05:6402:5146:b0:415:fd95:6afa with SMTP id n6-20020a056402514600b00415fd956afamr22919059edd.200.1648845365450;
        Fri, 01 Apr 2022 13:36:05 -0700 (PDT)
Received: from [192.168.0.170] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b004136c2c357csm1595857edt.70.2022.04.01.13.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 13:36:04 -0700 (PDT)
Message-ID: <1a26fd19-0f5e-d9f1-08e7-c5e3edd610a1@linaro.org>
Date:   Fri, 1 Apr 2022 22:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFT PATCH 0/2] regulator: richtek,rt4801: use existing ena_gpiod
 feature
Content-Language: en-US
To:     =?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220401154237.1061331-1-krzysztof.kozlowski@linaro.org>
 <1648831895.12596.6.camel@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648831895.12596.6.camel@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 18:51, cy_huang(黃啟原) wrote:
> 
> 於 五，2022-04-01 於 17:42 +0200，Krzysztof Kozlowski 提到：
>> Hi,
>>
>> Not tested.
>>
>> Follow up of discussion:
>> https://lore.kernel.org/all/2d124d53-1f36-5315-3877-af8f8ad5f824@linaro.org/#t
>>  <https://lore.kernel.org/all/2d124d53-1f36-5315-3877-af8f8ad5f824@linaro.org/#t
>> >
> 
> If RT4801 enable-gpio both go from high to low, the voltage reg will be
> reset, and I2C cannot be accessibele.
> This patch can be used to individually control enable for DSVP and DSVN,
> but the above i2c behavior is not considered.
> You can check rt4801_enable/rt4801_disable for the details.

Ah, so this is why this custom enable methods is there (pus bitmap etc).
Then the core ena_gpiod cannot be used, although still we want to move
on from two GPIOs in one enable-gpios property.

Best regards,
Krzysztof
