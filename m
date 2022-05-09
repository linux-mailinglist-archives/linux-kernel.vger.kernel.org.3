Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE21851FCA0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiEIMZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiEIMY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:24:56 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AF92550AC;
        Mon,  9 May 2022 05:21:02 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id y14-20020a9d460e000000b00605ee347da1so9957013ote.8;
        Mon, 09 May 2022 05:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=CL6w1tqa1qD4GwVR1BmE4sf7WG++85dECQ4XHoV82pM=;
        b=goRrz6r9GxEFzoewYlPVyyMqlIbXoYQf+5m9tQ3KzS8MiYZTJD/yaUNGmAMRNrXee7
         MJ4PlLz3gX5Xksx5/ZunlGCHowBzV+f+X3kg/Z0+Q24aERnNMsGihy6OYp09xJC3CDZq
         4aor53qbUeJpHYftZrusIgR4N7nqXDCTFOOUoTcz+vLeJh8gTyEbAYx844l5ADglbbuW
         JvMlIdjqCDzqRnxO8MOmkQC9WnFNvg/sRhnwCKXKz0vuy1fwihf3z1LkRssUhKq14nAq
         bU2UUurBXvmVbu3PN47mDduhuignDYLbZzEhldNwI2lX5NP+T8oknk1rFgh4FH23wEr8
         UvuA==
X-Gm-Message-State: AOAM533J3gLzzBatuIRvZUIBwuH2QvnR1OXn/HLAa7CzvPqrV0TDWety
        f57ryoW3K3R/bOPf+SCUWg==
X-Google-Smtp-Source: ABdhPJyYPUCuWnXkqMUn8CSgjlvGDITLJOGE1wCgwYZLeOPJP8mkqU5EfVup2MiR05RSXjZrKUscsQ==
X-Received: by 2002:a9d:f22:0:b0:5c9:5da1:3752 with SMTP id 31-20020a9d0f22000000b005c95da13752mr3718194ott.354.1652098861730;
        Mon, 09 May 2022 05:21:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 52-20020a9d0eb7000000b0060603221241sm4571606otj.17.2022.05.09.05.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 05:21:01 -0700 (PDT)
Received: (nullmailer pid 3576231 invoked by uid 1000);
        Mon, 09 May 2022 12:20:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     airlied@linux.ie, chunkuang.hu@kernel.org, nancy.lin@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        p.zabel@pengutronix.de, jason-jh.lin@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
In-Reply-To: <20220509044302.27878-4-rex-bc.chen@mediatek.com>
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com> <20220509044302.27878-4-rex-bc.chen@mediatek.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: mediatek: add ethdr definition for mt8195
Date:   Mon, 09 May 2022 07:20:58 -0500
Message-Id: <1652098858.568339.3576230.nullmailer@robh.at.kernel.org>
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

On Mon, 09 May 2022 12:43:02 +0800, Rex-BC Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 ETHDR definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,ethdr.yaml      | 191 ++++++++++++++++++
>  1 file changed, 191 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.example.dts:26:18: fatal error: dt-bindings/memory/mt8195-memory-port.h: No such file or directory
   26 |         #include <dt-bindings/memory/mt8195-memory-port.h>
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

