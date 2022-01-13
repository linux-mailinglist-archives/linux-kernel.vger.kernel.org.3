Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4336348D062
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiAMCRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:17:33 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:38272 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231591AbiAMCRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:17:25 -0500
X-UUID: 1f0b2121f4214d3982b0d380d1cb5b20-20220113
X-UUID: 1f0b2121f4214d3982b0d380d1cb5b20-20220113
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 493848900; Thu, 13 Jan 2022 10:17:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 13 Jan 2022 10:17:21 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 10:17:21 +0800
Message-ID: <903a27d5d68dddb23b9ace2708689a55f22714e8.camel@mediatek.com>
Subject: Re: [PATCH v9 0/3] Add basic SoC support for mediatek mt8195
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        <chunfeng.yun@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "David Matlack" <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        "Marc Zyngier" <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>
Date:   Thu, 13 Jan 2022 10:17:21 +0800
In-Reply-To: <e4f20498-3685-207f-2b94-0cb0ada725a4@oracle.com>
References: <20220112114724.1953-1-tinghan.shen@mediatek.com>
         <e4f20498-3685-207f-2b94-0cb0ada725a4@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Wed, 2022-01-12 at 15:54 +0100, Maciej S. Szmigiero wrote:
> On 12.01.2022 12:47, Tinghan Shen wrote:
> > This series adds basic SoC support for Mediatek's SoC MT8195.
> 
> Nice patchset Tinghan, however I can't stop wondering why I was CCed
> on
> it (and Paolo and Sean, too) - this isn't KVM related at all.
> 
> scripts/get_maintainer.pl going wild?
> 
Thanks,
Maciej

I'm sorry. I just find out that the file pattern I used includes
unrelated files to this series.

I'll clean up the CC list at next version.

Best regards,
TingHan

