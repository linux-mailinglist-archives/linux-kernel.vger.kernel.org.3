Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867984903DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbiAQIai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:30:38 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:58124 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232331AbiAQIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:30:37 -0500
X-UUID: 3370cf3aacdc4603b15923835050b341-20220117
X-UUID: 3370cf3aacdc4603b15923835050b341-20220117
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 466748169; Mon, 17 Jan 2022 16:30:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Jan 2022 16:30:26 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 16:30:25 +0800
Message-ID: <efc06609571d7b6a1d5327fa37661af8ddce8675.camel@mediatek.com>
Subject: Re: [PATCH 2/3] mmc: core: Add support for SDIO async interrupt
From:   Axe Yang <axe.yang@mediatek.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing =?UTF-8?Q?=28=E4=BA=95=E6=9C=9D=E5=A4=A9=29?= 
        <Chaotian.Jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 17 Jan 2022 16:30:25 +0800
In-Reply-To: <60f3d381-1af4-d002-e179-9550672dae5b@mediatek.com>
References: <20220117071220.17330-1-axe.yang@mediatek.com>
         <20220117071220.17330-3-axe.yang@mediatek.com>
         <60f3d381-1af4-d002-e179-9550672dae5b@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-17 at 16:14 +0800, Macpaul Lin wrote:
> On 1/17/22 3:12 PM, Axe Yang wrote:
> > If cap-sdio-async-irq flag is set in host dts node, parse EAI
> > information from SDIO CCCR interrupt externsion segment. If async
> > interrupt is supported by SDIO card then send command to card to
> > enable it and set enable_async_irq flag in sdio_cccr structure to
> > 1.
> > The parse flow is implemented in sdio_read_cccr().
> > 
> > Acked-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> 
> [deleted...]
> 
> It seems the prefix "[PATCH v3]" didn't applied to subject of each
> patch 
> in v3 series. Please remember to keep the version aligned in the
> same 
> patch set. Use "git format-patch --subject-prefix=[PATCH v3]" to
> help 
> you to keep the version number aligned is suggested.
> 
> Thanks!
> Macpaul Lin

Patches have been resent. Thanks.

