Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAEA5593FF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiFXHMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXHMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:12:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC663631;
        Fri, 24 Jun 2022 00:12:46 -0700 (PDT)
X-UUID: fcd566ff4a0742f4a7fdb3a8a25be47b-20220624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:d0c81944-64cf-4053-bf72-76d5d6d29b37,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:56
X-CID-INFO: VERSION:1.1.6,REQID:d0c81944-64cf-4053-bf72-76d5d6d29b37,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:56
X-CID-META: VersionHash:b14ad71,CLOUDID:7669f02d-1756-4fa3-be7f-474a6e4be921,C
        OID:c63a9d3e1870,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: fcd566ff4a0742f4a7fdb3a8a25be47b-20220624
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <edward-jw.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 525411220; Fri, 24 Jun 2022 15:12:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 24 Jun 2022 15:12:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 24 Jun 2022 15:12:40 +0800
Message-ID: <9addc9fb0c949e921f915fcf128783393214bfde.camel@mediatek.com>
Subject: Re: [RFC PATCH 2/2] clk: mediatek: Add frequency hopping support
From:   Edward-JW Yang <edward-jw.yang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang =?UTF-8?Q?=28=E7=8E=8B=E8=81=96=E9=91=AB=29?= 
        <Johnson.Wang@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <yu-chang.wang@mediatek.com>, <kuan-hsin.lee@mediatek.com>
Date:   Fri, 24 Jun 2022 15:12:39 +0800
In-Reply-To: <ca4b9a0e-b1ca-6861-e4c0-30a8c8a5c99c@collabora.com>
References: <20220612135414.3003-1-johnson.wang@mediatek.com>
         <20220612135414.3003-3-johnson.wang@mediatek.com>
         <ca4b9a0e-b1ca-6861-e4c0-30a8c8a5c99c@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Thanks for all the advices.

On Mon, 2022-06-13 at 17:43 +0800, AngeloGioacchino Del Regno wrote:
> Il 12/06/22 15:54, Johnson Wang ha scritto:
> > Add frequency hopping support and spread spectrum clocking
> > control for MT8186.
> > 
> > Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> 
> Before going on with the review, there's one important consideration:
> the Frequency Hopping control is related to PLLs only (so, no other clock
> types get in the mix).
> 
> Checking the code, the *main* thing that we do here is initializing the
> FHCTL by setting some registers, and we're performing the actual frequency
> hopping operation in clk-pll, which is right but, at this point, I think
> that the best way to proceed is to add the "FHCTL superpowers" to clk-pll
> itself, instead of adding multiple new files and devicetree bindings that
> are specific to the FHCTL itself.
> 
> This would mean that the `fh-id` and `perms` params that you're setting in
> the devicetree get transferred to clk-mt8186 (and hardcoded there), as to
> extend the PLL declarations to include these two: that will also simplify
> the driver so that you won't have to match names here and there.
> 
> Just an example:
> 
> 	PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x0224, 0x0230, 0,
> 
> 	    PLL_AO, 0, 22, 0x0228, 24, 0, 0, 0, 0x0228, 2, FHCTL_PERM_DBG_DUMP),
> 
> Besides, there are another couple of reasons why you should do that instead,
> of which:
>   - The devicetree should be "generic enough", we shall not see the direct value
>     to write to the registers in there (yet, perms assigns exactly that)
>   - These values won't change on a per-device basis, I believe? They're SoC-related,
>     not board-related, right?
> 
> In case they're board related (and/or related to TZ permissions), we can always add
> a bool property to the apmixedsys to advertise that board X needs to use an
> alternative permission (ex.: `mediatek,secure-fhctl`).

I think we should remain clk-fhctl files because FHCTL is a independent HW and is
not a necessary component of clk-pll.
Frequency hopping function from FHCTL is not used to replace original flow of
set_rate in clk-pll. They are two different ways to change PLL's frequency. The
current set_rate method in clk-pll changes PLL register setting directly. Another
way uses FHCTL to change PLL rate. We will set some PLL's frequency be controlled
by clk-pll and some are controlled by FHCTL. And use `perms` param to decide
whether a PLL is using FHCTL to change its frequency.

FHCTL has another function called SSC(spread spectrum clocking) which is used to
solve PLL de-sense problem. De-sense problem is board-related so we introduce a
`ssc-rate` param in the devicetree to decide whether SSC is enabled and how many
rate should be set. Mixing SSC function into clk-pll may cause clk-pll more
complex.

