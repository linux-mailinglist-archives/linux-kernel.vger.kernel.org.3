Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19EA5119A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiD0N52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiD0N50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:57:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE6B3C487;
        Wed, 27 Apr 2022 06:54:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 6F40D1F44800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651067650;
        bh=bti1EdzC6WGQOpy3EhTaJntgvmOLWjzLid7YZh3R18U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPMe9lhK77QoJalyS6cqCntKPDuSJtht+9pXHYF8jNb+Fm/jrQxt11+7ECe+kAVws
         7Q1djtafBwzDzuCu3Eby+gbF483OhYDVojG/lc5WwI8MRcXnN7HdXR8zQ6M9pDlypN
         na7Eu20Wwjpv/4P0GKb1tr58G4QTnzp4fbBjbq+d5IqmNp6RglbdzEEfcpmOFV5GiE
         trbvQnIiu8X82hAn6rayZwhczfMCPtaQxtfroSeu64fYXfKSySrR8Xp0icofv/Ago7
         8czX7fmeFd8iisdowAVFzbbMimCf3OeOJ5rWf1KoyqbK4c/yyGwv432ulrEMgp6J2b
         hOeWo0e123UZQ==
Date:   Wed, 27 Apr 2022 09:54:04 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 01/10] arm64: dts: mediatek: Introduce MT8192-based
 Asurada board family
Message-ID: <20220427135404.a4xxp3rvvzrgqfqs@notapiano>
References: <20220316151327.564214-1-nfraprado@collabora.com>
 <20220316151327.564214-2-nfraprado@collabora.com>
 <CAGXv+5Gv2pjPXynz6HCdgux+giPDC5qRk+KW1aFduVz82rM=+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5Gv2pjPXynz6HCdgux+giPDC5qRk+KW1aFduVz82rM=+g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

thank you for the review.

On Wed, Apr 27, 2022 at 04:43:50PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Wed, Mar 16, 2022 at 11:17 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > Introduce the MT8192 Asurada Chromebook platform, including the Asurada
> > Spherion and Asurada Hayato boards.
> >
> > This is enough configuration to get serial output working on Spherion
> > and Hayato.
> >
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >
> > ---
> >
> >  arch/arm64/boot/dts/mediatek/Makefile         |  2 ++
> >  .../dts/mediatek/mt8192-asurada-hayato-r1.dts | 11 ++++++++
> >  .../mediatek/mt8192-asurada-spherion-r0.dts   | 13 ++++++++++
> >  .../boot/dts/mediatek/mt8192-asurada.dtsi     | 26 +++++++++++++++++++
> >  4 files changed, 52 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> > index 8c1e18032f9f..034cba17276b 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -37,5 +37,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> > new file mode 100644
> > index 000000000000..e18e14b13d61
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> > @@ -0,0 +1,11 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright 2020 Google LLC
> > + */
> > +/dts-v1/;
> > +#include "mt8192-asurada.dtsi"
> > +
> > +/ {
> > +       model = "MediaTek Hayato rev1";
> 
> I think this should be "Google Hayato ...", and the one in spherion should
> read "Google Spherion" as well?
> 
> These are project code names used in Google. Both devices use the common
> "Asurada" hardware design, also done by Google.

These were the names downstream so I didn't want to change them. But I agree
with you, and will take this as authorization do change them so for the next
version.

> 
> > +       compatible = "google,hayato-rev1", "google,hayato", "mediatek,mt8192";
> 
> You should add a patch adding this to the DT binding doc
> Documentation/devicetree/bindings/arm/mediatek.yaml
> 
> Same for Spherion.

Okay.

Thanks,
Nícolas
