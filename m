Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B2048F2AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 23:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiANW5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 17:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiANW5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 17:57:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11608C061574;
        Fri, 14 Jan 2022 14:57:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8004D61FBB;
        Fri, 14 Jan 2022 22:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D79C36AE9;
        Fri, 14 Jan 2022 22:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642201019;
        bh=mSHMa56m6QrDlNOS78VQ+F4YIisxhlLmSPa8G3JzpKQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Hvf0/9Wl1naogft9BYGLGXy/yU3H5yh9dDc+JPMuxrIXXdGMYKqwvwJOwRO3S8tth
         tg31cmRgEq2Lz6iSByiqxVDr7WfN6VurlpeoqfNfc7g6KbDkddTGvy4Vno5NNN6y7h
         n3W8SjfulhieBbiOoNGXeVtQyN0iRrB4iTVb6RsDwWM99jwjPXgRj1Xbi9jEZV7Atv
         /ZDwXrhf9CRPHKdbK1581ObI95yCKd49Xxeidqu1Mr/sh01vQnnFgEyeZORoDSdv9P
         SHtXbSIi76rF6EEvEGDY5PkaTLbAdgBJr9FgtYSr4JC5ue7kkvbngj9+1oprJ81Vbb
         FrZdZjL/a9S2g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220114105100.im6gmkt6fjl2aiwl@pali>
References: <20210930095838.28145-1-pali@kernel.org> <20211103214209.azo2z3z4gy7aj5hu@pali> <87ee6bm9hn.fsf@BL-laptop> <20220114105100.im6gmkt6fjl2aiwl@pali>
Subject: Re: [PATCH v7 0/6] serial: mvebu-uart: Support for higher baudrates
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
To:     Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Date:   Fri, 14 Jan 2022 14:56:58 -0800
User-Agent: alot/0.10
Message-Id: <20220114225659.D5D79C36AE9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pali Roh=C3=A1r (2022-01-14 02:51:00)
> Hello Stephen!
>=20
> On Friday 17 December 2021 18:23:00 Gregory CLEMENT wrote:
> > Hello Pali,
> >=20
> > > On Thursday 30 September 2021 11:58:32 Pali Roh=C3=A1r wrote:
> > >> This patch series add support for baudrates higher than 230400 on
> > >> Marvell Armada 37xx boards.
> > >
> > > Stephen, Gregory, are there any issues with this patch series?
> >=20
> > I am not found of these changes but let's apply it as I didn't take time
> > to do a better review.
> >=20
> > However I can't apply the dt part if the driver is not merged.
>=20
> Stephen, are there any issues with driver (non-DT) part changes in this
> patch series? If not, could you please merge them? This patch series is
> here on the list since September without any request for change...

Oh I missed this thread. I thought it was going to be resent.

>=20
> We would really like to see support for higher baudrates for Armada 3720
> platforms in mainline kernel.

If we're adding new support why can't we break with backwards
compatibility for the binding and do it a different way?
