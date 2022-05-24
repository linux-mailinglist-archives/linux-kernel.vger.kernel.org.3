Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38B753226E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiEXF20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiEXF2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:28:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0D97A827;
        Mon, 23 May 2022 22:28:13 -0700 (PDT)
X-UUID: e1611a0dace443329cec0b00e9d29bd8-20220524
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:33b611c9-6de0-48a9-9daa-3e1597b904cd,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:f9e0657a-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,IP:nil,URL:1,File:ni
        l,QS:0,BEC:nil
X-UUID: e1611a0dace443329cec0b00e9d29bd8-20220524
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1192286197; Tue, 24 May 2022 13:28:09 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 24 May 2022 13:28:08 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 24 May 2022 13:28:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 24 May 2022 13:28:08 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <wenst@chromium.org>
Subject: Re: [PATCH 1/8] clk: mediatek export mtk_clk_simple_probe and mtk_clk_simple_remove
Date:   Tue, 24 May 2022 13:28:08 +0800
Message-ID: <20220524052808.7073-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <9bb62269-986b-180e-ce5f-ac8cf7d667ff@collabora.com>
References: <9bb62269-986b-180e-ce5f-ac8cf7d667ff@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SORTED_RECIPS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Export mtk_clk_simple_probe and mtk_clk_simple_remove because we need
>> them for MediaTek tristate clk drivers.
>> 
>> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
>
>Hello Miles,
>
>the changes in this patch are exactly the same as what I've pushed in my
>MT6795 clocks series, so you should simply advertise a dependency on my
>patch [6/7] for this series.

hi Angelo,

No problem, I will add this to the coverletter and drop patch 1/8 in v2.

cheers,
Miles
>
>https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/
>
>Regards,
>Angelo
>