> 
> In any case, to speed up development (I believe that transferring this in clk-pll
> means that the code will still be more or less the same), I've performed a review
> on the code; check below.
> 
> > ---
> >   drivers/clk/mediatek/Kconfig          |   8 +
> >   drivers/clk/mediatek/Makefile         |   2 +
> >   drivers/clk/mediatek/clk-fhctl-ap.c   | 347 ++++++++++++++++++++++++++
> >   drivers/clk/mediatek/clk-fhctl-pll.c  | 209 ++++++++++++++++
> >   drivers/clk/mediatek/clk-fhctl-pll.h  |  74 ++++++
> >   drivers/clk/mediatek/clk-fhctl-util.h |  24 ++
> >   drivers/clk/mediatek/clk-fhctl.c      | 191 ++++++++++++++
> >   drivers/clk/mediatek/clk-fhctl.h      |  45 ++++
> >   drivers/clk/mediatek/clk-pll.c        |   5 +-
> >   drivers/clk/mediatek/clk-pll.h        |   5 +
> >   10 files changed, 909 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/clk/mediatek/clk-fhctl-ap.c
> >   create mode 100644 drivers/clk/mediatek/clk-fhctl-pll.c
> >   create mode 100644 drivers/clk/mediatek/clk-fhctl-pll.h
> >   create mode 100644 drivers/clk/mediatek/clk-fhctl-util.h
> >   create mode 100644 drivers/clk/mediatek/clk-fhctl.c
> >   create mode 100644 drivers/clk/mediatek/clk-fhctl.h
> > 
> > diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> > index d5936cfb3bee..fd887c537a91 100644
> > --- a/drivers/clk/mediatek/Kconfig
> > +++ b/drivers/clk/mediatek/Kconfig
> > @@ -622,4 +622,12 @@ config COMMON_CLK_MT8516_AUDSYS
> >   	help
> >   	  This driver supports MediaTek MT8516 audsys clocks.
> >   
> > +config COMMON_CLK_MTK_FREQ_HOPPING
> > +	tristate "MediaTek frequency hopping driver"
> 
> If this goes inside of clk-pll, this configuration option can be safely removed.

I think we should keep this for clk-fhctl* files.

