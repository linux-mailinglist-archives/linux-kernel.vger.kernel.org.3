Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B052E430
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 07:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345522AbiETFIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 01:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbiETFIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 01:08:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8BF5A162;
        Thu, 19 May 2022 22:08:44 -0700 (PDT)
X-UUID: 669120a6ef3849ba98dec79670ee9a76-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:bdbf0688-9713-4d5a-a998-582b6da77e28,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:54
X-CID-INFO: VERSION:1.1.5,REQID:bdbf0688-9713-4d5a-a998-582b6da77e28,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_HamU,ACTI
        ON:release,TS:54
X-CID-META: VersionHash:2a19b09,CLOUDID:a2b4f579-5ef6-470b-96c9-bdb8ced32786,C
        OID:e9539d5b2519,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 669120a6ef3849ba98dec79670ee9a76-20220520
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1411693651; Fri, 20 May 2022 13:08:39 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 13:08:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 May 2022 13:08:38 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 May 2022 13:08:38 +0800
Message-ID: <095dd1c9d136e956ee2b53c90796bfc6a794d4e8.camel@mediatek.com>
Subject: Re: [PATCH v2 4/4] soc: mediatek: svs: add support for mt8195
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>
Date:   Fri, 20 May 2022 13:08:38 +0800
In-Reply-To: <2f2b6002-d505-48f3-cf10-5680d3280024@collabora.com>
References: <20220519060924.13493-1-jia-wei.chang@mediatek.com>
         <20220519060924.13493-5-jia-wei.chang@mediatek.com>
         <2f2b6002-d505-48f3-cf10-5680d3280024@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-19 at 10:34 +0200, AngeloGioacchino Del Regno wrote:
