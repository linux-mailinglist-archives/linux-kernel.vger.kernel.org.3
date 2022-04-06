Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216934F5C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiDFLVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245473AbiDFLU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:20:59 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73897488582;
        Wed,  6 Apr 2022 00:41:51 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8206024000E;
        Wed,  6 Apr 2022 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649230909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvBaVRFAnY/ORDXxtA7VK6NPEsfRZG+u0pw044v6QD0=;
        b=QjfOHTepZwXd5T6HN/mX5v71tbA9htl+dE1rSpmoV7tL19875uFjQNjgrAbs02TkOaWeMv
        9mSalcjui6EjmOqZ4EdV0EO4VXQ0Qu+5N718q9Jib5yyto3lyg4S+R6WX5NGuSmW6XzfTD
        kIrhjt4vv2pXQTH361h3SLqrtQyJDRP0sbjditUu7QEUvVTLeYSrliPrIyesodbCVCLkvq
        YS32ew/tBOYBVpAatyytk8q4jtF9DXEpH0+3G2j6hOJrtf/yfBABdjxrHsuS1TKw31wnFX
        BBevqEIuquORrd6Zj8N7dmFtd7FUoZYGCz6aC6qbf0PzVZXDuEHoM885ZOcjcA==
Date:   Wed, 6 Apr 2022 09:40:19 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
Message-ID: <20220406094019.670a2956@fixe.home>
In-Reply-To: <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
        <Ykst0Vb4fk+iALzc@robh.at.kernel.org>
        <20220405092434.6e424ed4@fixe.home>
        <YkxWeMNw9Ba0KjHM@robh.at.kernel.org>
        <20220405175120.23fc6b2a@fixe.home>
        <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, 5 Apr 2022 12:11:51 -0500,
Rob Herring <robh@kernel.org> a =C3=A9crit :

> On Tue, Apr 5, 2022 at 10:52 AM Cl=C3=A9ment L=C3=A9ger <clement.leger@bo=
otlin.com> wrote:
> >
> > Le Tue, 5 Apr 2022 09:47:20 -0500,
> > Rob Herring <robh@kernel.org> a =C3=A9crit :
> > =20

[...]

> >
> > I also tried loading an overlay from a driver on an ACPI based system.
> > Their patch is (I guess) targeting the specific problem that there is
> > no base DT when using ACPI. However, Mark Brown feedback was not to
> > mix OF and ACPI: =20
>=20
> I agree there. I don't think we should use DT bindings in ACPI tables
> which is already happening. In this case, I think what's described by
> ACPI and DT must be completely disjoint. I think that's the case here
> as everything is downstream of the PCIe device.

Yes, there is no references to the host devices (at least in my case).

>=20
> > "That seems like it's opening a can of worms that might be best left
> > closed."
> >
> > But I would be interested to know how the Xilinx guys are doing that
> > on x86/ACPI based system. =20
>=20
> They aren't, yet...

Ok...

[...]

>=20
>=20
> > > I've told the Xilinx folks the same thing, but I would separate this
> > > into 2 parts. First is just h/w work in a DT based system. Second is
> > > creating a base tree an overlay can be applied to. The first part sho=
uld
> > > be pretty straightforward. We already have PCI bus bindings. The only
> > > tricky part is getting address translation working from leaf device t=
hru
> > > the PCI bus to host bus, but support for that should all be in place
> > > (given we support ISA buses off of PCI bus). The second part will
> > > require generating PCI DT nodes at runtime. That may be needed for bo=
th
> > > DT and ACPI systems as we don't always describe all the PCI hierarchy
> > > in DT. =20
> >
> > But then, if the driver generate the nodes, it will most probably
> > have to describe the nodes by hardcoding them right ? =20
>=20
> No, the kernel already maintains its own tree of devices. You just
> need to use that to generate the tree. That's really not much more
> than nodes with a 'reg' property encoding the device and function
> numbers.

Just to clarified a point, my PCI device exposes multiple peripherals
behind one single PCI function.

To be sure I understood what you are suggesting, you propose to create
a DT node from the PCI driver that has been probed dynamically
matching this same PCI device with a 'reg' property. I also think
this would requires to generate some 'pci-ranges' to remap the
downstream devices that are described in the DTBO, finally, load the
overlay to be apply under this newly created node. Is that right ?

