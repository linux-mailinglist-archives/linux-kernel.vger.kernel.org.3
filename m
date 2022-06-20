Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AD8551C78
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbiFTNP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245091AbiFTNI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:08:29 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD9B1B7BB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:01:41 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z7so14986355edm.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tD9uUNT9XCLl71rBYEKigze1XhG3eLZdC6YZqfLDvzg=;
        b=BvQEWTHa4Iq1YBPiEICVFQd0aeeB3tGkxFn5lPUPTgkgrceHSOYPrAROHOGWWdMPEi
         13VnmLoqusC3tD5yt4+1soGwUSzQWMpXWkWwHx17Rbj0+oa5tS2QuzISc65MiuUiKpDG
         qRSI2LJmI26nGTax3/hqjzIHGdO0XA4kS+mqHo0EWdMpdMTdcjSWn55OASJQtHABhWFX
         W6qjXtJ86BDGDVTW1RU59sxBdIxoMbwxcfXRlvW4+UT0aJuHNNKGscmdBCmta/uk8WSy
         DIgEGVRpzaRvswyyG2+LfH6ILLd0o/PZZcOL5RCLncEj0ircT7NnEC7Xn8Rc8aI+PN37
         6Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tD9uUNT9XCLl71rBYEKigze1XhG3eLZdC6YZqfLDvzg=;
        b=vxrTNfLCdq0iSCxDqouuQ8gHgriF4Pnh1Kf/o8kkWv8pmEoIFF3HV4K5i7Acxap5oD
         9Ot/kLfkq/evQtnxVuXvtTCIvaWTFyCmvhZ4dRNgpDeiv5i2kh7wVZpLrkAvyeGwcTEV
         WkKMqgErJ4VGVBNzdY03Z3keMAuDBAfZZ+LHniwZ/joPFhug8+MY2EXN9/+ZW0TgbaR3
         gL+hm7zgZoQqUxnV+hDNc7LBSfwR8bo8jmnAI1DtdHW9Q4Jy7oeUHvISpRx6nxsYklDh
         1VBcx25UOozV0pztDN6iLlm2Qn3S5+E1ASBvbo97yqpW/f8HwT+dB8jUt6EJE6g3+tvr
         jK3g==
X-Gm-Message-State: AJIora+CC2VEFU/cvCZaQVCDumlXkVdHwo0vcJbfrL7Qnt0k71kaREE+
        36Rcs+DB3PrsoqQQwiu9H3YCjw==
X-Google-Smtp-Source: AGRyM1vW7T57TBehlpf2WN2b4z/6wROnJLNiUnGKA0BTpa7yikjOhmQJWvX3z5Qxz3LJ5QMdIe3mLQ==
X-Received: by 2002:a05:6402:3329:b0:435:8136:cb70 with SMTP id e41-20020a056402332900b004358136cb70mr5587757eda.106.1655730050702;
        Mon, 20 Jun 2022 06:00:50 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e27-20020a170906315b00b0071d3b6ed4eesm4758720eje.160.2022.06.20.06.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 06:00:50 -0700 (PDT)
Message-ID: <eac223c5-a3d4-65e5-3753-1bd4033513f2@linaro.org>
Date:   Mon, 20 Jun 2022 15:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 07/15] dt-bindings: reset: amd,pensando-elbasr-reset:
 Add AMD Pensando SR Reset Controller bindings
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, ulf.hansson@linaro.org, will@kernel.org,
        devicetree@vger.kernel.org
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-8-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220613195658.5607-8-brad@pensando.io>
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

On 13/06/2022 21:56, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> Document bindings for AMD Pensando Elba SR Reset Controller
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  .../reset/amd,pensando-elbasr-reset.yaml      | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> new file mode 100644
> index 000000000000..03bb86ebcfd3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/amd,pensando-elbasr-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD Pensando Elba SoC Reset Controller Device Tree Bindings

Here and in all other patches:
s/Device Tree Bindings//

> +
> +maintainers:
> +  - Brad Larson <blarson@amd.com>
> +
> +description: |
> +  AMD Pensando Elba SoC reset controller driver which supports a resource
> +  controller connected to the Elba SoC over a SPI bus.  The Elba reset
> +  controller must be defined as a child node of the Elba SPI bus
> +  chip-select 0 node.
> +
> +  See also:
> +  - dt-bindings/reset/amd,pensando-elba-reset.h
> +
> +properties:
> +  $nodename:
> +    pattern: "^reset-controller@[0-9a-f]+$"

Skip the pattern. No particular need for it and unit address part is not
correct (const: 0).

> +
> +  compatible:
> +    const: amd,pensando-elbasr-reset
> +
> +  reg:
> +    const: 0
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/amd,pensando-elba-reset.h>

Missing file:
ls: cannot access 'include/dt-bindings/reset/amd,pensando-elba-reset.h':
No such file or directory


Send complete bindings, not parts of it. Did you test it? I am pretty
sure that this did not happen. :(

> +    spi0 {

spi

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        num-cs = <4>;
> +
> +        spi@0 {
> +          reg = <0>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          rstc: reset-controller@0 {
> +            compatible = "amd,pensando-elbasr-reset";
> +            reg = <0>;
> +            #reset-cells = <1>;
> +          };
> +        };
> +    };
> +
> +...


Best regards,
Krzysztof
