Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD65571D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiGLOx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiGLOxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:53:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFA51E3E2;
        Tue, 12 Jul 2022 07:53:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E8B7CE1BC4;
        Tue, 12 Jul 2022 14:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4146BC3411C;
        Tue, 12 Jul 2022 14:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657637627;
        bh=n45oRxiLa8uA73AZc8PMhR9y8GqcCR0OM06oXnt/lqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ds0EWAWiE7Z4Ao3mDLO8e4iH8B5L5mgM9txDADk3ICwFkCZyx4xVJbwpI1h8ZyZVZ
         DCP8IpvJczgBkPmzT4vnOr/KXWAVZ1b3TqBysCofZ3uRkAjotNUBzS4uC3D6eqDIUf
         WEb69DT1ta/7dT676k/fQVwlCdLCE5JioNFLMm89EeDV+bIVgfyxVLWnIaASBLpdFP
         xo7X+yDvUv7Q9b+gkkdDSbBTIJZ2MoBLlTm8NRBNVkqxOasIx11zOUpfSvH1Eker9Z
         C8cskIdfA3GRGzk8oXhiN7zv/rf6qhdUmhq3ujZBrc///Ixnoq+HAN0igSzNUp0aBp
         iMt/mM4jvdlEA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBHGm-0002BL-Sh; Tue, 12 Jul 2022 16:53:49 +0200
Date:   Tue, 12 Jul 2022 16:53:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Add lost ranges for timer
Message-ID: <Ys2K/BH/kAeTBz5t@hovoldconsulting.com>
References: <20220707160858.3178771-1-bjorn.andersson@linaro.org>
 <Ysvlqw/+eMk5XLRY@hovoldconsulting.com>
 <YszcSgnSrbsncw0J@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YszcSgnSrbsncw0J@ripper>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 07:28:26PM -0700, Bjorn Andersson wrote:
> On Mon 11 Jul 01:56 PDT 2022, Johan Hovold wrote:
> 
> > On Thu, Jul 07, 2022 at 09:08:58AM -0700, Bjorn Andersson wrote:
> > > The timer node needs ranges specified to map the 1-cell children to the
> > > 2-cell address range used in /soc. This addition never made it into the
> > > patch that was posted and merged, so add it now.
> > > 
> > > Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > > index 2bdb42c88311..37a4cd6f85b6 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > > @@ -1667,6 +1667,7 @@ timer@17c20000 {
> > >  			reg = <0x0 0x17c20000 0x0 0x1000>;
> > >  			#address-cells = <1>;
> > >  			#size-cells = <1>;
> > > +			ranges = <0 0 0 0x20000000>;
> > 
> > While addressing the current issue, this looks odd to me. Why not use a
> > non-zero parent bus address here instead?
> > 
> 
> I guess we could express the frames relative the timer range, but that
> would imply that anyone porting downstream dts snippets would have to
> translate these addresses - or more likely would end up just copying the
> existing cases.
> 
> > And please use hex notation consistently for the addresses.
> 
> That seems like a reasonable ask, I can fix that up. But on both
> accounts this matches what I merged for all the other platforms in:
> 
> 458ebdbb8e5d ("arm64: dts: qcom: timer should use only 32-bit size")
> 
> 
> So I guess we'll also need to go back and fix up the style of all the
> other platforms - just because we're not allowed to express the frames
> in 64-bits according to the binding...

Would have been easier to just amend the binding. I don't think that
#size-cells = 1 constraint is set in stone as it was added when
converting to DT schema.

I also don't think you need to fixup the hex notation elsewhere, it's
quite inconsistent currently, but no need to make it worse.

But you probably should amend the commit message and mention that this
fixes time keeping. I had recently noticed that something was off
(journals rotating, and erratic cursor blinking) but didn't realise that
timers were broken until you posted this.

Johan
