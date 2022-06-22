Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F89554AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354522AbiFVNWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiFVNWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:22:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0823121F;
        Wed, 22 Jun 2022 06:22:30 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 17BDC66017B3;
        Wed, 22 Jun 2022 14:22:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655904148;
        bh=QGer2+WExG8zvGaah1wIlZ38pfIs0JV+iFqSuscS98w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bg9jN1q4MqLcePbJVH15YQvXfV+TiSmR6IMIqxnXBapnL/C8uo+tx+ruFIXNEVT8M
         M96gdCtX+gsWrui7vwRbxImJHDHcVw8kLrQvX0IuoZLc+1YMRsncEB0CpiQm3cVmwJ
         Ie6dRKu2vyiFEKgnTrSEINfl8iP4UrB8T7vrmBFhbtKUpHumPyNPleoQPfs//nXCcG
         g9kmBIsAHTYZ1IQTmPMzSspPechoh6Sm8KBLSZpIH3YQ65xSuAjaKp5mBide0Pc1CT
         ElNlhLpoF0Fpi4CQo4VQBIqM6iKe9cGz0ox44PNOixqj1Akug37n628Lwh7MSFqAGu
         u27BAThLBZL3w==
Date:   Wed, 22 Jun 2022 09:22:19 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: usb: mtk-xhci: Allow middle optional
 clocks to be missing
Message-ID: <20220622132219.36rvznhip2egujec@notapiano>
References: <20220617222916.2435618-3-nfraprado@collabora.com>
 <8639e64d-c659-7090-2d0a-078fd96cfbd4@linaro.org>
 <bb460aa483cc888ffa36709d9e9c1f2e3be0e000.camel@mediatek.com>
 <bc5458fe-083c-d679-9fcb-95810a290da8@linaro.org>
 <af50210b95d0cd8b2e3103b3d4a9702aeeba9452.camel@mediatek.com>
 <a24c24e6-fdee-df79-fd2f-6a71540bd9b3@linaro.org>
 <20220620155057.a6qilnhm7snzhapa@notapiano>
 <afae6179-3681-f5c6-4615-3228f16f1271@linaro.org>
 <ba6cccfa05aed087d14f5adc6db06496547a5094.camel@mediatek.com>
 <2705069844be7b3152a810e21b9f737a88d0302d.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2705069844be7b3152a810e21b9f737a88d0302d.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 02:10:55PM +0800, Wenbin Mei wrote:
