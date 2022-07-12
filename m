Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04AF57293C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiGLWXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiGLWXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:23:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E625223BD8;
        Tue, 12 Jul 2022 15:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AD33616C3;
        Tue, 12 Jul 2022 22:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CC3C3411E;
        Tue, 12 Jul 2022 22:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657664624;
        bh=EvcM/P0S92GwQxfYcLkzyCX5HzivdX1VwMpuvCer620=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oxpbHPcJ7VyRvD9wGYRaht6bT/aAA0xiYC5nx7ltxDBtmJZ1lHP1XJEmzwGrNVJFc
         gglHbVL1cQjC9PFRbCtLF6lA8vvtxa3wPzBY/LMholxuj32eaPwhUNDsgsBuYwvzEq
         NKqyILuNQXSlVo3HR9YXYtjRfvOhw97vBIOg8hdSpu+8EhcxLPOWrBZwob7Nso5ib+
         h+4Wv6CT6cmYcueewf28kI0mHLHVE4ddAaRk8pg+7a2GzUXVgDqChr7+03+fxBmbEu
         7pyX/RUkh0VX/QZBvIGoHHZKmXcJst38AizRKAG7vpvD3AL1hRM+BmQlhSqQPyCAWu
         4FbvNAS3GcCMA==
Date:   Wed, 13 Jul 2022 00:23:37 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] ARM: dts: mvebu: Add definitions for PCIe
 legacy INTx interrupts
Message-ID: <20220713002337.26bffcd9@thinkpad>
In-Reply-To: <Ys2oaL7U7Ue5syU4@lunn.ch>
References: <20220712164108.30262-1-kabel@kernel.org>
        <Ys2oaL7U7Ue5syU4@lunn.ch>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 18:59:20 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Jul 12, 2022 at 06:40:58PM +0200, Marek Beh=C3=BAn wrote:
> > As suggested by Gregory [1] (although he suggested it only for armada
> > 380), add definitions for PCIe legacy INTx interrupts into every DTS
> > file used by the pci-mvebu.c controller driver.
> >=20
> > It was tested on 88F6820 (A385) and 88F6281 (Kirkwood) SoCs.
> >=20
> > [1] https://lore.kernel.org/linux-arm-kernel/87wnhxjxlq.fsf@BL-laptop/
> >=20
> > Changes since v1:
> > - dropped armada-385 patch, which was already applied
> > - added commit messages =20
>=20
> Thanks for updating the commit message.
>=20
> I don't see any Fixes: tags here. So from that, can i assume that
> there are no known broken devices? We don't need to involve stable.

I don't think so. If it turns out we do, we can just send it to stable
afterwards.

Marek
