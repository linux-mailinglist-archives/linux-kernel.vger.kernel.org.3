Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1D4567FC6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiGFHZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiGFHZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:25:39 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC1EDF70
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:25:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m18so5955332lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 00:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TKgVE+FdRItJeaW6dhefsVPxfJCQGgpO5M7VhRxCZBs=;
        b=nHhgznajaCxrzWCH2A4/BuARFHu6ryIA9o+y8LRsICfDCzg5O1T2AmjP9vOaeVOTzc
         /sLLh8jiGlBoj6Rc/RKVKAbkylBMv0+IOiNy/InfqrsQUnP+pQhXRUUdntYOYIZLyB8D
         nAWWhy96J2BTOPnbX8Z3dzgNkr8UcjDFiGKWqiP06ADI3NIjFV6mqH4Csz69tMsiRy1h
         5KYbYGrL+YIQ86Y4Vm19hV0HwClrLpdf3gd+0PuEiGPC69h4Q60Cn5hC5vcFmlpiIHsQ
         ecvwUkN9Qes9OCs+jwji8OPWVd6rDnp6AFxD7fGvyL0Ve11hb5amHuL480nyGEnAjCRK
         W27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TKgVE+FdRItJeaW6dhefsVPxfJCQGgpO5M7VhRxCZBs=;
        b=JE5U6YHB+qYmPVYC0Pd5PksOMvnp58T4T9xAu7wiFlB6whQ42myEILftVhw0FpsqHE
         7GTDhrKD3XhD8SH/ZPOJWxaYo74Biwmql2gE3y/9PC4usOMMZkEqYiICxFhVYeyfkCAQ
         fMRKYO7HI11lwg5KJUHql+uAIoN/5v2yqxQc51gSI9WAmePmKDxM5Ex7pWm6JeBu6SaC
         YNZlWYAoBmwIT8LZQKfsWGxEy+xyV/qdJs/MiStVOuWyekJIMbQBRaOChdnGGaDvtXk9
         /djRCye7xcrrWbhflLp2mnRAGceD2LSeJDrbwSzO56KW+X5QRvJ9Rd0naGozdiTkwCip
         K70A==
X-Gm-Message-State: AJIora8maeCGdtib4cNtNfK4Zyn1Yxg5ga6lYW4B0cGVFLU5U1D/OGYo
        z/5jHxadpi4xbzvHdPuJtFr9/vcXnES3Ww==
X-Google-Smtp-Source: AGRyM1smhRl80gqSMQfoa7qwtQIgMtoDBKy3Wp4dx2r7HgVVLxlfayMZVy483HkqsJxy/MRP9Qu/9w==
X-Received: by 2002:a05:6512:3c99:b0:483:7dfc:931b with SMTP id h25-20020a0565123c9900b004837dfc931bmr4976947lfv.6.1657092337045;
        Wed, 06 Jul 2022 00:25:37 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id b13-20020a2eb90d000000b0025aa03fba32sm5987441ljb.12.2022.07.06.00.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 00:25:36 -0700 (PDT)
Message-ID: <64b08d73-0973-6074-7285-dd59d4bef9cd@linaro.org>
Date:   Wed, 6 Jul 2022 09:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] Add an entry for MOXA platform board
Content-Language: en-US
To:     =?UTF-8?B?SmltbXkgQ2hlbiAo6Zmz5rC46YGUKQ==?= <jimmy.chen@moxa.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SEYPR01MB4272F28F81FB51152496D9CBFA809@SEYPR01MB4272.apcprd01.prod.exchangelabs.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SEYPR01MB4272F28F81FB51152496D9CBFA809@SEYPR01MB4272.apcprd01.prod.exchangelabs.com>
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

On 06/07/2022 09:22, Jimmy Chen (陳永達) wrote:
> UC-8220 & UC-8210 hardware compatibility model
> 
> Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
> ---
>  .../devicetree/bindings/arm/moxa.yaml         | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/moxa.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/moxa.yaml b/Documentation/devicetree/bindings/arm/moxa.yaml
> new file mode 100644
> index 000000000000..73f4bf883b06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/moxa.yaml
This goes to fsl file.

> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/moxa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MOXA platform device tree bindings
> +
> +maintainers:
> +  - Jimmy Chen <jimmy.chen@moxa.com>
> +
> +properties:
> +  compatible:
> +    description: UC-82XX-LX embedded computer
> +    items:
> +      - const: moxa,uc-8210
> +      - const: moxa,uc-8220

Does not match your DTS and should fail the tests (dtbs_check).

Best regards,
Krzysztof
