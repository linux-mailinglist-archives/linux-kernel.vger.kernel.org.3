Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66DC5391BC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344705AbiEaNVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344699AbiEaNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:21:29 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B355B97295;
        Tue, 31 May 2022 06:21:27 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id r206so10177809oib.8;
        Tue, 31 May 2022 06:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sjiY+V80OL2DiZ6A4EsGgW9fJIH8AO134dDg8U/4y24=;
        b=GQqS4YzL0CcrjWio8g1620mtdtIoIFhVjGmYTjOmnL7S20z6Uh/9AnEqD4WKXuDZZc
         HSgpZhl70zIDubCokzfPjFmP+nEpjo7msu1sKYn58nH/7U+9ZmVRWOEJ7ughOagON/Vc
         JW9G7oQK490sIscHOtp//QtsaxCIUwdZWLeY45E717pQqV75WcmW89SoMZYdRglPgDvH
         mdqL6t8yyk0zrfaHnERuuFEBndWjiLbvWR+EeQu9E3pXLP1c+OhkgAzI4nIfGRR5JNhE
         VIakFRjzfDoeM+hZxOIOxlIdW9qjWiH01RdR4bsU9RGumc+FnPhKcKyPlUP6JxyCRXGt
         pCeg==
X-Gm-Message-State: AOAM533Jl+2o86Ast5GkZ/xUWzKrJRIafJtRcokypeg6vANmWFIBRiAv
        aX4F+jcIj6+bMQk+nrIZDQ==
X-Google-Smtp-Source: ABdhPJyl1Zml7tK5z8UzPYsy0IRPoHHsY9ZbD0LO+NEm3SnMP5YpNvNvBFYMbygVSD+kwDaZAn8DAw==
X-Received: by 2002:a05:6808:1510:b0:32a:ef6a:99b with SMTP id u16-20020a056808151000b0032aef6a099bmr12444054oiw.120.1654003286440;
        Tue, 31 May 2022 06:21:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t6-20020a056870f20600b000e90544b79fsm5563380oao.41.2022.05.31.06.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:21:26 -0700 (PDT)
Received: (nullmailer pid 1610155 invoked by uid 1000);
        Tue, 31 May 2022 13:21:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        chunkuang.hu@kernel.org, devicetree@vger.kernel.org,
        jitao.shi@mediatek.com, ck.hu@mediatek.com, p.zabel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, daniel@ffwll.ch,
        robh+dt@kernel.org
In-Reply-To: <20220530201436.902505-1-fparent@baylibre.com>
References: <20220530201436.902505-1-fparent@baylibre.com>
Subject: Re: [PATCH 1/7] dt-bindings: display: mediatek: dpi: add power-domains property
Date:   Tue, 31 May 2022 08:21:25 -0500
Message-Id: <1654003285.268526.1610147.nullmailer@robh.at.kernel.org>
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

On Mon, 30 May 2022 22:14:30 +0200, Fabien Parent wrote:
> DPI is part of the display / multimedia block in MediaTek SoCs, and
> always have a power-domain (at least in the upstream device-trees).
> Add the power-domains property to the binding documentation.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml  | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.example.dts:29.35-36 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.example.dtb] Error 1
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

