Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B243358280B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiG0N5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiG0N5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:57:16 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5BFE086;
        Wed, 27 Jul 2022 06:57:15 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id n138so13613827iod.4;
        Wed, 27 Jul 2022 06:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=nxMgZBBSR6x/A2wREjFjHPIdimpL4MklUGMoEuhSaos=;
        b=Cs9atv1Eb0HZy8Hsrh4lUPfmCXNmMYTq2PCAjGTUo8G+YOdhbJgT2VyHAnupRLKfhN
         gv27WoJHaLPVAh8nS+1pg63wU7/eJ9nCZwqNbtn4kpKqKrlrxJi4FEy3Y2ACfqvUJVE+
         bZlA3w4pDnJcy6xA75CItNHV1UyEInNsOps2+VpOkGmPvpxF9p9iL2390SJzEavDsH+A
         DSesqQuz0KHpAQ/mVRq/l8C+IfggFcdjGjTAKvlxcrXICa9bn/f6QWANc2rKghEFP17G
         pUjDHwp8+LOiH83YnU5W2gDNZxRGB9Bdci4TQtKn6CzMtxjKw8yokRstEkZLm4Wm44LK
         8nag==
X-Gm-Message-State: AJIora89NpM2Bcr8ASpcPz5Omx1eHK6FhibwPAx3+mgnoc1/PltmKY6P
        N4g1wbB4Z32dle72Ao3DBQ==
X-Google-Smtp-Source: AGRyM1tHbCtjpdAaPcSBOs8s5kywKzBslsKMi9tkX5yfFmADwm1Ig7XSyaEXUjPOYisj2Gy3/SdZTg==
X-Received: by 2002:a5d:9c56:0:b0:67b:e426:a514 with SMTP id 22-20020a5d9c56000000b0067be426a514mr7760929iof.71.1658930234178;
        Wed, 27 Jul 2022 06:57:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n11-20020a056638110b00b0033a29ec646dsm7738293jal.4.2022.07.27.06.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 06:57:13 -0700 (PDT)
Received: (nullmailer pid 2552038 invoked by uid 1000);
        Wed, 27 Jul 2022 13:57:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hui Liu <hui.liu@mediatek.com>
Cc:     linux-gpio@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jianguo.zhang@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        zhiyong.tao@mediatek.com, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
In-Reply-To: <20220727102140.6676-2-hui.liu@mediatek.com>
References: <20220727102140.6676-1-hui.liu@mediatek.com> <20220727102140.6676-2-hui.liu@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: add support for MediaTek mt8188
Date:   Wed, 27 Jul 2022 07:57:12 -0600
Message-Id: <1658930232.177263.2552037.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 18:21:39 +0800, Hui Liu wrote:
> From: "Hui.Liu" <hui.liu@mediatek.com>
> 
> Add pinctrl function header file and binding document for mt8188.
> 
> Signed-off-by: Hui.Liu <hui.liu@mediatek.com>
> ---
>  .../pinctrl/mediatek,mt8188-pinctrl.yaml      |  238 +++
>  .../pinctrl/mediatek,mt8188-pinfunc.h         | 1280 +++++++++++++++++
>  2 files changed, 1518 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
>  create mode 100644 include/dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/pinctrl/mediatek,mt8188-pinctrl.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.example.dtb: pinctrl@10005000: spi0-pins:pins-spi:bias-pull-up: More than one condition true in oneOf schema:
	{'oneOf': [{'items': [{'items': [{'enum': [100, 101, 102, 103]}],
	                       'maxItems': 1,
	                       'minItems': 1,
	                       'type': 'array'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {},
	           {'items': [{'items': [{'enum': [200,
	                                           201,
	                                           202,
	                                           203,
	                                           204,
	                                           205,
	                                           206,
	                                           207]}],
	                       'maxItems': 1,
	                       'minItems': 1,
	                       'type': 'array'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {},
	           {'items': [{'items': [{'enum': [1000,
	                                           1500,
	                                           2000,
	                                           3000,
	                                           4000,
	                                           5000,
	                                           10000,
	                                           75000]}],
	                       'maxItems': 1,
	                       'minItems': 1,
	                       'type': 'array'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {}]}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.example.dtb: pinctrl@10005000: spi0-pins:pins-spi-mi:bias-pull-down: More than one condition true in oneOf schema:
	{'oneOf': [{'items': [{'items': [{'enum': [100, 101, 102, 103]}],
	                       'maxItems': 1,
	                       'minItems': 1,
	                       'type': 'array'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {},
	           {'items': [{'items': [{'enum': [200,
	                                           201,
	                                           202,
	                                           203,
	                                           204,
	                                           205,
	                                           206,
	                                           207]}],
	                       'maxItems': 1,
	                       'minItems': 1,
	                       'type': 'array'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {},
	           {'items': [{'items': [{'enum': [75000, 5000]}],
	                       'maxItems': 1,
	                       'minItems': 1,
	                       'type': 'array'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {}]}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.example.dtb: pinctrl@10005000: i2c0-pins:pins:bias-pull-down: More than one condition true in oneOf schema:
	{'oneOf': [{'items': [{'items': [{'enum': [100, 101, 102, 103]}],
	                       'maxItems': 1,
	                       'minItems': 1,
	                       'type': 'array'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {},
	           {'items': [{'items': [{'enum': [200,
	                                           201,
	                                           202,
	                                           203,
	                                           204,
	                                           205,
	                                           206,
	                                           207]}],
	                       'maxItems': 1,
	                       'minItems': 1,
	                       'type': 'array'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {},
	           {'items': [{'items': [{'enum': [75000, 5000]}],
	                       'maxItems': 1,
	                       'minItems': 1,
	                       'type': 'array'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {}]}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.example.dtb: pinctrl@10005000: i2c1-pins:pins:bias-pull-up: More than one condition true in oneOf schema:
	{'oneOf': [{'items': [{'items': [{'enum': [100, 101, 102, 103]}],
	                       'maxItems': 1,
	                       'minItems': 1,
	                       'type': 'array'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {},
	           {'items': [{'items': [{'enum': [200,
	                                           201,
	                                           202,
	                                           203,
	                                           204,
	                                           205,
	                                           206,
	                                           207]}],
	                       'maxItems': 1,
	                       'minItems': 1,
	                       'type': 'array'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {},
	           {'items': [{'items': [{'enum': [1000,
	                                           1500,
	                                           2000,
	                                           3000,
	                                           4000,
	                                           5000,
	                                           10000,
	                                           75000]}],
	                       'maxItems': 1,
	                       'minItems': 1,
	                       'type': 'array'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {}]}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

