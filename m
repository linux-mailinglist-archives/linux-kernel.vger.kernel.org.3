Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1FA54E8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbiFPRwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiFPRwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:52:46 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF2A4CD7A;
        Thu, 16 Jun 2022 10:52:28 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id f7so1429867ilr.5;
        Thu, 16 Jun 2022 10:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sBvF2E09m1QcSC3OQvT6mnQfC15V6nMkozxCgxyedFA=;
        b=Wbx2A/kYmK6EXwss+t1o3N1QKZUsXobflRCmLSAbcqSbzC66oKeGdBFXeNfERiCnaQ
         wOHfc+LyuXxPGItiOwPdS3lcRMAjbwrlgOdrBP7iXf1KOdsKIP4Mic8OeFs8JoPCSk50
         EyRNWBOufU2H9wCKelLbo5+fjmka0tdOuqxcu1KaA7j1vetgAGlTw5LzLwbhhNfuBL+8
         LQRlXlmkzSvrIlMErNpSn6G4vkJ4dmvsJSh4yCdKGMUDHLGqRKfbvIOiXulUjBIkkHpj
         6UKk89w368ouEGSkqRVc48OZnRKdhlbWmgAG/7uPeeKEQDMokVaFTz0YOv5t9JANm4y/
         b4jg==
X-Gm-Message-State: AJIora8+7BaYJd6/fX+/vw8I6cmZa3kbmSSEjBV6Wyp9mr8z4JzXicH4
        /tBE7HDtKga9gux0cJtkcQ==
X-Google-Smtp-Source: AGRyM1sOLMfJXgeRbGQX+lZa94eN2BeFibMAozGWne9OQbCTVv/Yy2c184mFjW6lz0pdLJPoX6hIiA==
X-Received: by 2002:a05:6e02:1aa8:b0:2d3:d69a:6d88 with SMTP id l8-20020a056e021aa800b002d3d69a6d88mr3569568ilv.243.1655401947642;
        Thu, 16 Jun 2022 10:52:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id o14-20020a056e0214ce00b002cc20b48163sm1277215ilk.3.2022.06.16.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 10:52:27 -0700 (PDT)
Received: (nullmailer pid 3716762 invoked by uid 1000);
        Thu, 16 Jun 2022 17:52:25 -0000
Date:   Thu, 16 Jun 2022 11:52:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome NEANNE <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, nm@ti.com,
        kristo@kernel.org, will@kernel.org, lee.jones@linaro.org,
        khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/5] regulator: dt-bindings: Add TI TPS65219 PMIC
 bindings
Message-ID: <20220616175225.GA3712594-robh@kernel.org>
References: <20220613090604.9975-1-jneanne@baylibre.com>
 <20220613090604.9975-2-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613090604.9975-2-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 11:06:00AM +0200, Jerome NEANNE wrote:
> Add TPS65219 PMIC bindings using json-schema.
> 
> Describe required properties and regname-supply.
> regname-supply is required when bypass mode is used for a regulator.
> Describes regulator topology.
> 
> Signed-off-by: Jerome NEANNE <jneanne@baylibre.com>
> ---
>  .../bindings/regulator/ti,tps65219.yaml       | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> new file mode 100644
> index 000000000000..a4717ff4e95b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/ti,tps65219.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI tps65219 Power Management Integrated Circuit regulators
> +
> +maintainers:
> +  - Jerome Neanne <jerome.neanne@baylibre.com>
> +
> +description: |
> +  Regulator nodes should be named to buck<number> and ldo<number>.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tps65219
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^buck[1-3]-supply$":
> +    description: Input supply phandle of one regulator.
> +
> +  "^ldo[1-4]-supply$":
> +    description: Input supply phandle of one regulator.
> +
> +  regulators:
> +    type: object
> +    description: |
> +      list of regulators provided by this controller
> +
> +    patternProperties:
> +      "^ldo[1-4]$":
> +        type: object
> +        $ref: regulator.yaml#
> +        description:
> +          Properties for single LDO regulator.
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^VDD[A-Z0-9_]+$"
> +            description:
> +              should be "VDDNAME_LDO1", ..., "VDDNAMELDO4"
> +
> +        unevaluatedProperties: false

For the indented cases of this it's more readable when 'properties' gets 
long to put these next to 'type' or '$ref'.

Either way,

Reviewed-by: Rob Herring <robh@kernel.org>
