Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACC8580FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbiGZJ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiGZJ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:29:23 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1943139C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:29:22 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b34so10661183ljr.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C73GH9ihVQid8BYkT3Sa1NsZogeb4NXbL4mmn1ehaOE=;
        b=V5/W5DZLiKaTrI/gH/Wifh0YwVboE5Rt39xduS8KfMtLKsQB8CsUPW/ToeVabJjwJX
         iJreOYQFgEL3D0c5VdyfHyN1ZWvZCYQ3VwFPTGEMF2y4uTBXSykMine3MxQljjkShXw+
         tjMwp2iVq0M8Vrqm3ZVOs2fIl6kupIPgO8M7qjqZjsPHojcPiSTSM6jovX1eqUOpiB9I
         5uYzzC+P3b/hceQUfTdRPw+ZqshnZT3jLhdCwF6acqSxQQiLkNEJAVplGo6hXvvehUGq
         L6CmqS925cgyKKYzMGu+2AtFJuKOONfWe/jMQ9lK0mllU7EjxyauocPo06HgZIuhVDGX
         JBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C73GH9ihVQid8BYkT3Sa1NsZogeb4NXbL4mmn1ehaOE=;
        b=wTaBkWpf+054yWrqfNJ+mhbH1iSW2yZ03GZK7G3pI2e/0rCKoIpqSF1OxksANVMp/W
         8NVfW/o1Bo7O/QD2UrgWn+Qd6wA0SrPIpPJaFFMEJJuSS/PDb2X/LkF/tJpt2lUyUzwQ
         A6z+GqmtSIDPvy1aZC9tYWFc69CNLPz509lOoCk9qd0KibXRjjUK76Dd54EsEXH/Zqpc
         2bok99m3SRi0o2Y+Ye9VtjyYU0WqD1AN1ktXUZbQL8pJAzR86KtphPHO05kd9ctR9TjJ
         FEWUAFD5k4Go7NetOkt/I9hUF302Oand+RyTHF4kwjVjliWCUMuA9M7CwlNXyyWC7kqh
         WXLg==
X-Gm-Message-State: AJIora9bpBtQKUNiBJVriwm0gqhOocf2nj3G/tQF9k3e4Nr90St8SDiH
        O3Rf83CVYAiw7kF2zKO74izcCEFNYqUN/xbQ
X-Google-Smtp-Source: AGRyM1uQdBfRCK0JOiJbIzWqsixI71GKQA/6XmfE4JdFdLP4KzdKbUhd2rP0hztesLdVcjEBnAqqPA==
X-Received: by 2002:a2e:bd85:0:b0:25d:d750:7ac8 with SMTP id o5-20020a2ebd85000000b0025dd7507ac8mr5301578ljq.387.1658827760529;
        Tue, 26 Jul 2022 02:29:20 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id w5-20020ac25985000000b0048a8a4540d4sm1152563lfn.101.2022.07.26.02.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 02:29:19 -0700 (PDT)
Message-ID: <c4e8b285-1e77-492e-31d7-8c79328b95dd@linaro.org>
Date:   Tue, 26 Jul 2022 11:29:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 2/2] dt-binding: iio: time: add capture-tiecap.yaml
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com
References: <20220726072553.5136-1-jpanis@baylibre.com>
 <20220726072553.5136-3-jpanis@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726072553.5136-3-jpanis@baylibre.com>
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

On 26/07/2022 09:25, Julien Panis wrote:
> This commit adds a YAML binding for TI ECAP used in capture operating mode.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>  .../bindings/iio/time/capture-tiecap.yaml     | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml b/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
> new file mode 100644
> index 000000000000..4f08e49a8506
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml

Use filename based on compatible, so:
ti,am62-ecap-capture.yaml

> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/capture-tiecap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Enhanced Capture (eCAP) Module
> +
> +maintainers:
> +  - Julien Panis <jpanis@baylibre.com>
> +
> +description: |
> +  The eCAP module resources can be used to capture timestamps
> +  on input signal events (falling/rising edges).
> +
> +properties:
> +  compatible:
> +    const: ti,am62-ecap-capture
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: fck
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ecap0: capture@23100000 { /* eCAP in capture mode on am62x */
> +        compatible = "ti,am62-ecap-capture";
> +        reg = <0x00 0x23100000 0x00 0x100>;
> +        interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
> +        power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +        clocks = <&k3_clks 51 0>;
> +        clock-names = "fck";
> +    };


Best regards,
Krzysztof
