Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31351FCA6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiEIMZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiEIMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:24:58 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDED2555A8;
        Mon,  9 May 2022 05:21:04 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id k25-20020a056830169900b00605f215e55dso9967759otr.13;
        Mon, 09 May 2022 05:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sv2cI5/IIfv5TA9/D1vZuscnav6gHINQOSxljIH5MXs=;
        b=p/8CkiD6LEAAQPqLNBI2d7HTpuvCZPtmpx0DF5nQok9lBdglM2tM/hFDS31DaN2DTg
         KiztTXc8s5dLA8afMmYJ10phYBjCh3tTdTczLbWvqZdzRIhV/Y0SDsDBenGAHWYOGDFf
         Ee5Oqv2DTPZCiN9upPudZMlkg49Y186Q2zzZmQRAJeUiqXSGBk9keps/1hHtpLwinWyx
         3b15IDgURnIDobvdwdd/CyY5UPAf1x0kTMcCteRjgLGSsELKrE030Ei5+DG1RtcUzM7o
         QvKg/8KEsVadnOqxK7He6seRYK4xX/eGJdU/fgwDLsq2CpYS1kALPQz5QV8E5oNE9beT
         0bBw==
X-Gm-Message-State: AOAM533X5Bo7UHwc+M4rJkR1n0FCPvHHtL0APWqmKtPFfdYNYj6LZvdg
        2e7QfLw18Izzau8H641yVw==
X-Google-Smtp-Source: ABdhPJzmgTfUp6EHG/A94h+NBN2R5QfBMhZFGUuuka9lsHg+u9WLwv5BWtw2aG+NwSAp98BLFiz3Zg==
X-Received: by 2002:a9d:74d8:0:b0:606:42dc:5ce3 with SMTP id a24-20020a9d74d8000000b0060642dc5ce3mr5735048otl.303.1652098863902;
        Mon, 09 May 2022 05:21:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 52-20020a9d0eb7000000b0060603221241sm4571643otj.17.2022.05.09.05.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 05:21:03 -0700 (PDT)
Received: (nullmailer pid 3576229 invoked by uid 1000);
        Mon, 09 May 2022 12:20:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     airlied@linux.ie, robh+dt@kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, jason-jh.lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        nancy.lin@mediatek.com, linux-mediatek@lists.infradead.org
In-Reply-To: <20220509044302.27878-2-rex-bc.chen@mediatek.com>
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com> <20220509044302.27878-2-rex-bc.chen@mediatek.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: add vdosys1 RDMA definition for mt8195
Date:   Mon, 09 May 2022 07:20:58 -0500
Message-Id: <1652098858.557372.3576228.nullmailer@robh.at.kernel.org>
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

On Mon, 09 May 2022 12:43:00 +0800, Rex-BC Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 RDMA definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,mdp-rdma.yaml   | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.example.dts:27:18: fatal error: dt-bindings/memory/mt8195-memory-port.h: No such file or directory
   27 |         #include <dt-bindings/memory/mt8195-memory-port.h>
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

