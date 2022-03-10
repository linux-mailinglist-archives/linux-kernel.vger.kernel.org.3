Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59494D433D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbiCJJQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiCJJQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:16:50 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8407A12E9F7;
        Thu, 10 Mar 2022 01:15:48 -0800 (PST)
X-UUID: 96bdbec796c24e49bc8fab5fcf09007a-20220310
X-UUID: 96bdbec796c24e49bc8fab5fcf09007a-20220310
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 47384453; Thu, 10 Mar 2022 17:15:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Mar 2022 17:15:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Mar 2022 17:15:40 +0800
Message-ID: <0a05150360b7d5ec075396820ee7339c49fb5367.camel@mediatek.com>
Subject: Re: [RESEND V2 0/3] Add watchdog support for MT8186 SoC
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <runyang.chen@mediatek.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 10 Mar 2022 17:15:40 +0800
In-Reply-To: <b2195d5a5d9e7c18eb5e2269a04cb9b8ce431d90.camel@mediatek.com>
References: <20220301054405.25021-1-rex-bc.chen@mediatek.com>
         <b2195d5a5d9e7c18eb5e2269a04cb9b8ce431d90.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-10 at 16:34 +0800, Rex-BC Chen wrote:
> On Tue, 2022-03-01 at 13:44 +0800, Rex-BC Chen wrote:
> > resend v2:
> > 1. Fix topic to V2.
> > 
> > v2:
> > 1. Squash [1] into [2] in v1.
> > 2. Add tags of acked-by and reviewed-by.
> > 
> > [1]: [3/4] dt-bindings: reset: mt8186: add DSI reset bit for MMSYS
> > [2]: [2/4] dt-bindings: reset: mt8186: add toprgu reset-controller
> > header file
> > 
> > v1:
> > 1. Add mt8186-resets.h to define definition of reset bits.
> > 2. Add wdt compatible for MT8186.
> > 
> > Rex-BC Chen (1):
> >   dt-bindings: watchdog: Add compatible for MediaTek MT8186
> > 
> > Runyang Chen (2):
> >   dt-bindings: reset: mt8186: add reset-controller header file
> >   watchdog: mediatek: mt8186: add wdt support
> > 
> >  .../devicetree/bindings/watchdog/mtk-wdt.txt  |  1 +
> >  drivers/watchdog/mtk_wdt.c                    |  6 ++++
> >  include/dt-bindings/reset/mt8186-resets.h     | 36
> > +++++++++++++++++++
> >  3 files changed, 43 insertions(+)
> >  create mode 100644 include/dt-bindings/reset/mt8186-resets.h
> > 
> 
> Hello Guenter,
> 
> All patches are reviewed-by and acked-by.
> Do you have any suggestion for this series?
> 
> Thanks!
> 
> BRs,
> Rex
> 
Hello Guenter,

I am sorry that I did not notice this series is in watchdog-next.
Thanks for accepting this series!

BRs,
Rex

