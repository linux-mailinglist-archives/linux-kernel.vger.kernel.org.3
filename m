Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A025431D2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbiFHNpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240622AbiFHNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:45:14 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B015270416;
        Wed,  8 Jun 2022 06:45:10 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id y16so16560135ili.13;
        Wed, 08 Jun 2022 06:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=YvrT1V+/HQfLZp881xLcWn9Intydeg3IOxL76jyiPUQ=;
        b=lggw7S0BG9VxTIye6sxc8G9n7ViWhgVQRKJzxZqJ5urzpoJLgje32kDKgacQPWbEMb
         UkwjMIss86BDBEokt4Q60gq/vhCso1QXKokTxU/TGul2AA8yJW0aQpi5IGDWZZQOcsUK
         3slOPLtZjAdU3AQpKonlnn2uJjvtyFUhcKdKISGwkdp0Xtca/GWcp5VOjFKs0DXGHYkO
         BE8BgBO4FGDFQPtKX5Q5xXTbURfwZrUfqlXcmT3JOT/T3SdTzz5q2WSxvFTBOXxxgpg3
         +RecOCKV8FlYawxOqYvIDw+iUsaR3BHbMcK6miKWhJMxnxlztzIcpqdELTKfHB/U1Exj
         3e1A==
X-Gm-Message-State: AOAM531KPOX7HhjEI+fHZIeUNV404T3AXP0mHEPj37EI6OPCCK0jnPmf
        2SPRaoOzdSvZtWuGKDndfQ==
X-Google-Smtp-Source: ABdhPJyG4SDdl/qiO7uR+zJZDleVU9OlmS1o6OKezUiYwpR/5NmvOJi1tsdFU4+cf6knVV2/y1AciQ==
X-Received: by 2002:a05:6e02:1a83:b0:2d1:bb9a:bade with SMTP id k3-20020a056e021a8300b002d1bb9abademr19192517ilv.189.1654695909502;
        Wed, 08 Jun 2022 06:45:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id e34-20020a026d62000000b0032b3a7817a7sm7956341jaf.107.2022.06.08.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 06:45:08 -0700 (PDT)
Received: (nullmailer pid 1272083 invoked by uid 1000);
        Wed, 08 Jun 2022 13:45:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     UNGLinuxDriver@microchip.com, claudiu.beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        nicolas.ferre@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220607144740.14937-2-kavyasree.kotagiri@microchip.com>
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com> <20220607144740.14937-2-kavyasree.kotagiri@microchip.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: atmel,flexcom: Convert to json-schema
Date:   Wed, 08 Jun 2022 07:45:07 -0600
Message-Id: <1654695907.368178.1272082.nullmailer@robh.at.kernel.org>
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

On Tue, 07 Jun 2022 20:17:38 +0530, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v1 -> v2:
>  - Fix title.
> 
>  .../bindings/mfd/atmel,flexcom.yaml           | 97 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 ------------
>  2 files changed, 97 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/atmel,flexcom.example.dtb:0:0: /example-0/flexcom@f8034000/spi@400: failed to match any schema with compatible: ['atmel,at91rm9200-spi']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

