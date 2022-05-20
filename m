Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1540252E8EB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347729AbiETJfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244061AbiETJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:35:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C8713C4E8;
        Fri, 20 May 2022 02:35:07 -0700 (PDT)
X-UUID: d4d55e255c6f408eb54e4156e458e00f-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:71912025-9eb1-4f1e-b74d-aa9b9de228f8,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:71912025-9eb1-4f1e-b74d-aa9b9de228f8,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:a357007a-5ef6-470b-96c9-bdb8ced32786,C
        OID:b0708b025ba7,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,IP:nil,
        URL:0,File:nil,QS:0,BEC:nil
X-UUID: d4d55e255c6f408eb54e4156e458e00f-20220520
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1819122944; Fri, 20 May 2022 17:35:02 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 20 May 2022 17:35:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 May 2022 17:35:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 May 2022 17:35:00 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <yassine.oudjana@gmail.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <bgolaszewski@baylibre.com>, <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <ikjn@chromium.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <sam.shih@mediatek.com>, <sboyd@kernel.org>,
        <tinghan.shen@mediatek.com>, <weiyi.lu@mediatek.com>,
        <wenst@chromium.org>, <y.oudjana@protonmail.com>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH v2 4/4] clk: mediatek: Add drivers for MediaTek MT6735 main clock drivers
Date:   Fri, 20 May 2022 17:35:01 +0800
Message-ID: <20220520093501.28758-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <NJC6CR.M4CF312LSXXV1@gmail.com>
References: <NJC6CR.M4CF312LSXXV1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> 
>> Thanks for submitting this patch.
>> 
>> I compare this with drivers/clk/mediatek/clk-mt7986-apmixed.c,
>> and other clk files are using macros to make the mtk_pll_data array
>> more readable.
>
>I'd actually argue that macros make it less readable. While reading
>other drivers I had a lot of trouble figuring out which argument
>is which field of the struct, and had to constantly go back to the
>macro definitions and count arguments to find it. Having it this
>way, each value is labeled clearly with the field it's in. I think
>the tradeoff between line count and readability here is worth it.

It is easier for multiple developers to work together if we have a common style.

How do you think?

Thanks,
Miles

>
>> 
>> Would you mind following the same style for all c files, please?
>> 
>> e.g.,
>> 	static const struct mtk_pll_data plls[] = {
>> 		PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0x00000001, 0, 32,
>> 				0x0200, 4, 0, 0x0204, 0),
>> 		PLL(CLK_APMIXED_NET2PLL, "net2pll", 0x0210, 0x021C, 0x00000001, 0, 
>> 32,
>> 				0x0210, 4, 0, 0x0214, 0),
>> 		...
>> 	};
>> 
>>>  +	},
>>>  +		.reg = APLL1_CON0,
>>>  +		.pwr_reg = APLL1_PWR_CON0,
>>>  +module_platform_driver(clk_mt6735_apmixedsys);
>>>  +
>>>  +MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
>>>  +MODULE_DESCRIPTION("Mediatek MT6735 apmixedsys clock driver");
>> 
>> Would you mind changing all Mediatek to MediaTek?
>> i.e.,
>> 
>> s/Mediatek/MediaTek/
>> 
>
>Sure. Will fix it.

thanks
>
>> 
>> thanks,
>> Miles
>>  +MODULE_LICENSE("GPL");
>> 
>
>Thanks,
>Yassine
>
>
>
>
