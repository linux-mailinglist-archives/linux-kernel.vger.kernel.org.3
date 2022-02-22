Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9174C03D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiBVV2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiBVV1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:27:41 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519208E196
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:27:11 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21MLQgJt094027;
        Tue, 22 Feb 2022 15:26:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645565202;
        bh=4IgUtNPOVL10Vp/1imi/uYZI63freW9H4+vX2DPlXSY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LAiCT48cWfLm7s/Qi781s8RcKxLPuwos03bIGtQxAOiGatxkEHNkQX9tlLsVaLlA/
         +gMHbBht/OQ26yNsOaS3bNUeKIhwKyvFWQNTKLjT3EO8okdbAqUrLiDGa0NBFFfy77
         t4uiayVOEan2qDs1T2LWQHz9oP/9jPlcoq9qXJnQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21MLQgUv093354
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Feb 2022 15:26:42 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 22
 Feb 2022 15:26:42 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 22 Feb 2022 15:26:42 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21MLQgU8074960;
        Tue, 22 Feb 2022 15:26:42 -0600
Date:   Tue, 22 Feb 2022 15:26:42 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Rahul T R <r-ravikumar@ti.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <krzk@kernel.org>,
        <geert+renesas@glider.be>, <marcel.ziswiler@toradex.com>,
        <biju.das.jz@bp.renesas.com>, <vkoul@kernel.org>,
        <enric.balletbo@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] arm64: defconfig: Enable configs for DisplayPort on J721e
Message-ID: <20220222212642.vwtw7xiz7cck63ea@zombie>
References: <20220222180703.30401-1-r-ravikumar@ti.com>
 <20220222193930.sbc5xlsofhg3amgk@overrun>
 <YhVKSpMOKWzZy9a2@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YhVKSpMOKWzZy9a2@ripper>
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

On 12:40-20220222, Bjorn Andersson wrote:
> On Tue 22 Feb 11:39 PST 2022, Nishanth Menon wrote:
> 
> > On 23:37-20220222, Rahul T R wrote:
> > > Enable DRM and PHY configs required for supporting
> > > DisplayPort on J721e
> > > 
> > > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > > ---
> > >  arch/arm64/configs/defconfig | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > > index 9f23d7ec1232..b0cb894a392e 100644
> > > --- a/arch/arm64/configs/defconfig
> > > +++ b/arch/arm64/configs/defconfig
> > > @@ -702,6 +702,9 @@ CONFIG_DRM_EXYNOS_DSI=y
> > >  CONFIG_DRM_EXYNOS_HDMI=y
> > >  CONFIG_DRM_EXYNOS_MIC=y
> > >  CONFIG_DRM_ROCKCHIP=m
> > > +CONFIG_DRM_TIDSS=m
> > > +CONFIG_DRM_DISPLAY_CONNECTOR=m
> > > +CONFIG_DRM_CDNS_MHDP8546=m
> > 
> > Please use savedefconfig to place the changes in the correct location
> > 
> 
> Just to clarify the request, use "make savedefconfig" to generate a
> defconfig, then based on that put _only_ the relevant changes in the
> commit.

Yup, thanks for clarifying.
> 
> > Also indicate changes if any in vmlinux in commit message.
> > 
> 
> Nishanth, what are you asking for here? Just a mentioning if this has
> any impact to vmlinux (or is isolated to the modules selected), or are
> you asking for anything specific?

In this case, just ensure to state that vmlinux size has'nt
changed, in case where we see a =y, we should indicate via
./scripts/bloat-o-meter change that is introduced and if yes, we
should explain why this is fundamental to system boot.

Why is this necessary? This is to prevent product specific
configurations (such as early display banner, chime etc) from creeping
and increasing vmlinux size which has an impact for all ARM SoCs.


[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
