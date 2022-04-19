Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85C5506C10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352020AbiDSMQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352113AbiDSMP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:15:56 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE077205DC;
        Tue, 19 Apr 2022 05:12:46 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e5c42b6e31so7259998fac.12;
        Tue, 19 Apr 2022 05:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=0569YfmtjdqJ+2hyukw09AFuvfwmKEbwEGbKGweOpvI=;
        b=mU+GuPAI/15nGvzXSSBRrx85MX8MX49a39LXE31Muk7yi89zlEy5E+vnEf+eR+vczy
         dVNbtM07pnfWYH8mbwRLA/+WO0ntPLUrN10Syu9ZDnzrR1rCYbzV7DeQL5bfsasvfqZS
         5K3n1K1k1+WiPzgwgwRnl9m+ttCY9xux+i2y1edgV5lR9CsOdmlItRLxY+tDopdjVjAy
         mYeQx/GKNRbY3e3Cal2b4HN4pUSkSzBpXEcN6pot87bajBzCBxHw1ja6Yg2bHZJf1ZZ5
         SUApIaowHrfVkYj1ZU1vRLh5Rb+91+hu14sR5u+FgWNGQzP0/gYmrxR7Y4h2Tq9/Migr
         9Hqg==
X-Gm-Message-State: AOAM533QpWOLA4hfKhers+70PevwGGXqMgAJv1qFFM2q9BSdAEbphf9D
        Xh756HpbjK0MlT6/2LuWAQ==
X-Google-Smtp-Source: ABdhPJx8LiBK0K4XkLwgCXtqriBYjWmQ7YGCbPJHV61zXAKBySQssJNDd/Khvosb+uQCNv6rnPT75g==
X-Received: by 2002:a05:6870:9611:b0:df:200f:a6dd with SMTP id d17-20020a056870961100b000df200fa6ddmr6047417oaq.299.1650370366071;
        Tue, 19 Apr 2022 05:12:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g25-20020a544f99000000b002da70c710b8sm5082428oiy.54.2022.04.19.05.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:12:45 -0700 (PDT)
Received: (nullmailer pid 1977866 invoked by uid 1000);
        Tue, 19 Apr 2022 12:12:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     krzysztof.kozlowski+dt@linaro.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        nancy.lin@mediatek.com, angelogioacchino.delregno@collabora.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, jason-jh.lin@mediatek.com,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org
In-Reply-To: <20220419033237.23405-4-rex-bc.chen@mediatek.com>
References: <20220419033237.23405-1-rex-bc.chen@mediatek.com> <20220419033237.23405-4-rex-bc.chen@mediatek.com>
Subject: Re: [PATCH 3/5] dt-bindings: mediatek: add vdosys1 RDMA definition for mt8195
Date:   Tue, 19 Apr 2022 07:12:43 -0500
Message-Id: <1650370363.539386.1977865.nullmailer@robh.at.kernel.org>
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

On Tue, 19 Apr 2022 11:32:35 +0800, Rex-BC Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 RDMA definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,mdp-rdma.yaml   | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/display/mediatek/mediatek,mdp-rdma.yaml#
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

