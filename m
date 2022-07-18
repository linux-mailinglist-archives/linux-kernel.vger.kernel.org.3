Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B07577962
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiGRBnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiGRBna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:43:30 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F2F13F4B;
        Sun, 17 Jul 2022 18:43:29 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id e69so723704iof.5;
        Sun, 17 Jul 2022 18:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Ai6PAExtnvwmvUQ1ZBj8kPBo45sFiw2ydYbB8VGvDYI=;
        b=xaBVOyzJcRfQPqRR6UpGcsuRW5QydGYre4P5X/tcN4cm7+Rm9dX+lesTkZtDxMOuUf
         fdJ5w47stDkiznJn5AEjSNPHDNYHmDDChckdA5ub9LPd1YRY+g7olZTr9thBDLlG00+h
         MJ9N68i382EtuG13ab7AcVk9cn5VKErbr1HneiWbaa+KT64lxhWg+Ik2q0ZuEY8VUqYq
         lN8lKTuBORPws/FkwIecv1De7Lp2DuU7g2bDP6VX5kr3A4A7Yf36qlKpNAdoz/IZod5q
         pkxh7E7xKUZXvC/zqEHOFi5d02u2/7vpTwSrpYrfCdxGVjgxY6QmKOGEyY97Zp6o0g40
         +9cA==
X-Gm-Message-State: AJIora/ExN8EQq66rWi8S24s++qZitHrXBIsW0mto2eO6c9gxcsZEYAA
        gweFdMkCXnIB6WK5OmIVkg==
X-Google-Smtp-Source: AGRyM1tLIjs7nxXC1NQRkUwRt7fOytxB8Zpe8WQ0YFYZNW0mh8YXnaS8XfnnKx0jdKB9q/EM1AIwzA==
X-Received: by 2002:a05:6638:4685:b0:33f:65bb:3c3c with SMTP id bq5-20020a056638468500b0033f65bb3c3cmr13493423jab.99.1658108608273;
        Sun, 17 Jul 2022 18:43:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f16-20020a05660215d000b0067c05df65aasm1456331iow.15.2022.07.17.18.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 18:43:27 -0700 (PDT)
Received: (nullmailer pid 1667785 invoked by uid 1000);
        Mon, 18 Jul 2022 01:43:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Tomasz Figa <tfiga@chromium.org>, wenst@chromium.org,
        devicetree@vger.kernel.org, Tzung-Bi Shih <tzungbi@chromium.org>,
        kyrie wu <kyrie.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, maoguang.meng@mediatek.com,
        xia.jiang@mediatek.com, srv_heupstream@mediatek.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com,
        Rob Herring <robh+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        nicolas.dufresne@collabora.com
In-Reply-To: <20220716093435.29796-2-irui.wang@mediatek.com>
References: <20220716093435.29796-1-irui.wang@mediatek.com> <20220716093435.29796-2-irui.wang@mediatek.com>
Subject: Re: [V11,1/7] dt-bindings: mediatek: Add mediatek, mt8195-jpgenc compatible
Date:   Sun, 17 Jul 2022 19:43:21 -0600
Message-Id: <1658108601.900307.1667784.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2022 17:34:29 +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgenc compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> 
> ---
>  .../media/mediatek,mt8195-jpegenc.yaml        | 139 ++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml:98:5: [warning] wrong indentation: expected 2 but found 4 (indentation)
./Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml:102:9: [error] syntax error: expected <block end>, but found '<scalar>' (syntax)
./Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml:111:17: [warning] wrong indentation: expected 0 but found 16 (indentation)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.example.dts'
Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml:102:9: did not find expected key
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml:102:9: did not find expected key
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml: ignoring, error parsing file
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

