Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533D84F7EB5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiDGMIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbiDGMH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:07:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D30C4E13
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:05:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n6so10294192ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bwsyQ5Vu4W5RWwfy6VtuRb8dpLJkggv+g3kZE12CFcQ=;
        b=Tgo1TI51TajsJx0sXfbOwR5Gyu9coBohhsu8zhdZpA5kKuZTg8NJboDw/1NK+7+giS
         63z3ioCQc/KKpkCRyUx1Kql1U0zHvzD2P+/4t1emulGnKynZOlcd40K5G4UbsZaCWuAG
         WcJcqH+2My0E/GLm6+1ysAUPqpBiuwkB/Vk/BtyU67L3p+ibRJGDzA3J23HKmFE22/PQ
         /2Hr4TZpBJx3jL0uIwyDjYIP5eg7tNEawLpH78UFM6f39HNe6u0bIaJ8TCnEt/hqXxel
         +/k51tILeOrMFz8JeqTe5wa2qG3pKBEqqoYZl9ekM9Y3LMDG+wBH/HuFSwQgX+hGf/sn
         b0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bwsyQ5Vu4W5RWwfy6VtuRb8dpLJkggv+g3kZE12CFcQ=;
        b=SYR1DBKkwL4d7fcatoluilDOIMgiXCxIqRyOUVyeutiiO9PzuqF7xPcYVl5HI7/Eeb
         qWrUwZ8mcKaIHx+SbgUzti+PPBB7Qy51ttW2IdOcKnyZboEtNYO90p5geOgG7fsCuydL
         BAs33Oq3E6PN+l5MmNG4lRIfjwFOnZmTXmrU8GDJPsbm35sMCW25Cu+LqCVMMIVO88Kl
         pWH0iqBFkgK7vAjNEbH+w0RWmYFF8GXLGYf7sJd1Ca4AovR5EdjPLpJ4W7bpZ2fVZVue
         MKU6WD4I3z9uNvHi61mdx+IdCSCqNSFi0YMaGesUloj8pcdiBHriwKmB3h89tb7wiG1Z
         tgWw==
X-Gm-Message-State: AOAM531BLdqXDdgatZtWMpX1z9Qf+zSd2x/skgO9Xxe0SkX3IU65b5Bk
        bL5rh3xVyM/j6QUSybpHMVSsXg==
X-Google-Smtp-Source: ABdhPJw306Xv8hi4MiEDFStVaE0H2lWBzMserAaLf5q9MTAVjR/RGdsOIDq6FnIZCvCQRrdAPOBNOA==
X-Received: by 2002:a17:907:6ea4:b0:6e1:260e:a232 with SMTP id sh36-20020a1709076ea400b006e1260ea232mr13324944ejc.15.1649333121669;
        Thu, 07 Apr 2022 05:05:21 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j8-20020aa7c0c8000000b0041934547989sm9247017edp.55.2022.04.07.05.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 05:05:21 -0700 (PDT)
Message-ID: <bc71266a-50c9-ef0f-6bc1-20df79782d32@linaro.org>
Date:   Thu, 7 Apr 2022 14:05:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] spi: atmel,quadspi: Define lan966x QSPI
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, tudor.ambarus@microchip.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Manohar.Puri@microchip.com
References: <20220407105420.10765-1-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407105420.10765-1-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 12:54, Kavyasree Kotagiri wrote:
> LAN966x SoC supports 3 QSPI controllers. Each of them support
> data and clock frequency upto 100Mhz DDR and QUAD protocol.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  Documentation/devicetree/bindings/spi/atmel,quadspi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
> index 1d493add4053..100d6e7f2748 100644
> --- a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
> @@ -19,6 +19,7 @@ properties:
>        - microchip,sam9x60-qspi
>        - microchip,sama7g5-qspi
>        - microchip,sama7g5-ospi
> +      - microchip,lan966x-qspi

Expect the comment you got about wildcard, please also put it in
alphabetical order. As you can check, the other entries are ordered.

Best regards,
Krzysztof
