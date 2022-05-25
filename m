Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986FF533CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiEYMoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiEYMoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:44:06 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9594ED123;
        Wed, 25 May 2022 05:44:04 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id e189so24868971oia.8;
        Wed, 25 May 2022 05:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=1xKn1TwFCEiFxTgut6Nt95ns9umTBM5bV8PgAamEzGI=;
        b=U4hOSp/+4mz+lSlPH5EfRnsRB1Z1TH2wIGBizl7FjUTpGjeosqOdyPNW60o/hrqktp
         u9gyZCxGtOUN/lVe3W/QGAaUdoLMCO1uR3OFf2s9EwNv52c8Mtiw5LSEhr7T8xpJuh4o
         4H0Ad7f7xxp7rka0XAADGarkEDZ0oIl7WKuYQrxxD+BMKxFFP6XPfthClC0RNxJJ54JB
         CVKJ51f9soBrkhs1kf5mPVfq+xNiP17HnS39fq3aL7rxbRd7yVR0uHTsompD/zdNdBUq
         tMkvhGoRN4gylWyXi1sxCIVqTFao2rZ7rboUHb7F9uBgUIfYcXwyVm/xGvFdXzEs74q3
         oxgw==
X-Gm-Message-State: AOAM530zFho56UCDJmfxnZ7MQDJKpAYHPXTQ98MHrI1X6Ql+q/FMRnjF
        2bkN6IasHOCzZ16KJuyVgg==
X-Google-Smtp-Source: ABdhPJyp4RR2/wWLrfrKz/ft7jvpqGKEU8/LjZ5HHq0aDMy4VC3N1ZKM5JQ8agR6C41wBqF0tK49xg==
X-Received: by 2002:a05:6808:1201:b0:325:75e1:25a8 with SMTP id a1-20020a056808120100b0032575e125a8mr5116618oil.18.1653482643566;
        Wed, 25 May 2022 05:44:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ec25-20020a0568708c1900b000edae17a8cesm5952127oab.3.2022.05.25.05.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:44:02 -0700 (PDT)
Received: (nullmailer pid 1760895 invoked by uid 1000);
        Wed, 25 May 2022 12:44:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     linux-pm@vger.kernel.org, khilman@baylibre.com,
        linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de,
        james.lo@mediatek.com, linux-arm-kernel@lists.infradead.org,
        rui.zhang@intel.com, rafael@kernel.org, matthias.bgg@gmail.com,
        amitk@kernel.org, robh+dt@kernel.org, fan.chen@mediatek.com,
        daniel.lezcano@linaro.org, krzk+dt@kernel.org,
        devicetree@vger.kernel.org, rex-bc.chen@mediatek.com,
        louis.yu@mediatek.com, mka@chromium.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220524152552.246193-3-abailon@baylibre.com>
References: <20220524152552.246193-1-abailon@baylibre.com> <20220524152552.246193-3-abailon@baylibre.com>
Subject: Re: [PATCH v7 2/6] dt-bindings: thermal: Add binding document for LVTS thermal controllers
Date:   Wed, 25 May 2022 07:44:01 -0500
Message-Id: <1653482641.588144.1760894.nullmailer@robh.at.kernel.org>
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

On Tue, 24 May 2022 17:25:49 +0200, Alexandre Bailon wrote:
> This patch adds binding document for mt8192 and mt8195 thermal
> controllers.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  .../thermal/mediatek,mt8192-lvts.yaml         | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml: allOf:1:$ref: '/nvmem/nvmem-consumer.yaml#' does not match '^(/schemas/|\\.\\./|#(/|$)|[a-zA-Z0-9]+)'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml: ignoring, error in schema: allOf: 1: $ref
Error: Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.example.dts:34.36-37 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

