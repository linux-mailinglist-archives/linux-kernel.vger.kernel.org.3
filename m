Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF340567047
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiGEOGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiGEOGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:06:21 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2100237E3;
        Tue,  5 Jul 2022 06:54:35 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id z191so11148684iof.6;
        Tue, 05 Jul 2022 06:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=lTyedAFkYCMRnxsVgj2lGtfLlmacjsmd+UHWQbblE0g=;
        b=uhMclJKrlNfIbRhq3RkYg3fRrWAvbvjwPYds2Ugjam7jazAdoG/87IBqk/EERfLPBm
         5A6UeZqbd7/wJHlMmxX7CCp0R/CdgNrqTgTFMiO1N4yZTHGGi+l5aVs8VSOcwyGTlMsP
         pqIu2pGkh6QLzytnbHglrZnlpuvNjgBpyPjV0AJsz0E/2+a4qlX7agw2B+krG+T4HUFf
         FhXiY5uNjCK6VROA4/HllWozPp5yY4xM149l2xpSkK3Fipw3aOyEf28H62qc65bezyQT
         UytKUkLzCYQse8xbxLwt6w6EVteRxR+EH+rTy5nWrgxE0saYqk/qrqAPjYOhARF4oOwJ
         umIw==
X-Gm-Message-State: AJIora+YE5nSdPUJuLTkaZnocsnOp0otM4AV3gNbhBCz6OddlAfvDaFz
        F6oVwmNgKWFx8f+tTJjRgQ==
X-Google-Smtp-Source: AGRyM1tPDtMiMEWiV5K9UuTKrIsnPvaN6PBgV9T35MDcykItXZe8or12GzDVpnV+C0m1DaqWbVfOQQ==
X-Received: by 2002:a05:6638:4806:b0:339:c232:928b with SMTP id cp6-20020a056638480600b00339c232928bmr20140250jab.213.1657029275232;
        Tue, 05 Jul 2022 06:54:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f9-20020a056e0204c900b002dc0d2f7c7bsm2703020ils.4.2022.07.05.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:54:34 -0700 (PDT)
Received: (nullmailer pid 1999991 invoked by uid 1000);
        Tue, 05 Jul 2022 13:54:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, UNGLinuxDriver@microchip.com,
        devicetree@vger.kernel.org, Kavyasree.Kotagiri@microchip.com,
        claudiu.beznea@microchip.com, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220705065758.17051-2-kavyasree.kotagiri@microchip.com>
References: <20220705065758.17051-1-kavyasree.kotagiri@microchip.com> <20220705065758.17051-2-kavyasree.kotagiri@microchip.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mfd: atmel,flexcom: Convert to json-schema
Date:   Tue, 05 Jul 2022 07:54:31 -0600
Message-Id: <1657029271.199284.1999990.nullmailer@robh.at.kernel.org>
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

On Tue, 05 Jul 2022 04:57:56 -0200, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v5 -> v6:
>  - Removed spi node from example as suggested by Rob and
>    also pattern properties(spi dt-bindings conversion to yaml patch is under review).
>    Once that is accepted, I will add back spi example through new patch.
> 
> v4 -> v5:
>  - Fixed indentations.
> 
> v3 -> v4:
>  - Corrected format of enum used for compatible string.
> 
> v2 -> v3:
>  - used enum for compatible string.
>  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
>  - fixed dtschema errors.
> 
> v1 -> v2:
>  - Fix title.
> 
>  .../bindings/mfd/atmel,flexcom.yaml           | 72 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 ----------------
>  2 files changed, 72 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/atmel,flexcom.example.dts:24.13-45: Warning (ranges_format): /example-0/flexcom@f8034000:ranges: "ranges" property has invalid length (12 bytes) (parent #address-cells == 1, child #address-cells == 2, #size-cells == 1)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.example.dtb: flexcom@f8034000: '#address-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.example.dtb: flexcom@f8034000: '#size-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

