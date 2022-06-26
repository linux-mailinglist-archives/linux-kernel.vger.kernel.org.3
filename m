Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1577B55AEF9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiFZEon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 00:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiFZEok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 00:44:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AEF13E32;
        Sat, 25 Jun 2022 21:44:39 -0700 (PDT)
X-UUID: 2ceb064edde3461ab5cf8a6eafa52110-20220626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:382c677b-88c6-423a-a3b1-731e35d78379,OB:20,L
        OB:20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:382c677b-88c6-423a-a3b1-731e35d78379,OB:20,LOB
        :20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:c64283ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:dbdc9b4de735,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,IP:nil,
        URL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2ceb064edde3461ab5cf8a6eafa52110-20220626
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 477535433; Sun, 26 Jun 2022 12:44:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 26 Jun 2022 12:44:32 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 26 Jun 2022 12:44:31 +0800
Message-ID: <1f0e594b7c10f0937f9e676c3ba2ccfe401951d9.camel@mediatek.com>
Subject: Re: [PATCH v2 4/5] pinctrl: mediatek: dropping original advanced
 drive configuration function
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
Date:   Sun, 26 Jun 2022 12:44:31 +0800
In-Reply-To: <20220624160810.alotw7iwvivp5zg6@notapiano>
References: <20220624133700.15487-1-guodong.liu@mediatek.com>
         <20220624133700.15487-5-guodong.liu@mediatek.com>
         <20220624160810.alotw7iwvivp5zg6@notapiano>
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
Subject: Re: [PATCH v2 4/5] pinctrl: mediatek: dropping original
advanced drive configuration function
Date: Fri, 24 Jun 2022 12:08:10 -0400

Hi Guodong,

On Fri, Jun 24, 2022 at 09:36:59PM +0800, Guodong Liu wrote:
> Function bias_combo getter/setters already handle all cases advanced
> drive
> configuration, include drive for I2C related pins.

This commit message could be improved. I suggest using the following
commit
message:

The bias_combo getter/setter is already able to handle advanced drive
configuration, which is the reason commit 353d2ef77f2b ("dt-bindings:
pinctrl:
mt8192: Use generic bias instead of pull-*-adv") dropped the pull-up-
adv and
pull-down-adv properties from the binding. With those properties
removed,
there's no longer any use for the adv_pull callbacks, so drop them.

When commit info include info "commit 353d2ef77f2b", local check pathch
will report "WARNING:UNKNOWN_COMMIT_IO: Unknow commit id
'353d2ef77f2b'", so isn't add those commit info here. thanks!
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

