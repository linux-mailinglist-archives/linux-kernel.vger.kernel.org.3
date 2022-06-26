Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1055AF33
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiFZEpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 00:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiFZEpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 00:45:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173D14D22;
        Sat, 25 Jun 2022 21:45:47 -0700 (PDT)
X-UUID: 3dfabf3dbdca40c19f4dc6353c3e88cf-20220626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:a48a8ce6-fead-4dcf-96cb-2ef86e1104b9,OB:20,L
        OB:50,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:a48a8ce6-fead-4dcf-96cb-2ef86e1104b9,OB:20,LOB
        :50,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:cb4483ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:bc5cf8b9677e,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,IP:nil,
        URL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3dfabf3dbdca40c19f4dc6353c3e88cf-20220626
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 958410682; Sun, 26 Jun 2022 12:45:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sun, 26 Jun 2022 12:45:42 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 26 Jun 2022 12:45:41 +0800
Message-ID: <59308e27c021de6bed80d6986bc2766f2a73a739.camel@mediatek.com>
Subject: Re: [PATCH v2 1/5] pinctrl: mediatek: add generic driving setup
 property on mt8192
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Sun, 26 Jun 2022 12:45:41 +0800
In-Reply-To: <20220624155224.lizeca5rnruhihdn@notapiano>
References: <20220624133700.15487-1-guodong.liu@mediatek.com>
         <20220624133700.15487-2-guodong.liu@mediatek.com>
         <20220624155224.lizeca5rnruhihdn@notapiano>
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

-----Original Message-----
From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
To: Guodong Liu <guodong.liu@mediatek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <
robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Sean
Wang <sean.wang@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
Zhiyong Tao <zhiyong.tao@mediatek.com>, linux-gpio@vger.kernel.org, 
devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 1/5] pinctrl: mediatek: add generic driving
setup property on mt8192
Date: Fri, 24 Jun 2022 11:52:24 -0400

Hi Guodong,

please see comments below.

On Fri, Jun 24, 2022 at 09:36:56PM +0800, Guodong Liu wrote:
> 1. The dt-binding expects that drive-strength arguments be passed
> in mA, but the driver was expecting raw values. And that this
> commit changes the driver so that it is aligned with the binding.
> 2. This commit provides generic driving setup, which support
> 2/4/6/8/10/12/14/16mA driving, original driver just set raw data
> setup setting when use drive-strength property.

This commit message is a bit confusing, I suggest using the following
commit
message instead:

The dt-binding expects the drive-strength arguments to be passed in mA,
but the
driver was using callbacks that expect raw values instead. Change the
callbacks
for the ones that operate on mA values, so that the driver is in
accordance to
the dt-binding.

The drive-strength property requiring values in mA is the standard and
other
MediaTek SoCs of the same generation already do the same, so this
change avoids
mt8192 having a non-standard property.

There are no current upstream users of this driver, so this change
doesn't cause
any regression.

Fixed in next patch, thanks!

> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

