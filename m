Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A59856705F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiGEOH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiGEOHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:07:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19992E81;
        Tue,  5 Jul 2022 06:56:18 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AED8166017ED;
        Tue,  5 Jul 2022 14:56:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657029377;
        bh=TrAckFq//mcfArH9T4vThAxiQUoSnKs/JzP+6HRCZCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cWRpW2IoEkwH4IM3aQhOMvzPgqiZk/635M4nKqLmQ1bDU4L/Q9sn8RDFJWYDW0FMY
         Js0EzwlsM0laerEdKwDmOKkIDM/iEHW96bHQ8Mqg5xV07lUWLOqBLd36wHf7t4oXUD
         irDRDjaBo3Vl00X6WZMOFcV9zHvya5NJgq2FiKFfExXv4TNL5QQyGahFi644Jv7W8n
         3PBnpmoDr+aWvowlQvNb43tIPdS53p17Zpt4q8nyrzsUdPbkUapqHJaYTrwHNf4v3I
         4iKibbgULKsZ7OB2XOosakrxlmQXmpx420097rKLDNfC4DlRB82s1s3MBnDnbmxGrh
         Hwf9mubsPsFaw==
Date:   Tue, 5 Jul 2022 09:56:11 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, Maxim Kutnij <gtk3@inbox.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 00/19] Introduce support for MediaTek MT8192 Google
 Chromebooks
Message-ID: <20220705135611.jlfltaormhcpuutc@notapiano>
References: <20220629155956.1138955-1-nfraprado@collabora.com>
 <CAGXv+5Epmo1=DZvoFkqj57hiO8nim=cuP1v3i9b2diZwqBe3Mw@mail.gmail.com>
 <20220701150145.2myyk2o3vxydyhql@notapiano>
 <CAGXv+5FsTNKgWG75eSKt4ngnhmSekWNT+oS1ke+P4tazHDdnzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5FsTNKgWG75eSKt4ngnhmSekWNT+oS1ke+P4tazHDdnzQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:03:08PM +0800, Chen-Yu Tsai wrote:
> On Fri, Jul 1, 2022 at 11:01 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > On Fri, Jul 01, 2022 at 08:44:53PM +0800, Chen-Yu Tsai wrote:
> > > On Thu, Jun 30, 2022 at 12:00 AM Nícolas F. R. A. Prado
> > > <nfraprado@collabora.com> wrote:
> > > >
> > > >
> > > > This series introduces Devicetrees for the MT8192-based Asurada platform
> > > > as well as Asurada Spherion and Asurada Hayato boards.
> > > >
> > > > Support for the boards is added to the extent that is currently enabled
> > > > in the mt8192.dtsi, and using only properties already merged in the
> > > > dt-bindings, as to not add any dependencies to this series.
> > > >
> > > > This series was peer-reviewed internally before submission.
> > > >
> > > > Series tested on next-20220629.
> > >
> > > Just FYI I also got the internal display to work after some fixes to
> > > the dtsi [1] and copying the stuff over from the ChromeOS kernel tree.
> > >
> > > It might be harder to enable the external display, given that we don't
> > > have a good way of describing the weird design of using the DP bridge
> > > also as a mux. See [2] for ongoing discussion.
> >
> > Hi ChenYu,
> >
> > I actually have both the internal and external display working on my local
> > branch [1], but the commits there aren't final, and I'm also following the
> > Type-C switch discussion to update my commits whenever the binding is settled
> > on.
> 
> I see. I think the internal display part is more or less final. It should
> be worth including it, as it is a fairly visible indication that things
> are working.

Yeah, it is final, but not all of the display-related nodes in mt8192.dtsi have
been merged yet [1] and I didn't want to introduce dependencies to the series.

If that series gets merged before this one, I could add the display to this
series as well, but I'm just worried that by introducing new commits with almost
every new series version, this series might never get reviewed and merged, and
this series is pretty big already. So I'd prefer to leave the display for a
following series.

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20220701090547.21429-1-allen-kh.cheng@mediatek.com

