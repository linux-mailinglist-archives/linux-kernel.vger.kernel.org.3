Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E2D59E414
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242432AbiHWM4m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Aug 2022 08:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbiHWM4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:56:12 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29846F57D;
        Tue, 23 Aug 2022 03:01:10 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oQQi4-0003tG-BS; Tue, 23 Aug 2022 12:00:36 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     =?ISO-8859-1?Q?Jo=E3o_H=2E?= Spies <jhlspies@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: rockchip: Enhance support for IRQ_TYPE_EDGE_BOTH
Date:   Tue, 23 Aug 2022 12:00:34 +0200
Message-ID: <4242490.iIbC2pHGDl@diego>
In-Reply-To: <CACRpkda6VoNjJfKY3+oCvdB+V6O_4cumKpjVSdBb9e8mEmHF6g@mail.gmail.com>
References: <20220808025121.110223-1-jhlspies@gmail.com> <CACRpkda6VoNjJfKY3+oCvdB+V6O_4cumKpjVSdBb9e8mEmHF6g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 22. August 2022, 11:03:08 CEST schrieb Linus Walleij:
> On Mon, Aug 8, 2022 at 4:53 AM João H. Spies <jhlspies@gmail.com> wrote:
> 
> > Switching between falling/rising edges for IRQ_TYPE_EDGE_BOTH on pins that
> > require debounce can cause the device to lose events due to a desync
> > between pin state and irq type.
> >
> > This problem is resolved by switching between IRQ_TYPE_LEVEL_LOW and
> > IRQ_TYPE_LEVEL_HIGH instead.
> >
> > Fixes: 936ee26 ("gpio/rockchip: add driver for rockchip gpio")
> > Signed-off-by: João H. Spies <jhlspies@gmail.com>
> 
> No reaction from maintainers so I'm just gonna assume this fix is
> correct and applied for fixes.

This plays with behavioral peculiarities of the gpio controller
(using the level setting to hopefully prevent missing edge irqs),
so doesn't follow

So I guess it really is more of a wait-and-see. And I guess as João
seems to have experienced that issue, that will hopefully work
for others too.

Heiko


