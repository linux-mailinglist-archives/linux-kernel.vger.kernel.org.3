Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609D25242D3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbiELCgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiELCgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:36:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF97D36E0E;
        Wed, 11 May 2022 19:36:07 -0700 (PDT)
X-UUID: 0e061dee875c49cdb5f395ef68a3429d-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:0fe12182-a9ab-45b5-a4dd-c44fa9e9e382,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:0fe12182-a9ab-45b5-a4dd-c44fa9e9e382,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:5ccc4125-b432-452e-9e03-2bf3148aed85,C
        OID:f89df0872269,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: 0e061dee875c49cdb5f395ef68a3429d-20220512
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 484231883; Thu, 12 May 2022 10:36:02 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 12 May 2022 10:36:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 May 2022 10:36:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 12 May 2022 10:36:00 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <rex-bc.chen@mediatek.com>, <sboyd@kernel.org>
Subject: Re: [PATCH v2 01/11] clk: mediatek: Make mtk_clk_register_composite() static
Date:   Thu, 12 May 2022 10:36:00 +0800
Message-ID: <20220512023600.25520-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220510104804.544597-2-wenst@chromium.org>
References: <20220510104804.544597-2-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> mtk_clk_register_composite() is not used anywhere outside of the file it
> is defined.
> 
> Make it static.
> 
> Fixes: 9741b1a68035 ("clk: mediatek: Add initial common clock support for Mediatek SoCs.")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 
