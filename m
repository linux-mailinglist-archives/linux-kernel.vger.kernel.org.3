Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06255A7675
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiHaGSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiHaGSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:18:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3F5BCC31
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:18:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so18534027lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ilqLNPvsII8KEDh0w8kfF61kZXvaJ3cQYRVHo9/0h3U=;
        b=BcU60Y4XL1hgYi0tY/3PvZxXTRHGOvIRv+77r5/bt1SHRS4n0Qym16xciE7Rg8Up5p
         CogCv0Ppa2Eccmyafu24Zm30x5DqwLQwvShTt9VMc9OUSH4kC2vuhsz9W8r6U01MHdkj
         j8ouSviUN1dFtQ1A5M/fFcjc3TuUnuSrGwR+Zv7wB8YE+8Ocl9tWBrp1dpleAdVmvhGX
         NDuirvcfWcOWh43FMCA+yIR33IzT0s1S4/YcTl+I6tynCh0a1XchNMJz/YkL8K5R8Q8V
         EuQ218DdGJDBaCjl0SVfM3LQEWA0P8SaokzvqAL0S7B1JDLED4ZqJIz07JmQMRITl+gv
         XRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ilqLNPvsII8KEDh0w8kfF61kZXvaJ3cQYRVHo9/0h3U=;
        b=qvx5IWtquuyexnKavAnAFTSrpaFRQt+7OahVWizG1jCCNRBsDMIY8zN6scy28C1Dz0
         1DmZRXoSUF4N27Vvai2IW26MSsDF0SJiaLRB3ZIWzvSoeXtTdDBejvxegqk/AY18hCk3
         quLwDGYCe2ACUeuaKuOAd3WBuhxim+m52Wx5JWdqfM2kBmOE6xCOxzUIzRKii0cL4TQb
         T0V+xpGm588OqSP2CUitCmfA9Ufvz2g6rv8eQuJhXf62vhiG5QALp4LbyXBhDW2OF7MC
         srV1BYhb+RlBCH0qc8+3NGsof7Jk5wvtBpflt1NfHFnSYqOe9qnPmyeBds0h8KoqavqA
         g9BA==
X-Gm-Message-State: ACgBeo2qkyowJtxJpDS4zYsUkJ2GxUPRprqZAJT9mKIrMwCUYomYImAp
        La9vIgbUqiGSqYUbEGX1mCr7Sg==
X-Google-Smtp-Source: AA6agR6jQOXoYRnO2V77lWo5mwnqhstpnuRdVJ5UWwQBmUtHdZPRXZ5XoRGx/ZM2mKx3UiSrTIHbiw==
X-Received: by 2002:a05:6512:228a:b0:492:b7cd:9599 with SMTP id f10-20020a056512228a00b00492b7cd9599mr8090107lfu.625.1661926707541;
        Tue, 30 Aug 2022 23:18:27 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id f42-20020a0565123b2a00b004947426aafdsm712074lfv.248.2022.08.30.23.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 23:18:27 -0700 (PDT)
Message-ID: <08d8807e-18cf-032e-90e9-e08023e7a6e0@linaro.org>
Date:   Wed, 31 Aug 2022 09:18:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/4] dt-bindings: memory: Factor out common properties of
 LPDDR bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220831013359.1807905-1-jwerner@chromium.org>
 <20220831013359.1807905-2-jwerner@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831013359.1807905-2-jwerner@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 04:33, Julius Werner wrote:
