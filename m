Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62A64BF48B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiBVJT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiBVJTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:19:54 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25590149B96;
        Tue, 22 Feb 2022 01:19:24 -0800 (PST)
X-UUID: 951274d253d146568774f9b4553653be-20220222
X-UUID: 951274d253d146568774f9b4553653be-20220222
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 424485977; Tue, 22 Feb 2022 17:19:19 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Feb 2022 17:18:05 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Feb 2022 17:18:05 +0800
Message-ID: <2d53a11e31a9b521fd18d78aafe42b94bfa74aec.camel@mediatek.com>
Subject: Re: [PATCH v9 2/3] dt-bindings: pinctrl: mt8195: Add
 mediatek,drive-strength-adv property
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Sean Wang" <sean.wang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        <chunfeng.yun@mediatek.com>
Date:   Tue, 22 Feb 2022 17:18:05 +0800
In-Reply-To: <CACRpkdZ194_7+mHauDPwMHG3TeGnp2ENdcSDjZnWny1X4YTT7w@mail.gmail.com>
References: <20220112114724.1953-1-tinghan.shen@mediatek.com>
         <20220112114724.1953-3-tinghan.shen@mediatek.com>
         <18f7a647-6153-6d38-dff1-727b9592b01e@gmail.com>
         <102ea6303dd16fdf9ec931d0a1845a93afe92545.camel@mediatek.com>
         <CACRpkdZ194_7+mHauDPwMHG3TeGnp2ENdcSDjZnWny1X4YTT7w@mail.gmail.com>
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

On Sun, 2022-01-30 at 01:38 +0100, Linus Walleij wrote:
> On Tue, Jan 25, 2022 at 7:21 AM Tinghan Shen <tinghan.shen@mediatek.com> wrote:
> 
> > I want to send next version to update the CC list of this series, but I'm not sure
> > whether this will break the conversation between you and Linus.
> > 
> > Is it ok to send next version? or waiting the response?
> 
> Send a new version, I'll apply the v10 version!
> 
> Yours,
> Linus Walleij

Hi Linus,

The new version is available.


https://patchwork.kernel.org/project/linux-mediatek/patch/20220216113131.13145-3-tinghan.shen@mediatek.com/

v11 is rebased on 5.17-rc4 and it's the same as v10.


Best regards,
Tinghan
 

