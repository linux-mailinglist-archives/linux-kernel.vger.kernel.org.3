Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50A74D7925
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 02:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiCNBsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 21:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiCNBso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 21:48:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B520D3EF0D;
        Sun, 13 Mar 2022 18:47:34 -0700 (PDT)
X-UUID: d728eb265687495fa82ae314004082be-20220314
X-UUID: d728eb265687495fa82ae314004082be-20220314
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1440433874; Mon, 14 Mar 2022 09:46:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Mar 2022 09:46:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Mar 2022 09:46:47 +0800
Message-ID: <c429d079010051552c3673baafc3b20289043875.camel@mediatek.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: watchdog: Add compatible for
 Mediatek MT8186
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        <linux-mediatek@lists.infradead.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        <hsinyi@chromium.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Mon, 14 Mar 2022 09:46:47 +0800
In-Reply-To: <Yitv4sRQMuewLcfT@robh.at.kernel.org>
References: <20220311130732.22706-1-allen-kh.cheng@mediatek.com>
         <20220311130732.22706-3-allen-kh.cheng@mediatek.com>
         <Yitv4sRQMuewLcfT@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-11 at 09:50 -0600, Rob Herring wrote:
> On Fri, 11 Mar 2022 21:07:30 +0800, Allen-KH Cheng wrote:
> > From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> > 
> > This commit adds dt-binding documentation of watchdog for Mediatek
> > MT8186 SoC Platform.
> > 
> > Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

Hello Allen,

I have mentioned I also upstreamed wdt serires for MT8186 which is
inclduing binding patch, and my patch is accepted by Guenter in [1].
Please drop this patch in next version.

Thanks.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/commit/?h=watchdog-next&id=888423f98c8fbf67e8cb2df8099678ff57274911

BRs,
Rex

