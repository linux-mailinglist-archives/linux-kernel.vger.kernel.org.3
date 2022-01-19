Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8FC4943CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344145AbiASXQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbiASXQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:16:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF0C061574;
        Wed, 19 Jan 2022 15:16:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98A72614DE;
        Wed, 19 Jan 2022 23:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFF3C004E1;
        Wed, 19 Jan 2022 23:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642634216;
        bh=4uRWizOBaKdIv4eU9IeBasCKBDNbDWDfxnzAhH/pWmA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=X1gZj0K+EKHFwCdIhhAp3VDq76WY7t/Bs9cCB+zpi5VjmmifIdDGRqps1pyyx7HkS
         zVhwkegi8UHZrFp0+Qp+PpAMdJzJrmZFaL9QLUOWnvzKs6xzcYPcPGYDXvnP+Q9KdZ
         wP8oqelNhZpHZyMVkPKcGcB0uSIVKLnQGeahXW8s9d9Dkq9EOXYEXGnMX9eBqpl1ko
         idXYWoZebJZnaf7uzEg6bQ9f1rUkKH/RZ8T64xtzqwb+g7ZoSVyTbP8Q4d6dG9JRxK
         jstQK5Le9qmgf87xFOcK96D7cAw2ucX18ENoKRkIIE0ryvxsQCp1mVRsBknkp0QrG6
         5KE/VZssUw4Ag==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220115122618.plhiqnjh2755bv5h@pali>
References: <20210930095838.28145-1-pali@kernel.org> <163425678347.1688384.10695189000353676651@swboyd.mtv.corp.google.com> <20211015090937.gnt66hgugrhwnkei@pali> <20211015093701.pfvkighxsndj4ujg@pali> <163433494758.1688384.5994009027317282677@swboyd.mtv.corp.google.com> <20211016064210.7ahqfqcvf66wtt66@pali> <20220115080213.0CCAFC36AE3@smtp.kernel.org> <20220115115018.he4hnnhlvrb6kann@pali> <20220115130509.4a240730@thinkpad> <20220115122618.plhiqnjh2755bv5h@pali>
Subject: Re: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
To:     Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
        Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Date:   Wed, 19 Jan 2022 15:16:54 -0800
User-Agent: alot/0.10
Message-Id: <20220119231655.EFFF3C004E1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pali Roh=C3=A1r (2022-01-15 04:26:18)
> On Saturday 15 January 2022 13:05:09 Marek Beh=C3=BAn wrote:
> > On Sat, 15 Jan 2022 12:50:18 +0100
> > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >=20
> > > On Saturday 15 January 2022 00:02:11 Stephen Boyd wrote:
> > > > Quoting Pali Roh=C3=A1r (2021-10-15 23:42:10) =20
> > > > >=20
> > > > > If I was designing this driver and DTS bindings I would have choo=
se
> > > > > something like this:
> > > > >=20
> > > > > uart@0x12000 { =20
> > > >=20
> > > > Drop the 0x
> > > >  =20
> > > > >     reg =3D <0x12000 0x18>, <0x12200 0x30>;
> > > > >     clock-controller {
> > > > >         ...
> > > > >     }; =20
> > > >=20
> > > > Drop this node and put whatever properties are inside into the pare=
nt
> > > > node.
> > > >  =20
> > > > >     serial1 {
> > > > >         ...
> > > > >         status =3D "disabled";
> > > > >     };
> > > > >     serial2 {
> > > > >         ...
> > > > >         status =3D "disabled";
> > > > >     };
> > > > > };
> > > > >=20
> > > > > Meaning that 0x12000 node would be 3 subnodes and all registers w=
ould be
> > > > > defined in top level nodes and would be handled by one driver.
> > > > >=20
> > > > > This is really how hardware block looks like. But it is not backw=
ard
> > > > > compatible... =20
> > > >=20
> > > > Sounds good to me. I presume we need the serial child nodes so we c=
an
> > > > reference them from the stdout-path? =20
> > >=20
> > > Yes, exactly, separate nodes for serial1 and serial2 are still requir=
ed.
> > >=20
> > > But dropping clock controller is not possible as for higher baudrates=
 we
> > > need to use and configure uart clock controller. Without it we just g=
et
> > > comparable feature support which is already present in driver.
> >=20
> > What Stephen means is making clock controller out of the uart node
> > directly. No need to add separate subnode just for clock controller.
>=20
> This is already implemented in v7 patch series. Clock controller is
> already outside of uart nodes.

I mean to combine the uart node and the clock-controller node together

	uart-wrapper {
		reg =3D <0x12000 0x18>, <0x12200 0x30>;
		#clock-cells ...

		serial1 {
			...
		};

		serial2 {
			...
		};
	};
