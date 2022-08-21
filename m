Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E6159B64A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 22:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiHUUVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 16:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiHUUVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 16:21:34 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292C51AF1E;
        Sun, 21 Aug 2022 13:21:33 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso6485605otv.1;
        Sun, 21 Aug 2022 13:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=zaang43qN+/ZquL2Zo396AnsznNRkcyayaHV3/kK8qY=;
        b=LiCXOtOTazvG1DAJATBwHdwkRjEuXvEog7tCZO2FfPz2Ez+5c3jOOS1DZCKgwkDn1I
         Izok2tLEb4qex5XjI9pM4MJC3+Vu19apewbIKSOtvM2Qgj21s+LLFwrDi3Hz+wdi5IWk
         yN5cYbgTbzQvr4y6d/vH6tDfNt/8w1+NaRxzGP7VsBP3t1kshfW0F8AUCpFQ6uiqwnpq
         TL3k2Qxzt1h4Ls0pJtyhi/Ibo1BgbKO19PPdPtgHh3d7wq5jGdc8Af1YwV7J+e5aZmO1
         XQfqdGzRc9p4Ep3qzTW5+40oNsgPy1gcXTYLEGvdfqcNpccVV6NYk/4mWDvjqprBFiok
         pdrA==
X-Gm-Message-State: ACgBeo0QkKpr/am+GA5HdroCAndp3gUSpr2y0evAs0nkQ69OSE/Dmt3l
        0xiJHPsIiLSAJzfyfimxMA==
X-Google-Smtp-Source: AA6agR5+2XHkqPZv+Fo1bbBB5sV3kaGyWPx5o5bMtO0CFcHcv8eqXCCbDt45gehNsmveC/hP9ot60A==
X-Received: by 2002:a9d:809:0:b0:637:80b:3a3e with SMTP id 9-20020a9d0809000000b00637080b3a3emr6629945oty.328.1661113292406;
        Sun, 21 Aug 2022 13:21:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q198-20020a4a33cf000000b00435a59fba01sm2164618ooq.47.2022.08.21.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 13:21:31 -0700 (PDT)
Received: (nullmailer pid 1729145 invoked by uid 1000);
        Sun, 21 Aug 2022 20:21:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     catalin.marinas@arm.com, gerg@linux-m68k.org, gsomlo@gmail.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        thomas.lendacky@amd.com, krzk@kernel.org, rdunlap@infradead.org,
        alcooperx@gmail.com, brijeshkumar.singh@amd.com,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
        ulf.hansson@linaro.org, piotrs@cadence.com, p.yadav@ti.com,
        lee.jones@linaro.org, andy.shevchenko@gmail.com,
        suravee.suthikulpanit@amd.com, krzysztof.kozlowski+dt@linaro.org,
        blarson@amd.com, will@kernel.org, arnd@arndb.de,
        p.zabel@pengutronix.de, samuel@sholland.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, fancer.lancer@gmail.com
In-Reply-To: <20220820195750.70861-7-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io> <20220820195750.70861-7-brad@pensando.io>
Subject: Re: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando Elba System Resource chip
Date:   Sun, 21 Aug 2022 15:21:26 -0500
Message-Id: <1661113286.942295.1729142.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2022 12:57:39 -0700, Brad Larson wrote:
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
>  .../bindings/mfd/amd,pensando-elbasr.yaml     | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/reset/amd,pensando-elbasr-reset.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.example.dtb: system-controller@0: reset-controller@0: False schema does not allow {'compatible': ['amd,pensando-elbasr-reset'], 'reg': [[0]], '#reset-cells': [[1]]}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.example.dtb:0:0: /example-0/spi/system-controller@0/reset-controller@0: failed to match any schema with compatible: ['amd,pensando-elbasr-reset']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

