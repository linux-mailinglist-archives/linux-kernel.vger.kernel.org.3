Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B55553A24F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351979AbiFAKOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351713AbiFAKOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:14:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8848166AF3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:14:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fu3so1245052ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AlvALx0zMnGDVnEapBQ7KHJlm9HnZCeBAZQY2Z7YIfQ=;
        b=KpJ7iB62rkYxYYPytNHxK/MzKHmZsF5SvunBuTcECK0tn0gBcv1PatBmUDZ+SvIPy6
         2vqt4Zj3vabQUZh4U3OAndnCqt9yZyLZ0IKx3nkfjHESGq5PandWAV10KgQKMi2pMU2K
         ho27qU7HddcfX1+Ll7SPEaP5cq7FDEBr9ywhMsVOarhAz563nJibiKkzZGXMSf/76XI2
         7XJ+7WhqDvf4p9WEs5e88JGVmweks7E88ztDQGkWkgeXJYq1/x4N1OkEu7GCo0a4VD+U
         Fk7xDFGl6MW00LFfN2Ek7iVNwZMl4z/F5PPhmDrLWw+2CH0XVcZpjoaDOzSaGaz4v3H1
         wqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AlvALx0zMnGDVnEapBQ7KHJlm9HnZCeBAZQY2Z7YIfQ=;
        b=Z4/TDosC9Vt3bZ7vLpzlSzhlsD2PmorIUP1IM4Sj8Mk7SiAUGwLccd6ED60QfHbqMk
         ZqqsEOOQlN/QUo2jlEHGllwzaNBBj7jngb6rfwWVtOofHhMWN+BwD1TOv3fmAoGlumuT
         8w27O6X+0hfUcvBv9XuS0JE/0Kajgdx6pI92sciRAVz0LetZouRhirfaz2zKQGpzkd8p
         kpAMqMiW+u2lcjQTKU3GXPYH6cmWTTBWL4aVRziknTLED8zGGlyfxo8BeqU/N32d32KU
         rM4Iz3S5+B5y6o52eBvDPVh8NCVAyGWGA9vU89NauYP40BYyrED0N4ow5VYGjYRj5R6h
         GPBA==
X-Gm-Message-State: AOAM531LxjSl8aZkgbkf9omdM2ucKYfqpb7uftvB0wCI48I7xq7gtV33
        ULLFnYubpaEKMY1IStn4Mu+F8A==
X-Google-Smtp-Source: ABdhPJxmm2Ul6Qx7gD8GTPvF4loAnXC4xOsCGIvm33g8Xu31YADXTnZMvU21oiaV1IKR3O6RT4tgSA==
X-Received: by 2002:a17:907:7291:b0:6f9:a3b5:7ce4 with SMTP id dt17-20020a170907729100b006f9a3b57ce4mr58314733ejc.642.1654078475092;
        Wed, 01 Jun 2022 03:14:35 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k24-20020aa7c398000000b0042dcac2afc6sm710131edq.72.2022.06.01.03.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:14:34 -0700 (PDT)
Message-ID: <30a4ce8f-366c-9e58-1a48-fc434ae739c0@linaro.org>
Date:   Wed, 1 Jun 2022 12:14:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 14/17] dt-bindings: usb: mediatek,mtk-xhci: add MT8365 SoC
 bindings
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-15-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-15-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
