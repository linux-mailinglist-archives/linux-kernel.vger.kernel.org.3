Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EBC5A5F44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiH3JXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiH3JWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:22:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9F5D5701
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:21:44 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q16so10671099ljp.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=t2+Vzdbmp1Zj1Ubn+bhI2XCo+Y34oD2vP1kC7goh3Bw=;
        b=X6FnQQTX10HojjPRr3B1zGRv1y5UZb7bIMt1siV1lv3+CH5P/DZcWxPMxp3IsdC6r9
         Of0mU8sRK/7nvVLEgEVukOLGijmUWq5Da4p7o7+3HLFtdQdjabb+/nHaMQ+lGLhLXcT3
         YnBVCRxnn+IhV6KPozHi3MO0S2nSSK/I6mEhc9QLI8Ct5NDUwSTqRzoqtXr0JOVFwhxP
         ybvsHs9QlUZIbtI2yU2gt5c7ihP1EI5dhuKr+lYwFNJVP88PyBR7KzZMROckPDjookf2
         N0UIcnIPbrmOGeCPdkML+QYXmSAT3s0/KT93n+bM2X+FirQmni8h6wAtX/n1QKvu3XXU
         8wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=t2+Vzdbmp1Zj1Ubn+bhI2XCo+Y34oD2vP1kC7goh3Bw=;
        b=PbBq1gAgD4wc01g/n4z8lkJL1rUoNkrSqsjlYR3qria63H7yhNQEQbsRlrZhd4SRDX
         17+p0bQmaj+BJvU7oSQC+CTK2r/tdORyv7SfSvG0HxbJWT4qb8s5vGEeS5qghNLskfRn
         1iMk0E8f8xNaLilPODqRCJmmWhJFzjyvy8tyjvJqDsMEoghbkV1dou75q0RRhLCdBj4o
         HrQsf9XQq5KDSaU6ZIvEjcwHhopWTsT/JwfaGciKMTyYA/SVyVjOtK4FyrsQFdrWcAHa
         lSM2D0se8MUgInryw1cH1EjNAaLSlHVNsRjcOht7kcRoR+tr4KyC3nekSo8aAwQoQjTY
         6okA==
X-Gm-Message-State: ACgBeo1o68KvjikszFCZK+J356/QnwcDHhbE0GudnTJWqpCgpXuvgp/y
        MQsh72TqqsFvITv5CEdoqYWC6g==
X-Google-Smtp-Source: AA6agR5zv64xIKhp5mngmPjgak7Swpb4ZKHAk+rW+baGQB1oMx+uhC/VI6E/0/k/pe8ZVO//UspI1Q==
X-Received: by 2002:a05:651c:2d0:b0:25e:6c94:59d5 with SMTP id f16-20020a05651c02d000b0025e6c9459d5mr7057524ljo.488.1661851302780;
        Tue, 30 Aug 2022 02:21:42 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id o14-20020ac25e2e000000b004946da0f075sm577821lfg.135.2022.08.30.02.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:21:42 -0700 (PDT)
Message-ID: <9a63271b-48c0-1b31-c450-5abc9eedbced@linaro.org>
Date:   Tue, 30 Aug 2022 12:21:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: mtd: spi-nor: Add reset-gpios property
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
        git@amd.com
References: <20220829090528.21613-1-sai.krishna.potthuri@amd.com>
 <20220829090528.21613-2-sai.krishna.potthuri@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829090528.21613-2-sai.krishna.potthuri@amd.com>
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

On 29/08/2022 12:05, Sai Krishna Potthuri wrote:
> SPI-NOR flashes have RESET pin which can be toggled using GPIO
> controller, for those platforms reset-gpios property can be used to
> reset the flash device.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 7149784a36ac..d2fc8e9c787f 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -70,6 +70,12 @@ properties:
>        be used on such systems, to denote the absence of a reliable reset
>        mechanism.
>  
> +  reset-gpios:
> +    description:
> +      contains a GPIO specifier. 

Skip this part - obvious.

> The reset GPIO is asserted and then deasserted
> +      to perform device reset. If "broken-flash-reset" is present then having
> +      this property does not make any difference.

Isn't then broken-flash-reset conflicting with this one (e.g.
disallowing it)?

Best regards,
Krzysztof
