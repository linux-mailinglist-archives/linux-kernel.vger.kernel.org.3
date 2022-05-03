Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF44151915A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243629AbiECWZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbiECWZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:25:26 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE9F3ED27;
        Tue,  3 May 2022 15:21:53 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e5e433d66dso18588773fac.5;
        Tue, 03 May 2022 15:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=jAs3NAScHrB+A6PvNOqiGT3WbTZEZfZCmF0rQVevpas=;
        b=yfjDKngGMfZhKpch3hkbOXWfoJlowgw37QGOGr/63bGg77SG9qQRXWdIG/uBR6bKuk
         1CAeXGPP/ULc34xNYGW1KClu3Qn6uJgveokJrD8fvLXQnnVUJMx+8SNC6xUwLd4SWO91
         Qy7Uoo02Jo8ALJW2qKk7V7mizrESY9SPub9IlWfDNaq+nJJ4ME6zGAXWzi5liOFdiH7E
         emvkeIRLDx+fA2Gsko9722ZcH3xJfgR0RilwAd1pUgtFCFbao2NEkSBcOS6Ddy97DcFu
         iXklSm5Hhc0G9s9MlNmYxQpMgTg0oLOM9QmgyyaNt09EKKV2xdKrw6P9jslZTct50q12
         63jA==
X-Gm-Message-State: AOAM530IarVrb4Qn/nBiKD3BLfwveaG5zp0sVSLcfBwMZTsC/nC3i2po
        WCSsaXWwLKDHRqRhJELVHA==
X-Google-Smtp-Source: ABdhPJx2qP8TkucEjD8msix8TxJmAarK1uRUmwgXHNb7Lqk2i56Bbhv9jE2reUKzQAmq1Z3/bzYMhw==
X-Received: by 2002:a05:6870:548c:b0:ed:aa94:fd33 with SMTP id f12-20020a056870548c00b000edaa94fd33mr2629803oan.84.1651616512493;
        Tue, 03 May 2022 15:21:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t21-20020a056871055500b000e92d5a54ffsm7323349oal.26.2022.05.03.15.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 15:21:52 -0700 (PDT)
Received: (nullmailer pid 139785 invoked by uid 1000);
        Tue, 03 May 2022 22:21:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     Kavyasree.Kotagiri@microchip.com, peda@axentia.se,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Manohar.Puri@microchip.com, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk
In-Reply-To: <20220503105528.12824-2-kavyasree.kotagiri@microchip.com>
References: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com> <20220503105528.12824-2-kavyasree.kotagiri@microchip.com>
Subject: Re: [PATCH 1/4] dt-bindings: mfd: atmel,flexcom: Convert to json-schema
Date:   Tue, 03 May 2022 17:21:51 -0500
Message-Id: <1651616511.149012.139784.nullmailer@robh.at.kernel.org>
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

On Tue, 03 May 2022 16:25:25 +0530, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  .../bindings/mfd/atmel,flexcom.yaml           | 68 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 -----------------
>  2 files changed, 68 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml: properties:reg: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'Flexcom registers'}] is too short
	False schema does not allow 1
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml: ignoring, error in schema: properties: reg
Documentation/devicetree/bindings/mfd/atmel,flexcom.example.dtb:0:0: /example-0/flexcom@f8034000: failed to match any schema with compatible: ['atmel,sama5d2-flexcom']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