> 
> ChenYu
> 
> > I noticed the lack of the mandatory display aliases in the mt8192 series but
> > somehow missed mentioning that in the review, so thanks for adding that.
> >
> > Thanks,
> > Nícolas
> >
> > [1] https://gitlab.collabora.com/nfraprado/linux/-/commits/mt8192-asurada
> >
> > >
> > > ChenYu
> > >
> > > [1] https://lore.kernel.org/linux-mediatek/CAGXv+5F_Gi_=vV1NSk0AGRVYCa3Q8+gBaE+nv3OJ1AKe2voOwg@mail.gmail.com/
> > > [2] https://lore.kernel.org/dri-devel/20220622173605.1168416-1-pmalani@chromium.org/
> > >
> > > > v3: https://lore.kernel.org/all/20220512205602.158273-1-nfraprado@collabora.com/
> > > > v2: https://lore.kernel.org/all/20220505194550.3094656-1-nfraprado@collabora.com/
> > > > v1: https://lore.kernel.org/all/20220316151327.564214-1-nfraprado@collabora.com/
> > > >
> > > > Changes in v4:
> > > > - Added patches 17-19 enabling MMC, SCP and SPI NOR flash
> > > > - Switched mediatek,drive-strength-adv for drive-strength-microamp
> > > > - Switched mediatek,pull-up-adv for bias-pull-up
> > > > - Updated Vgpu minimum voltage to appropriate value
> > > >
> > > > Changes in v3:
> > > > - Renamed regulator nodes to be generic
> > > > - Fixed keyboard layout for Hayato
> > > >
> > > > Changes in v2:
> > > > - Added patches 1-2 for Mediatek board dt-bindings
> > > > - Added patches 13-16 enabling hardware for Asurada that has since been
> > > >   enabled on mt8192.dtsi
> > > >
> > > > Nícolas F. R. A. Prado (19):
> > > >   dt-bindings: arm64: dts: mediatek: Add mt8192-asurada-spherion
> > > >   dt-bindings: arm64: dts: mediatek: Add mt8192-asurada-hayato
> > > >   arm64: dts: mediatek: Introduce MT8192-based Asurada board family
> > > >   arm64: dts: mediatek: asurada: Document GPIO names
> > > >   arm64: dts: mediatek: asurada: Add system-wide power supplies
> > > >   arm64: dts: mediatek: asurada: Enable and configure I2C and SPI busses
> > > >   arm64: dts: mediatek: asurada: Add ChromeOS EC
> > > >   arm64: dts: mediatek: asurada: Add keyboard mapping for the top row
> > > >   arm64: dts: mediatek: asurada: Add Cr50 TPM
> > > >   arm64: dts: mediatek: asurada: Add Elan eKTH3000 I2C trackpad
> > > >   arm64: dts: mediatek: asurada: Add I2C touchscreen
> > > >   arm64: dts: mediatek: spherion: Add keyboard backlight
> > > >   arm64: dts: mediatek: asurada: Enable XHCI
> > > >   arm64: dts: mediatek: asurada: Enable PCIe and add WiFi
> > > >   arm64: dts: mediatek: asurada: Add MT6359 PMIC
> > > >   arm64: dts: mediatek: asurada: Add SPMI regulators
> > > >   arm64: dts: mediatek: asurada: Enable MMC
> > > >   arm64: dts: mediatek: asurada: Enable SCP
> > > >   arm64: dts: mediatek: asurada: Add SPI NOR flash memory
> > > >
> > > >  .../devicetree/bindings/arm/mediatek.yaml     |  13 +
> > > >  arch/arm64/boot/dts/mediatek/Makefile         |   2 +
> > > >  .../dts/mediatek/mt8192-asurada-hayato-r1.dts |  47 +
> > > >  .../mediatek/mt8192-asurada-spherion-r0.dts   |  62 ++
> > > >  .../boot/dts/mediatek/mt8192-asurada.dtsi     | 959 ++++++++++++++++++
> > > >  5 files changed, 1083 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> > > >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
> > > >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > > >
> > > > --
> > > > 2.36.1
> > > >
