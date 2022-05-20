Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDE952E421
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345468AbiETEy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiETEy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:54:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39009674EE;
        Thu, 19 May 2022 21:54:50 -0700 (PDT)
X-UUID: e072c075cd874dff8f6dfe1aa6c4e30c-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:a057667c-2344-48a6-a407-c9831addb816,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:be52e5e2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: e072c075cd874dff8f6dfe1aa6c4e30c-20220520
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 729493440; Fri, 20 May 2022 12:54:45 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 20 May 2022 12:54:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 May 2022 12:54:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 20 May 2022 12:54:43 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <bgolaszewski@baylibre.com>, <chun-jie.chen@mediatek.com>,
        <ck.hu@mediatek.com>, <devicetree@vger.kernel.org>,
        <fparent@baylibre.com>, <ikjn@chromium.org>,
        <jason-jh.lin@mediatek.com>, <kernel@collabora.com>,
        <konrad.dybcio@somainline.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <marijn.suijten@somainline.org>, <martin.botka@somainline.org>,
        <matthias.bgg@gmail.com>, <miles.chen@mediatek.com>,
        <mturquette@baylibre.com>, <p.zabel@pengutronix.de>,
        <paul.bouchara@somainline.org>, <phone-devel@vger.kernel.org>,
        <rex-bc.chen@mediatek.com>, <robh+dt@kernel.org>,
        <sam.shih@mediatek.com>, <sboyd@kernel.org>,
        <tinghan.shen@mediatek.com>, <weiyi.lu@mediatek.com>,
        <wenst@chromium.org>, <y.oudjana@protonmail.com>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH v2 7/7] clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers
Date:   Fri, 20 May 2022 12:54:38 +0800
Message-ID: <20220520045438.25661-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <a253f338-c162-17b8-f412-95cd63195151@collabora.com>
References: <a253f338-c162-17b8-f412-95cd63195151@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

>For MT8195... and 92, 83, 73... and others from the same era, being them for
>chromebooks, iot, smartphones and whatever else... yeah you're totally right.
>
>The issue starts raising when looking at older SoCs featuring an older bootloader
>that does have a kernel size limitation; for example, to make the loader happy on
>MT6795, I had to strip the defconfig a lot and keep the Android-style boot.img
>smaller than 10MB (that's Image.gz-dtb + ramdisk).

I think you have the point :-)
I did not consider the older SoCs case you mentioned and there is a real 10MB limit.
I'm fine with this.

ChenYu, What do you think?

thanks,
Miles
