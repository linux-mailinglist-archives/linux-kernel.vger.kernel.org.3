Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A27752084C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiEIXWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiEIXWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:22:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4851151302;
        Mon,  9 May 2022 16:18:37 -0700 (PDT)
X-UUID: bcb3ca1d964c4820a26c9c276bc88abb-20220510
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:dc9a6e72-e91a-4097-bab1-e3017460814d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:a84ecb16-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: bcb3ca1d964c4820a26c9c276bc88abb-20220510
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1906186339; Tue, 10 May 2022 07:18:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 10 May 2022 07:18:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 10 May 2022 07:18:08 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <robh@kernel.org>
CC:     <allen-kh.cheng@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <ikjn@chromium.org>, <krzk+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <matthias.bgg@kernel.org>, <miles.chen@mediatek.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: ARM: Mediatek: Remove msdc binding of mt8192 clock
Date:   Tue, 10 May 2022 07:18:08 +0800
Message-ID: <20220509231808.7657-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YnmXX0DldjhmbjY3@robh.at.kernel.org>
References: <YnmXX0DldjhmbjY3@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

>On Thu, May 05, 2022 at 01:31:11PM +0800, Miles Chen wrote:
>> Hi Rob,
>> 
>> >> From: Matthias Brugger <matthias.bgg@gmail.com>
>> >> 
>> >> The msdc gate is part of the MMC driver. Delete the binding description
>> >> of this node.
>> > 
>> >An ABI break is okay because ...?
>> 
>> Sorry for that, 
>> 
>> If the mediatek,mt8192-msdc part is removed from the driver, 
>
>That's an ABI break too. You just need to explain why as Matthias did in 
>the commit message if the ABI break is okay.

Thanks for your explanation.

I would like to learn more about this. In this case
If there was a user (say xxx.c) but the user was removed, can I remove mediatek,mt8192-msdc?

thanks,
Miles

>
>> Is it ok to keep "mediatek,mt8192-msdc" in the binding document? or 
>> we should add '# deprecated' to "mediatek,mt8192-msdc" and keep the example.
>
>We do that sometimes, but depends on the situation.
>
>Rob

