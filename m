Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6117E4F1BCD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381591AbiDDVXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378963AbiDDQK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:10:58 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DFBDF4E;
        Mon,  4 Apr 2022 09:09:01 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id z8so10545169oix.3;
        Mon, 04 Apr 2022 09:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=cezylBcNKJIb7u3t+c6rzI4fkWol+SJJy81HJ0NVukk=;
        b=eQB7UTSAKpyr2i1uSIGLihmH4foHNvfHZo8GkAKqNeCNXjGBa1rQCXD+czhoOTdLrV
         IIeFZemdqC4gAaoz9wzGBjwT416R1w0Sl6wmXUm/8AOuuuX7vUbd1wXZ5x9OMsIIzZga
         v2qgevPwRC3lK5CSm2BYCC0mKmDwFt4w09nkGktckYummLpndLu8LYqZbkg/p9OjeOVf
         Y1zmdkDm94SNuFic67W4yfQeATNrQdtxUtI4cfDIvXX1nuCb77Y6Hhrm7cZCTB+se7oI
         Ujx/lRBUiEoT+pO8OL6AHLYLGNVlscrZPwRc2RpKXlKkwKZ1evIODXMC9WQxIjCd7FI7
         E7eA==
X-Gm-Message-State: AOAM533PPDC+D0FH29F1SsGWXvhv6XgocUoRN1dVyCwi3Myi/TLHY3k8
        D6yVtz81/SLGU1aOshEdbg==
X-Google-Smtp-Source: ABdhPJxu7q0HR0nZflSaNkabmyqrbGx7Kocd4s/sq7R0bRlhaws0t4qgX1Nk2HPeARa/X2rziRYFcw==
X-Received: by 2002:a05:6808:ecb:b0:2f7:41cc:21b9 with SMTP id q11-20020a0568080ecb00b002f741cc21b9mr10234348oiv.156.1649088540993;
        Mon, 04 Apr 2022 09:09:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m65-20020acabc44000000b002ed13d0fe6fsm4309194oif.23.2022.04.04.09.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 09:09:00 -0700 (PDT)
Received: (nullmailer pid 1436950 invoked by uid 1000);
        Mon, 04 Apr 2022 16:08:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Pratyush Yadav <p.yadav@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Roger Quadros <rogerq@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mediatek@lists.infradead.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-mtd@lists.infradead.org
In-Reply-To: <20220404131818.1817794-5-gch981213@gmail.com>
References: <20220404131818.1817794-1-gch981213@gmail.com> <20220404131818.1817794-5-gch981213@gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: spi: add binding doc for spi-mtk-snfi
Date:   Mon, 04 Apr 2022 11:08:58 -0500
Message-Id: <1649088538.050456.1436949.nullmailer@robh.at.kernel.org>
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

On Mon, 04 Apr 2022 21:18:17 +0800, Chuanhong Guo wrote:
> Add device-tree binding documentation for Mediatek SPI-NAND Flash
> Interface.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> Changes since v1:
>   1. add a blank line between properties in dt binding doc
>   2. rename ecc-engine to nand-ecc-engine for the generic properties
> 
> Change since v2: none
> 
>  .../bindings/spi/mediatek,spi-mtk-snfi.yaml   | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.example.dt.yaml: spi@1100d000: 'ecc-engine' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.example.dt.yaml:0:0: /example-0/soc/spi@1100d000/flash@0: failed to match any schema with compatible: ['spi-nand']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

