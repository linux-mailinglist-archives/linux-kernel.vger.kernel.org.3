Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053DD581867
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiGZRb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbiGZRb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:31:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD001BE99
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:31:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p11so18841084lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=nUsqrIcncbnAblsl66lT/lEZJ2lw+9ku+eiTV2ZWI6Y=;
        b=OyRS/08wVlN551H9uCmoUeTFl2tMNki5reqZdw3CT81GT8LgTsXqk1jO57wdUodH2g
         xc0iJX8XCvFuVYwQ/TJofmliTWDifgjexn294tm1ofBY/7Dkr9wcE3a0RHERg68yW0BF
         9rS2N2dGVl2hPGLGPNDHr4BhG02/Gg1a0TpywMqZI2oScVjP9Q+tPkdGhZgbwHdPPlw+
         2mRzXFRQhiBmN/gldSjIrf6WnAU3VupQ4N9v0FxN/F02J9FkTy/8S8QqfDQFAnS3T9vT
         vybmAQ/bonklLF/sgF594c5gQRduNdZpShCNQ4bnixqwS575JB57AADT1wqextDJ1JFc
         qQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nUsqrIcncbnAblsl66lT/lEZJ2lw+9ku+eiTV2ZWI6Y=;
        b=RVeCsrmBqSk8ArXD0ycCKjt6igei+3ZcHuA166ApkaVEfIR1TBio+EvyIRfG/J0SyE
         S9jZzdSHd6w6gxh6iGSV+NZxD+ftbTn9LGtgFhqBcWaZrcigHihf5Bm8h6qBIsoFpLQL
         BHqZAYUqAb8Lh9tvIU9vN4E6RX01B8DjhFoOZoUJj47vBaDuay3/U+cSkMaIBHWLnf40
         +NJjGWLYc+JARtN9juQBG4tI7OHw/eZ4TXyAJ1HLJkyfAi9qTOn54oXgx70dy7KOp+aM
         fvebwrrnWAWSvepSDih5JhCSguTwG1oCbIC8g4zcorD4Qrqe4Ro09ltx68zKaJlT+ROq
         vlhw==
X-Gm-Message-State: AJIora/gvJeM/8UynbNO2HGyeNh2QG5AQacLbOn50hKrLev9hY1iXYbV
        PYe4kJ/yZ/YnQqGQbHoHQ5RJMQ==
X-Google-Smtp-Source: AGRyM1thhHPJv1gCsMqopzoDCU3kSSNaevw3WpkoAl9o10A2PSZBRyQoWCrT5Ve7WL8oKcVOHuWQbg==
X-Received: by 2002:a05:6512:1092:b0:48a:766e:7e20 with SMTP id j18-20020a056512109200b0048a766e7e20mr7071165lfg.646.1658856711127;
        Tue, 26 Jul 2022 10:31:51 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id t12-20020a19dc0c000000b0047f9cfa914csm3319933lfg.18.2022.07.26.10.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 10:31:50 -0700 (PDT)
Message-ID: <d83f7689-303f-cecd-882a-ed6e03a8db5b@linaro.org>
Date:   Tue, 26 Jul 2022 19:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] dt-bindings: soc: bcm: use absolute path to other
 schema
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Saenz Julienne <nsaenz@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220726115841.101249-1-krzysztof.kozlowski@linaro.org>
 <20220726115841.101249-2-krzysztof.kozlowski@linaro.org>
 <a70148d3-c87f-969a-b743-11c679d161d3@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a70148d3-c87f-969a-b743-11c679d161d3@gmail.com>
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

On 26/07/2022 17:59, Florian Fainelli wrote:
> On 7/26/22 04:58, Krzysztof Kozlowski wrote:
>> Absolute path to other DT schema is preferred over relative one.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Are you applying those patches or do you want the SoC maintainer to do that?

The best if  you (SoC maintainer) would pick them up. If you cannot or
it is too late for this, maybe arm-soc could grab them (already Cced).

Best regards,
Krzysztof
