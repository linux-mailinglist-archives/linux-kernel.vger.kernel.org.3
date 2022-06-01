Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6042E539F74
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350739AbiFAI2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349252AbiFAI2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:28:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68954B432
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:28:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n10so2198082ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wFBenkxcV8H3DIKMgJI5qRF4midP3listcvGBUVIQNU=;
        b=I15Clzvecl8YhknTG4YB7hRjJ2Vkz9e0RfPx2yKyQqUqbPMGqAYAlzufSv7/mz8kXG
         nJ1GhVTmFlbYkJ8kl0mzo+ybXVif+AwBrW4T2ZkXUlF8JEfCQltMiBKpDpsHQP+2FUmC
         j3vCn22DYGs1TbmMpTQs7qud9eRtUOIhH5MM2D6BlM21khsyL0j7iXm2Muz2+oMsNPAY
         td4VZUrLloSGevkV2X80H6msH4gty1BRrFXAdBV36xciyP5m5FEe++928nvmqwf5Xrbl
         Vv0KX57TKN4wKgGkcRWsyLO8ay/lAfD3Z4Vc2fMHemzu1v4GVqUbQT5euNShjxLcfTZB
         OaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wFBenkxcV8H3DIKMgJI5qRF4midP3listcvGBUVIQNU=;
        b=p16a+htAjpHJ4Kc7zYP71eZPOgiM9YL8vG+noahfmRiqBSjyPJMPhdWIJzvwmStuVy
         /CQAdFMU1PDgtdMvwzK5eKrWIeCYstkLUzNfreYJ6SEKijCGcq8WYId8qogBvAGkJLuz
         XxfQNLW1U0LOOInYIj3If5eY03tKtt9ZxzRo0ITXV2PJ83Ldi2C5EVD8D8jFJzWDGSyT
         0IHNt0vngS7vGMjC3rh2WY1yavosLPbpoIJe4Mf7PGP71H4US1jmlkVYsKjeXzCofaa2
         6kQ2HShMvHKZ5ZuOy0TX/7KhpR9bp22FQ0oamtmJSlkuv15PZBDGvWIeKioE2+9WnqU+
         YF/w==
X-Gm-Message-State: AOAM5309WXZ+KCNVxJqXYsxt4a1jNjy9lyBzwkA44HUGF2kOCg9F7EP5
        P9lkOZFsvywSUU84+6OnoduMTg==
X-Google-Smtp-Source: ABdhPJwsvlE0YrfNB1fZakqRmXA83lPY4udQbeayRO2WNTbdfJWZVT/6XrmNTrGsYa6zimx93kkKag==
X-Received: by 2002:a17:907:7282:b0:6fa:9365:f922 with SMTP id dt2-20020a170907728200b006fa9365f922mr56059560ejc.262.1654072128282;
        Wed, 01 Jun 2022 01:28:48 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w2-20020a056402268200b0042ddd08d5f8sm627792edd.2.2022.06.01.01.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 01:28:47 -0700 (PDT)
Message-ID: <b6b84d29-fd4c-a7e7-6a8f-db86fc3bdb29@linaro.org>
Date:   Wed, 1 Jun 2022 10:28:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] dt-bindings: vendor-prefixes: document jabil vendors
 for Aspeed BMC boards
Content-Language: en-US
To:     David Wang <David_Wang6097@jabil.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     edward_chen@jabil.com, ben_pai@jabil.com
References: <20220601080856.1548851-1-David_Wang6097@jabil.com>
 <20220601080856.1548851-3-David_Wang6097@jabil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601080856.1548851-3-David_Wang6097@jabil.com>
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

On 01/06/2022 10:08, David Wang wrote:
> Depends on Krzysztof Kozlowski's vendor prefix patch
> 
> Added Jabil vendor prefix for Aspeed SoC based BMC board manufacturers.
> 
> ---
> 
> v2
> 
> - Change the order of items

This is a v5. Please version your patchset properly.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

We have extensive guide how to send patches, so be sure you read all of
them before posting:

https://elixir.bootlin.com/linux/v5.18.1/source/Documentation/process/submitting-patches.rst
https://elixir.bootlin.com/linux/v5.18.1/source/Documentation/process/development-process.rst
https://elixir.bootlin.com/linux/v5.18.1/source/Documentation/process/5.Posting.rst

Best regards,
Krzysztof
