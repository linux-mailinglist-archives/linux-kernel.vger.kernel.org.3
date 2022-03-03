Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32504CB777
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiCCHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiCCHJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:09:12 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE21120F5E;
        Wed,  2 Mar 2022 23:08:25 -0800 (PST)
X-UUID: ce64ad0c28084ac89185cb577bc88571-20220303
X-UUID: ce64ad0c28084ac89185cb577bc88571-20220303
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1732930282; Thu, 03 Mar 2022 15:08:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Mar 2022 15:08:19 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Mar 2022 15:08:19 +0800
Message-ID: <131c801871de28d3f124cc5b22571bcc83da199e.camel@mediatek.com>
Subject: Re: [PATCH 0/2] Add gce support for mt8186
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <yongqiang.niu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 3 Mar 2022 15:08:19 +0800
In-Reply-To: <20220223030138.13939-1-rex-bc.chen@mediatek.com>
References: <20220223030138.13939-1-rex-bc.chen@mediatek.com>
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

On Wed, 2022-02-23 at 11:01 +0800, Rex-BC Chen wrote:
> Rex-BC Chen (1):
>   dt-bindings: mailbox: add definition for mt8186
> 
> Yongqiang Niu (1):
>   dt-bindings: gce: add gce header file for mt8186
> 
>  .../devicetree/bindings/mailbox/mtk-gce.txt   |   8 +-
>  include/dt-bindings/gce/mt8186-gce.h          | 421
> ++++++++++++++++++
>  2 files changed, 426 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/gce/mt8186-gce.h
> 
Hello Jassi,

All binding patches are acked by Rob.
Do you have any suggestion for this series?

Thanks!

BRs,
Rex

