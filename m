Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7FD4E9707
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbiC1MxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242635AbiC1Mwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:52:50 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF023ED3E;
        Mon, 28 Mar 2022 05:51:08 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-de3ca1efbaso15056127fac.9;
        Mon, 28 Mar 2022 05:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=YKxyUK+Nou4xViHDx8TkfPYtGoA/VwvXE7HQXU1aq8I=;
        b=uGEGFy03xxAvRqNyUMlVHsjmP42NeryTXBBNTGQkGysZ49e3LGGf1JVYFSMvuQ/wne
         j6K5VrJdfNxPlsnTMn0EAroBTRQki8VXBly3HGnKKgFx4ACvuXvWrnAKtLih+MXFPxPY
         +mKGoEWgrz416l/CSbZsILZQqNX1mAhengWe8PTScUeaeC2xYHqdElwVNrPX0mWKlbIy
         uccPJbrzEvWrY3RkpRMHj9uF7Van2R99kJsYsiI5S0Po6f4FEbHvfLwUbWCmB8cwjAq3
         nLDg8LAbrUO/EnBgg/0A6iTjLi8+YMLhWgCschGaByfLCd2T+8Jraido+gNMbWZfysuh
         cg8w==
X-Gm-Message-State: AOAM530uv5A6V6vymiQyeDONB/3stKkMy74hILXIfCMIquyrgpIWNUJO
        qMDXxqCqKInBJA5wJwUnVPoQbQSVQQ==
X-Google-Smtp-Source: ABdhPJx44lE4vp2aYCeZ7I/lyjmousbKuU1sEX5HIWJFpKqkaVPGdwLqNEmBm4TX4iixQSE+3S145A==
X-Received: by 2002:a05:6871:694:b0:dd:a43e:fca4 with SMTP id l20-20020a056871069400b000dda43efca4mr15486919oao.77.1648471867780;
        Mon, 28 Mar 2022 05:51:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y67-20020a4a4546000000b0032476e1cb40sm6811033ooa.25.2022.03.28.05.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 05:51:07 -0700 (PDT)
Received: (nullmailer pid 2153569 invoked by uid 1000);
        Mon, 28 Mar 2022 12:51:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     mripard@kernel.org, airlied@linux.ie, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, chunfeng.yun@mediatek.com,
        krzk+dt@kernel.org, linux-phy@lists.infradead.org,
        matthias.bgg@gmail.com, chunkuang.hu@kernel.org,
        jitao.shi@mediatek.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, kishon@ti.com,
        linux-fbdev@vger.kernel.org, daniel@ffwll.ch,
        angelogioacchino.delregno@collabora.com,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        p.zabel@pengutronix.de, linux-mediatek@lists.infradead.org,
        deller@gmx.de, linux-arm-kernel@lists.infradead.org,
        markyacoub@google.com, ck.hu@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20220327223927.20848-3-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com> <20220327223927.20848-3-granquet@baylibre.com>
Subject: Re: [PATCH v9 02/22] dt-bindings: mediatek,dp: Add Display Port binding
Date:   Mon, 28 Mar 2022 07:51:05 -0500
Message-Id: <1648471865.772251.2153568.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 00:39:07 +0200, Guillaume Ranquet wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This controller is present on several mediatek hardware. Currently
> mt8195 and mt8395 have this controller without a functional difference,
> so only one compatible field is added.
> 
> The controller can have two forms, as a normal display port and as an
> embedded display port.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  .../display/mediatek/mediatek,dp.yaml         | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dts:24:18: fatal error: dt-bindings/power/mt8195-power.h: No such file or directory
   24 |         #include <dt-bindings/power/mt8195-power.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1609955

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