> 
> > +	depends on ARCH_MEDIATEK || COMPILE_TEST
> > +	select COMMON_CLK_MEDIATEK
> > +	help
> > +	  This driver supports frequency hopping and spread spectrum clocking
> > +	  control for some MediaTek SoCs.
> > +
> >   endmenu
> > diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> > index caf2ce93d666..3c0e9bd3978b 100644
> > --- a/drivers/clk/mediatek/Makefile
> > +++ b/drivers/clk/mediatek/Makefile
> > @@ -99,3 +99,5 @@ obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
> >   				   clk-mt8195-apusys_pll.o
> >   obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
> >   obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> > +obj-$(CONFIG_COMMON_CLK_MTK_FREQ_HOPPING) += fhctl.o
> > +fhctl-objs += clk-fhctl.o clk-fhctl-ap.o clk-fhctl-pll.o
> > diff --git a/drivers/clk/mediatek/clk-fhctl-ap.c b/drivers/clk/mediatek/clk-fhctl-ap.c
> > new file mode 100644
> > index 000000000000..9e3226a9c1ca
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-fhctl-ap.c
> > @@ -0,0 +1,347 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2022 MediaTek Inc.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/string.h>
> > +#include <linux/slab.h>
> > +#include "clk-fhctl.h"
> > +#include "clk-fhctl-pll.h"
> > +#include "clk-fhctl-util.h"
> > +
> > +#define FHCTL_TARGET FHCTL_AP
> > +
> > +#define PERCENT_TO_DDSLMT(dds, percent_m10) \
> > +	((((dds) * (percent_m10)) >> 5) / 100)
> > +
> > +struct fh_ap_match {
> > +	char *name;
> > +	struct fh_hdlr *hdlr;
> > +	int (*init)(struct pll_dts *array, struct fh_ap_match *match);
> > +};
> > +
> > +struct hdlr_data {
> > +	struct pll_dts *array;
> > +	struct fh_pll_domain *domain;
> > +	spinlock_t *lock;
> > +};
> > +
> > +static int fhctl_set_ssc_regs(struct fh_pll_regs *regs,
> > +			      struct fh_pll_data *data,
> > +			      int fh_id, int rate)
> > +{
> > +	unsigned int updnlmt_val;
> > +
> > +	if (rate > 0) {
> > +		fh_set_field(regs->reg_cfg, data->frddsx_en, 0);
> > +		fh_set_field(regs->reg_cfg, data->sfstrx_en, 0);
> > +		fh_set_field(regs->reg_cfg, data->fhctlx_en, 0);
> 
> Are all of these writes to be performed with a barrier?
> Can't we use writel_relaxed() for some, with a "final" writel() where ordering
> *really* matters?

Do this mean use writel_relaxed() on the first two and writel() on the thrid?

> 
> Also, at least these three field settings are common between (rate > 0) and
> (rate <= 0), so they can go outside of the conditional.

OK, we will move them to outside of conditional. Thanks.

> 
> > +
> > +		/* Set the relative parameter registers (dt/df/upbnd/downbnd) */
> > +		fh_set_field(regs->reg_cfg, data->msk_frddsx_dys, data->df_val);
> > +		fh_set_field(regs->reg_cfg, data->msk_frddsx_dts, data->dt_val);
> > +
> > +		writel((readl(regs->reg_con_pcw) & data->dds_mask) |
> > +			data->tgl_org, regs->reg_dds);
> > +
> > +		/* Calculate UPDNLMT */
> > +		updnlmt_val = PERCENT_TO_DDSLMT((readl(regs->reg_dds) &
> > +						 data->dds_mask), rate) <<
> > +						 data->updnlmt_shft;
> > +
> > +		writel(updnlmt_val, regs->reg_updnlmt);
> > +
> > +		fh_set_field(regs->reg_hp_en, BIT(fh_id), 1);
> > +
> > +		/* Enable SSC */
> > +		fh_set_field(regs->reg_cfg, data->frddsx_en, 1);
> > +		/* Enable Hopping control */
> > +		fh_set_field(regs->reg_cfg, data->fhctlx_en, 1);
> > +
> > +	} else {
> > +		fh_set_field(regs->reg_cfg, data->frddsx_en, 0);
> > +		fh_set_field(regs->reg_cfg, data->sfstrx_en, 0);
> > +		fh_set_field(regs->reg_cfg, data->fhctlx_en, 0);
> > +
> > +		/* Switch to APMIXEDSYS control */
> > +		fh_set_field(regs->reg_hp_en, BIT(fh_id), 0);
> > +
> > +		/* Wait for DDS to be stable */
> > +		udelay(30);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int hopping_hw_flow(void *priv_data, char *domain_name, int fh_id,
> > +			   unsigned int new_dds, int postdiv)
> > +{
> > +	struct fh_pll_domain *domain;
> > +	struct fh_pll_regs *regs;
> > +	struct fh_pll_data *data;
> > +	unsigned int dds_mask;
> > +	unsigned int mon_dds = 0;
> > +	int ret = 0;
> > +	unsigned int con_pcw_tmp;
> > +	struct hdlr_data *d = (struct hdlr_data *)priv_data;
> > +	struct pll_dts *array = d->array;
> > +
> > +	domain = d->domain;
> > +	regs = &domain->regs[fh_id];
> > +	data = &domain->data[fh_id];
> > +	dds_mask = data->dds_mask;
> 
> Just perform these assignments in the variable declarations... with some
> reordering as well, and drop the zero assignment to ret.
> 
> In few words:
> 
> 	struct hdlr_data *d = (struct hdlr_data *)priv_data;
> 
> 	struct fh_pll_domain *domain = d->domain;
> 
> 	struct fh_pll_regs *regs = &domain->regs[fh_id];
> 
> 	struct fh_pll_data *data = &domain->data[fh_id];
> 
> 	struct pll_dts *array = d->array;
> 
> 	u32 con_pcw_tmp, dds_mask;
> 
> 	u32 mon_dds = 0;
> 
> 	int ret;
> 
> This comment is valid for some other functions as well - I won't repeat
> this for every instance... :-)

OK, we will merge them. Thanks.

> 
> > +
> > +	if (array->ssc_rate)
> > +		fhctl_set_ssc_regs(regs, data, fh_id, 0);
> > +
> > +	writel((readl(regs->reg_con_pcw) & dds_mask) |
> > +		data->tgl_org, regs->reg_dds);
> > +
> > +	fh_set_field(regs->reg_cfg, data->sfstrx_en, 1);
> > +	fh_set_field(regs->reg_cfg, data->fhctlx_en, 1);
> > +	writel(data->slope0_value, regs->reg_slope0);
> > +	writel(data->slope1_value, regs->reg_slope1);
> > +
> > +	fh_set_field(regs->reg_hp_en, BIT(fh_id), 1);
> > +	writel((new_dds) | (data->dvfs_tri), regs->reg_dvfs);
> > +
> > +	/* Wait 1000 us until DDS stable */
> > +	ret = readl_poll_timeout_atomic(regs->reg_mon, mon_dds,
> > +				(mon_dds & dds_mask) == new_dds, 10, 1000);
> 
> Why are you writing to CON_PCW even when this returns en error?
> Please add a comment explaining the reasons.

Oh, we will add a warning log and dump HW register when this returns an error
The reg_mon is a register reflects the current frequency rate. So, it's fine to
write the current rate back to CON_PCW. We will also add a comment on it. Thanks

> 
> > +
> > +	con_pcw_tmp = readl(regs->reg_con_pcw) & (~dds_mask);
> > +	con_pcw_tmp = (con_pcw_tmp | (readl(regs->reg_mon) & dds_mask) |
> > +		       data->pcwchg);
> > +
> > +	writel(con_pcw_tmp, regs->reg_con_pcw);
> > +
> > +	fh_set_field(regs->reg_hp_en, BIT(fh_id), 0);
> > +
> > +	if (array->ssc_rate)
> > +		fhctl_set_ssc_regs(regs, data, fh_id, array->ssc_rate);
> > +
> > +	return ret;
> > +}
> > +
> > +static unsigned int __get_postdiv(struct fh_pll_regs *regs,
> > +				  struct fh_pll_data *data)
> > +{
> > +	unsigned int regval;
> > +
> > +	regval = (readl(regs->reg_con_postdiv) & data->postdiv_mask)
> > +		  >> data->postdiv_offset;
> > +
> > +	return data->postdiv_table[regval];
> 
> Can we instead simply reuse `struct clk_div_table` from clk-provider.h?

"postdiv" is part of setting in PCW_CON, not a individual clk divider. I think
it's not suitable to use `struct clk_div_table` here.

> 
> > +}
> > +
> > +static void __set_postdiv(struct fh_pll_regs *regs, struct fh_pll_data *data,
> > +			  int postdiv)
> > +{
> > +	unsigned int regval, temp;
> > +
> > +	for (regval = 0 ; regval < data->postdiv_table_size ; regval++) {
> > +		if (data->postdiv_table[regval] > postdiv) {
> > +			regval--;
> > +			break;
> > +		}
> > +	}
> > +
> > +	temp = (readl(regs->reg_con_postdiv)) & ~(data->postdiv_mask);
> > +	temp |= regval << data->postdiv_offset;
> > +	writel(temp, regs->reg_con_postdiv);
> > +}
> > +
> > +static int fhctl_ap_hopping(void *priv_data, char *domain_name, int fh_id,
> > +			    unsigned int new_dds, int postdiv)
> > +{
> > +	struct fh_pll_domain *domain;
> > +	struct fh_pll_regs *regs;
> > +	struct fh_pll_data *data;
> > +	int ret = 0;
> > +	struct hdlr_data *d = (struct hdlr_data *)priv_data;
> > +	spinlock_t *lock = d->lock;
> > +	unsigned long flags = 0;
> > +	unsigned int pll_postdiv;
> > +
> > +	domain = d->domain;
> > +	regs = &domain->regs[fh_id];
> > +	data = &domain->data[fh_id];
> > +
> > +	if (postdiv > 0) {
> > +		pll_postdiv = __get_postdiv(regs, data);
> > +
> > +		if (postdiv > pll_postdiv)
> > +			__set_postdiv(regs, data, postdiv);
> > +	}
> > +
> > +	spin_lock_irqsave(lock, flags);
> > +
> > +	ret = hopping_hw_flow(priv_data, domain_name, fh_id, new_dds, postdiv);
> > +
> > +	spin_unlock_irqrestore(lock, flags);
> > +
> > +	if (postdiv > 0) {
> > +		if (postdiv < pll_postdiv)
> > +			__set_postdiv(regs, data, postdiv);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int fhctl_ap_ssc_enable(void *priv_data, char *domain_name,
> > +			       int fh_id, int rate)
> > +{
> > +	struct fh_pll_domain *domain;
> > +	struct fh_pll_regs *regs;
> > +	struct fh_pll_data *data;
> > +	struct hdlr_data *d = (struct hdlr_data *)priv_data;
> > +	spinlock_t *lock = d->lock;
> > +	struct pll_dts *array = d->array;
> > +	unsigned long flags = 0;
> > +
> > +	spin_lock_irqsave(lock, flags);
> > +
> > +	domain = d->domain;
> > +	regs = &domain->regs[fh_id];
> > +	data = &domain->data[fh_id];
> > +
> > +	fhctl_set_ssc_regs(regs, data, fh_id, rate);
> > +
> > +	array->ssc_rate = rate;
> > +
> > +	spin_unlock_irqrestore(lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static int fhctl_ap_ssc_disable(void *priv_data, char *domain_name, int fh_id)
> > +{
> > +	struct fh_pll_domain *domain;
> > +	struct fh_pll_regs *regs;
> > +	struct fh_pll_data *data;
> > +	struct hdlr_data *d = (struct hdlr_data *)priv_data;
> > +	spinlock_t *lock = d->lock;
> > +	struct pll_dts *array = d->array;
> > +	unsigned long flags = 0;
> > +
> > +	spin_lock_irqsave(lock, flags);
> > +
> > +	domain = d->domain;
> > +	regs = &domain->regs[fh_id];
> > +	data = &domain->data[fh_id];
> > +
> > +	fhctl_set_ssc_regs(regs, data, fh_id, 0);
> > +
> > +	array->ssc_rate = 0;
> > +
> > +	spin_unlock_irqrestore(lock, flags);
> > +
> > +	return 0;
> > +}
> 
> 
> Just commonize these two...
> 
> static int __fhctl_ap_ssc_enable(struct hdlr_data *d, int fh_id, int rate)
> {
> 	struct fh_pll_domain *domain = d->domain;
> 
> 	struct fh_pll_regs *regs = &domain->regs[fh_id];
> 
> 	struct fh_pll_data *data = &domain->data[fh_id];
> 
> 	struct pll_dts *array = d->array;
> 
> 	spinlock_t *lock = d->lock;
> 
> 	unsigned long flags = 0;
> 
> 
> 
> 	spin_lock_irqsave(lock, flags);
> 
> 
> 
> 	fhctl_set_ssc_regs(regs, data, fh_id, rate);
> 
> 
> 
> 	array->ssc_rate = rate;
> 
> 
> 
> 	spin_unlock_irqrestore(lock, flags);
> 
> 
> 
> 	return 0;
> }
> 
> static int fhctl_ap_ssc_enable(void *priv_data, char *domain_name, int fh_id, int rate)
> {
> 	return __fhctl_ap_ssc_enable((struct hdlr_data *)priv_data, domain_name,
> 				     fh_id, rate);
> }
> 
> static int fhctl_ap_ssc_disable(void *priv_data, char *domain_name, int fh_id)
> {
> 	return __fhctl_ap_ssc_enable((struct hdlr_data *)priv_data, domain_name,
> 				     fh_id, 0);
> }

OK, we will commonize these. Thanks.

> 
> 
> > +
> > +static int fhctl_ap_hw_init(struct pll_dts *array, struct fh_ap_match *match)
> > +{
> > +	static DEFINE_SPINLOCK(lock);
> > +	struct hdlr_data *priv_data;
> > +	struct fh_hdlr *hdlr;
> > +	struct fh_pll_domain *domain;
> > +	int fh_id = array->fh_id;
> > +	struct fh_pll_regs *regs;
> > +	struct fh_pll_data *data;
> > +	int mask = BIT(fh_id);
> > +
> > +	priv_data = kzalloc(sizeof(*priv_data), GFP_KERNEL);
> > +	hdlr = kzalloc(sizeof(*hdlr), GFP_KERNEL);
> > +	init_fh_domain(array->domain, array->comp, array->fhctl_base,
> > +		       array->apmixed_base);
> > +
> > +	priv_data->array = array;
> > +	priv_data->lock = &lock;
> > +	priv_data->domain = get_fh_domain(array->domain);
> > +
> > +	/* do HW init */
> > +	domain = priv_data->domain;
> > +	regs = &domain->regs[fh_id];
> > +	data = &domain->data[fh_id];
> > +
> > +	fh_set_field(regs->reg_clk_con, mask, 1);
> > +	fh_set_field(regs->reg_rst_con, mask, 0);
> > +	fh_set_field(regs->reg_rst_con, mask, 1);
> > +	writel(0x0, regs->reg_cfg);
> > +	writel(0x0, regs->reg_updnlmt);
> > +	writel(0x0, regs->reg_dds);
> > +
> > +	/* hook to array */
> > +	hdlr->data = priv_data;
> > +	hdlr->ops = match->hdlr->ops;
> > +	/* hook hdlr to array is the last step */
> > +	mb();
> 
> I really don't think that you need this barrier here - if there's something that
> I have misunderstood about that, please provide an extensive explanation.

Actually we can remove this mb(), the original thought is that make sure once
hdlr is used, hdlr->data and hdlr->ops is prepared.
After review, hdlr won't be used during fhctl_ap_hw_init, so it can be safely
removed. Thanks.

> 
> > +	array->hdlr = hdlr;
> > +
> > +	/* do SSC */
> > +	if (array->ssc_rate) {
> > +		struct fh_hdlr *hdlr = array->hdlr;
> > +
> > +		hdlr->ops->ssc_enable(hdlr->data, array->domain, array->fh_id,
> > +				      array->ssc_rate);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct fh_operation fhctl_ap_ops = {
> > +	.hopping = fhctl_ap_hopping,
> > +	.ssc_enable = fhctl_ap_ssc_enable,
> > +	.ssc_disable = fhctl_ap_ssc_disable,
> > +};
> > +
> > +static struct fh_hdlr mt8186_hdlr = {
> > +	.ops = &fhctl_ap_ops,
> > +};
> > +
> > +static struct fh_ap_match mt8186_match = {
> > +	.name = "mediatek,mt8186-fhctl",
> > +	.hdlr = &mt8186_hdlr,
> > +	.init = &fhctl_ap_hw_init,
> > +};
> > +
> > +static struct fh_ap_match *matches[] = {
> > +	&mt8186_match,
> > +	NULL,
> > +};
> > +
> > +int fhctl_ap_init(struct pll_dts *array)
> > +{
> > +	int i;
> > +	int num_pll = array->num_pll;
> > +	struct fh_ap_match **match = matches;
> > +
> > +	/* find match by compatible */
> > +	for (i = 0; i < ARRAY_SIZE(matches); i++) {
> > +		char *comp = (*match)->name;
> > +		char *target = array->comp;
> > +
> > +		if (!strcmp(comp, target))
> > +			break;
> > +		match++;
> > +	}
> > +
> > +	if (*match == NULL)
> > +		return -1;
> > +
> > +	/* init flow for every pll */
> > +	for (i = 0; i < num_pll; i++, array++) {
> > +		char *method = array->method;
> > +
> > +		if (!strcmp(method, FHCTL_TARGET))
> > +			(*match)->init(array, *match);
> > +	}
> > +
> > +	return 0;
> > +}
> > diff --git a/drivers/clk/mediatek/clk-fhctl-pll.c b/drivers/clk/mediatek/clk-fhctl-pll.c
> > new file mode 100644
> > index 000000000000..b3ccbbd04e1b
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-fhctl-pll.c
> > @@ -0,0 +1,209 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2022 MediaTek Inc.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include "clk-fhctl-pll.h"
> > +#include "clk-fhctl-util.h"
> > +
> > +#define REG_ADDR(base, x) ((void __iomem *)((unsigned long)base + (x)))
> > +
> > +struct fh_pll_match {
> > +	char *compatible;
> > +	struct fh_pll_domain **domain_list;
> > +};
> > +
> > +static int fhctl_pll_init(struct fh_pll_domain *d, void __iomem *fhctl_base,
> > +			  void __iomem *apmixed_base)
> > +{
> > +	struct fh_pll_data *data = d->data;
> > +	struct fh_pll_offset *offset = d->offset;
> > +	struct fh_pll_regs *regs = d->regs;
> > +
> > +	if (regs->reg_hp_en)
> > +		return 0;
> > +
> > +	while (data->dds_mask != 0) {
> > +		int regs_offset;
> > +
> > +		/* fhctl common part */
> > +		regs->reg_hp_en = REG_ADDR(fhctl_base, offset->offset_hp_en);
> > +		regs->reg_clk_con = REG_ADDR(fhctl_base,
> > +					     offset->offset_clk_con);
> > +		regs->reg_rst_con = REG_ADDR(fhctl_base,
> > +					     offset->offset_rst_con);
> > +		regs->reg_slope0 = REG_ADDR(fhctl_base, offset->offset_slope0);
> > +		regs->reg_slope1 = REG_ADDR(fhctl_base, offset->offset_slope1);
> > +
> > +		/* fhctl pll part */
> > +		regs_offset = offset->offset_fhctl + offset->offset_cfg;
> > +		regs->reg_cfg = REG_ADDR(fhctl_base, regs_offset);
> > +		regs->reg_updnlmt = REG_ADDR(regs->reg_cfg,
> > +					     offset->offset_updnlmt);
> > +		regs->reg_dds = REG_ADDR(regs->reg_cfg, offset->offset_dds);
> > +		regs->reg_dvfs = REG_ADDR(regs->reg_cfg, offset->offset_dvfs);
> > +		regs->reg_mon = REG_ADDR(regs->reg_cfg, offset->offset_mon);
> > +
> > +		/* apmixed part */
> > +		regs->reg_con_pcw = REG_ADDR(apmixed_base,
> > +					     offset->offset_con_pcw);
> > +		regs->reg_con_postdiv = REG_ADDR(apmixed_base,
> > +						 offset->offset_con_postdiv);
> > +
> > +		data++;
> > +		offset++;
> > +		regs++;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static unsigned int __postdiv_pow_tbl[8] = {1, 2, 4, 8, 16, 1, 1, 1};
> > +#define POSTDIV_TABLE_SIZE (sizeof(__postdiv_pow_tbl)\
> > +	/sizeof(unsigned int))
> > +
> > +#define SIZE_8186_TOP (sizeof(mt8186_top_data)\
> > +	/sizeof(struct fh_pll_data))
> > +#define DATA_8186_TOP(_name) {						\
> 
> Is it just only about the name?
> I mean, are there other SoCs for which each PLL needs different parameters?
> 
> If not, there are many ways to commonize these params instead of repeating
> them over and over again...

Some parameters are difference on other SoCs. We will find a way to commonize
these. Thanks.

> 
> > +		.name = _name,						\
> > +		.dds_mask = GENMASK(21, 0),				\
> > +		.postdiv_mask = GENMASK(26, 24),			\
> > +		.postdiv_offset = 24,					\
> > +		.postdiv_table = __postdiv_pow_tbl,			\
> > +		.postdiv_table_size = POSTDIV_TABLE_SIZE,		\
> > +		.slope0_value = 0x6003c97,				\
> > +		.slope1_value = 0x6003c97,				\
> > +		.sfstrx_en = BIT(2),					\
> > +		.frddsx_en = BIT(1),					\
> > +		.fhctlx_en = BIT(0),					\
> > +		.tgl_org = BIT(31),					\
> > +		.dvfs_tri = BIT(31),					\
> > +		.pcwchg = BIT(31),					\
> > +		.dt_val = 0x0,						\
> > +		.df_val = 0x9,						\
> > +		.updnlmt_shft = 16,					\
> > +		.msk_frddsx_dys = GENMASK(23, 20),			\
> > +		.msk_frddsx_dts = GENMASK(19, 16),			\
> > +	}
> > +#define OFFSET_8186_TOP(_fhctl, _con_pcw) {				\
> > +		.offset_fhctl = _fhctl,					\
> > +		.offset_con_pcw = _con_pcw,				\
> > +		.offset_con_postdiv = _con_pcw,				\
> > +		.offset_hp_en = 0x0,					\
> > +		.offset_clk_con = 0x8,					\
> > +		.offset_rst_con = 0xc,					\
> > +		.offset_slope0 = 0x10,					\
> > +		.offset_slope1 = 0x14,					\
> > +		.offset_cfg = 0x0,					\
> > +		.offset_updnlmt = 0x4,					\
> > +		.offset_dds = 0x8,					\
> > +		.offset_dvfs = 0xc,					\
> > +		.offset_mon = 0x10,					\
> > +	}
> > +static struct fh_pll_data mt8186_top_data[] = {
> > +	DATA_8186_TOP("armpll_ll"),
> > +	DATA_8186_TOP("armpll_bl"),
> > +	DATA_8186_TOP("ccipll"),
> > +	DATA_8186_TOP("mainpll"),
> > +	DATA_8186_TOP("mmpll"),
> > +	DATA_8186_TOP("tvdpll"),
> > +	DATA_8186_TOP("mpll"),
> > +	DATA_8186_TOP("adsppll"),
> > +	DATA_8186_TOP("mfgpll"),
> > +	DATA_8186_TOP("nnapll"),
> > +	DATA_8186_TOP("nna2pll"),
> > +	DATA_8186_TOP("msdcpll"),
> > +	DATA_8186_TOP("mempll"),
> > +	{}
> > +};
> > +static struct fh_pll_offset mt8186_top_offset[] = {
> > +	OFFSET_8186_TOP(0x003C, 0x0208),
> > +	OFFSET_8186_TOP(0x0050, 0x0218),
> > +	OFFSET_8186_TOP(0x0064, 0x0228),
> > +	OFFSET_8186_TOP(0x0078, 0x0248),
> > +	OFFSET_8186_TOP(0x008C, 0x0258),
> > +	OFFSET_8186_TOP(0x00A0, 0x0268),
> > +	OFFSET_8186_TOP(0x00B4, 0x0278),
> > +	OFFSET_8186_TOP(0x00C8, 0x0308),
> > +	OFFSET_8186_TOP(0x00DC, 0x0318),
> > +	OFFSET_8186_TOP(0x00F0, 0x0360),
> > +	OFFSET_8186_TOP(0x0104, 0x0370),
> > +	OFFSET_8186_TOP(0x0118, 0x0390),
> > +	OFFSET_8186_TOP(0x012c, 0xdeb1),
> > +	{}
> > +};
> > +static struct fh_pll_regs mt8186_top_regs[SIZE_8186_TOP];
> > +static struct fh_pll_domain mt8186_top = {
> > +	.name = "top",
> > +	.data = (struct fh_pll_data *)&mt8186_top_data,
> > +	.offset = (struct fh_pll_offset *)&mt8186_top_offset,
> > +	.regs = (struct fh_pll_regs *)&mt8186_top_regs,
> > +	.init = &fhctl_pll_init,
> > +};
> > +static struct fh_pll_domain *mt8186_domain[] = {
> > +	&mt8186_top,
> > +	NULL,
> > +};
> > +static struct fh_pll_match mt8186_match = {
> > +	.compatible = "mediatek,mt8186-fhctl",
> > +	.domain_list = (struct fh_pll_domain **)mt8186_domain,
> > +};
> > +
> > +static const struct fh_pll_match *matches[] = {
> > +	&mt8186_match,
> > +	NULL
> > +};
> > +
> > +
> > +static struct fh_pll_domain **get_list(char *comp)
> > +{
> > +	struct fh_pll_match **match;
> > +	static struct fh_pll_domain **list;
> > +	int i;
> > +
> > +	match = (struct fh_pll_match **)matches;
> > +
> > +	/* name used only if !list */
> > +	if (!list) {
> > +		for (i = 0; i < ARRAY_SIZE(matches); i++) {
> > +			if (!strcmp(comp, (*match)->compatible)) {
> > +				list = (*match)->domain_list;
> > +				break;
> > +			}
> > +			match++;
> > +		}
> > +	}
> > +	return list;
> > +}
> > +void init_fh_domain(const char *domain, char *comp, void __iomem *fhctl_base,
> > +		    void __iomem *apmixed_base)
> > +{
> > +	struct fh_pll_domain **list;
> > +
> > +	list = get_list(comp);
> > +
> > +	while (*list != NULL) {
> > +		if (!strcmp(domain, (*list)->name)) {
> > +			(*list)->init(*list, fhctl_base, apmixed_base);
> > +			return;
> > +		}
> > +		list++;
> > +	}
> > +}
> > +
> > +struct fh_pll_domain *get_fh_domain(const char *domain)
> > +{
> > +	struct fh_pll_domain **list;
> > +
> > +	list = get_list(NULL);
> > +
> > +	/* find instance */
> > +	while (*list != NULL) {
> > +		if (!strcmp(domain, (*list)->name))
> > +			return *list;
> > +		list++;
> > +	}
> > +	return NULL;
> > +}
> > diff --git a/drivers/clk/mediatek/clk-fhctl-pll.h b/drivers/clk/mediatek/clk-fhctl-pll.h
> > new file mode 100644
> > index 000000000000..7f0f7577f7a5
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-fhctl-pll.h
> > @@ -0,0 +1,74 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2022 MediaTek Inc.
> > + */
> > +
> > +#ifndef __CLK_FHCTL_PLL_H
> > +#define __CLK_FHCTL_PLL_H
> > +#include <linux/types.h>
> > +#include <linux/bitops.h>
> > +#include <linux/iopoll.h>
> > +
> > +struct fh_pll_data {
> > +	char *name;
> > +	unsigned int dds_mask;
> > +	unsigned int postdiv_mask;
> > +	unsigned int postdiv_offset;
> > +	unsigned int *postdiv_table;
> > +	unsigned int postdiv_table_size;
> > +	unsigned int slope0_value;
> > +	unsigned int slope1_value;
> > +	unsigned int sfstrx_en;
> > +	unsigned int frddsx_en;
> > +	unsigned int fhctlx_en;
> > +	unsigned int tgl_org;
> > +	unsigned int dvfs_tri;
> > +	unsigned int pcwchg;
> > +	unsigned int dt_val;
> > +	unsigned int df_val;
> > +	unsigned int updnlmt_shft;
> > +	unsigned int msk_frddsx_dys;
> > +	unsigned int msk_frddsx_dts;
> 
> That's describing some hardware, so... you should really use `u32` here
> as that would be more descriptive.

OK, we will fix it. Thanks.

> 
> > +};
> > +struct fh_pll_offset {
> > +	int offset_fhctl;
> > +	int offset_con_pcw;
> > +	int offset_con_postdiv;
> > +	int offset_hp_en;
> > +	int offset_clk_con;
> > +	int offset_rst_con;
> > +	int offset_slope0;
> > +	int offset_slope1;
> > +	int offset_cfg;
> > +	int offset_updnlmt;
> > +	int offset_dds;
> > +	int offset_dvfs;
> > +	int offset_mon;
> 
> These also seem to be describing HW registers, and I don't think that
> we'll ever see a negative offset for any of these?

Oh, you are right, these are positive value. We will fix it. Thanks.

> 
> > +};
> > +struct fh_pll_regs {
> > +	void __iomem *reg_hp_en;
> > +	void __iomem *reg_clk_con;
> > +	void __iomem *reg_rst_con;
> > +	void __iomem *reg_slope0;
> > +	void __iomem *reg_slope1;
> > +	void __iomem *reg_cfg;
> > +	void __iomem *reg_updnlmt;
> > +	void __iomem *reg_dds;
> > +	void __iomem *reg_dvfs;
> > +	void __iomem *reg_mon;
> > +	void __iomem *reg_con_pcw;
> > +	void __iomem *reg_con_postdiv;
> > +};
> > +struct fh_pll_domain {
> > +	char *name;
> > +	struct fh_pll_data *data;
> > +	struct fh_pll_offset *offset;
> > +	struct fh_pll_regs *regs;
> > +	int (*init)(struct fh_pll_domain *d, void __iomem *fhctl_base,
> > +		    void __iomem *apmixed_base);
> > +};
> > +extern struct fh_pll_domain *get_fh_domain(const char *name);
> > +extern void init_fh_domain(const char *domain_name, char *comp_name,
> > +			   void __iomem *fhctl_base,
> > +			   void __iomem *apmixed_base);
> > +#endif
> 
> ...and I think this covers enough of the code that may be transferred to clk-pll.
> 
> Excited to see the next iteration of this one!
> 
> Cheers,
> Angelo

