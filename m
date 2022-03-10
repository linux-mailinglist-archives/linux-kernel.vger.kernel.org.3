Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93CC4D42A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbiCJIfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240466AbiCJIfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:35:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFC87E5AE;
        Thu, 10 Mar 2022 00:34:29 -0800 (PST)
X-UUID: 18c86a87dd1442e1a7a2724389b0c4f3-20220310
X-UUID: 18c86a87dd1442e1a7a2724389b0c4f3-20220310
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1562569698; Thu, 10 Mar 2022 16:34:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Mar 2022 16:34:22 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Mar 2022 16:34:22 +0800
Message-ID: <b2195d5a5d9e7c18eb5e2269a04cb9b8ce431d90.camel@mediatek.com>
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
Date:   Thu, 10 Mar 2022 16:34:21 +0800
In-Reply-To: <20220301054405.25021-1-rex-bc.chen@mediatek.com>
References: <20220301054405.25021-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-01 at 13:44 +0800, Rex-BC Chen wrote:
> resend v2:
> 1. Fix topic to V2.
> 
> v2:
> 1. Squash [1] into [2] in v1.
> 2. Add tags of acked-by and reviewed-by.
> 
> [1]: [3/4] dt-bindings: reset: mt8186: add DSI reset bit for MMSYS
> [2]: [2/4] dt-bindings: reset: mt8186: add toprgu reset-controller
> header file
> 
> v1:
> 1. Add mt8186-resets.h to define definition of reset bits.
> 2. Add wdt compatible for MT8186.
> 
> Rex-BC Chen (1):
>   dt-bindings: watchdog: Add compatible for MediaTek MT8186
> 
> Runyang Chen (2):
>   dt-bindings: reset: mt8186: add reset-controller header file
>   watchdog: mediatek: mt8186: add wdt support
> 
>  .../devicetree/bindings/watchdog/mtk-wdt.txt  |  1 +
>  drivers/watchdog/mtk_wdt.c                    |  6 ++++
>  include/dt-bindings/reset/mt8186-resets.h     | 36
> +++++++++++++++++++
>  3 files changed, 43 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mt8186-resets.h
> 

Hello Guenter,

All patches are reviewed-by and acked-by.
Do you have any suggestion for this series?

Thanks!

BRs,
Rex

