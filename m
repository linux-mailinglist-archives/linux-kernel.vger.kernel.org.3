Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A024BAF9E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiBRCXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:23:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiBRCXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:23:32 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0684B632A;
        Thu, 17 Feb 2022 18:23:12 -0800 (PST)
X-UUID: 0f9ddc87c92c42ac95e8ab0eca6a7c45-20220218
X-UUID: 0f9ddc87c92c42ac95e8ab0eca6a7c45-20220218
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1899599194; Fri, 18 Feb 2022 10:23:08 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 18 Feb 2022 10:23:07 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Feb
 2022 10:23:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Feb 2022 10:23:07 +0800
Message-ID: <b1146e977bbbda7bd74d9f4096ed16dc371e1e67.camel@mediatek.com>
Subject: Re: [PATCH v11 0/3] Add basic SoC support for mediatek mt8195
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Bartosz Golaszewski" <bgolaszewski@baylibre.com>,
        Sean Wang <Sean.Wang@mediatek.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "ryder.lee@kernel.org" <ryder.lee@kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "Chunfeng Yun =?UTF-8?Q?=28=E4=BA=91=E6=98=A5=E5=B3=B0=29?=" 
        <Chunfeng.Yun@mediatek.com>, Fabien Parent <fparent@baylibre.com>,
        "Bear Wang" <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>
Date:   Fri, 18 Feb 2022 10:23:07 +0800
In-Reply-To: <e17592b2-5e02-44a6-5c21-ac599af5fce1@mediatek.com>
References: <20220216113131.13145-1-tinghan.shen@mediatek.com>
         <e17592b2-5e02-44a6-5c21-ac599af5fce1@mediatek.com>
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

Hi Macpaul,

On Thu, 2022-02-17 at 14:24 +0800, Macpaul Lin wrote:
> On 2/16/22 7:31 PM, Tinghan Shen wrote:
> > This series adds basic SoC support for Mediatek's SoC MT8195.
> > 
> > ---
> > Changes in v11:
> >    - rebase on 5.17-rc4
> > Changes in v10:
> >    - clean CC list
> > Changes in v9:
> >    - remove duplicated cpus dt-bindings patch in v8
> > Changes in v8:
> >    - v7 mediatek,spi-mtk-nor.yaml patch is applied in branch for-5.17 at
> >      kernel/git/broonie/spi.git
> >    - v7 pinctrl-mt8195.yaml patch is applied in branch for-next at
> >      kernel/git/linusw/linux-pinctrl.git
> >    - add cortex-a78 compatible to cpus dt-bindings
> >    - add mediatek,drive-strength-adv property to pinctrl dt-bindings
> >    - fix evb dts
> >      - remove i2c nodes with disabled status from dts
> >      - fix pin properties not match pinctrl dt-bindings
> >      - remove unnecessary u3port*
> >    - fix dtsi
> >      - fix node format
> >      - reorder oscillator* nodes
> >      - fix node name of cpu idle nodes
> >      - remove clock-frequency property in the timer node
> >      - reorder clock and clock names in usb nodes
> > Changes in v7:
> >    - refine title of spi-nor dt-bindings patch
> >    - refine commit message of pinctrl dt-bindings patch
> >    - update pinctrl-mt8195.yaml
> >      - change property pattern from 'pins' to '^pins'
> >      - update examples with new property in descriptions
> >      - add new example
> >    - drop '_' from node names of pinctrl subnodes in mt8195-evb.dts
> > Changes in v6:
> >    - rebase on 5.16-rc1
> >    - add new clock name to spi-nor dt-bindings
> >    - add "pins" property in pinctrl dt-bindings
> >    - fix fails of dtbs_checks
> >      - remove "arm,armv8" not matched in yaml from cpu compatile
> >      - fix node name of xhci
> >      - remvoe xhci upstreaming wakeup properties
> >      - remove xhci unused properties address-cells and size-cells
> >      - fix node name of ufs-phy
> >      - fix node name of spi-nor
> >      - fix node name and sub-nodes of pinctrl
> >      - fix mmc compatible
> > Changes in v5:
> >    - enable basic nodes in mt8195-evb.dts
> >    - remove dedicated clock nodes
> >    - add mmc2 node
> >    - fix interrupt number of pinctrl node
> >    - update clock nodes to apply internal fixes
> >    - add dt-bindings for perficfg node
> > 
> > v4 thread:
> > 
https://urldefense.com/v3/__https://lore.kernel.org/all/20210922093303.23720-2-seiya.wang@mediatek.com/__;!!CTRNKA9wMg0ARbw!xv2H7ZXYIUG7YY1R5OuFgbvDxyfaE6dkkD5H_PciKAZAb5jk-uThgSgItGuvt2d6gCs$
> > v3 thread:
> > 
https://urldefense.com/v3/__https://lore.kernel.org/all/20210601075350.31515-2-seiya.wang@mediatek.com/__;!!CTRNKA9wMg0ARbw!xv2H7ZXYIUG7YY1R5OuFgbvDxyfaE6dkkD5H_PciKAZAb5jk-uThgSgItGuvgIQSNYo$
> > v2 thread:
> > 
https://urldefense.com/v3/__https://lore.kernel.org/all/20210319023427.16711-10-seiya.wang@mediatek.com/__;!!CTRNKA9wMg0ARbw!xv2H7ZXYIUG7YY1R5OuFgbvDxyfaE6dkkD5H_PciKAZAb5jk-uThgSgItGuvBx50AeU$
> > v1 thread:
> > 
https://urldefense.com/v3/__https://lore.kernel.org/all/20210316111443.3332-11-seiya.wang@mediatek.com/__;!!CTRNKA9wMg0ARbw!xv2H7ZXYIUG7YY1R5OuFgbvDxyfaE6dkkD5H_PciKAZAb5jk-uThgSgItGuvpH_NtEY$
> > ---
> > 
> > Tinghan Shen (3):
> >    dt-bindings: arm: mediatek: Add mt8195 pericfg compatible
> >    dt-bindings: pinctrl: mt8195: Add mediatek,drive-strength-adv property
> >    arm64: dts: Add mediatek SoC mt8195 and evaluation board
> > 
> >   .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
> >   .../bindings/pinctrl/pinctrl-mt8195.yaml      |   35 +
> >   arch/arm64/boot/dts/mediatek/Makefile         |    1 +
> >   arch/arm64/boot/dts/mediatek/mt8195-evb.dts   |  161 +++
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 1049 +++++++++++++++++
> >   5 files changed, 1247 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > 
> 
> Just trying to clarify something.
> Dear Tinghan, is there any "lines of code" changed between v10 and v11  
> due to the rebase? Is that you just updated the parent commit hash for  
> rebasing this patchset to 5.17-rc4? I've just get confused if v10 and  
> v11 are duplicated then should we need to review the patch again in detail?
> 
> Thanks.
> Macpaul Lin

Thanks for your review.

There's no change introduced after rebase v10 to 5.17-rc4.

v11 and v10 are the same.


Best regards,
TingHan




