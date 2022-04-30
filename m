Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EE55160F0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 01:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351176AbiD3XRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 19:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiD3XRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 19:17:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129CE517F2;
        Sat, 30 Apr 2022 16:14:11 -0700 (PDT)
X-UUID: 65a0f79ec973441ba9cf2e07990c17b2-20220501
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:aedec0f3-be3e-43f0-9053-f6390d329c18,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:aedec0f3-be3e-43f0-9053-f6390d329c18,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:2fc94a2f-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,File:nil,QS:
        0,BEC:nil
X-UUID: 65a0f79ec973441ba9cf2e07990c17b2-20220501
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 591683792; Sun, 01 May 2022 07:14:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sun, 1 May 2022 07:14:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 1 May 2022 07:14:04 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <matthias.bgg@kernel.org>
CC:     <allen-kh.cheng@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <ikjn@chromium.org>, <krzk+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <sboyd@kernel.org>, <weiyi.lu@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: ARM: Mediatek: Remove msdc binding of MT8192 clock
Date:   Sun, 1 May 2022 07:14:04 +0800
Message-ID: <20220430231404.3078-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220429123133.28869-2-matthias.bgg@kernel.org>
References: <20220429123133.28869-2-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The msdc gate is part of the MMC driver. Delete the binding description
> of this node.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 
