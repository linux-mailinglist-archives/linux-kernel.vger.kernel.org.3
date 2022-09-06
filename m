Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E455AEB47
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbiIFN5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbiIFNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:54:39 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F6E7D792;
        Tue,  6 Sep 2022 06:41:28 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id z22-20020a056830129600b0063711f456ceso8068450otp.7;
        Tue, 06 Sep 2022 06:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9O7PzS9icEWvflax/sDIyoRvTTpAWAalNbCvjy/7uKY=;
        b=Un0FqAHnDAuEn3eHAp8SnM1d1hoy9d/fCnxshOAEA0weUGtB2rZvpTPKLoV9R2OX79
         RkixNO6FrYKPV7sQ51DZA91v+ZMiIuwiQr/P4nzfl5uaIcJM7Y0IsezAOFVBti1ylUiD
         JUtC45vPEXPaA7SO0nvsEUtDFbo1ZE6YfehQHTjECpxlXsEsNBMx85xMImzAiC2VNDrE
         sI1GAbc4z5NWEfLr4xFlTP6qtSD4Jno/09rQrYg1Z3ILm7mnQzYL+1ohps4DwhDJAEOk
         1OLCF/ItcRTmkLWfi8LqpcD6W9RMHFAOnSPCDKb+te+FxQyLJPotTcE9USRHM7GjaJmJ
         CyQA==
X-Gm-Message-State: ACgBeo1Xs90dN1Sruwb147m2E+XTPu684NlfOC85dd5yN2pmwEk1okbo
        0xTBcEDMCJxhUptfzDEeiA==
X-Google-Smtp-Source: AA6agR7l+RC3By/UqrddRF5+IacRUXfeqCIuCYqKB3YKY7keBuvMZhDzLRaciOChnidIJTDSmhMq+w==
X-Received: by 2002:a05:6830:2aa4:b0:637:1824:80f3 with SMTP id s36-20020a0568302aa400b00637182480f3mr22420142otu.330.1662471646640;
        Tue, 06 Sep 2022 06:40:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l21-20020a9d7a95000000b00616d25dc933sm5852439otn.69.2022.09.06.06.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:40:46 -0700 (PDT)
Received: (nullmailer pid 360953 invoked by uid 1000);
        Tue, 06 Sep 2022 13:40:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, Victor Wan <victor.wan@amlogic.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
In-Reply-To: <20220906060034.2528-5-liang.yang@amlogic.com>
References: <20220906060034.2528-1-liang.yang@amlogic.com> <20220906060034.2528-5-liang.yang@amlogic.com>
Subject: Re: [PATCH RESEND v8 4/5] dt-bindings: nand: meson: convert txt to yaml
Date:   Tue, 06 Sep 2022 08:40:45 -0500
Message-Id: <1662471645.297810.360952.nullmailer@robh.at.kernel.org>
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

On Tue, 06 Sep 2022 14:00:32 +0800, Liang Yang wrote:
> convert the amlogic,meson-name.txt to amlogic,meson-nand.yaml
> 
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.txt       | 55 ------------
>  .../bindings/mtd/amlogic,meson-nand.yaml      | 88 +++++++++++++++++++
>  2 files changed, 88 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.example.dtb: nand-controller@ffe07800: Unevaluated properties are not allowed ('reg-names' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml

doc reference errors (make refcheckdocs):
MAINTAINERS: Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

