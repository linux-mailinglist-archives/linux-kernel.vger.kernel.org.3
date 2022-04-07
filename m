Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A54F7211
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbiDGC34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiDGC3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:29:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43DE1DEC21;
        Wed,  6 Apr 2022 19:27:54 -0700 (PDT)
X-UUID: 83a90710a2764557bcfdae17802b3075-20220407
X-UUID: 83a90710a2764557bcfdae17802b3075-20220407
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 514213017; Thu, 07 Apr 2022 10:27:49 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 Apr 2022 10:27:48 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 10:27:47 +0800
Message-ID: <5ba2e990b15e0d4d4a2b4a52c773b8494b70d1c5.camel@mediatek.com>
Subject: Re: [PATCH v5 0/2] phy: mediatek: Add PCIe PHY driver
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wei-Shun Chang <weishunc@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <rex-bc.chen@mediatek.com>, <randy.wu@mediatek.com>,
        <jieyy.yang@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <jian.yang@mediatek.com>
Date:   Thu, 7 Apr 2022 10:27:47 +0800
In-Reply-To: <CAJKOXPfWH-XSogkWVy0Q5LcHSk9SXinR7AA_Odo-oTc32y1Ykg@mail.gmail.com>
References: <20220326022728.2969-1-jianjun.wang@mediatek.com>
         <06c9f2f8236f8dab6b27da9db0332b4ca45a1039.camel@mediatek.com>
         <CAJKOXPfWH-XSogkWVy0Q5LcHSk9SXinR7AA_Odo-oTc32y1Ykg@mail.gmail.com>
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

On Wed, 2022-04-06 at 17:38 +0200, Krzysztof Kozlowski wrote:
> On Wed, 6 Apr 2022 at 07:47, Jianjun Wang <jianjun.wang@mediatek.com>
> wrote:
> > 
> > Hello Maintainers,
> > 
> > Is there anything I can do to get these patches merged?
> 
> Patience. :) You posted a patch during the merge window which
> finished
> three days ago, so basically one can assume you ping folks after
> three
> days. Three days is too fast for pinging. :(

Oh, right, thanks for the reminder.

Thanks.
> 
> Best regards,
> Krzysztof

