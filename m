Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE971527340
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiENRLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 13:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiENRLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 13:11:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9771CFCB;
        Sat, 14 May 2022 10:11:18 -0700 (PDT)
X-UUID: 3bbd8b7fea674d01a3c3640ed1c74eb8-20220515
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:34efa526-a302-4a28-b136-fd5d520cb01b,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:07914da7-eab7-4b74-a74d-5359964535a9,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,IP:nil,URL:0,File:ni
        l,QS:0,BEC:nil
X-UUID: 3bbd8b7fea674d01a3c3640ed1c74eb8-20220515
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1597973636; Sun, 15 May 2022 01:11:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sun, 15 May 2022 01:11:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sun, 15 May 2022 01:11:13 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <rex-bc.chen@mediatek.com>, <sboyd@kernel.org>,
        <wenst@chromium.org>
Subject: Re: [PATCH v2 00/11] clk: mediatek: Move to struct clk_hw provider APIs
Date:   Sun, 15 May 2022 01:11:13 +0800
Message-ID: <20220514171113.32747-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <18fee6fe-2378-391e-993d-425c887ba40a@collabora.com>
References: <18fee6fe-2378-391e-993d-425c887ba40a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi everyone,
> 
> This is v2 of part 2 of my proposed MediaTek clk driver cleanup work [1].
> 
> Changes since v1:
> - Rebased and added coverage of new MT8186 clk drivers
> - Split patch "clk: mediatek: Replace 'struct clk' with 'struct clk_hw'"
>    into arbitrary pieces so that they don't bounce from the mailing lists
> 
> This was tested on MT8183 Juniper. Apppreciate any help testing on non-
> ChromeOS devices.
>

> For the entire series:
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> ...and this entire series was tested on:
> MT8173/92/95 and MT6795 (Sony Xperia M5 smartphone, clock drivers not sent
> upstream yet), so you also get my:
> 
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Tested on: MT6779

Tested-by: Miles Chen <miles.chen@mediatek.com> 

> 
> ...and last, but not least:
> 
> Thank you! :-)

