Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7293D48F6A6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiAOMFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAOMFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:05:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930CFC061574;
        Sat, 15 Jan 2022 04:05:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33257B800E2;
        Sat, 15 Jan 2022 12:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B253C36AE3;
        Sat, 15 Jan 2022 12:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642248317;
        bh=2IT+FQbGuQK8tZVADwQ/U1hJPKJDewZokL/75ySxy4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nJmsxeN7eNg6Ht9L7sZ3312fAX5DCZ1KMwL3ZBGk8jEx8f/Ja8iNyqGLzj5MRf5am
         4eZT/c4qBEzaHmM1uPQKbhOcBwubWTMbGp4O60vgXW9PG/zhEclq23u8s71gW5aeMU
         KS1pFEWbuY6KJr4qcrf/vixin9sTripjkHQfSuDJcj8vSb6iAsE2WttJ8k2xLhlbwv
         n3ToJD949Y3oFqtC0hmVzm6CMqNcq+U45mED9RwDJa1xQg1mnj3fogFxeKjX+vsGfP
         JOAn2JbFDwMw9lom5c8EpxT/Bh7MlGRnAyCD8QLqpgRqMSat12f/62FVUbt01+A144
         AcpmpKHl+p3Ug==
Date:   Sat, 15 Jan 2022 13:05:09 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings
 for marvell,armada-3700-uart-clock
Message-ID: <20220115130509.4a240730@thinkpad>
In-Reply-To: <20220115115018.he4hnnhlvrb6kann@pali>
References: <20210930095838.28145-1-pali@kernel.org>
        <20210930095838.28145-4-pali@kernel.org>
        <163425678347.1688384.10695189000353676651@swboyd.mtv.corp.google.com>
        <20211015090937.gnt66hgugrhwnkei@pali>
        <20211015093701.pfvkighxsndj4ujg@pali>
        <163433494758.1688384.5994009027317282677@swboyd.mtv.corp.google.com>
        <20211016064210.7ahqfqcvf66wtt66@pali>
        <20220115080213.0CCAFC36AE3@smtp.kernel.org>
        <20220115115018.he4hnnhlvrb6kann@pali>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 12:50:18 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Saturday 15 January 2022 00:02:11 Stephen Boyd wrote:
> > Quoting Pali Roh=C3=A1r (2021-10-15 23:42:10) =20
> > >=20
> > > If I was designing this driver and DTS bindings I would have choose
> > > something like this:
> > >=20
> > > uart@0x12000 { =20
> >=20
> > Drop the 0x
> >  =20
> > >     reg =3D <0x12000 0x18>, <0x12200 0x30>;
> > >     clock-controller {
> > >         ...
> > >     }; =20
> >=20
> > Drop this node and put whatever properties are inside into the parent
> > node.
> >  =20
> > >     serial1 {
> > >         ...
> > >         status =3D "disabled";
> > >     };
> > >     serial2 {
> > >         ...
> > >         status =3D "disabled";
> > >     };
> > > };
> > >=20
> > > Meaning that 0x12000 node would be 3 subnodes and all registers would=
 be
> > > defined in top level nodes and would be handled by one driver.
> > >=20
> > > This is really how hardware block looks like. But it is not backward
> > > compatible... =20
> >=20
> > Sounds good to me. I presume we need the serial child nodes so we can
> > reference them from the stdout-path? =20
>=20
> Yes, exactly, separate nodes for serial1 and serial2 are still required.
>=20
> But dropping clock controller is not possible as for higher baudrates we
> need to use and configure uart clock controller. Without it we just get
> comparable feature support which is already present in driver.

What Stephen means is making clock controller out of the uart node
directly. No need to add separate subnode just for clock controller.

Marek
