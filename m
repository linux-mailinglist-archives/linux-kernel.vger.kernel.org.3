Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D415816E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbiGZP7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiGZP65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:58:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAD92F649;
        Tue, 26 Jul 2022 08:58:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o14-20020a17090a4b4e00b001f2f2b61be5so2186918pjl.4;
        Tue, 26 Jul 2022 08:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=vceTr9PbHgS7inYnpxj9pAebnTFEc9gOhZMQ08CgBlU=;
        b=QOwMzncj8BYBPgQW3UQwzOEZKrMXb/Ew5zDbZXaxXSuu2i/4Pn3iqO58tA0J2ffDYC
         hjY5u6ENlKNfjZeDzNZXJhL2DXznhHB4aLsjiX+MD3TlkrQAtSGl2cQi/gbfSCBWJlTe
         SjvgmrdF11fkZyStx10amU6gUKVaE4kgG7yTZSFbrb+2kmYSz6k0TokSb1IOj23F61dQ
         tFSWMxaVR4Q9f/tSmFbIW8VySxoIRnSdE3OD0JfJ2jNz5jccimkAkaOP4R0wximIZzjO
         gHEp3fMWcLJuHORo2ZVygwfixILSaEvcgx9sf7aXZ0Xb7OTsojUCMxxaUzgzTd1duqQj
         J7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vceTr9PbHgS7inYnpxj9pAebnTFEc9gOhZMQ08CgBlU=;
        b=vhmCjtkbBPYZVeTpxwwWF8JuOPPIUyY4d+232pJpPxAEn+sc2a3/WzWra9PTtBIhNj
         R4Kl/qaMLU7yJVss8vDg2lHohwM8UXRLCH0QggEPRKEv59xJc/5fjmv0M81VZjoNVD8Q
         sy6mMCTaWqZieuAO6XxoYjWiaIysvMVVrlnbUktX56OuGBptcOvqG4lDhzZftkeiDdPa
         U388U5G8eOstj8qz1ksbMZU+kIH8A9LvbElZPOvbGlQnUc+zPCdslDwiE0L/FoIWAclL
         BGvSP9IhqngObqstJnoTA4pvY2NANSoYFJlN2fEStS3GTC5SICuTjXLJPRAqCK/RGNmu
         kU3A==
X-Gm-Message-State: AJIora8Bs2/YRTuHxZ8O1X3tTRY92Jv96Fca7RKXcKSehhpIsrJ4VM2z
        gQvKw7AagFi55AW3Dvud0/c=
X-Google-Smtp-Source: AGRyM1vq/iJIGqBfIpH7h2igFX/YIJ3gqQDe3IIPX87H2wR84iDbN004uwu9hRfn13qOFsg0Kov5XQ==
X-Received: by 2002:a17:902:e5c7:b0:16d:82dd:8c3d with SMTP id u7-20020a170902e5c700b0016d82dd8c3dmr7989689plf.62.1658851136039;
        Tue, 26 Jul 2022 08:58:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w1-20020a17090a028100b001f216a9d021sm13343952pja.40.2022.07.26.08.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 08:58:55 -0700 (PDT)
Message-ID: <d46287c3-42b0-8138-9a4d-0428133cb9df@gmail.com>
Date:   Tue, 26 Jul 2022 08:58:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] dt-bindings: soc: bcm: drop quotes when not needed
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220726115841.101249-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 04:58, Krzysztof Kozlowski wrote:
> Id and schema fields do not need quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
