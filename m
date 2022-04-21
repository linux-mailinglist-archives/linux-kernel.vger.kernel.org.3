Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CC9509C21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387361AbiDUJOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiDUJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:14:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD62224970;
        Thu, 21 Apr 2022 02:11:36 -0700 (PDT)
X-UUID: d67f4c6c3a754be6b02c07b0c0461c6d-20220421
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b20682e8-a8af-45fd-aee3-b8b1ef1b587a,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:21c9a2ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: d67f4c6c3a754be6b02c07b0c0461c6d-20220421
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1260397824; Thu, 21 Apr 2022 17:11:28 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 21 Apr 2022 17:11:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 21 Apr
 2022 17:11:26 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Apr 2022 17:11:26 +0800
Message-ID: <87d953ecfae99e786b0bc3c3756816114e3af287.camel@mediatek.com>
Subject: Re: [PATCH v24 3/7] soc: mediatek: SVS: introduce MTK SVS engine
From:   Roger Lu <roger.lu@mediatek.com>
To:     Kevin Hilman <khilman@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>
Date:   Thu, 21 Apr 2022 17:11:26 +0800
In-Reply-To: <7h5yn3s3jq.fsf@baylibre.com>
References: <20220420102044.10832-1-roger.lu@mediatek.com>
         <20220420102044.10832-4-roger.lu@mediatek.com>
         <7h5yn3s3jq.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

Thanks very much for the feedback.

On Wed, 2022-04-20 at 17:06 -0700, Kevin Hilman wrote:
> Hi Roger,
> 
> 
> Roger Lu <roger.lu@mediatek.com> writes:
> 
> > The Smart Voltage Scaling(SVS) engine is a piece of hardware
> > which calculates suitable SVS bank voltages to OPP voltage table.
> > Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> > when receiving OPP_EVENT_ADJUST_VOLTAGE.
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> 
> Can SVS work with one or the other clusters disabled?  It seems like it
> should still be able to work.  However, if you disable the 2nd cluster
> (e.g. by passing `maxcpus=4` on the kernel command-line, the SVS driver
> will fail to probe.
> 
> I dont' think it's a blocker for merging this series, but making the
> probe a bit more robust so it can handle the cluster being disabled
> would be nice additional fix for later.
> 
> For example, upstream kernel on mt8183-pumpkin board is very unstable
> with the 2nd cluster enabled (I'm still trying to debug why), but I have
> to boot with `maxcpus=4` on the cmdline, otherwise kernel fails to boot,
> so that's how I noticed this probe failure with SVS.

On mt8183 platform, I think SVS can work with one or the other clusters
disabled. However, SVS is supposed to be enabled after system is stable for not
involving any power unstable concern.

If we want part of SVS works at the development stage, we can disable non-
working svs bank as below. Thanks.

--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2164,7 +2164,7 @@ static struct svs_bank svs_mt8183_banks[] = {
                .cpu_id                 = 4,
                .buck_name              = "proc",
                .volt_flags             = SVSB_INIT01_VOLT_INC_ONLY,
-               .mode_support           = SVSB_MODE_INIT01 | SVSB_MODE_INIT02,
+               .mode_support           = SVSB_MODE_ALL_DISABLE,
                .opp_count              = MAX_OPP_ENTRIES,

> 
> Kevin