>=20
> We already support matching a PCI device to a DT node. The PCI
> subsystem checks if there is a corresponding DT node for each PCI
> device created and sets the of_node pointer if there is. For
> OpenFirmware systems (PPC), there always is a node. For FDT, we
> generally don't have a node unless there are additional
> non-discoverable properties. Hikey960 is an example with PCI device
> nodes in the DT as it has a soldered down PCIe switch with downstream
> devices and non-discoverable properties (e.g. reset GPIO for each
> port).
>=20
> > Or probably load
> > some dtbo from the FS. If so, I would then have to describe the card
> > for both ACPI and DT. How is that better than using a single software
> > node description for both ACPI/OF based systems ? Or maybe I missed
> > something, but the device description won't come out of thin air I
> > guess. =20
>=20
> What you would have to load is a DT overlay describing all your
> downstream devices.
>=20
> We support DTBs (including DTBOs) built into the kernel already, so
> whether it's built into the kernel or in the FS is up to you really.

Indeed.

>=20
> > Also, when saying "That may be needed for both DT and ACPI systems", do
> > you actually meant that ACPI overlay should be described for ACPI based
> > systems and DT overlays for DT based ones ? =20
>=20
> No, as I said: "I think DT overlays is the right (or only) solution
> here." ACPI overlays doesn't seem like a workable solution because it
> can't describe your downstream devices.

Ok, so you are actually really suggesting to use OF overlays on ACPI
based systems. If so, I'm ok with that.

>=20
> The reason generating nodes may be needed on DT systems as well is
> that all PCI devices are not described in DT systems either.
>=20
> > If so, some subsystems do
> > not even support ACPI (reset for instance which is need for my
> > PCI card but that is not the only one). So how to accomodate both ? This
> > would result in having 2 separate descriptions for ACPI and OF and
> > potentially non working with ACPI description.
> >
> > Software nodes have the advantage of being independent from the
> > description systems used (ACPI/OF). If switching susbsystems to use
> > fwnode, this would also allows to accomodate easily for all nodes types
> > and potentially factorize some code. =20
>=20
> It's not independent. You are effectively creating the DT nodes with C
> code. Are these not DT bindings:
>=20
> > static const struct property_entry ddr_clk_props[] =3D {
> >         PROPERTY_ENTRY_U32("clock-frequency", 30000000),
> >         PROPERTY_ENTRY_U32("#clock-cells", 0),
> >         {}
> > }; =20
>=20
> Sure looks like DT bindings to me. I don't think moving them into the
> kernel as sw nodes avoids any of the potential pitfalls of mixing ACPI
> and DT. For example, what happens when you have a downstream sw node
> device that wants to do DMA allocations and transfers? I suspect that
> sw nodes can't really handle more than trivial cases.

When integrating with fwnode, the subsystem support will be almost the
same as the one with OF. But I agree that it requires certain level of
subsystem modifications to support fwnode.

>=20
>=20
> > > That could work either by the PCI subsystem creating nodes as it
> > > populates devices or your driver could make a request to populate nod=
es
> > > for its hierarchy. That's not a hard problem to solve. That's what
> > > OpenFirmware implementations do already. =20
> >
> > This would also require to get address translation working with ACPI
> > based systems since the PCI bus isn't described with DT on such
> > systems. I'm not sure how trivial it is. Or it would require to add PCI
> > root complex entries into the device-tree to allow adress translation
> > to work using the existing system probably. =20
>=20
> It would require all that most likely. Maybe there's some shortcuts we
> can take. All the necessary information is maintained by the kernel
> already. Normally it's populated from the firmware into the kernel
> structures. But here we need the opposite direction.
>=20
>=20
> > > https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx=
.com/ =20
> >
> > Looking at the feedback of the previous series that I mentionned,
> > absolutely nobody agreed on the solution to be adopted. I asked for a
> > consensus but I only got an answer from Hans de Goede which was ok
> > with the fwnode way. I would be really glad to have some consensus on
> > that in order to implement a final solution (and if the OF overlays is
> > the one to be used, I'll use it). =20
>=20
> Yes, that's a challenge, but buried in some patch series is not going
> to get you there.

Sorry, indeed, you were not on the series were the discussion took
place. I'll think about that next time.

> I am trying to widen the discussion because it is a
> problem that's been on my radar for some time.

Thanks for the proposal, maybe we can achieve something that will suit
everybody and solve the current problems.

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
