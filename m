Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E8C497901
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 07:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiAXGjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 01:39:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36430 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229788AbiAXGjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 01:39:42 -0500
X-UUID: e0731d60e70742ac87e0b2356132db18-20220124
X-UUID: e0731d60e70742ac87e0b2356132db18-20220124
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 152998873; Mon, 24 Jan 2022 14:39:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 24 Jan 2022 14:39:35 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Jan 2022 14:39:34 +0800
Message-ID: <dc84332f190a8be7d5b004fc4d2a2c1341f9a357.camel@mediatek.com>
Subject: Re: [PATCH v21 3/8] soc: mediatek: SVS: introduce MTK SVS engine
From:   Roger Lu <roger.lu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Mon, 24 Jan 2022 14:39:34 +0800
In-Reply-To: <63d8884d-d02d-53f9-8524-4a074ca5bfea@collabora.com>
References: <20220107095200.4389-1-roger.lu@mediatek.com>
         <20220107095200.4389-4-roger.lu@mediatek.com>
         <63d8884d-d02d-53f9-8524-4a074ca5bfea@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Sorry for the late reply and thanks for the advice.

On Fri, 2022-01-07 at 15:33 +0100, AngeloGioacchino Del Regno wrote:
> Il 07/01/22 10:51, Roger Lu ha scritto:
> > The Smart Voltage Scaling(SVS) engine is a piece of hardware
> > which calculates suitable SVS bank voltages to OPP voltage table.
> > Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> > when receiving OPP_EVENT_ADJUST_VOLTAGE.
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > ---
> >   drivers/soc/mediatek/Kconfig   |   10 +
> >   drivers/soc/mediatek/Makefile  |    1 +
> >   drivers/soc/mediatek/mtk-svs.c | 1446 ++++++++++++++++++++++++++++++++
> >   3 files changed, 1457 insertions(+)
> >   create mode 100644 drivers/soc/mediatek/mtk-svs.c

[snip]

> > +
> > +struct svs_platform_data {
> > +	char *name;
> > +	struct svs_bank *banks;
> > +	bool (*efuse_parsing)(struct svs_platform *svsp);
> > +	unsigned long irqflags;
> > +	const u32 *regs;
> > +	u32 bank_max;
> > +	int (*probe)(struct svs_platform *svsp);
> > +};
> > +
> 
> Please move the definition of struct svs_platform_data at the beginning of
> the file for increased readability.

Okay. I'll move them at the beginning of the file in the next patch.

> 
> With that done,
> 
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

