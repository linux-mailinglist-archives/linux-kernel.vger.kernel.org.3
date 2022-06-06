Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7428D53E7FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbiFFMyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbiFFMx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:53:59 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E6025282;
        Mon,  6 Jun 2022 05:53:58 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id z197so7902520iof.1;
        Mon, 06 Jun 2022 05:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=5oeNRqJHXQOxmP96SxoUW0sboEGHvZBA+hQSWA/WSEQ=;
        b=Wvj1E21XoGcRBcm3qNxK7jry4xp1mui9rYXglCpTHUw5moFWUYrRpH/XUkC9nTBuyp
         jx9jip9t4B1CDvxB7LBXGpWtqLv05P1zg6yHiuEZlu7kg9gGNZf68PK7oEAPAqOsPmYz
         HDhY2hcbwCXPBZnd611/ho5nvt+YDbvxl8RpkAqkJH78WfCh4oeDFLUS1+OYLxMuyAeo
         bIgdzYkqF/ChghLIzzVtf82ua8j5VZRGC6eUGLQ1E3mnLRduF+YxY0dhfzx02FefQ4tr
         3k6uHMqyWugkA7J7cvFPc3j1w84sjqR67UFkCLcDDZB572F/A0bjOjiz/JnZYjSqrFYn
         6qkg==
X-Gm-Message-State: AOAM533DRsJLyHjHYUjJFbmGBSOVRxkU+E9DPeYKeoberKPLA7bHU3OT
        U+xdg83pIMTEyFW+Gof/MA==
X-Google-Smtp-Source: ABdhPJxl4I6L73YL+CEdCXFSlZqbhylQ9woaXl6Dvpd8oQXNa8pk/9ibMdKb7n3+JHc51K6Q4Iy7KQ==
X-Received: by 2002:a05:6638:389f:b0:331:b463:fbee with SMTP id b31-20020a056638389f00b00331b463fbeemr2681428jav.145.1654520038133;
        Mon, 06 Jun 2022 05:53:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id f2-20020a02b782000000b003315c00e885sm5429712jam.0.2022.06.06.05.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 05:53:57 -0700 (PDT)
Received: (nullmailer pid 534475 invoked by uid 1000);
        Mon, 06 Jun 2022 12:53:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     chunkuang.hu@kernel.org, airlied@linux.ie,
        angelogioacchino.delregno@collabora.com, robh+dt@kernel.org,
        pavel@ucw.cz, Project_Global_Chrome_Upstream_Group@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nancy.lin@mediatek.com,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, ck.hu@mediatek.com
In-Reply-To: <20220606051131.14182-4-rex-bc.chen@mediatek.com>
References: <20220606051131.14182-1-rex-bc.chen@mediatek.com> <20220606051131.14182-4-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v4 3/3] dt-bindings: mediatek: add ethdr definition for mt8195
Date:   Mon, 06 Jun 2022 07:53:53 -0500
Message-Id: <1654520033.535645.534474.nullmailer@robh.at.kernel.org>
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

On Mon, 06 Jun 2022 13:11:31 +0800, Bo-Chen Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 ETHDR definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.example.dtb:0:0: /example-0/soc/hdr-engine@1c114000: failed to match any schema with compatible: ['mediatek,mt8195-disp-ethdr']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

