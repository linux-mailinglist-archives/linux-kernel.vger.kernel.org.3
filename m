Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2976A57331B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiGMJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiGMJme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:42:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B9F6B8C;
        Wed, 13 Jul 2022 02:42:27 -0700 (PDT)
X-UUID: 3335e337e67f4c20abb0b27598c85d09-20220713
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:5cb099b1-7e7e-4fc9-b723-405512c90f1e,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:60b95fd7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 3335e337e67f4c20abb0b27598c85d09-20220713
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 688521074; Wed, 13 Jul 2022 17:42:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 13 Jul 2022 17:42:23 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Jul 2022 17:42:22 +0800
Message-ID: <28177f7f7c1d48b30338071f57f9801d45617f8b.camel@mediatek.com>
Subject: Re: [PATCH 1/5] usb: mtu3: fix coverity of string buffer
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Wed, 13 Jul 2022 17:42:22 +0800
In-Reply-To: <YsvHD6dpU3O7gQD4@kroah.com>
References: <20220708071903.25752-1-chunfeng.yun@mediatek.com>
         <YsfcFXtkDxe6ndFT@kroah.com>
         <9bbc0472bafa6116618e9861c3566d470c30c619.camel@mediatek.com>
         <YsvHD6dpU3O7gQD4@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-11 at 08:45 +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 11, 2022 at 02:39:10PM +0800, Chunfeng Yun wrote:
> > On Fri, 2022-07-08 at 09:26 +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jul 08, 2022 at 03:18:59PM +0800, Chunfeng Yun wrote:
> > > > Use snprintf instead of sprintf which could cause buffer
> > > > overflow.
> > > 
> > > How can it cause an overflow?
> > 
> > Maybe I didn't describe it clearly, this patch is used to fix
> > coverity
> > check warning of string buffer, in fact no overflow happens.
> 
> Then perhaps the coverity warning is useless and
> yet-another-false-positive that that tool is known to spit out?
> 
> Don't make code changes just because broken tools say to do so.
Got it, thanks a lot

> 
> thanks,
> 
> greg k-h

