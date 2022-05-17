Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF54A529F72
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344235AbiEQKau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241853AbiEQKak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:30:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E6621B0;
        Tue, 17 May 2022 03:30:38 -0700 (PDT)
X-UUID: c66ce7917cd44ea3ab9552e558e0b8a6-20220517
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:2e6b7c57-7ac6-442f-a68f-d7521cb297c3,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:65367de2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: c66ce7917cd44ea3ab9552e558e0b8a6-20220517
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1398611353; Tue, 17 May 2022 18:30:34 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 17 May 2022 18:30:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 17 May 2022 18:30:32 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 May 2022 18:30:32 +0800
Message-ID: <b7c080dfcdc3488b5b58badbff8396a8604b5969.camel@mediatek.com>
Subject: Re: [PATCH v6 00/16] Cleanup MediaTek clk reset drivers and support
 MT8192/MT8195
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen =?UTF-8?Q?=28=E9=99=B3=E6=B5=9A=E6=A1=80=29?= 
        <Chun-Jie.Chen@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        Runyang Chen =?UTF-8?Q?=28=E9=99=88=E6=B6=A6=E6=B4=8B=29?= 
        <Runyang.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 17 May 2022 18:30:31 +0800
In-Reply-To: <20220517072329.D367AC385B8@smtp.kernel.org>
References: <20220503093856.22250-1-rex-bc.chen@mediatek.com>
         <445ef1e3ef9d62934e1b84d4fb207705a90d4f34.camel@mediatek.com>
         <20220517072329.D367AC385B8@smtp.kernel.org>
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

On Tue, 2022-05-17 at 15:23 +0800, Stephen Boyd wrote:
> Quoting Rex-BC Chen (2022-05-08 22:35:55)
> > 
> > The drivers of this series are reviewed.
> > The binding of this series are also acked.
> > Could you spare some time and give us some suggestion?
> 
> Have you considered using the auxiliary bus to split the Mediatek clk
> and reset device up into a clk device and a reset device? The idea
> would
> be to move the reset related code into drivers/reset and have the clk
> code in drivers/clk. It's purely an organizational thing and it can
> certainly be done later but it may be a good idea to do this to
> clearly split out the two different functionalities.

Hello Stephen,

Thanks for your advice.
The purpose of this series is to clean up the drivers and we can apply
new socs for it.

I didn't use the auxiliary bus before. However, I can study to the
implementation of auxiliary bus for this reset drivers in another
series. Is this ok for you?

Thanks!

BRs,
Rex

