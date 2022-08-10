Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015AF58EC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiHJMdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHJMc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:32:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADA47695E;
        Wed, 10 Aug 2022 05:32:51 -0700 (PDT)
X-UUID: 52b81401940747069a6db42f422caf24-20220810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=TtWR+yg+ag6c4ySzzvo2nUeXBN5GFbEppUG3w7dP/gc=;
        b=CO0ufijyH0LMbYLByIfDiWu+w1sN/AsjupYVghxxT0TbjGHCAQOI/SAYJ3U160o9ls2IDwxINq+duY9LYFVmWIIkjxC1IHHt/sf1o/K9ftT7xkNpmj/ysV8ttVzSq+c5gSkTHHeF6+5UY9NtbNUpOJa4eaB+x3sTXAj1z8iCOec=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:18091ccc-f505-4a59-ad45-9e1794a43c0b,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:-5
X-CID-META: VersionHash:3d8acc9,CLOUDID:0c2270ae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 52b81401940747069a6db42f422caf24-20220810
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1112623319; Wed, 10 Aug 2022 20:32:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 10 Aug 2022 20:32:46 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 10 Aug 2022 20:32:46 +0800
Message-ID: <e85295cb7a7a0dc928337b88a14af377c34b6108.camel@mediatek.com>
Subject: Re: [PATCH v2 0/2] Add mt8186 mutex support for mdp3
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 10 Aug 2022 20:32:45 +0800
In-Reply-To: <20220711123247.15807-1-allen-kh.cheng@mediatek.com>
References: <20220711123247.15807-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias.

Gentle ping on this series.

Is this series ok for you?

BRs,
Allen

On Mon, 2022-07-11 at 20:32 +0800, Allen-KH Cheng wrote:
> This series are based on matthias.bgg/linux.git, for-next and provide
> mt8186 mutex support for Media Data Path 3 (MDP3).
> 
> As discussed, we add data field (mt8186_mdp_mutex_driver_data) for 
> mt8186 mdp3 mutex support instead of adding mutex_table_mod into
> mt8186
> disp mutex data.
> 
> changes since v1:
>  - add mt8186_mdp_mutex_table_mod
>  - add mt8186_mdp_mutex_driver_data for mt8186-mdp3-mutex
> 
> Allen-KH Cheng (2):
>   dt-bindings: soc: mediatek: add mdp3 mutex support for mt8186
>   soc: mediatek: mutex: add mt8186 mutex mod settings for mdp3
> 
>  .../bindings/soc/mediatek/mediatek,mutex.yaml |  1 +
>  drivers/soc/mediatek/mtk-mutex.c              | 28
> +++++++++++++++++++
>  include/linux/soc/mediatek/mtk-mutex.h        |  2 ++
>  3 files changed, 31 insertions(+)
> 

