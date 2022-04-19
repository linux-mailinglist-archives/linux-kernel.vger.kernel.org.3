Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FCE506C18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352047AbiDSMQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbiDSMP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:15:56 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2656220BCC;
        Tue, 19 Apr 2022 05:12:48 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso5544432otk.10;
        Tue, 19 Apr 2022 05:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=lbM+6TXr7OH0hoMGKTtqkVWI32EFUbBVKJzBhHmX6V4=;
        b=BGZoEx1Om+auEVYWvL2c+vBeGYCzNsfwGdCVPCH6AjFaU8o5u/rmXfQ5IhNpEkxn3S
         0zgLlYxZf+8AFJ9l8ekjASOeuplN0ikj77eKFam4EYrFsxjXcqD+XmK0U4XZI+yBk2pi
         JO6IeHBenxn3E+ZzYioWjjAllwyys1xUkcjF04r1ZFIPk6ExRp+vrsN1p0eheJuik3m6
         Dba2E0ZW0tpQar7uE39cxwb0SYlJ5LHJo6Mba3nZJ8wYEvM2qlgcNGmqy0O3JfSkym9d
         k+VR2mvsGIoL4zSlntwfDSPI5DpifNlnInhSF6w34FcEl/6nL/OWIk48+XVW13mtp3ka
         Kymg==
X-Gm-Message-State: AOAM531ZLHoXKEfMnCD+lrYOs94NahmIpQI64BNBnnPi2rpRYL52+tde
        bSl0UpFBV7cmTgdzShCpuQ==
X-Google-Smtp-Source: ABdhPJyjKDFF8xz6BuFfOGVDFYuw4bwRD11RnRt3Q2XGouMWxrrzMKZfe3UV4QNteW5WL5S5+lphdg==
X-Received: by 2002:a9d:765a:0:b0:605:4910:afb8 with SMTP id o26-20020a9d765a000000b006054910afb8mr4193620otl.1.1650370367445;
        Tue, 19 Apr 2022 05:12:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o17-20020a9d5c11000000b005b2611a13edsm5239752otk.61.2022.04.19.05.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:12:47 -0700 (PDT)
Received: (nullmailer pid 1977868 invoked by uid 1000);
        Tue, 19 Apr 2022 12:12:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     chunkuang.hu@kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com, nancy.lin@mediatek.com,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jason-jh.lin@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com
In-Reply-To: <20220419033237.23405-6-rex-bc.chen@mediatek.com>
References: <20220419033237.23405-1-rex-bc.chen@mediatek.com> <20220419033237.23405-6-rex-bc.chen@mediatek.com>
Subject: Re: [PATCH 5/5] dt-bindings: mediatek: add ethdr definition for mt8195
Date:   Tue, 19 Apr 2022 07:12:43 -0500
Message-Id: <1650370363.563060.1977867.nullmailer@robh.at.kernel.org>
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

On Tue, 19 Apr 2022 11:32:37 +0800, Rex-BC Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 ETHDR definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,ethdr.yaml      | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
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

