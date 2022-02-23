Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C594C0DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiBWH7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiBWH7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:59:18 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BF141FB4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:58:50 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21N7wSIK118950;
        Wed, 23 Feb 2022 01:58:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645603108;
        bh=xeHlKo3olK+DJJaOwQQ411JFoxtohqodC7yeAbrDRYA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YA4EAXoxrMNk350f5P4LdC5iLpmvAuztW/M6SSt5Mc39+qOAEoxeifodLdHgFZ9jI
         D2AUiO0pdIheqNA08jYjFI7ZuUrdMZCosbEBuzATFRqaRESqMQuV6culGn7pR6yvnC
         dBijKK5/V876oKMPcjzBaXD2EmFpG2WswzHZ1eP0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21N7wSbT075191
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 01:58:28 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Feb 2022 01:58:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Feb 2022 01:58:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21N7wQDr052547;
        Wed, 23 Feb 2022 01:58:27 -0600
Date:   Wed, 23 Feb 2022 13:28:26 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Nishanth Menon <nm@ti.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <krzk@kernel.org>,
        <geert+renesas@glider.be>, <marcel.ziswiler@toradex.com>,
        <biju.das.jz@bp.renesas.com>, <vkoul@kernel.org>,
        <enric.balletbo@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] arm64: defconfig: Enable configs for DisplayPort on J721e
Message-ID: <20220223075825.ecqbyhllikh2sscx@uda0490373>
References: <20220222180703.30401-1-r-ravikumar@ti.com>
 <20220222193930.sbc5xlsofhg3amgk@overrun>
 <YhVKSpMOKWzZy9a2@ripper>
 <20220222212642.vwtw7xiz7cck63ea@zombie>
 <YhVgjFWShgc8btJP@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YhVgjFWShgc8btJP@ripper>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:15-20220222, Bjorn Andersson wrote:
> On Tue 22 Feb 13:26 PST 2022, Nishanth Menon wrote:
> 
> > On 12:40-20220222, Bjorn Andersson wrote:
> > > On Tue 22 Feb 11:39 PST 2022, Nishanth Menon wrote:
> > > 
> > > > On 23:37-20220222, Rahul T R wrote:
> > > > > Enable DRM and PHY configs required for supporting
> > > > > DisplayPort on J721e
> > > > > 
> > > > > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > > > > ---
> > > > >  arch/arm64/configs/defconfig | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > > > > index 9f23d7ec1232..b0cb894a392e 100644
> > > > > --- a/arch/arm64/configs/defconfig
> > > > > +++ b/arch/arm64/configs/defconfig
> > > > > @@ -702,6 +702,9 @@ CONFIG_DRM_EXYNOS_DSI=y
> > > > >  CONFIG_DRM_EXYNOS_HDMI=y
> > > > >  CONFIG_DRM_EXYNOS_MIC=y
> > > > >  CONFIG_DRM_ROCKCHIP=m
> > > > > +CONFIG_DRM_TIDSS=m
> > > > > +CONFIG_DRM_DISPLAY_CONNECTOR=m
> > > > > +CONFIG_DRM_CDNS_MHDP8546=m
> > > > 
> > > > Please use savedefconfig to place the changes in the correct location
> > > > 
> > > 
> > > Just to clarify the request, use "make savedefconfig" to generate a
> > > defconfig, then based on that put _only_ the relevant changes in the
> > > commit.
> > 
> > Yup, thanks for clarifying.
> > > 
> > > > Also indicate changes if any in vmlinux in commit message.
> > > > 
> > > 
> > > Nishanth, what are you asking for here? Just a mentioning if this has
> > > any impact to vmlinux (or is isolated to the modules selected), or are
> > > you asking for anything specific?
> > 
> > In this case, just ensure to state that vmlinux size has'nt
> > changed, in case where we see a =y, we should indicate via
> > ./scripts/bloat-o-meter change that is introduced and if yes, we
> > should explain why this is fundamental to system boot.
> > 
> > Why is this necessary? This is to prevent product specific
> > configurations (such as early display banner, chime etc) from creeping
> > and increasing vmlinux size which has an impact for all ARM SoCs.
> > 
> 
> Sounds very reasonable, I'll make sure to ask for such motivations in
> the defconfig changes that I pick up through the Qualcomm tree as well.
> 
> Regards,
> Bjorn
>

Thanks for the review!
I will send a v2 with the fixes

Regards
Rahul T R

> > 
> > [...]
> > 
> > -- 
> > Regards,
> > Nishanth Menon
> > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
