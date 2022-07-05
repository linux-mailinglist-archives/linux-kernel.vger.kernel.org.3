Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B8567881
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiGEUge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiGEUgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:36:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231821C12D;
        Tue,  5 Jul 2022 13:36:29 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0AC7B660180F;
        Tue,  5 Jul 2022 21:36:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657053387;
        bh=OrwB8qOVDqFzOmPNBZc6oHWmrOYIVjhvGlY/DI5Fmbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwmHEE/rRolwWUxTzRAtTvFqraneOsrTub3hjYLXaYUxiqQYrpdmBj+MUr4E5kfbV
         elmrfnZhaM09/ZMNfJ3hs+xT3nx9DgjMZPklZIp2l+bJCUJ2iBR2YSiAAcE/FEQcy3
         j0/S0tKcRLHASd1Adsa/qfkAZyPRiuEOzW8WOHP8O1g8vlkew1/E5mIIpYPdWgCyKp
         u7J/UHsDpavuRqlwAg4GOpnBWlVYS5nTT/qen3z3vRnxxtW3BMvvqCbWtPY00On4ka
         sY7J+WcNHBCEltQdD7sc1FWNRFLsHF9WypC9Of9jPxTA8cNr3RM3iznimFj3IyaNMI
         g1d0jZSQ5gQBw==
Date:   Tue, 5 Jul 2022 16:36:21 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: usb: mtk-xhci: Make all clocks
 required
Message-ID: <20220705203621.hunczzwfhiwpcrhy@notapiano>
References: <20220623193702.817996-1-nfraprado@collabora.com>
 <20220623193702.817996-3-nfraprado@collabora.com>
 <93c6b7201533325cf7758637dd194a372f3c00c6.camel@mediatek.com>
 <20220629185546.z6rn7xp3ejpmaupi@notapiano>
 <20220701213702.GA1591697-robh@kernel.org>
 <5f85280ea5fd0d4b445307a13a70c3e3fe552ccf.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f85280ea5fd0d4b445307a13a70c3e3fe552ccf.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 04:24:12PM +0800, Chunfeng Yun wrote:
> On Fri, 2022-07-01 at 15:37 -0600, Rob Herring wrote:
> > On Wed, Jun 29, 2022 at 02:55:46PM -0400, Nícolas F. R. A. Prado
> > wrote:
> > > On Tue, Jun 28, 2022 at 08:57:45AM +0800, Chunfeng Yun wrote:
> > > > Hi Nícolas,
> > > > 
> > > > On Thu, 2022-06-23 at 15:37 -0400, Nícolas F. R. A. Prado wrote:
> > > > > All of the clocks listed in the binding are always wired to the
> > > > > XHCI
> > > > > controller hardware blocks on all SoCs. The reason some clocks
> > > > > were
> > > > > made
> > > > > optional in the binding was to account for the fact that
> > > > > depending on
> > > > > the SoC, some of the clocks might be fixed (ie not controlled
> > > > > by
> > > > > software).
> > > > > 
> > > > > Given that the devicetree should represent the hardware, make
> > > > > all
> > > > > clocks
> > > > > required in the binding. Subsequent patches will make the DTS
> > > > > changes
> > > > > to
> > > > > specify fixed-clocks for the clocks that aren't controllable.
> > > > > 
> > > > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > > > 
> > > > > ---
> > > > > 
> > > > > Changes in v2:
> > > > > - Undid clock list changes that allowed middle clocks to be
> > > > > missing
> > > > > from
> > > > >   v1 and made all clocks required instead
> > > > > - Rewrote commit message and title
> > > > > 
> > > > >  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml |
> > > > > 4 +
> > > > > ---
> > > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > xhci.yaml
> > > > > index 63cbc2b62d18..1444d18ef9bc 100644
> > > > > --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > xhci.yaml
> > > > > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > xhci.yaml
> > > > > @@ -67,7 +67,6 @@ properties:
> > > > >      maxItems: 1
> > > > >  
> > > > >    clocks:
> > > > > -    minItems: 1
> > > > >      items:
> > > > >        - description: Controller clock used by normal mode
> > > > >        - description: Reference clock used by low power mode
> > > > > etc
> > > > > @@ -76,9 +75,8 @@ properties:
> > > > >        - description: controller clock
> > > > >  
> > > > >    clock-names:
> > > > > -    minItems: 1
> > > > >      items:
> > > > > -      - const: sys_ck  # required, the following ones are
> > > > > optional
> > > > > +      - const: sys_ck
> > > > >        - const: ref_ck
> > > > >        - const: mcu_ck
> > > > >        - const: dma_ck
> > > > 
> > > > This patch causes more check warning, I prefer to leave dt-
> > > > bindings
> > > > unchanged, but just fix mt8195's dts warning instead, thanks a
> > > > lot
> > > 
> > > Hi Chunfeng,
> > > 
> > > the warnings reported by Rob's bot only happen if patches 3 and 4
> > > aren't applied
> > > to adapt the devicetrees. They are ABI breaking changes, but I
> > > understood this
> > > as the desired solution from the discussion we had with Krzysztof
> > > on v1 [1].
> > 
> > The warnings have nothing to do with patches 3 and 4 as those are
> > for 
> > dts files. It's examples in bindings that are the problem.

Sorry, you're right, I misread the errors.

> Yes, I mean almost all existing dts supporting mtk-xhci will also cause
> similar warnings, as changes in patches 3, 4;
> 
> It seems less flexible to make all clock required, not only changes all
> existing ones but also need more changes if additional clock is added.

Yes, that's a valid concern. I must have misunderstood the discussion in v1
then.

So, I'm going to send a revert for this change and send a new patch adding fixed
clocks on the dts for just mt8192 and mt8195 to fix the dtbs_check warnings.
Does that sound good?

Thanks,
Nícolas
