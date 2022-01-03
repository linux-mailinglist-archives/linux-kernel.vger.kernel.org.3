Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D46482EC7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiACHo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:44:26 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58302 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229793AbiACHo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:44:26 -0500
X-UUID: 1fdf354a63754465837a47703602c459-20220103
X-UUID: 1fdf354a63754465837a47703602c459-20220103
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 239288997; Mon, 03 Jan 2022 15:44:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Jan 2022 15:44:22 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Jan 2022 15:44:21 +0800
Message-ID: <8d0b14c93f98d97ed1c1147b785738baf7dfc117.camel@mediatek.com>
Subject: Re: [PATCH v20 0/7] soc: mediatek: SVS: introduce MTK SVS engine
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
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
Date:   Mon, 3 Jan 2022 15:44:21 +0800
In-Reply-To: <fff75b65-51ab-cafd-a55f-137c0b7c2dc6@gmail.com>
References: <20210721070904.15636-1-roger.lu@mediatek.com>
         <fff75b65-51ab-cafd-a55f-137c0b7c2dc6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Thu, 2021-12-30 at 16:13 +0100, Matthias Brugger wrote:
> Hi Roger,
> 
> On 21/07/2021 09:08, Roger Lu wrote:
> > 1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
> > 2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by
> > get_cpu_device().
> > After retrieving subsys device, SVS driver calls device_link_add() to make
> > sure probe/suspend callback priority.
> > 3. SVS dts refers to reset controller [4] to help reset SVS HW.
> > 
> > #mt8183 SVS related patches
> > [1] 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/patch/11193513/__;!!CTRNKA9wMg0ARbw!1SsvfMF2dN3uBcTxgzllNcmZ0yWfXvvAKdKlWRVgaEm69mvIZUYLBf27o_UqdhsH$
> >  
> > [2] 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20201013102358.22588-2-michael.kao@mediatek.com/__;!!CTRNKA9wMg0ARbw!1SsvfMF2dN3uBcTxgzllNcmZ0yWfXvvAKdKlWRVgaEm69mvIZUYLBf27o_10UEyP$
> >  
> > [3] 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20200306041345.259332-3-drinkcat@chromium.org/__;!!CTRNKA9wMg0ARbw!1SsvfMF2dN3uBcTxgzllNcmZ0yWfXvvAKdKlWRVgaEm69mvIZUYLBf27ozqhhMBj$
> >  
> > 
> 
> Comments made in v16 actually also hold for v20, so please take them into
> account :)

Sure. Thanks for the reminding :)

> 
> Regards,
> Matthias