> Il 19/05/22 08:09, Tim Chang ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > To support svs on MT8195, add corresponding bank information,
> > platform
> > data, probe and parsing function.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Hello Jia-Wei,
> thanks for the patch!
> 
> However, there are a few things to improve...
> 
> > ---
> >   drivers/soc/mediatek/mtk-svs.c | 193
> > +++++++++++++++++++++++++++++++++
> >   1 file changed, 193 insertions(+)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-svs.c
> > b/drivers/soc/mediatek/mtk-svs.c
> > index 656d0361ff7d..919226faee6d 100644
> > --- a/drivers/soc/mediatek/mtk-svs.c
> > +++ b/drivers/soc/mediatek/mtk-svs.c
> > @@ -1680,6 +1680,92 @@ static int svs_bank_resource_setup(struct
> > svs_platform *svsp)
> >   	return 0;
> >   }
> >   
> > +static bool svs_mt8195_efuse_parsing(struct svs_platform *svsp)
> > +{
> > +	struct svs_bank *svsb;
> > +	struct nvmem_cell *cell;
> > +	u32 idx, i, ft_pgm, vmin, golden_temp;
> > +
> > +	for (i = 0; i < svsp->efuse_max; i++)
> > +		if (svsp->efuse[i])
> > +			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
> > +				 i, svsp->efuse[i]);
> > +
> > +	if (!svsp->efuse[10]) {
> > +		dev_notice(svsp->dev, "svs_efuse[10] = 0x0?\n");
> > +		return false;
> > +	}
> > +
> > +	/* Svs efuse parsing */
> > +	ft_pgm = svsp->efuse[0] & GENMASK(7, 0);
> > +	vmin = (svsp->efuse[19] >> 4) & GENMASK(1, 0);
> > +
> > +	for (idx = 0; idx < svsp->bank_max; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +
> > +		if (svsb->sw_id != SVSB_GPU)
> > +			return false;
> > +
> > +		if (vmin == 0x1)
> > +			svsb->vmin = 0x1e;
> > +
> > +		if (ft_pgm == 0)
> > +			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
> > +
> > +		if (svsb->type == SVSB_LOW) {
> > +			svsb->mtdes = svsp->efuse[10] & GENMASK(7, 0);
> > +			svsb->bdes = (svsp->efuse[10] >> 16) &
> > GENMASK(7, 0);
> > +			svsb->mdes = (svsp->efuse[10] >> 24) &
> > GENMASK(7, 0);
> > +			svsb->dcbdet = (svsp->efuse[8]) & GENMASK(7,
> > 0);
> > +			svsb->dcmdet = (svsp->efuse[8] >> 8) &
> > GENMASK(7, 0);
> > +		} else if (svsb->type == SVSB_HIGH) {
> > +			svsb->mtdes = svsp->efuse[9] & GENMASK(7, 0);
> > +			svsb->bdes = (svsp->efuse[9] >> 16) &
> > GENMASK(7, 0);
> > +			svsb->mdes = (svsp->efuse[9] >> 24) &
> > GENMASK(7, 0);
> > +			svsb->dcbdet = (svsp->efuse[8]) & GENMASK(7,
> > 0);
> > +			svsb->dcmdet = (svsp->efuse[8] >> 8) &
> > GENMASK(7, 0);
> > +		}
> > +
> > +		svsb->vmax += svsb->dvt_fixed;
> > +	}
> > +
> > +	/* Thermal efuse parsing */
> > +	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
> > +	if (IS_ERR_OR_NULL(cell)) {
> > +		dev_err(svsp->dev, "no \"t-calibration-data\"? %ld\n",
> > +			PTR_ERR(cell));
> > +		return false;
> > +	}
> > +
> > +	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_max);
> > +	if (IS_ERR(svsp->tefuse)) {
> > +		dev_err(svsp->dev, "cannot read thermal efuse: %ld\n",
> > +			PTR_ERR(svsp->tefuse));
> > +		nvmem_cell_put(cell);
> > +		return false;
> > +	}
> > +
> > +	svsp->tefuse_max /= sizeof(u32);
> > +	nvmem_cell_put(cell);
> > +
> > +	for (i = 0; i < svsp->tefuse_max; i++)
> > +		if (svsp->tefuse[i] != 0)
> > +			break;
> > +
> > +	if (i == svsp->tefuse_max)
> > +		golden_temp = 50; /* All thermal efuse data are 0 */
> > +	else
> > +		golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
> > +
> > +	for (idx = 0; idx < svsp->bank_max; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +		svsb->mts = 500;
> > +		svsb->bts = (((500 * golden_temp + 250460) / 1000) -
> > 25) * 4;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> >   static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
> >   {
> >   	struct svs_bank *svsb;
> > @@ -2141,6 +2227,39 @@ static struct device
> > *svs_add_device_link(struct svs_platform *svsp,
> >   	return dev;
> >   }
> >   
> > +static int svs_mt8195_platform_probe(struct svs_platform *svsp)
> 
> We can reuse svs_mt8192_platform_probe() for MT8195, as this is
> simply
> a duplicate of that.

Sure, I will remove svs_mt8195_platform_probe and reuse
svs_mt8192_platform_probe instead in the next version.

> 
> > +{
> > +	struct device *dev;
> > +	struct svs_bank *svsb;
> > +	u32 idx;
> > +
> > +	svsp->rst = devm_reset_control_get_optional(svsp->dev,
> > "svs_rst");
> > +	if (IS_ERR(svsp->rst))
> > +		return dev_err_probe(svsp->dev, PTR_ERR(svsp->rst),
> > +				     "cannot get svs reset control\n");
> > +
> > +	dev = svs_add_device_link(svsp, "lvts");
> > +	if (IS_ERR(dev))
> > +		return dev_err_probe(svsp->dev, PTR_ERR(dev),
> > +				     "failed to get lvts device\n");
> > +
> > +	for (idx = 0; idx < svsp->bank_max; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +
> > +		if (svsb->type == SVSB_HIGH)
> > +			svsb->opp_dev = svs_add_device_link(svsp,
> > "mali");
> > +		else if (svsb->type == SVSB_LOW)
> > +			svsb->opp_dev = svs_get_subsys_device(svsp,
> > "mali");
> > +
> > +		if (IS_ERR(svsb->opp_dev))
> > +			return dev_err_probe(svsp->dev, PTR_ERR(svsb-
> > >opp_dev),
> > +					     "failed to get OPP device
> > for bank %d\n",
> > +					     idx);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >   static int svs_mt8192_platform_probe(struct svs_platform *svsp)
> >   {
> >   	struct device *dev;
> > @@ -2257,6 +2376,67 @@ static int svs_mt8183_platform_probe(struct
> > svs_platform *svsp)
> >   	return 0;
> >   }
> >   
> > +static struct svs_bank svs_mt8195_banks[] = {
> > +	{
> > +		.sw_id			= SVSB_GPU,
> > +		.type			= SVSB_LOW,
> > +		.set_freq_pct		= svs_set_bank_freq_pct_v3,
> > +		.get_volts		= svs_get_bank_volts_v3,
> > +		.tzone_name		= "gpu1",
> > +		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT,
> > +		.mode_support		= SVSB_MODE_INIT02,
> > +		.opp_count		= MAX_OPP_ENTRIES,
> > +		.freq_base		= 640000000,
> > +		.turn_freq_base		= 640000000,
> > +		.volt_step		= 6250,
> > +		.volt_base		= 400000,
> > +		.vmax			= 0x38,
> > +		.vmin			= 0x14,
> > +		.age_config		= 0x555555,
> > +		.dc_config		= 0x1,
> > +		.dvt_fixed		= 0x1,
> > +		.vco			= 0x18,
> > +		.chk_shift		= 0x87,
> > +		.core_sel		= 0x0fff0100,
> > +		.int_st			= BIT(0),
> > +		.ctl0			= 0x00540003,
> 
> 
> > +		.tzone_htemp		= 85000,
> > +		.tzone_htemp_voffset	= 0,
> > +		.tzone_ltemp		= 25000,
> > +		.tzone_ltemp_voffset	= 7,
> 
> tzone_{h,l}temp(_voffset) params are used only when (volt_flags &
> SVSB_MODE_MON).
> On this entry, there's no MON mode, so these four are useless: please
> remove.

Sure, I will remove them in the next version.

> 
> > +	},
> > +	{
> > +		.sw_id			= SVSB_GPU,
> > +		.type			= SVSB_HIGH,
> > +		.set_freq_pct		= svs_set_bank_freq_pct_v3,
> > +		.get_volts		= svs_get_bank_volts_v3,
> > +		.tzone_name		= "gpu1",
> > +		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT |
> > +					  SVSB_MON_VOLT_IGNORE,
> > +		.mode_support		= SVSB_MODE_INIT02 |
> > SVSB_MODE_MON,
> > +		.opp_count		= MAX_OPP_ENTRIES,
> > +		.freq_base		= 880000000,
> > +		.turn_freq_base		= 640000000,
> > +		.vboot			= 0x38,
> > +		.volt_step		= 6250,
> > +		.volt_base		= 400000,
> > +		.vmax			= 0x38,
> > +		.vmin			= 0x14,
> > +		.age_config		= 0x555555,
> > +		.dc_config		= 0x1,
> > +		.dvt_fixed		= 0x6,
> > +		.vco			= 0x18,
> > +		.chk_shift		= 0x87,
> > +		.core_sel		= 0x0fff0101,
> > +		.int_st			= BIT(1),
> > +		.ctl0			= 0x00540003,
> > +		.tzone_htemp		= 85000,
> > +		.tzone_htemp_voffset	= 0,
> > +		.tzone_ltemp		= 25000,
> > +		.tzone_ltemp_voffset	= 7,
> > +	},
> > +};
> > +
> >   static struct svs_bank svs_mt8192_banks[] = {
> >   	{
> >   		.sw_id			= SVSB_GPU,
> > @@ -2559,6 +2739,16 @@ static struct svs_bank svs_mt8183_banks[] =
> > {
> >   	},
> >   };
> >   
> > +static const struct svs_platform_data svs_mt8195_platform_data = {
> > +	.name = "mt8195-svs",
> > +	.banks = svs_mt8195_banks,
> > +	.efuse_parsing = svs_mt8195_efuse_parsing,
> > +	.probe = svs_mt8195_platform_probe,
> 
> 	.probe = svs_mt8192_platform_probe,

I will use mt8192's instead in the next version.
Thanks.

> 
> > +	.irqflags = IRQF_TRIGGER_HIGH,
> > +	.regs = svs_regs_v2,
> > +	.bank_max = ARRAY_SIZE(svs_mt8195_banks),
> > +};
> > +
> 
> Regards,
> Angelo
> 

