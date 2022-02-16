Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3054B9410
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 23:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbiBPWwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 17:52:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiBPWwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 17:52:11 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF4045AE7;
        Wed, 16 Feb 2022 14:51:59 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id d3so955995ilr.10;
        Wed, 16 Feb 2022 14:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=5LcHm2dtPJOfjjaQ9D+1olObje338uGmX6hVzgLLasI=;
        b=D62Ae7Cox3uxHwnmecdADhqBxU8Bz+Jc2qgcUyS6smPt2vP9tWbUQ8h3qRIatlTCq1
         4E81K+ocdPEeGEb74Tza2NPYsvz4Gt0jC5FsWvZGKAYP2ZCxi963K6eLdR+uLrB7Hfgt
         NXlRAb1BHV1ZA+svV05fx9dsLdLtfdNI7HvD/jznEMaB1IlMUjiGf2KqqWWNjJoiCoCB
         t5/DKGDit4ACYghxd0VUzjLJghN5jIbQzQcOz2tc+ysmhL3nFVJgt1w5Kq87f2I/bJGL
         dAzBJvX4AF2v8r+NoD4mZ0o7NLujErrtOi2GTBodUb/09CTUUz89Es5uyOZIf/lLbVI9
         n4pQ==
X-Gm-Message-State: AOAM532HQmFm6k/Fxhp9KVWD8Qh1akNRcvDUgQlL2VR0X/sfzO3PRKW+
        Z6KImYQQN7/X4Ay09cfgKQ==
X-Google-Smtp-Source: ABdhPJy6uPiOPSuOwS6ElLhTY/GwFNGS8Y3qpFEdr0AOVnyH/N2tTKBDhuctpLRGIKutBi441ThK7Q==
X-Received: by 2002:a92:ca0f:0:b0:2bf:56d4:3aec with SMTP id j15-20020a92ca0f000000b002bf56d43aecmr33197ils.220.1645051918300;
        Wed, 16 Feb 2022 14:51:58 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s16sm793892iow.10.2022.02.16.14.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:51:57 -0800 (PST)
Received: (nullmailer pid 1825837 invoked by uid 1000);
        Wed, 16 Feb 2022 22:51:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     xinlei.lee@mediatek.com
Cc:     linux-arm-kernel@lists.infradead.org, thierry.reding@gmail.com,
        lee.jones@linaro.org, linux-pwm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, jitao.shi@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, allen-kh.cheng@mediatek.com,
        u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org,
        Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
In-Reply-To: <1645003971-16908-2-git-send-email-xinlei.lee@mediatek.com>
References: <1645003971-16908-1-git-send-email-xinlei.lee@mediatek.com> <1645003971-16908-2-git-send-email-xinlei.lee@mediatek.com>
Subject: Re: [v2,1/4] dt-bindings: pwm: Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml format
Date:   Wed, 16 Feb 2022 16:51:53 -0600
Message-Id: <1645051913.078742.1825836.nullmailer@robh.at.kernel.org>
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

On Wed, 16 Feb 2022 17:32:48 +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
> 
> Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml format as suggested by maintainer
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
> ---
>  .../bindings/pwm/mediatek,pwm-disp.yaml       | 71 +++++++++++++++++++
>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt  | 44 ------------
>  2 files changed, 71 insertions(+), 44 deletions(-)
>  create mode 100755 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1593550


pwm@1400a000: compatible:0: 'mediatek,mt7623-disp-pwm' is not one of ['mediatek,mt2701-disp-pwm', 'mediatek,mt6595-disp-pwm', 'mediatek,mt8173-disp-pwm', 'mediatek,mt8183-disp-pwm']
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml
	arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml

pwm@1400a000: compatible: ['mediatek,mt7623-disp-pwm', 'mediatek,mt2701-disp-pwm'] is too long
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml
	arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml

pwm@1400a000: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/mt2701-evb.dt.yaml
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml
	arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml

pwm@1400a000: 'power-domains' is a required property
	arch/arm/boot/dts/mt2701-evb.dt.yaml
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml
	arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml

pwm@1401e000: compatible: ['mediatek,mt8173-disp-pwm', 'mediatek,mt6595-disp-pwm'] is too long
	arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8173-evb.dt.yaml

pwm@1401e000: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8173-evb.dt.yaml

pwm@1401e000: 'power-domains' is a required property
	arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8173-evb.dt.yaml

pwm@1401f000: compatible: ['mediatek,mt8173-disp-pwm', 'mediatek,mt6595-disp-pwm'] is too long
	arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8173-evb.dt.yaml

