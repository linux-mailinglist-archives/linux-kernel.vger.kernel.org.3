Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C985519C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbiFTNBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244669AbiFTM7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:59:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683DD1A04E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:56:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id h23so20897158ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h3Tl1NcyyBUWJ2hHdmOi/Ijf7c9vRxpUfpu/sNPMip0=;
        b=L/a+blQMKJ0CtjtTkyZsQV8mZ9nBiyrM0wdEwFTgm1g9+bNjfOUsuqa4hfYy25H4Su
         CrEGNcLWNROSbOjP950Cv/bHAwylQVKT2hbbdgmq0CRPZdWDIKTESY4DiTaBTaqSR8Ba
         MHcDwv0495ZgqFzrjTcCnqdeE4PSOKLjXoXkSo4Q808FhPz9TGdHsG4x0qGP8nXUD/Zl
         +DzUh7shBy7R5aMQGAVx043OJFbNIa7to12Skiof61OdV+8xhHZLFh6PjDxhvTrv220f
         XJyoQvVXVaLdPTvBZnIHccivBtK1KArdEMV+A1mOwWzM2YjLyk97Eyc1ruGcDtoRe8Fb
         hd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h3Tl1NcyyBUWJ2hHdmOi/Ijf7c9vRxpUfpu/sNPMip0=;
        b=RGkI8eQHhRX2LiRdZcwcZlZY9TeShHcGNdzF3VEjUoTBHEAKDGdCFpDojphcjj8RQt
         br19bnofV5CjhTObym0KRctzZ4Mjl+j7GOPaaVNg9IEk0tX3sFFiWeM5UKrnWsCMRLvA
         COBqWdYJukuAEJiPmDvnp90MBKI51j6ab3Q+5HLg7tadoe3bx5oWJPuce0YAaZraF6MU
         IawtDtnHnt30hBwyJHFZA4WUozW4Ev4w4KTxUHRQBmTRGykQDIKKvDhESQ8nsSBmoCBM
         2mKEv0LoKKPX5/TeoR7eDmZQ++JG5eVja2pSNeQP8ebWOz7opMjWdlB/9DKe6nHE/Z1N
         qlOA==
X-Gm-Message-State: AJIora+nvRX0KpXAkPmMH1/VRZylAYf7vL1sc/uGuUqufvEpr2AGlu9I
        oFEofRXxSugD+fyZ6U3uyaqJmg==
X-Google-Smtp-Source: AGRyM1u/8SxdA92Z860M9UR7l1Kg2/zV6W837GoE6rMQOgOO+jYLeQhNPSn5HkrZgk422GiqUnGnEQ==
X-Received: by 2002:a17:906:7053:b0:711:b90e:47b7 with SMTP id r19-20020a170906705300b00711b90e47b7mr20354864ejj.652.1655729800692;
        Mon, 20 Jun 2022 05:56:40 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004357ab9cfb1sm3830386edy.26.2022.06.20.05.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 05:56:40 -0700 (PDT)
Message-ID: <b42b197f-2b11-cb6e-458a-ed12b2eb997d@linaro.org>
Date:   Mon, 20 Jun 2022 14:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
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
 <20220613195658.5607-7-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220613195658.5607-7-brad@pensando.io>
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
> Add support for the AMD Pensando Elba SoC System Resource chip
> using the SPI interface.  The Elba SR is a Multi-function Device
> supporting device register access using CS0, smbus interface for
> FRU and board peripherals using CS1, dual Lattice I2C masters for
> transceiver management using CS2, and CS3 for flash access.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  .../bindings/mfd/amd,pensando-elbasr.yaml     | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> new file mode 100644
> index 000000000000..13356800b1cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/amd,pensando-elbasr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD Pensando Elba SoC Resource Controller bindings
> +
> +description: |
> +  AMD Pensando Elba SoC Resource Controller bindings attached to a SPI bus.
> +
> +maintainers:
> +  - Brad Larson <blarson@amd.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - amd,pensando-elbasr
> +      - const: simple-mfd
> +
> +  spi-max-frequency:
> +    description: Maximum SPI frequency of the device in Hz.
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +
> +patternProperties:
> +  '^reset-controller@[a-f0-9]+$':
> +    $ref: ../reset/amd,pensando-elbasr-reset.yaml
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/amd,pensando-elba-reset.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spi0 {

Just "spi"

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        num-cs = <4>;
> +
> +        spi@0 {

"spi" is for SPI controllers. Use generic name matching the device.
Usually this is "system-controller", however Rob pointed out your
inaccurate bindings and example.

> +          compatible = "amd,pensando-elbasr", "simple-mfd";
> +          reg = <0>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          spi-max-frequency = <12000000>;
> +
> +          rstc: reset-controller@0 {
> +            compatible = "amd,pensando-elbasr-reset";
> +            reg = <0>;
> +            #reset-cells = <1>;
> +          };
> +        };
> +
> +        spi@1 {
> +          compatible = "amd,pensando-elbasr", "simple-mfd";
> +          reg = <1>;
> +          spi-max-frequency = <12000000>;
> +        };
> +
> +        spi@2 {
> +          compatible = "amd,pensando-elbasr", "simple-mfd";
> +          reg = <2>;
> +          spi-max-frequency = <12000000>;
> +          interrupt-parent = <&porta>;
> +          interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +
> +        spi@3 {
> +          compatible = "amd,pensando-elbasr", "simple-mfd";
> +          reg = <3>;
> +          spi-max-frequency = <12000000>;
> +        };
> +    };
> +
> +...


Best regards,
Krzysztof
