Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625BA57BCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbiGTRcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbiGTRc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:32:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFDE5E336
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:32:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a9so31408257lfk.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FpdLAALfeFZJFf34lr9EAhmP/cSrmy7SxAXiREu4lCE=;
        b=e2PwSymV0hA+iIEXs5JnVHMHTYba9XQeH1c2XfY/o0kRymmpd+9BFAruPDv8CzYshH
         7UNWBFLSTwSwpS7PgmNyLKD7dcV25GMdPqgurrpIqDzTKca1UbsGLc0fX4rKKZVBFR/y
         tuE4CWS3WSCn8N5efQvbI328K33oijpEPSZLThOZimXoq/kosT5TIMmQpwcvj9Zd1RrD
         PvqjlNJQwxnzemXPGKP8NdhOCgS3Oyu7a9qARuKOiabCTX0V0lwBJMAnAT5LTbllpfKX
         t8zNsw2nEL1IgV8iKQxyx31A+hu/coiIuhkosx5vZGkk4e4jyr0Vk0vbcG7gMPruU3FM
         /XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FpdLAALfeFZJFf34lr9EAhmP/cSrmy7SxAXiREu4lCE=;
        b=llRBgeGuGmEUT+m8h9Hi1OJP0iKpoiM/yj3Gi9d0NoXcdj5mUWKkMG5L2GjbIc1Hph
         n+kFQnLDnBmGmgOEuuc+Z8RyRife/cLBUT0kaB5emlz8P+wiTOvpG/dvZ+VLfpHnOkwK
         EzoD2ZjNp3Y7GndThCwuUOBe4DpyEKPgQxZbyxTFZJogVc9XbrNsa7LX4UNdcZA+wErW
         W6iG/ojXslwHfVky0BKOZh4x9FwckqVfJAnDGL549PEbUmo0RKh9qHV601BTfau3CB5q
         mfgJKkdVKXxJHsXi2onFsrwXT4HmfGT0Bhv5XzwiHsa6+RFuotG/1OzfeOvreUvBcuqS
         BWcQ==
X-Gm-Message-State: AJIora8rl84n9CqK/3CFSQkfxgUkC25D6FVL6z1YWe+MZ5vFCTPJtRgg
        nO306r1tjC4FDMuxXdXfk4Moag==
X-Google-Smtp-Source: AGRyM1sjIgDPvW7XqgXeKtiTiExWUywK1Bz9F9BKOt5z1/TReYjxYJre4a0CVxkypZSJHZbV45ScyQ==
X-Received: by 2002:a19:700b:0:b0:486:e7ec:67ad with SMTP id h11-20020a19700b000000b00486e7ec67admr19129070lfc.263.1658338344098;
        Wed, 20 Jul 2022 10:32:24 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id o13-20020ac25e2d000000b004896ed8dce3sm3917980lfg.2.2022.07.20.10.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:32:23 -0700 (PDT)
Message-ID: <4afe8a76-08be-224f-d40f-0b45566a5147@linaro.org>
Date:   Wed, 20 Jul 2022 19:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 03/21] dt-bindings: power: mediatek: Refine multiple
 level power domain nodes
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-4-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720123023.13500-4-tinghan.shen@mediatek.com>
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

On 20/07/2022 14:30, Tinghan Shen wrote:
> Extract duplicated properties and support more levels of power
> domain nodes.
> 
> This change fix following error when do dtbs_check,
>     arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: power-controller: power-domain@15:power-domain@16:power-domain@18: 'power-domain@19', 'power-domain@20', 'power-domain@21' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	 From schema: Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../power/mediatek,power-controller.yaml      | 131 +++---------------
>  1 file changed, 17 insertions(+), 114 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index b448101fac43..321802c95308 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -42,6 +42,23 @@ properties:
>  
>  patternProperties:
>    "^power-domain@[0-9a-f]+$":
> +    $ref: "#/$defs/power-domain-node"
> +    patternProperties:
> +      "^power-domain@[0-9a-f]+$":
> +        $ref: "#/$defs/power-domain-node"
> +        patternProperties:
> +          "^power-domain@[0-9a-f]+$":
> +            $ref: "#/$defs/power-domain-node"
> +            patternProperties:
> +              "^power-domain@[0-9a-f]+$":
> +                $ref: "#/$defs/power-domain-node"
> +                unevaluatedProperties: false
> +            unevaluatedProperties: false
> +        unevaluatedProperties: false
> +    unevaluatedProperties: false

I see some beauty in previous endless recurrence, but at least we are
specific...


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
