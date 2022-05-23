Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FEF53089F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354800AbiEWFOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiEWFOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:14:12 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39BF15833;
        Sun, 22 May 2022 22:14:10 -0700 (PDT)
X-UUID: 1e72670177804820a993c9184072fe96-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:62a28043-4333-4519-9c0a-d4e1df92f655,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:2a953c7a-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 1e72670177804820a993c9184072fe96-20220523
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 503088311; Mon, 23 May 2022 13:14:07 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 23 May 2022 13:14:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 May 2022 13:14:06 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 May 2022 13:14:06 +0800
Message-ID: <93464881d214501851eafd55fdb25b69b6bf77e9.camel@mediatek.com>
Subject: Re: [PATCH v7 13/19] dt-bindings: reset: mediatek: Add infra_ao
 reset index for MT8192/MT8195
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen =?UTF-8?Q?=28=E9=99=B3=E6=B5=9A=E6=A1=80=29?= 
        <Chun-Jie.Chen@mediatek.com>,
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
Date:   Mon, 23 May 2022 13:14:06 +0800
In-Reply-To: <20220521042323.BA60AC385A5@smtp.kernel.org>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
         <20220519125527.18544-14-rex-bc.chen@mediatek.com>
         <3f39777a225fac66f01858262defcc11c6135bb2.camel@mediatek.com>
         <CAGXv+5Ee3QvpHqWeSOFJYmq+P3POFSTB45JM42UNF8pn4b4T9A@mail.gmail.com>
         <20220521042323.BA60AC385A5@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-05-21 at 12:23 +0800, Stephen Boyd wrote:
> Quoting Chen-Yu Tsai (2022-05-19 20:10:35)
> > On Fri, May 20, 2022 at 10:58 AM Rex-BC Chen <
> > rex-bc.chen@mediatek.com> wrote:
> > > 
> > > 
> > > Hello Stephen,
> > > 
> > > this patch will have conflict with Matthias's commit branch for
> > > include/dt-bindings/reset/mt8192-resets.h.
> > > 
> > > It's on linux-next.
> > > 
> > > I have fix it in this version, but I think there will be a merge
> > > conflict if you pick my series in this run.
> > > 
> > > 
https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/dt-bindings/reset/mt8192-resets.h?h=next-20220519&id=19c66219e4d5b813ebbd28621cfe9c450659ded7__;!!CTRNKA9wMg0ARbw!xFfRxOWRAvhQMzoKxqRu8xFsMZLpVZEoK0WZBKeMOoeRGBjKphSL2tox-8zWlRwytjtEImTo1VB1f38wwj8XSlyKIw$
> > >  
> > 
> > The commit in question is in Matthias's v5.18-next/dts64 branch,
> > which also
> > has the v5.18-next-dts64 tag. The PR for this tag was already
> > picked up
> > by the soc maintainers, so I guess we could consider it stable.
> > 
> > Matthias, what do you think? Give an ack for the patch to go
> > through the
> > clk tree with the tag merged in as dependency? There's a compile
> > time
> > dependency between this and the next patch so we can't just split
> > them
> > into different trees.
> > 
> 
> It's pretty late to land something that has cross tree dependencies
> like
> that so I guess we'll just take up this patch series after the merge
> window closes.

Hello Stephen,

Thanks for your big help!
I will send v8 to modify comments from Nícolas.

BRs,
Rex

