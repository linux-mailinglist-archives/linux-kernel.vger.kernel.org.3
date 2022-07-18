Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B20577960
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiGRBn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiGRBn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:43:27 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06229F582;
        Sun, 17 Jul 2022 18:43:25 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id r70so7105575iod.10;
        Sun, 17 Jul 2022 18:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=oj3Zm/SQRO5MOitoOMIklr7G150Ky3mACmzWauG0RBA=;
        b=WbmMqA0qH++41O5VwVJ+DGwfVo1CJ+NBbX5hCsdrEo9o5vYbsfBurgFJn2lEM+FIq3
         7KCORIgzAr5D84oGNL7E6RmzcrFZKGErbzC/yUmutxj1b+qR31ILpalsLWpm2qFJkPPy
         hGDlr9FRbu6SCTtlTHFNU3awM62ZE+AXUdivXSpgFtDQB0YtM441zjHEjSYxIiYu9c5m
         hXVA/iOFbnhpwI9DM0DxmV9ttIwVF0ydac7si0Os2Owh/i3D7K92CnJRTmnP2LPe0l7l
         w3ih8bfRb4RZJSEyZJFH4QUFsUcUuNQw0pbO7J2D/8gCQPuGOhSjdFl35jk1AqjRo0jL
         Wc8w==
X-Gm-Message-State: AJIora+X85fviNYNyQyBuLc2+C2a+oPjSEM0UmtApNqPB99IojFCHsmY
        yTDga5d2ONelQRla5g37CQ==
X-Google-Smtp-Source: AGRyM1uiqFrYjUOelbjO2ccWrnnbbv01J29IHfmPZakQn9i+h9JEq0jlLLxuslHjF/ef6ILjcvo7fw==
X-Received: by 2002:a6b:cd8c:0:b0:67b:90c4:43c3 with SMTP id d134-20020a6bcd8c000000b0067b90c443c3mr11863916iog.28.1658108604204;
        Sun, 17 Jul 2022 18:43:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r20-20020a02aa14000000b0033202bb9829sm4854226jam.49.2022.07.17.18.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 18:43:23 -0700 (PDT)
Received: (nullmailer pid 1667782 invoked by uid 1000);
        Mon, 18 Jul 2022 01:43:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     wenst@chromium.org, angelogioacchino.delregno@collabora.com,
        Tomasz Figa <tfiga@chromium.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, xia.jiang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        nicolas.dufresne@collabora.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        linux-kernel@vger.kernel.org, maoguang.meng@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kyrie wu <kyrie.wu@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org
In-Reply-To: <20220716093408.29734-2-irui.wang@mediatek.com>
References: <20220716093408.29734-1-irui.wang@mediatek.com> <20220716093408.29734-2-irui.wang@mediatek.com>
Subject: Re: [V5,1/8] dt-bindings: mediatek: Add mediatek,mt8195-jpgdec compatible
Date:   Sun, 17 Jul 2022 19:43:21 -0600
Message-Id: <1658108601.891612.1667781.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2022 17:34:01 +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgdec compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> 
> ---
>  .../media/mediatek,mt8195-jpegdec.yaml        | 160 ++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml:98:5: [warning] wrong indentation: expected 2 but found 4 (indentation)
./Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml:102:9: [error] syntax error: expected <block end>, but found '<scalar>' (syntax)
./Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml:113:17: [warning] wrong indentation: expected 0 but found 16 (indentation)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.example.dts'
Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml:102:9: did not find expected key
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml:102:9: did not find expected key
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml: ignoring, error parsing file
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

