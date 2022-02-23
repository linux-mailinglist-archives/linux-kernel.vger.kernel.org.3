Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816A54C0E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiBWI3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiBWI3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:29:01 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C64349CA2;
        Wed, 23 Feb 2022 00:28:29 -0800 (PST)
X-UUID: 88666749a70d4908bd586b90ac9f7a38-20220223
X-UUID: 88666749a70d4908bd586b90ac9f7a38-20220223
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 704011851; Wed, 23 Feb 2022 16:28:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Feb 2022 16:28:15 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Feb 2022 16:28:15 +0800
Message-ID: <0e528e1649d49a04ae28590309307789563c6105.camel@mediatek.com>
Subject: Re: [PATCH 1/4] mfd: Add support for the MediaTek MT6366 PMIC
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 23 Feb 2022 16:28:15 +0800
In-Reply-To: <Ygpbl/pxEVAug6jl@google.com>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
         <20220106065407.16036-2-johnson.wang@mediatek.com>
         <Ygpbl/pxEVAug6jl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-14 at 13:39 +0000, Lee Jones wrote:
> On Thu, 06 Jan 2022, Johnson Wang wrote:
> 
> > This adds support for the MediaTek MT6366 PMIC. This is a
> > multifunction device with the following sub modules:
> > 
> > - Regulator
> > - RTC
> > - Codec
> > - Interrupt
> > 
> > It is interfaced to the host controller using SPI interface
> > by a proprietary hardware called PMIC wrapper or pwrap.
> > MT6366 MFD is a child device of the pwrap.
> > 
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > ---
> >  drivers/mfd/mt6358-irq.c             | 1 +
> >  include/linux/mfd/mt6358/registers.h | 7 +++++++
> >  include/linux/mfd/mt6397/core.h      | 1 +
> >  3 files changed, 9 insertions(+)
> 
> Applied, thanks.
> 

Hi Lee,

Thank you for your review and response.

However, it seems that my patches are not applied yet.
Is it possible to merge my patches into mainline?

If you have any concern, please let me know.

Thanks.

BRs,
Johnson Wang

