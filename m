Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F9858227F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiG0IxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiG0IxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:53:17 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE1446D8B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:53:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b21so12056790ljk.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WT6Bf9Wd4u+/b76NZ7GFsefZqgMs6EzwTFrQjSlCe3w=;
        b=P2Xf23tKUaRyXof5W984HGD9Q13GEbmMRWtao19Yy6tXQymySJSoLwBl8IJu5ivoeW
         ZHAWQdljf+z/vec6k1AUBOC+6cCSWgo2AxWN6rzMP45tV3++m0ABQlibobCzXP5egc19
         sliU3eo/trQLpCikT4ArHN6v4p+iHZXjlB0VswATrBYX63mTGndF63tmFxasgkbJ6mlV
         nJIxVVo0e2MFB2uA1q32lpdasb/ZVBNcg9HU/25HKqdnn/iAmmygOJPjmaAx3rPcGoWX
         3wWFZmFVDT9icClBwCfQ7ChFFzGpYPE3rIu2GAQnYG0eM0kUdRwAfzemPWbWDNhl+Min
         1ZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WT6Bf9Wd4u+/b76NZ7GFsefZqgMs6EzwTFrQjSlCe3w=;
        b=nda9v6bInm/KHGyeaaEtgA7lxtaLDLYQOS0/eU9j210BYObh+WErgMA+6C61kQBu/O
         a+htjc5legmO0xZ0Yga00Xw7WzyYky/H3HoBuSB9kKAXTHJezmzi3kwPRKAp13FKnz32
         q6hR9CyNQSIAC6DRGzMN7py+VQodAHAEPezn/rU4cs6StbUatUBZVJQbHeGH6hp52k8E
         DHE51hG9WMNIrvzueG909DCP9ncpQYLIK6gv5ATqr4Yqylwedn/Zp95LDVUkX4ocCydq
         hI8AgfDCujD9uK/85muZcxho2EJKGkDFSoqfk6v3vlQ53qQ9K9hwUi0kcyGLI18W7ptR
         mAqA==
X-Gm-Message-State: AJIora8PV0Mpzr7w9aHXUi7OoSk94/+lL6b0kdomqa/o/D15Y3cL2pa/
        rLMfjPPQ/Jjn9DM+J/Wz16sspg==
X-Google-Smtp-Source: AGRyM1sGsKeiDwI8gtL3TJYG4H41ewonY4JOKjtqR9UyMESCXxgq6JLJOzIk0g47YQaVf+2cD3uWPA==
X-Received: by 2002:a2e:700d:0:b0:25d:d6fc:277f with SMTP id l13-20020a2e700d000000b0025dd6fc277fmr7357817ljc.52.1658911994144;
        Wed, 27 Jul 2022 01:53:14 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id f16-20020a05651c03d000b0025d67053f0dsm1789534ljp.135.2022.07.27.01.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 01:53:13 -0700 (PDT)
Message-ID: <952a85ec-d1e9-7c14-6404-bc087723252f@linaro.org>
Date:   Wed, 27 Jul 2022 10:53:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/6] dt-bindings: arm: renesas: Ignore the schema for
 RISC-V arch
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726180623.1668-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On 26/07/2022 20:06, Lad Prabhakar wrote:
> Ignore the ARM renesas.yaml schema if the board is RZ/Five SMARC EVK
> (RISC-V arch).
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/renesas.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
> index ff80152f092f..f646df1a23af 100644
> --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
> @@ -9,6 +9,15 @@ title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
>  maintainers:
>    - Geert Uytterhoeven <geert+renesas@glider.be>
>  
> +# We want to ignore this schema if the board is of RISC-V arch
> +select:
> +  not:
> +    properties:
> +      compatible:
> +        contains:
> +          items:
> +            - const: renesas,r9a07g043f01

Second issue - why not renesas,r9a07g043?


Best regards,
Krzysztof
