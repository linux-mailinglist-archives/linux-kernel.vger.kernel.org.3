Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499A0547DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 04:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbiFMCuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 22:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238159AbiFMCuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 22:50:50 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E909377D7;
        Sun, 12 Jun 2022 19:50:49 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id e80so4813840iof.3;
        Sun, 12 Jun 2022 19:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ex2ldVBZZOLPyGXJ1joosoKNwHYbBC23z6wBX0YiLPc=;
        b=c4Aj0QmW8cQHTHjDR/HfR4D7b5peacg4GO9UzP4GB6vaaBjoWs8tIzlawHWuMqBMWi
         8EjG+gqpH0gxaY8mq7dl74rnYpil1+GWgCNdmyxTygh3qE66ZTiawSEMv7JGgakFgDuD
         UydwiMYjVhToasg5ustxfHOfCQQsZDISPLMGAAhGSXdytLCdQE8ZOOiiSo9JgoADVhkt
         AVqU3zm2eFs4W5OOiqVjH1/xMQ1kcjT+XbftcmGNvnQCl5VDf1XKrrcFFDGKwIiE+yj+
         Drn5/XK//08lSFkh+P9NjA/406TC2Jj/5rwuM3TXpb/FBJzvKjI0HXDy7L0GeLvS8xoI
         e1Lw==
X-Gm-Message-State: AOAM533CUGM8lrp2ipD3ZPmj01wRel89Ej9Nwsfry9xB0ksDOORb3z17
        aCRmP7IDUXiKe5CLNCUYXw==
X-Google-Smtp-Source: ABdhPJzhzSp+6kz2CQ8SuCbS2FqxGMvYT2GRKaaRl/f8tYODquYLh75JQmdd5Zq0tnojtNSQhcIDCQ==
X-Received: by 2002:a05:6638:d83:b0:331:f0ea:676d with SMTP id l3-20020a0566380d8300b00331f0ea676dmr13901069jaj.11.1655088647436;
        Sun, 12 Jun 2022 19:50:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p5-20020a056e0206c500b002d11888a1acsm3284393ils.34.2022.06.12.19.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 19:50:46 -0700 (PDT)
Received: (nullmailer pid 2612898 invoked by uid 1000);
        Mon, 13 Jun 2022 02:50:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, Kavyasree.Kotagiri@microchip.com
In-Reply-To: <20220612152604.24280-2-kavyasree.kotagiri@microchip.com>
References: <20220612152604.24280-1-kavyasree.kotagiri@microchip.com> <20220612152604.24280-2-kavyasree.kotagiri@microchip.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: mfd: atmel,flexcom: Convert to json-schema
Date:   Sun, 12 Jun 2022 20:50:42 -0600
Message-Id: <1655088642.987858.2612897.nullmailer@robh.at.kernel.org>
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

On Sun, 12 Jun 2022 20:56:02 +0530, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v2 -> v3:
>  - used enum for compatible string.
>  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
>  - fixed dtschema errors.
> 
> v1 -> v2:
>  - Fix title.
> 
>  .../bindings/mfd/atmel,flexcom.yaml           | 103 ++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -----------
>  2 files changed, 103 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml: properties:compatible:enum: 'atmel,sama5d2-flexcom' is not of type 'array'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml: properties:compatible:enum: 'atmel,sama5d2-flexcom' is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml: properties:compatible:enum: 'atmel,sama5d2-flexcom' is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml: ignoring, error in schema: properties: compatible: enum
Documentation/devicetree/bindings/mfd/atmel,flexcom.example.dtb:0:0: /example-0/flexcom@f8034000: failed to match any schema with compatible: ['atmel,sama5d2-flexcom']
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

