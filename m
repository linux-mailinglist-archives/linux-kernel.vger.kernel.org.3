Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4255261F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380276AbiEMMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350172AbiEMMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:33:25 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0C666AC3;
        Fri, 13 May 2022 05:33:24 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id w130so10010174oig.0;
        Fri, 13 May 2022 05:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=buZCjK/zEXixkrBZxaDQw6YBg7oqOrxcHQhY9x47DBY=;
        b=0Ydr2WIdaX/24jjhjChfjM+iK/3LVoVr7ZUjKqo69C6JUebUy+J9ewXCyik0EKpWXv
         UigQ/yBCTh0cw5pj1wWTG+vWH3b8A/Vv7q1WsJ/DSLmub0FDuj0L48rTdw5lPMOdLhO+
         VMjf2EprOUIexqFdiHmTQ0xv5g0tqZmBOp60Bq+LvhkQ2NQgZrydGMNJwj8DXZt3F4AL
         SmBqmbF6eDRr5X5SjvaSCExQr+9LT1kemPtyXBb4stWTOzCVQBleb+5SaMKff3Uq/6BL
         DqSAxEAA+PYTUzX7KymKYkdw2t7/bl04dKWUGP20hI2oKrmOxtLTqLJKJLRnAdO57h+A
         2nTQ==
X-Gm-Message-State: AOAM533LwuJ7aQfeDIAibbovSo1hgj74v1P7OCy3CtIrWPkFwk0SyWck
        TzODVbaVWkSJsmHbo+hSfFijMH8zcA==
X-Google-Smtp-Source: ABdhPJw7upKKDoDgfZ+8DZ0CWGKjhxTuOLrapQu7ccyksWW8Kk1fXfQ/lZ4uAKurnleTew8Xzr+gOw==
X-Received: by 2002:a05:6808:1206:b0:2d7:65a8:65e with SMTP id a6-20020a056808120600b002d765a8065emr2225633oil.107.1652445202398;
        Fri, 13 May 2022 05:33:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c24-20020a9d6858000000b00606ad72bdcbsm880686oto.38.2022.05.13.05.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:33:21 -0700 (PDT)
Received: (nullmailer pid 85827 invoked by uid 1000);
        Fri, 13 May 2022 12:33:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, nancy.lin@mediatek.com,
        dri-devel@lists.freedesktop.org, chunkuang.hu@kernel.org,
        jason-jh.lin@mediatek.com
In-Reply-To: <20220512080523.25082-2-rex-bc.chen@mediatek.com>
References: <20220512080523.25082-1-rex-bc.chen@mediatek.com> <20220512080523.25082-2-rex-bc.chen@mediatek.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: mediatek: add vdosys1 RDMA definition for mt8195
Date:   Fri, 13 May 2022 07:33:21 -0500
Message-Id: <1652445201.069924.85826.nullmailer@robh.at.kernel.org>
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

On Thu, 12 May 2022 16:05:21 +0800, Rex-BC Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 RDMA definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,mdp-rdma.yaml   | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml: properties:compatible: [{'const': 'mediatek,mt8195-vdo1-rdma'}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml: ignoring, error in schema: properties: compatible
Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.example.dts:25:18: fatal error: dt-bindings/memory/mt8195-memory-port.h: No such file or directory
   25 |         #include <dt-bindings/memory/mt8195-memory-port.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.example.dtb] Error 1
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

