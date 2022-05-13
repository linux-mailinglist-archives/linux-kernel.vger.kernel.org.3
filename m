Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE22C5261FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380339AbiEMMdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380282AbiEMMd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:33:29 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96D1674C8;
        Fri, 13 May 2022 05:33:28 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-e5e433d66dso10334831fac.5;
        Fri, 13 May 2022 05:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Y6SXqHq4jVINYnWAPbjFMrHoSh+02pvk+f0QJ78bs+8=;
        b=j4UJDfGay9yf9mS/NV8zIV1ypV/n4rDuCSd9dfl7uhoJTo7kT6O+VowgQQgHqcu22H
         DrY2OnGyBPirfwWkI2FYblm82nGRt4iHNNHuDJpb6slEe+kVOurBjzkkUsDDV4TS1Smc
         KHisXUiOBivQbn6w91dh3Bmnp8kHeY22bT7DN8xvLcvmVBgQ9z8fymMY9xlifhe47nBt
         CQxiNChj1sntFM6Q9cJm6Q74d+Ii2FvUS3tnjYLqDXQxRlReGlwmqfpkT3fFrH+yJ5sH
         ViEJc9RQHUwzcNg2LOV4yChxuPsJpSEsp8bRGhHGOjypiTM49bloAUHeet1lpoTy7Hd3
         QLxg==
X-Gm-Message-State: AOAM5312Nz8zbKDFueUp75Dl1LcXtGjgpabVbQCCgohXTGBEaBuPJecG
        gvy+YJ3la561ocOR07hB7A==
X-Google-Smtp-Source: ABdhPJyPZn3Xgpi1f5vxZ52Fd5aXo/LxlG8R5JGXBiXK/g/Fud6q3u5VC0bItDo8dFuPlwtasN2xFg==
X-Received: by 2002:a05:6870:a1a0:b0:dd:e471:8baf with SMTP id a32-20020a056870a1a000b000dde4718bafmr8054392oaf.40.1652445206767;
        Fri, 13 May 2022 05:33:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v3-20020a05683011c300b0060603221278sm866823otq.72.2022.05.13.05.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:33:26 -0700 (PDT)
Received: (nullmailer pid 85833 invoked by uid 1000);
        Fri, 13 May 2022 12:33:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        nancy.lin@mediatek.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, airlied@linux.ie, robh+dt@kernel.org,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        chunkuang.hu@kernel.org, angelogioacchino.delregno@collabora.com,
        jason-jh.lin@mediatek.com, linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org
In-Reply-To: <20220512080523.25082-4-rex-bc.chen@mediatek.com>
References: <20220512080523.25082-1-rex-bc.chen@mediatek.com> <20220512080523.25082-4-rex-bc.chen@mediatek.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: mediatek: add ethdr definition for mt8195
Date:   Fri, 13 May 2022 07:33:21 -0500
Message-Id: <1652445201.080121.85831.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 16:05:23 +0800, Rex-BC Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 ETHDR definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,ethdr.yaml      | 188 ++++++++++++++++++
>  1 file changed, 188 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml: properties:compatible: [{'const': 'mediatek,mt8195-disp-ethdr'}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml: ignoring, error in schema: properties: compatible
Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.example.dts:24:18: fatal error: dt-bindings/memory/mt8195-memory-port.h: No such file or directory
   24 |         #include <dt-bindings/memory/mt8195-memory-port.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.example.dtb] Error 1
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

