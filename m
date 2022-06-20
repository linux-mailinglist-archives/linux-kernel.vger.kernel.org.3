Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EBA55114C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbiFTHSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239308AbiFTHS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:18:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A8B116E;
        Mon, 20 Jun 2022 00:18:24 -0700 (PDT)
X-UUID: acaba29734624d179a7245cebab7e2cf-20220620
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.6,REQID:e9311f20-6b30-4099-917c-d278413dbe0d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:100,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS6885AD
        ,ACTION:quarantine,TS:195
X-CID-INFO: VERSION:1.1.6,REQID:e9311f20-6b30-4099-917c-d278413dbe0d,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:100,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_US65DF41,A
        CTION:quarantine,TS:195
X-CID-META: VersionHash:b14ad71,CLOUDID:98b42b3d-9948-4b2a-a784-d8a6c1086106,C
        OID:0c15e3eaddee,Recheck:0,SF:28|17|19|48|801,TC:nil,Content:3,EDM:-3,IP:n
        il,URL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: acaba29734624d179a7245cebab7e2cf-20220620
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 597411295; Mon, 20 Jun 2022 15:18:21 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 20 Jun 2022 15:18:20 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 20 Jun 2022 15:18:18 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        "Steve Cho" <stevecho@chromium.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH] MAINTAINERS: add Yunfei Dong as mediatek vcodec driver maintainer
Date:   Mon, 20 Jun 2022 15:18:17 +0800
Message-ID: <20220620071817.11685-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been working on mediatek driver development for a very long time,
and sent many patches to change the driver architecture. Add myself as
co-maintainer for mediatek vcodec driver.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e22a79ffa4d0..1b3a30f33f0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12389,6 +12389,7 @@ F:	drivers/media/platform/mediatek/vpu/
 MEDIATEK MEDIA DRIVER
 M:	Tiffany Lin <tiffany.lin@mediatek.com>
 M:	Andrew-CT Chen <andrew-ct.chen@mediatek.com>
+M:	Yunfei Dong <yunfei.dong@mediatek.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/media/mediatek,vcodec*.yaml
 F:	Documentation/devicetree/bindings/media/mediatek-vpu.txt
-- 
2.25.1

