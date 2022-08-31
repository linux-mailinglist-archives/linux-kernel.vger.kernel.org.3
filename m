Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9887B5A768A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiHaG3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiHaG3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:29:00 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E63FBD165
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:28:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id k18so7175799lji.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=vXIpnTplt7Zn2kn3GeNcnd6sClvGJXOShQyQw8kYRLw=;
        b=SFx62zVCYAThk1LKQTvqQRwJyRwQ1Dk7SJiWMuMJyDSurl+1I9bxsb+7XtcuI3ZuLB
         trRjIcoRJdPLnWarUy3X5wta2/EM70FBS0dMnBy2UJff1eHYA6sXiA0S6Xk4L/R7LSw9
         4sMIYgqfTxNGRQBdwpKJyHpRpidOqSKNUu4dzm1KT03x5dxomjq14ELwZxg8dBnAsu4d
         n6pv8NVtrJYemq0s9R9Pt4RCbFWHXlHqIIDHb9M6A3L4qXmhwX0D3mzcZ7hDxg69qBfD
         f7cbc5a2HBZbB+l+9ce2uplKKRdiW0EIRzneovDREyLqvQX9cTqkBNjEYTJh6x3XbY95
         UzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=vXIpnTplt7Zn2kn3GeNcnd6sClvGJXOShQyQw8kYRLw=;
        b=CtUgVUQpCIzyKPTf0DwU3xTQIFqhdQjyGiR75BtIQp24syxmYjy1wPAiSFlw0Vjfqj
         +HqbFmSL52/R+jeni2YGPJIE/sngV96fBBlycubfdH7OhqAImxKiBs0J8XVlWm4aRAgr
         sEbPXmvxrO/fqyNX6z6ic3iaBQP/dD2GQYnT4FT5MdzdBh2cZJWP5lgCWokk8Laxg16N
         /KtCgFVV9x+rxS8Fp/X//J46WcVvJxq7F/KA3IlB7MPplmRQNe0rk21q7wcwwYd+2eQa
         jU8kHDjl5QlqUFZo1yRpmkgWzqf1NsOqEvTeKMa1dk1yhI1UjjQ5WHUw/cOHu91AqUG5
         GCfQ==
X-Gm-Message-State: ACgBeo25Hb/85N004cpokn77KhERwwNfJtmiPMFLqJa/FQtSR/jlW+MD
        iwTK2+DbJK+Y0ge9777O9BKsUQ==
X-Google-Smtp-Source: AA6agR7Gh6EPFymQVH2FDoSw8lSOQtwnJOcmcnwwMYh0u5odzoIb1PeUOia1hGmEAndLdJ30GqL2Iw==
X-Received: by 2002:a05:651c:98d:b0:261:b5c0:121d with SMTP id b13-20020a05651c098d00b00261b5c0121dmr7615833ljq.336.1661927335761;
        Tue, 30 Aug 2022 23:28:55 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id a30-20020a195f5e000000b00492efa461aasm27907lfj.204.2022.08.30.23.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 23:28:55 -0700 (PDT)
Message-ID: <983c1224-8174-3534-a276-d1ab1f9968a4@linaro.org>
Date:   Wed, 31 Aug 2022 09:28:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 3/4] dt-bindings: memory: Add jedec,lpddr4 and
 jedec,lpddr5 bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220831013359.1807905-1-jwerner@chromium.org>
 <20220831013359.1807905-4-jwerner@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831013359.1807905-4-jwerner@chromium.org>
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

On 31/08/2022 04:33, Julius Werner wrote:
> This patch adds bindings for LPDDR4 and LPDDR5 memory analogous to the
> existing bindings for LPDDR2 and LPDDR3. For now, the new types are only
> needed for topology description, so other properties like timing
> parameters are omitted. They can be added later if needed.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  .../ddr/jedec,lpddr-props.yaml                |  4 ++
>  .../memory-controllers/ddr/jedec,lpddr4.yaml  | 36 ++++++++++++++
>  .../memory-controllers/ddr/jedec,lpddr5.yaml  | 48 +++++++++++++++++++
>  3 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> index 0c7d2feafd77c8..e1182e75ca1a3f 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> @@ -53,9 +53,13 @@ properties:
>        - 512
>        - 1024
>        - 2048
> +      - 3072
>        - 4096
> +      - 6144
>        - 8192
> +      - 12288
>        - 16384
> +      - 24576
>        - 32768

Either you limit now LPDDR2 and LPDDR3 to old values or instead add this
bigger list to LPDDR4 and LPDDR5 (if it works that way).

>  
>    io-width:
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
> new file mode 100644
> index 00000000000000..860300cebee754
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr4.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LPDDR4 SDRAM compliant to JEDEC JESD209-4
> +
> +allOf:
> +  - $ref: "jedec,lpddr-props.yaml#"

allOf goes below maintainers.

> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - pattern: "^lpddr4-[0-9a-f]{2},[0-9a-f]{4}$"
> +      - const: jedec,lpddr4
> +
> +required:
> +  - compatible
> +  - density
> +  - io-width
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    lpddr4 {

Let's just call it "lpddr" to be generic.

> +        compatible = "lpddr4-ff,0100", "jedec,lpddr4";
> +        density = <8192>;
> +        io-width = <16>;
> +        manufacturer-id = <255>;
> +        revision-id = <1 0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
> new file mode 100644
> index 00000000000000..ae3894bb346d5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr5.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LPDDR5 SDRAM compliant to JEDEC JESD209-5
> +
> +allOf:
> +  - $ref: "jedec,lpddr-props.yaml#"
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - pattern: "^lpddr5-[0-9a-f]{2},[0-9a-f]{4}$"
> +      - const: jedec,lpddr5
> +
> +  serial-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Serial IDs read from Mode Registers 47 through 54. One byte per uint32
> +      cell (i.e. <MR47 MR48 MR49 MR50 MR51 MR52 MR53 MR54>).
> +    minItems: 8

No need for minItems.

> +    maxItems: 8
> +    items:
> +      minimum: 0
> +      maximum: 255
> +
> +required:
> +  - compatible
> +  - density
> +  - io-width
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    lpddr4 {

Let's just call it "lpddr" to be generic (it's lpddr5 anyway).

> +        compatible = "lpddr5-01,0200", "jedec,lpddr5";
> +        density = <8192>;
> +        io-width = <8>;
> +        manufacturer-id = <1>;
> +        revision-id = <2 0>;
> +        serial-id = <3 1 0 0 0 0 0 0>;
> +    };


Best regards,
Krzysztof
