Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC64506FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346490AbiDSOF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345228AbiDSOFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:05:53 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA17396A6;
        Tue, 19 Apr 2022 07:03:10 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-d39f741ba0so17534173fac.13;
        Tue, 19 Apr 2022 07:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TDZP7ePRswAIISIUjc7s2geqqBhzSgxpIYSzSITB6gw=;
        b=TJOiAnoSofNM+FQARVKhZEujeDLaHB6U2Vf3LCcDlXTLC0l+TfrIKrDYQH4Nur046g
         aegi3+3LvhH3fjkncl2zrYSgI51GNhMXhYpyeLnE2pqjduZv0MI3E2+UHqdro7N+UONX
         BVJqlgSbpxfZTQALCpH+7ZiD4c+KC6knU+XpVXCeJXsiEU/aEIJNQmPWZ9EpcgXuzece
         yQmVKz7a8pRhALuPi/BbxtaoW9bkhYKjwtFUBbCeu2IpNWDXjcFCKFENoyx4Xv8NlztX
         AeukZINTqjefKWXJ8PF3L5SaL4Ni1ApebPlcdAc8oGOrwkbML6fPeVXfYFsw1B8SjKvP
         9LLg==
X-Gm-Message-State: AOAM530JWOrk2uIPNN0bYA8yFmNL+QLSF7tLfJ1zVSzX+jbTXFtKQEL1
        Kwl0NRsOaFg1qyC9T5FcuA==
X-Google-Smtp-Source: ABdhPJwrjiIBKYuettgxgJ28fYmidqtOP5jxahgbM3QuhrzJs3kwctfAHTnWYPhAaD9xK13JDKL5QQ==
X-Received: by 2002:a05:6870:15d3:b0:e5:bae5:4db with SMTP id k19-20020a05687015d300b000e5bae504dbmr6318114oad.245.1650376990157;
        Tue, 19 Apr 2022 07:03:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g8-20020acab608000000b002ecf38fb699sm5177240oif.38.2022.04.19.07.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:03:09 -0700 (PDT)
Received: (nullmailer pid 2462270 invoked by uid 1000);
        Tue, 19 Apr 2022 14:03:09 -0000
Date:   Tue, 19 Apr 2022 09:03:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: regulator: Add bindings for Silicon
 Mitus SM5703 regulators
Message-ID: <Yl7BHcPdy5iuuNxg@robh.at.kernel.org>
References: <20220415164356.25165-1-markuss.broks@gmail.com>
 <20220415164356.25165-2-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415164356.25165-2-markuss.broks@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 07:43:52PM +0300, Markuss Broks wrote:
> This patch adds device-tree bindings for regulators on Silicon Mitus
> SM5703 MFD.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../siliconmitus,sm5703-regulator.yaml        | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> new file mode 100644
> index 000000000000..560df4c020ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/siliconmitus,sm5703-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silicon Mitus SM5703 multi function device regulators
> +
> +maintainers:
> +  - Markuss Broks <markuss.broks@gmail.com>
> +
> +description: |
> +  SM5703 regulators node should be a sub node of the SM5703 MFD node. See SM5703 MFD
> +  bindings at Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> +  Regulator nodes should be named as USBLDO_<number>, BUCK, VBUS, LDO_<number>.
> +  The definition for each of these nodes is defined using the standard
> +  binding for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
> +
> +properties:
> +  compatible:
> +    const: siliconmitus,sm5703-regulator
> +
> +  buck:
> +    type: object
> +    $ref: regulator.yaml#

       unevaluatedProperties: false

> +    description:
> +      Properties for the BUCK regulator.
> +
> +  vbus:
> +    type: object
> +    $ref: regulator.yaml# 

       unevaluatedProperties: false

> +    description:
> +      Properties for the VBUS regulator.
> +
> +patternProperties:
> +  "^ldo[1-3]$":
> +    type: object
> +    $ref: regulator.yaml#

       unevaluatedProperties: false

> +    description:
> +      Properties for single LDO regulator.
> +
> +  "^usbldo[1-2]$":
> +    type: object
> +    $ref: regulator.yaml#

       unevaluatedProperties: false

> +    description:
> +      Properties for a single USBLDO regulator.
> +
> +additionalProperties: false
> -- 
> 2.35.1
> 
> 
