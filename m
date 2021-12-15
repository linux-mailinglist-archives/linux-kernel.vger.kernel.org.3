Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D404750AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhLOCDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:03:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33186 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238932AbhLOCDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:03:36 -0500
X-UUID: 7321fadf45f9404c9cae01c8e99ef3d5-20211215
X-UUID: 7321fadf45f9404c9cae01c8e99ef3d5-20211215
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1772619576; Wed, 15 Dec 2021 10:03:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 15 Dec 2021 10:03:31 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Dec 2021 10:03:31 +0800
Message-ID: <768b202c7bf78e26102c91ae558d4d0887e11124.camel@mediatek.com>
Subject: Re: [PATCH v6 2/4] dt-bindings: spi: add new clock name 'axi' for
 spi nor
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <matthias.bgg@gmail.com>, <bgolaszewski@baylibre.com>,
        <sean.wang@mediatek.com>, <bayi.cheng@mediatek.com>,
        <gch981213@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 15 Dec 2021 10:03:31 +0800
In-Reply-To: <YbdvIPq1hKPmKXXs@sirena.org.uk>
References: <20211211204014.8014-1-tinghan.shen@mediatek.com>
         <20211211204014.8014-3-tinghan.shen@mediatek.com>
         <YbdvIPq1hKPmKXXs@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for the reviews and advice.


On Mon, 2021-12-13 at 16:04 +0000, Mark Brown wrote:
> On Sun, Dec 12, 2021 at 04:40:12AM +0800, Tinghan Shen wrote:
> 
> > Some mtk spi nor has dedicated dma(s) inside. Add a new clock name,
> > axi,
> > for spi nor dma bus clock.
> >    clock-names:
> > +    minItems: 2
> >      items:
> >        - const: spi
> >        - const: sf
> > +      - const: axi
> 
> This will cause any existing DTs that don't have both spi and sf
> clocks
> defined to fail to validate which doesn't seem great.  Given that
> your
> commit message says this is only required for some SoCs shouldn't the
> minimum clocks requirement depend on which particular SoC/IP version
> is
> being used?  Not exactly sure how one specifies that in the YAML
> format.
> 
> Please submit patches using subject lines reflecting the style for
> the
> subsystem, this makes it easier for people to identify relevant
> patches.
> Look at what existing commits in the area you're changing are doing
> and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

I'll update the subject at next version.
It'll be "dt-bindings: spi: mtk-spi-nor: ...".


regards,
TingHan

