Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934E1520C39
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiEJDmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiEJDkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:40:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E83A1AF11;
        Mon,  9 May 2022 20:36:07 -0700 (PDT)
X-UUID: 997e40054d824b18a0d998b419c6c56e-20220510
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:8f55eb27-f67a-449c-9bfd-f3b5ec79c8bb,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:227234b3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 997e40054d824b18a0d998b419c6c56e-20220510
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1199608047; Tue, 10 May 2022 11:36:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 10 May 2022 11:36:02 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 May 2022 11:36:02 +0800
Message-ID: <0fed7d2383c1b8367d22fe4f2cccf91b207e14e5.camel@mediatek.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: mediatek: mt8195: add efuse node and
 cells
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Macpaul Lin <macpaul.lin@gmail.com>
Date:   Tue, 10 May 2022 11:36:02 +0800
In-Reply-To: <6e26f483-f4b6-0d0f-7cca-cfa19a39b10a@mediatek.com>
References: <20220128062902.26273-1-chunfeng.yun@mediatek.com>
         <20220128062902.26273-3-chunfeng.yun@mediatek.com>
         <YgY3qvAy5lW1tEdG@kroah.com>
         <6e26f483-f4b6-0d0f-7cca-cfa19a39b10a@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-16 at 17:38 +0800, Macpaul Lin wrote:
> 
> On 2/11/22 6:17 PM, Greg Kroah-Hartman wrote:
> > On Fri, Jan 28, 2022 at 02:29:01PM +0800, Chunfeng Yun wrote:
> > > Add efuse node and cells used by t-phy to fix the bit shift issue
> > > 
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > > v2: use hw auto load for u2phy which has no this issue
> > > 
> > > Note:
> > > 
> > >   depend on the reviewing patch:
> > > 
> > > [v9,3/3] arm64: dts: Add mediatek SoC mt8195 and evaluation board
> > > 
https://urldefense.com/v3/__https://patchwork.kernel.org/patch/12711296__;!!CTRNKA9wMg0ARbw!0Jg8kLN4kBw0LcbiAH1HYTq2uQ5VwiD-CE8yoFBD7oApn8YNSdmVpwSdY1q2C7LvY6c$
> > 
> > As I don't have that in my tree, I can only take the first 2
> > patches
> > here now, thanks.
> > 
> > greg k-h
> > 
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > 

Tested-by: Macpaul Lin <macpaul.lin@mediatek.com>

This patch has been
tested with:
 - "for-next" branch in MediaTek tree [1].

https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git 
 - added more debug log to confirm efuse probing status at my local.
  -
If probe success, it won't show any log.

Thanks
Macpaul Lin