> On Wed, 2022-06-22 at 09:57 +0800, Chunfeng Yun wrote:
> > On Tue, 2022-06-21 at 09:14 +0200, Krzysztof Kozlowski wrote:
> > > On 20/06/2022 17:50, Nícolas F. R. A. Prado wrote:
> > > > On Mon, Jun 20, 2022 at 10:50:57AM +0200, Krzysztof Kozlowski
> > > > wrote:
> > > > > On 20/06/2022 08:59, Chunfeng Yun wrote:
> > > > > > On Sun, 2022-06-19 at 14:05 +0200, Krzysztof Kozlowski wrote:
> > > > > > > On 19/06/2022 09:46, Chunfeng Yun wrote:
> > > > > > > > On Fri, 2022-06-17 at 18:25 -0700, Krzysztof Kozlowski
> > > > > > > > wrote:
> > > > > > > > > On 17/06/2022 15:29, Nícolas F. R. A. Prado wrote:
> > > > > > > > > > The current clock list in the binding doesn't allow
> > > > > > > > > > for
> > > > > > > > > > one of
> > > > > > > > > > the
> > > > > > > > > > optional clocks to be missing and a subsequent clock
> > > > > > > > > > to
> > > > > > > > > > be
> > > > > > > > > > present.
> > > > > > > > > > An
> > > > > > > > > > example where this is an issue is in mt8192.dtsi,
> > > > > > > > > > which
> > > > > > > > > > has
> > > > > > > > > > "sys_ck",
> > > > > > > > > > "ref_ck", "xhci_ck" and would cause dtbs_check
> > > > > > > > > > warnings.
> > > > > > > > > > 
> > > > > > > > > > Change the clock list in a way that allows the middle
> > > > > > > > > > optional
> > > > > > > > > > clocks to
> > > > > > > > > > be missing, while still guaranteeing a fixed order.
> > > > > > > > > > The
> > > > > > > > > > "ref_ck" is
> > > > > > > > > > kept
> > > > > > > > > > as a const even though it is optional for simplicity,
> > > > > > > > > > since it
> > > > > > > > > > is
> > > > > > > > > > present in all current dts files.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Nícolas F. R. A. Prado <
> > > > > > > > > > nfraprado@collabora.com>
> > > > > > > > > > ---
> > > > > > > > > > 
> > > > > > > > > >  .../devicetree/bindings/usb/mediatek,mtk-
> > > > > > > > > > xhci.yaml       | 9
> > > > > > > > > > +++++++--
> > > > > > > > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git
> > > > > > > > > > a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > > > > > > xhci.yaml
> > > > > > > > > > b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > > > > > > xhci.yaml
> > > > > > > > > > index 63cbc2b62d18..99a1b233ec90 100644
> > > > > > > > > > ---
> > > > > > > > > > a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > > > > > > xhci.yaml
> > > > > > > > > > +++
> > > > > > > > > > b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > > > > > > xhci.yaml
> > > > > > > > > > @@ -80,8 +80,13 @@ properties:
> > > > > > > > > >      items:
> > > > > > > > > >        - const: sys_ck  # required, the following
> > > > > > > > > > ones
> > > > > > > > > > are
> > > > > > > > > > optional
> > > > > > > > > >        - const: ref_ck
> > > > > > > > > > -      - const: mcu_ck
> > > > > > > > > > -      - const: dma_ck
> > > > > > > > > > +      - enum:
> > > > > > > > > > +          - mcu_ck
> > > > > > > > > > +          - dma_ck
> > > > > > > > > > +          - xhci_ck
> > > > > > > > > > +      - enum:
> > > > > > > > > > +          - dma_ck
> > > > > > > > > > +          - xhci_ck
> > > > > > > > > >        - const: xhci_ck
> > > > > > > > > 
> > > > > > > > > You allow now almost any order here, including
> > > > > > > > > incorrect
> > > > > > > > > like
> > > > > > > > > sys,ref,xhci,xhci,xhci.
> > > > > > > > > 
> > > > > > > > > The order of clocks has to be fixed and we cannot allow
> > > > > > > > > flexibility.
> > > > > > > > > Are
> > > > > > > > > you sure that these clocks are actually optional (not
> > > > > > > > > wired to
> > > > > > > > > the
> > > > > > > > > device)?
> > > > > > > > 
> > > > > > > > In fact, these optional clocks are fixed, due to no gates
> > > > > > > > are
> > > > > > > > provided,
> > > > > > > > SW can't control them by CCF;
> > > > > > > > In this case, I usually use a fixed clock, or ignore it.
> > > > > > > 
> > > > > > > But in some versions these clocks are controllable or not?
> > > > > > 
> > > > > > Some SoCs are controllable, some ones are not (fixed clock).
> > > > > 
> > > > > Thanks for confirming. Then I would prefer to make these clocks
> > > > > required
> > > > > (not optional) and always provide them - via common clock
> > > > > framework or
> > > > > fixed-clock.
> > > > 
> > > > Hi Krzysztof and Chunfeng,
> > > > 
> > > > thank you both for the feedback.
> > > > 
> > > > Since the solution I proposed in this patch is not acceptable I
> > > > see
> > > > two options:
> > > > 1. Split the clocks in several if blocks matched by compatibles
> > > > 2. Make the clocks required and use fixed-clock nodes for the
> > > > missing clocks in
> > > >    the DT
> > > > 
> > > > My understanding is that 1 is the desirable solution if the clock
> > > > is really
> > > > missing in some hardware variants, while 2 is desirable if all
> > > > hardware variants
> > > > really receive all the clocks, only that on some variants they're
> > > > fixed and not
> > > > controlable by SW.
> > > > 
> > > > From what I'm reading of this discussion it seems that the latter
> > > > is the case
> > > > here and thus we should go for 2. Is this correct?
> > > 
> > > This is how I understood it as well, so correct from my side.
> > 
> > Also right for me.
> > 
> > > 
> > > > 
> > > > Also Chunfeng, do you have information on whether the same is
> > > > true
> > > > for the MMC
> > > > HW block? I recently submitted some changes to that binding [1]
> > > > but
> > > > I followed
> > > > approach 1 there instead. However if all the clocks are present
> > > > in
> > > > the HW level
> > > > there as well it would make more sense for me to change it to
> > > > follow approach 2.
> > 
> > I discussed it with Wenbin, MMC seems a little different with USB,
> > 
> > Hi Wenbin,
> > 
> >    Please give some comments about MMC, thanks
> > 
> Hi Chunfeng,
> 
> As we discussed, the following change is the desirable solution for the
> Mediatek MMC HW.
> 
> https://lists.infradead.org/pipermail/linux-mediatek/2022-June/043691.html

Got it, thank you both. I'll keep that approach for MMC then, and change the one
here for USB.

Thanks,
Nícolas