> The bindings for different LPDDR versions mostly use the same kinds of
> properties, so in order to reduce duplication when we're adding support
> for more versions, this patch creates a new lpddr-props subschema that
> can be referenced by the others to define these common parts. (This will
> consider a few smaller I/O width and density numbers "legal" for LPDDR3
> that are usually not used there, but this should be harmless.)
> 
> This also un-deprecates the manufacturer ID property for LPDDR3 (and
> introduces it to LPDDR2), since it was found that having this
> information available in a separate property can be useful in some
> cases.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  .../ddr/jedec,lpddr-props.yaml                | 60 +++++++++++++++++++
>  .../memory-controllers/ddr/jedec,lpddr2.yaml  | 40 ++-----------
>  .../memory-controllers/ddr/jedec,lpddr3.yaml  | 39 ++----------
>  3 files changed, 68 insertions(+), 71 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> new file mode 100644
> index 00000000000000..8b31c60ea2435b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr-props.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common properties for LPDDR types
> +
> +description:
> +  Different LPDDR types generally use the same properties and only differ in the
> +  range of legal values for each. This file defines the common parts that can be
> +  reused for each type.
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +properties:
> +  manufacturer-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Manufacturer ID read from Mode Register 5.

Are you sure that register numbers (here 5, 6-7-8 later) are the same
between LPDDR 2-5? The description should match the broadest case and
specific schema can narrow or correct it.

> +    minimum: 0
> +    maximum: 255
> +
> +  revision-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
> +    minItems: 2

No need for minItems.

> +    maxItems: 2
> +    items:
> +      minimum: 0
> +      maximum: 255
> +
> +  density:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Density in megabits of SDRAM chip. Decoded from Mode Register 8.
> +    enum:
> +      - 64
> +      - 128
> +      - 256
> +      - 512
> +      - 1024
> +      - 2048
> +      - 4096
> +      - 8192
> +      - 16384
> +      - 32768
> +
> +  io-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      IO bus width in bits of SDRAM chip. Decoded from Mode Register 8.
> +    enum:
> +      - 32
> +      - 16
> +      - 8

While moving, order it from lowest to highest.

> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
> index 9d78f140609b6c..63c47235cb9896 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
> @@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: LPDDR2 SDRAM compliant to JEDEC JESD209-2
>  
> +allOf:
> +  - $ref: "jedec,lpddr-props.yaml#"
> +

This goes just before "properties:"

>  maintainers:
>    - Krzysztof Kozlowski <krzk@kernel.org>
>  
> @@ -41,41 +44,6 @@ properties:
>        Property is deprecated, use revision-id instead.
>      deprecated: true
>  
> -  revision-id:
> -    $ref: /schemas/types.yaml#/definitions/uint32-array
> -    description: |
> -      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
> -    minItems: 2
> -    maxItems: 2
> -    items:
> -      minimum: 0
> -      maximum: 255
> -
> -  density:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -    description: |
> -      Density in megabits of SDRAM chip. Obtained from device datasheet.
> -    enum:
> -      - 64
> -      - 128
> -      - 256
> -      - 512
> -      - 1024
> -      - 2048
> -      - 4096
> -      - 8192
> -      - 16384
> -      - 32768
> -
> -  io-width:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -    description: |
> -      IO bus width in bits of SDRAM chip. Obtained from device datasheet.
> -    enum:
> -      - 32
> -      - 16
> -      - 8
> -
>    tRRD-min-tck:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      maximum: 16
> @@ -168,7 +136,7 @@ required:
>    - density
>    - io-width
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
> index 48908a19473c3f..5969166cdc9e0f 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
> @@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: LPDDR3 SDRAM compliant to JEDEC JESD209-3
>  
> +allOf:
> +  - $ref: "jedec,lpddr-props.yaml#"
> +

Also move below (before properties:)

>  maintainers:
>    - Krzysztof Kozlowski <krzk@kernel.org>
>  
> @@ -20,40 +23,6 @@ properties:
>      const: 1
>      deprecated: true
>  
> -  density:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -    description: |
> -      Density in megabits of SDRAM chip.
> -    enum:
> -      - 4096
> -      - 8192
> -      - 16384
> -      - 32768

This must stay (so density with enum, but no ref and no description).

> -
> -  io-width:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -    description: |
> -      IO bus width in bits of SDRAM chip.
> -    enum:
> -      - 32
> -      - 16

The same.

Best regards,
Krzysztof
