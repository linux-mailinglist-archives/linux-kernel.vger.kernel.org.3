Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECED35638A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiGARf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiGARf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:35:27 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59512FFEC;
        Fri,  1 Jul 2022 10:35:26 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id z191so2925447iof.6;
        Fri, 01 Jul 2022 10:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FUW5StgEXWi6CmKJ5HAihZrzuEB0UaUqYmi5N5q77ow=;
        b=IWG4khxBt13yCUWzbn6skHN3t2rM45lMIoZabJhc0c5XJ3t0uRSTUigyGrmt1kUUAA
         C2wPpleYbmrMYMyQVFybqqgVKoCTQtS9UFwZdS+nlfhz4xQQHt2MuUWt7KQDLqntT3VN
         FTl7jRGxUPUOVMAMUG76tEewLaoDU31MkFqdhDCX4V1MKV7NBHZrVy/N+v9rKfGGyDdI
         XAEDcf6pSYMZQm0VtNztfcORkDU7TbHSUpNDncLN3Ln6Zb2ZoyUi9vyAwD5sjjNpQzYC
         zWTuyivQJFlLNfxmxERUpKKGV0oS/MxHf2+lN8TYdeNbSQTR/ojBZ/dTfo33PaDgUDsS
         Sx9w==
X-Gm-Message-State: AJIora/+DPq5ioBT88Tt87hgWv8nwzCb/88sqh3HG+xuxgAXSmk39coQ
        HTwwPg7OGBCCF2DoDHaVOQ==
X-Google-Smtp-Source: AGRyM1v1Vrtk3FNhMLMg4BAdK8+/X5pyHVcz0ZkhRMCLOQetrI4TURhs9OBhQSRucOlGBeyUov97zA==
X-Received: by 2002:a05:6638:2516:b0:339:f061:a27c with SMTP id v22-20020a056638251600b00339f061a27cmr9335025jat.24.1656696926067;
        Fri, 01 Jul 2022 10:35:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i19-20020a023b53000000b00339cdf821dasm10009823jaf.51.2022.07.01.10.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 10:35:25 -0700 (PDT)
Received: (nullmailer pid 1189343 invoked by uid 1000);
        Fri, 01 Jul 2022 17:35:24 -0000
Date:   Fri, 1 Jul 2022 11:35:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: samsung: s5pv210-chipid: add S5PV210
 ChipID
Message-ID: <20220701173524.GA1185040-robh@kernel.org>
References: <20220629123543.94515-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629123543.94515-1-krzysztof.kozlowski@linaro.org>
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

On Wed, Jun 29, 2022 at 02:35:43PM +0200, Krzysztof Kozlowski wrote:
> Add bindings for the S5PV210 ChipID block.

Is this new or was undocumented?

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soc/samsung/s5pv210-chipid.yaml  | 30 +++++++++++++++++++

samsung,s5pv210-chipid.yaml

Surely there's other similar blocks. Can we start collecting in a 
common directory?

>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/samsung/s5pv210-chipid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/samsung/s5pv210-chipid.yaml b/Documentation/devicetree/bindings/soc/samsung/s5pv210-chipid.yaml
> new file mode 100644
> index 000000000000..7c3f4ec47f7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/samsung/s5pv210-chipid.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/samsung/s5pv210-chipid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S5PV210 SoC series Chipid driver
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: samsung,s5pv210-chipid
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    chipid@e0000000 {
> +        compatible = "samsung,s5pv210-chipid";
> +        reg = <0xe0000000 0x1000>;
> +    };
> -- 
> 2.34.1
> 
> 
