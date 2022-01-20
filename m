Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6E5494712
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 07:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358635AbiATGBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 01:01:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57156 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiATGBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 01:01:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61C07B81CDB;
        Thu, 20 Jan 2022 06:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF24C340E0;
        Thu, 20 Jan 2022 06:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642658509;
        bh=byhNPY5mxbXic33tX2h88V+7lpizYcbc+f67+IcnEnk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iT6S9Ey3WM7CUkSZgLpHioATP2Veja0Ox+KzsCXn2W6/FNSh72qpmJb5rF5exVWL0
         2lHQNsnDveaYyZZujZrgsG27Xps6nllbaO0FsdTA5ReNvnwMb6Gy+iWmc0ScnSOQPN
         PekZ6rrRpLtEytMTl08oUedVMllmjW3x+q+QU9xjTR6czljKxFlmQBKMQlL9LnsEbf
         KmRdkRpp26cR4IfrDajklvo91aRgqb+4Tb9zEuGntUHnKXsFQn85VD5dYOR8Gx7W1o
         SxPBdwAE2qiGxBhMLO86iYTgrOGUDHH7E2NKrYEfiOzYFdHYA+dF0KlgvkDYv/gwuT
         yEHCXGb/H3aqA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220120000651.in7s6nazif5qjkme@pali>
References: <163425678347.1688384.10695189000353676651@swboyd.mtv.corp.google.com> <20211015093701.pfvkighxsndj4ujg@pali> <163433494758.1688384.5994009027317282677@swboyd.mtv.corp.google.com> <20211016064210.7ahqfqcvf66wtt66@pali> <20220115080213.0CCAFC36AE3@smtp.kernel.org> <20220115115018.he4hnnhlvrb6kann@pali> <20220115130509.4a240730@thinkpad> <20220115122618.plhiqnjh2755bv5h@pali> <20220119231655.EFFF3C004E1@smtp.kernel.org> <20220120000651.in7s6nazif5qjkme@pali>
Subject: Re: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
To:     Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Date:   Wed, 19 Jan 2022 22:01:47 -0800
User-Agent: alot/0.10
Message-Id: <20220120060149.0FF24C340E0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pali Roh=C3=A1r (2022-01-19 16:06:51)
> On Wednesday 19 January 2022 15:16:54 Stephen Boyd wrote:
> > Quoting Pali Roh=C3=A1r (2022-01-15 04:26:18)
> > > On Saturday 15 January 2022 13:05:09 Marek Beh=C3=BAn wrote:
> > > > On Sat, 15 Jan 2022 12:50:18 +0100
> > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > >=20
> > > > > On Saturday 15 January 2022 00:02:11 Stephen Boyd wrote:
> > > > > > Quoting Pali Roh=C3=A1r (2021-10-15 23:42:10) =20
> > > > > > >=20
> > > > > > > If I was designing this driver and DTS bindings I would have =
choose
> > > > > > > something like this:
> > > > > > >=20
> > > > > > > uart@0x12000 { =20
> > > > > >=20
> > > > > > Drop the 0x
> > > > > >  =20
> > > > > > >     reg =3D <0x12000 0x18>, <0x12200 0x30>;
> > > > > > >     clock-controller {
> > > > > > >         ...
> > > > > > >     }; =20
> > > > > >=20
> > > > > > Drop this node and put whatever properties are inside into the =
parent
> > > > > > node.
> > > > > >  =20
> > > > > > >     serial1 {
> > > > > > >         ...
> > > > > > >         status =3D "disabled";
> > > > > > >     };
> > > > > > >     serial2 {
> > > > > > >         ...
> > > > > > >         status =3D "disabled";
> > > > > > >     };
> > > > > > > };
> > > > > > >=20
> > > > > > > Meaning that 0x12000 node would be 3 subnodes and all registe=
rs would be
> > > > > > > defined in top level nodes and would be handled by one driver.
> > > > > > >=20
> > > > > > > This is really how hardware block looks like. But it is not b=
ackward
> > > > > > > compatible... =20
> > > > > >=20
> > > > > > Sounds good to me. I presume we need the serial child nodes so =
we can
> > > > > > reference them from the stdout-path? =20
> > > > >=20
> > > > > Yes, exactly, separate nodes for serial1 and serial2 are still re=
quired.
> > > > >=20
> > > > > But dropping clock controller is not possible as for higher baudr=
ates we
> > > > > need to use and configure uart clock controller. Without it we ju=
st get
> > > > > comparable feature support which is already present in driver.
> > > >=20
> > > > What Stephen means is making clock controller out of the uart node
> > > > directly. No need to add separate subnode just for clock controller.
> > >=20
> > > This is already implemented in v7 patch series. Clock controller is
> > > already outside of uart nodes.
> >=20
> > I mean to combine the uart node and the clock-controller node together
> >=20
> >       uart-wrapper {
> >               reg =3D <0x12000 0x18>, <0x12200 0x30>;
> >               #clock-cells ...
> >=20
> >               serial1 {
> >                       ...
> >               };
> >=20
> >               serial2 {
> >                       ...
> >               };
> >       };
>=20
> Ok, now I see what you mean.
>=20
> But problem is that this is not backward compatible change. And would
> not work per existing DT bindings definitions, which defines how
> bootloader should set configured clocks.
>=20
> As I wrote in emails 3 months ago, this new "proposed" DTS definition is
> something which I would have chosen if I had designed this driver and
> bindings in past. But that did not happen and different approach is
> already widely in used.
>=20
> To support existing DTS definitions and bootloaders, it is really
> required to have current structure backward compatible like it is
> defined in current DT bindings document. And my changes in this patch
> series are backward compatible.

I'm lost. Is the bootloader the one that's expecting some particular
serial node format and updating something? What is the bootloader doing?

>=20
> To change DTS structure, it would be needed to provide uart nodes in DTS
> files two times: once in old style (the current one) and second time in
> this new style.

That's not a good idea. Why do we need to support both at the same time?

>=20
> But such thing would even more complicate updating driver and it needs
> to be implemented.
>=20
> Plus this would open a question how to define default stdout-path if
> there would be 4 serial nodes, where one pair would describe old style
> and second pair new style; meaning that 2 cross nodes would describe
> same define.

Huh? We shouldn't have both bindings present in the DTB.

>=20
> For me this looks like a more complications and I do not see any benefit
> from it.
>=20
> It is really important to break backward compatibility, just to try
> having new cleaner API at the cost of having more complications and
> requirement for more development and also important maintenance?

It's important to not make DT nodes have reg properties that overlap.
Maybe this is a DT purist viewpoint and I'm totally off base! I think
Rob did ack this binding already so I must be coming from the wrong
angle.

Nothing prevents register overlap from happening in practice, but it's
good to avoid such a situation as it clearly divides the I/O space by
assigning an address range to a particular device. In this case, we see
the two uarts are really one device, but we need two nodes in DT for
stdout-path, so we make some child nodes and have the driver figure out
which serial port to use for the console.

We shouldn't be adding more nodes to DT to get drivers to probe for
device I/O spaces that have already been described in DT. When this
happens, we learn that some I/O range is actually a combination of
functions, like uart and clks, and thus we should be able to add any
required properties to the existing DT node to support that new feature
that wasn't described before in the binding.
