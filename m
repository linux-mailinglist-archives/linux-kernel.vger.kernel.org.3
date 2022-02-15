Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8104B7540
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbiBOTtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:49:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243804AbiBOTtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:49:33 -0500
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0586660C;
        Tue, 15 Feb 2022 11:49:22 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id r144so25235994iod.9;
        Tue, 15 Feb 2022 11:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=KXSZwObXwXhyqBUgs8Dj2mGzNepAgJtQoKeKbytKAUc=;
        b=Niifu3b/FINdxzgfxxNqLLaqM4A/FSx28rBdR0SrY6tSoajgBZblHW1DpBC2sVFwGZ
         IPefElNFsEjbg7Sb8pzr5C3bDzPcVmh6ccxifor2WhSFucXO6Pj5I7XGyNWiAFStLowj
         /vlhGgq+XxhH5+1s5y7+dZxUjs78yntZsEQHpUHxx7z6vHycxnppT4LNIUALdwKt7MX0
         RWxBykSlQLZ2aQ3c8bBCqyLlz4RuvHCfJ16yOpjaV+7Q6hu/4RGzbk2RCAV1gFDLCAss
         3cJ94UoVQLgIjojWlRhESuW1tInU9rla4y5IQwF66kz/UPfocQDRWnvY/6KyDB/FK/tw
         EWJw==
X-Gm-Message-State: AOAM5324t6HQdjPzLyuDzaknX+gvUVFrNHBFdbqWwpjMW4xIMj65iFEW
        fLF/IROadrBX6z5PnObT3g==
X-Google-Smtp-Source: ABdhPJw4dH7aOt4PpzLwO7VCfIbho2N2cLTRW+nmzH1+8BgDGfbcmPlRXiw84CD6uvuop7GaxBvJ4Q==
X-Received: by 2002:a05:6638:37a1:: with SMTP id w33mr301609jal.73.1644954560908;
        Tue, 15 Feb 2022 11:49:20 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h12sm6014113ild.44.2022.02.15.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 11:49:20 -0800 (PST)
Received: (nullmailer pid 3813672 invoked by uid 1000);
        Tue, 15 Feb 2022 19:49:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     linux-aspeed@lists.ozlabs.org, Richard Weinberger <richard@nod.at>,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Pratyush Yadav <p.yadav@ti.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20220214094231.3753686-3-clg@kaod.org>
References: <20220214094231.3753686-1-clg@kaod.org> <20220214094231.3753686-3-clg@kaod.org>
Subject: Re: [PATCH 02/10] dt-bindings: spi: Add Aspeed SMC controllers device tree binding
Date:   Tue, 15 Feb 2022 13:49:18 -0600
Message-Id: <1644954558.088844.3813671.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 10:42:23 +0100, Cédric Le Goater wrote:
> The "interrupt" property is optional because it is only necessary for
> controllers supporting DMAs (Not implemented yet in the new driver).
> 
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.example.dt.yaml: example-0: spi@1e620000:reg:0: [509739008, 196, 536870912, 268435456] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.example.dt.yaml: spi@1e620000: reg: [[509739008, 196, 536870912, 268435456]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1592369

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

