Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AE64C370C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiBXUuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiBXUt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:49:59 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317471C8855;
        Thu, 24 Feb 2022 12:49:29 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id ay7so4891051oib.8;
        Thu, 24 Feb 2022 12:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ad4J5+9RdUyS+Z6nJ1tSy2gtAoNHPdi9y1eK0/M4fGc=;
        b=hueGmrjpnWW93evKE/Xa7TQSfDXpsAf2Vc/JrweL/Ixuei02ExugflrTQ/5IsUz5D9
         72aUFDAkDUkGcRREC+AuXS7nAfbdNnuVrjbxbXK2+IlbSeW6X3338ZOj+OW5OrSdWC+E
         IjhUAIHdyyDxUx0LzZWsQ74lBAe6WWTGOgkD4zSDXrXXBbxWY8CD1gTXbqBfVfongafY
         bTr0jA2V2mc2BSKwGpJNDiKqDoEHGQ15nJpiZxxyW7uOaGokOU5kcXmDPha/s7Hx7pLU
         +Q5UkK9C4I7lvA7HmWDvZW2qelFQ5jCnPAiOUW7vsB+zuH3YZtg7klwDzZ/VVVoy60OO
         vnag==
X-Gm-Message-State: AOAM533x4NGEFwmeJXdKH92P9m8TIwilQDtloPHq1LSMEP0ERwXcF29Z
        B4tk7ePx9d4lqXgdr6DTCg==
X-Google-Smtp-Source: ABdhPJyNOaa8f2/SMomPS8HIDN+rN46ER7uWdTBb9aUTc5PuznLNa1TL+sk5tH4Dr49CjtvFltA65w==
X-Received: by 2002:a05:6808:2213:b0:2d4:f6a4:cc99 with SMTP id bd19-20020a056808221300b002d4f6a4cc99mr2401266oib.195.1645735768488;
        Thu, 24 Feb 2022 12:49:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i11-20020a056830402b00b005af1411565bsm174855ots.78.2022.02.24.12.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:49:27 -0800 (PST)
Received: (nullmailer pid 3560757 invoked by uid 1000);
        Thu, 24 Feb 2022 20:49:26 -0000
Date:   Thu, 24 Feb 2022 14:49:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     "xinlei.lee" <xinlei.lee@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org, thierry.reding@gmail.com,
        lee.jones@linaro.org, linux-pwm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, allen-kh.cheng@mediatek.com,
        u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org,
        Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
Subject: Re: [v2,1/4] dt-bindings: pwm: Convert pwm-mtk-disp.txt to
 mediatek,pwm-disp.yaml format
Message-ID: <YhfvVmtX9hj6E6KQ@robh.at.kernel.org>
References: <1645003971-16908-1-git-send-email-xinlei.lee@mediatek.com>
 <1645003971-16908-2-git-send-email-xinlei.lee@mediatek.com>
 <1645051913.078742.1825836.nullmailer@robh.at.kernel.org>
 <0f8c014c077d0fc75c8552e457482d9daf68d73b.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f8c014c077d0fc75c8552e457482d9daf68d73b.camel@mediatek.com>
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

On Thu, Feb 17, 2022 at 08:35:58PM +0800, xinlei.lee wrote:
> On Wed, 2022-02-16 at 16:51 -0600, Rob Herring wrote:
> > On Wed, 16 Feb 2022 17:32:48 +0800, xinlei.lee@mediatek.com wrote:
> > > From: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
> > > 
> > > Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml format as
> > > suggested by maintainer
> > > 
> > > Signed-off-by: Xinlei Lee <
> > > xinlei.lee@mediatek.corp-partner.google.com>
> > > ---
> > >  .../bindings/pwm/mediatek,pwm-disp.yaml       | 71
> > > +++++++++++++++++++
> > >  .../devicetree/bindings/pwm/pwm-mtk-disp.txt  | 44 ------------
> > >  2 files changed, 71 insertions(+), 44 deletions(-)
> > >  create mode 100755
> > > Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-
> > > disp.txt
> > > 
> > 
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> > 
> > Note that it is not yet a requirement to have 0 warnings for
> > dtbs_check.
> > This will change in the future.
> > 
> > Full log is available here: 
> > https://patchwork.ozlabs.org/patch/1593550
> > 
> > 
> > pwm@1400a000: compatible:0: 'mediatek,mt7623-disp-pwm' is not one of
> > ['mediatek,mt2701-disp-pwm', 'mediatek,mt6595-disp-pwm',
> > 'mediatek,mt8173-disp-pwm', 'mediatek,mt8183-disp-pwm']
> > 	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml
> > 	arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml
> > 
> > pwm@1400a000: compatible: ['mediatek,mt7623-disp-pwm',
> > 'mediatek,mt2701-disp-pwm'] is too long
> > 	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml
> > 	arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml
> > 
> > pwm@1400a000: 'oneOf' conditional failed, one must be fixed:
> > 	arch/arm/boot/dts/mt2701-evb.dt.yaml
> > 	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml
> > 	arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml
> > 
> > pwm@1400a000: 'power-domains' is a required property
> > 	arch/arm/boot/dts/mt2701-evb.dt.yaml
> > 	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml
> > 	arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml
> > 
> > pwm@1401e000: compatible: ['mediatek,mt8173-disp-pwm',
> > 'mediatek,mt6595-disp-pwm'] is too long
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8173-evb.dt.yaml
> > 
> > pwm@1401e000: 'oneOf' conditional failed, one must be fixed:
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8173-evb.dt.yaml
> > 
> > pwm@1401e000: 'power-domains' is a required property
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8173-evb.dt.yaml
> > 
> > pwm@1401f000: compatible: ['mediatek,mt8173-disp-pwm',
> > 'mediatek,mt6595-disp-pwm'] is too long
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8173-evb.dt.yaml
> > 
> Hi Rob:
> 
> Thanks for your review. I'm trying to modify the dtbs_check warning you
> mentioned. I would like to ask what cmd I can use to test the modified
> dtbs_check locally.

# Enable building all dtbs
make allmodconfig

make dtbs_check DT_SCHEMA_FILES=path/to/schema.yaml

> Also for WARNING: DT binding docs and includes should be a separate
> patch. I've also made some attempts including splitting the delete .txt
> and create .yaml files into two patches, but the warning doesn't
> resolve. Do you have any suggestions for the results of checkpatch
> ?This will help a lot with the next edition I send out.

Ignore it for conversion patches.

Rob
