Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B810155C188
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiF0It4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiF0Ity (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:49:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3D4626A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:49:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eq6so11919116edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=FP/GaPcBvGjggyyQ1dCEEdUzjPdfMITFn6wRnSlyWGg=;
        b=yjbLzOF5j+urN6XfJzvyPM94OzRtbJ+8bFayxKEE6RW2z5v6WIFQgMaz/BKF/+PGiX
         MQWIwRZh9zhvFB4Bvy8mwM2Fiw8cEH0O8PxPodp9w3Z+rAcO8C+163DcL57nJO0+D6gF
         9NfyKJ34gwqAvt9G944h4LBPedW6fLjvGONSuT1JGZXt+5wY340l1OGCF/gk8xsaD2Y7
         dtavos2IiyqFEL7qHS9C4OzA1kvPT7Lo3ICQy8XHVBUylKFt5vcOBpBe62Ns+ts+5bCc
         YIf30U9DAP/DIn5vdQG0pRCorA4Ghv80NGfhsKEEKlKuNwqH09aPAvpw0KF/f2fUNZsa
         iuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=FP/GaPcBvGjggyyQ1dCEEdUzjPdfMITFn6wRnSlyWGg=;
        b=rNs5XqpfJRWtMFQv0TzNmAw3USamPK6Z0bR/pEAUxYnb+LAhwODr9DGBeGF8BYVFjD
         fGmVWvTfoPlMEY+VD5qJp/po2AyYonGrWg8kRAloGpJw4JqZSwHS7vlzGy7QuwuGD8El
         rAkJ6SkvtLIDanOMXNop9fE3ocfha/nqlEX38LHz1jgLemv8f+5Ouayl72UL9CPKatQ2
         6MnIS37fOA2uffjhw0umNHAxnko7dvXDrlLevc74SKOX89cOU/W1J+MSAN5pWhMXP7is
         92hy0HaQru3+slKQb4Jx/fosPNuYuX1GD83E6a1O2PAxAgJHhM//VDdEMijTxQTaeKdV
         jDYQ==
X-Gm-Message-State: AJIora8wTN3oWU4PZ4Y/gZ54ny8zMOTDnOeLYSCKkbnO1uxy8ENVXogq
        20+/CfcD3GDrWzXnNVcXlwzthA==
X-Google-Smtp-Source: AGRyM1vWeJVmejaOPOyVJ0lfNvFasd3Lk5cx3A4395nD73h1yXyEWVIEMiYkIg8YEEoeEq8raaeW5A==
X-Received: by 2002:aa7:c881:0:b0:435:5dc4:5832 with SMTP id p1-20020aa7c881000000b004355dc45832mr15297321eds.265.1656319791931;
        Mon, 27 Jun 2022 01:49:51 -0700 (PDT)
Received: from [192.168.0.247] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j12-20020a1709062a0c00b00722e1bca239sm4810194eje.204.2022.06.27.01.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 01:49:51 -0700 (PDT)
Message-ID: <5e0d5cca-c4a8-6651-0e67-47b5fc23c5c7@linaro.org>
Date:   Mon, 27 Jun 2022 10:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 36/40] ARM: dts: aspeed: align gpio-key node names with
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
 <20220616005333.18491-36-krzysztof.kozlowski@linaro.org>
Cc:     soc@kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220616005333.18491-36-krzysztof.kozlowski@linaro.org>
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

On 16/06/2022 02:53, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 30 ++++++------
>  .../boot/dts/aspeed-bmc-bytedance-g220a.dts   | 48 +++++++++----------
>  arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts  |  8 ++--
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts  | 12 ++---
>  .../boot/dts/aspeed-bmc-inspur-fp5280g2.dts   | 22 ++++-----
>  arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts   | 23 ++++-----
>  arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts   | 20 ++++----
>  arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts   |  2 +-
>  arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts |  2 +-
>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |  2 +-
>  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts    | 30 ++++++------
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   | 12 ++---
>  arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts   |  4 +-
>  .../boot/dts/aspeed-bmc-opp-witherspoon.dts   | 16 +++----
>  arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts    |  4 +-
>  15 files changed, 118 insertions(+), 117 deletions(-)
> 

Joel,

Any comments on the Aspeed patches? Do you intend to take them or shall
I handle them with the rest?

Best regards,
Krzysztof
