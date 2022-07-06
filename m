Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E308756892C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiGFNRE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Jul 2022 09:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiGFNRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:17:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09F87D99;
        Wed,  6 Jul 2022 06:17:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2118C106F;
        Wed,  6 Jul 2022 06:17:01 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6860C3F792;
        Wed,  6 Jul 2022 06:16:59 -0700 (PDT)
Date:   Wed, 6 Jul 2022 14:16:55 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/6] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
Message-ID: <20220706141655.15d2dd0e@donnerap.cambridge.arm.com>
In-Reply-To: <5278570.Sb9uPGUboI@kista>
References: <20220428230933.15262-1-andre.przywara@arm.com>
        <22699277.6Emhk5qWAg@kista>
        <20220704225534.3e1a901a@slackpad.lan>
        <5278570.Sb9uPGUboI@kista>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jul 2022 19:32:26 +0200
Jernej Škrabec <jernej.skrabec@gmail.com> wrote:

Hi Jernej,

so after seemingly having finished writing this email, I realised that
this won't really help, as I think this diverts the discussion. And the
problem has been around for a while, and won't probably be solved easily
or quickly. I think we agree to disagree here, or we should admit that
there are different approaches ("bundled firmware" vs. "UEFI"), so in the
interest of not blocking the H616 series:

Shall I just keep the firmware node? This would work both ways, whereas
dropping the node would impede the "bundled firmware" approach?

Answers and replies, as mentioned going potentially a bit off-topic, below.

> Dne ponedeljek, 04. julij 2022 ob 23:58:02 CEST je Andre Przywara napisal(a):
> > On Mon, 04 Jul 2022 20:42:47 +0200
> > Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
> > 
> > Hi Jernej,
> >   
> > > Dne ponedeljek, 04. julij 2022 ob 15:30:57 CEST je Andre Przywara   
> napisal(a):
> > > > On Sat, 02 Jul 2022 23:16:53 +0200
> > > > Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
> > > > 
> > > > Hi Jernej,
> > > >   
> > > > > Dne četrtek, 30. junij 2022 ob 02:04:10 CEST je Andre Przywara   
> napisal(a):
> > > > > > On Tue, 03 May 2022 21:05:11 +0200
> > > > > > Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
> > > > > > 
> > > > > > Hi Jernej,
> > > > > > 
> > > > > > many thanks for taking the time to wade through this file!
> > > > > >   
> > > > > > > Dne petek, 29. april 2022 ob 01:09:30 CEST je Andre Przywara  
> > > 
> > > napisal(a):  
> > > > > > > > This (relatively) new SoC is similar to the H6, but drops the  
> > > 
> > > (broken)
> > >   
> > > > > > > > PCIe support and the USB 3.0 controller. It also gets the
> > > > > > > > management
> > > > > > > > controller removed, which in turn removes *some*, but not all of
> > > > > > > > the
> > > > > > > > devices formerly dedicated to the ARISC (CPUS).
> > > > > > > > And while there is still the extra sunxi interrupt controller,
> > > > > > > > the
> > > > > > > > package lacks the corresponding NMI pin, so no interrupts for
> > > > > > > > the  
> > > 
> > > PMIC.
> > >   
> > > > > > > > The reserved memory node is actually handled by Trusted Firmware  
> > > 
> > > now,
> > >   
> > > > > > > > but U-Boot fails to propagate this to a separately loaded DTB,
> > > > > > > > so we
> > > > > > > > keep it in here for now, until U-Boot learns to do this
> > > > > > > > properly.
> > > > > > > > 
> > > > > > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > > > > > ---
> > > > > > > > 
> > > > > > > >  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 574
> > > > > > > >  +++++++++++++++  
> > > 
> > > +++
> > >   
> > > > > > > >  1 file changed, 574 insertions(+)
> > > > > > > >  create mode 100644
> > > > > > > >  arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > > > > > > > 
> > > > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > > > > > > > b/arch/arm64/  
> > > > > > > 
> > > > > > > boot/dts/allwinner/sun50i-h616.dtsi
> > > > > > >   
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..cc06cdd15ba5
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > > > > > > > @@ -0,0 +1,574 @@
> > > > > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > > > > +// Copyright (C) 2020 Arm Ltd.
> > > > > > > > +// based on the H6 dtsi, which is:
> > > > > > > > +//   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> > > > > > > > +
> > > > > > > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > > > > +#include <dt-bindings/clock/sun50i-h616-ccu.h>
> > > > > > > > +#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
> > > > > > > > +#include <dt-bindings/reset/sun50i-h616-ccu.h>
> > > > > > > > +#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> > > > > > > > +
> > > > > > > > +/ {
> > > > > > > > +	interrupt-parent = <&gic>;
> > > > > > > > +	#address-cells = <2>;
> > > > > > > > +	#size-cells = <2>;
> > > > > > > > +
> > > > > > > > +	cpus {
> > > > > > > > +		#address-cells = <1>;
> > > > > > > > +		#size-cells = <0>;
> > > > > > > > +
> > > > > > > > +		cpu0: cpu@0 {
> > > > > > > > +			compatible = "arm,cortex-a53";
> > > > > > > > +			device_type = "cpu";
> > > > > > > > +			reg = <0>;
> > > > > > > > +			enable-method = "psci";
> > > > > > > > +			clocks = <&ccu CLK_CPUX>;
> > > > > > > > +		};
> > > > > > > > +
> > > > > > > > +		cpu1: cpu@1 {
> > > > > > > > +			compatible = "arm,cortex-a53";
> > > > > > > > +			device_type = "cpu";
> > > > > > > > +			reg = <1>;
> > > > > > > > +			enable-method = "psci";
> > > > > > > > +			clocks = <&ccu CLK_CPUX>;
> > > > > > > > +		};
> > > > > > > > +
> > > > > > > > +		cpu2: cpu@2 {
> > > > > > > > +			compatible = "arm,cortex-a53";
> > > > > > > > +			device_type = "cpu";
> > > > > > > > +			reg = <2>;
> > > > > > > > +			enable-method = "psci";
> > > > > > > > +			clocks = <&ccu CLK_CPUX>;
> > > > > > > > +		};
> > > > > > > > +
> > > > > > > > +		cpu3: cpu@3 {
> > > > > > > > +			compatible = "arm,cortex-a53";
> > > > > > > > +			device_type = "cpu";
> > > > > > > > +			reg = <3>;
> > > > > > > > +			enable-method = "psci";
> > > > > > > > +			clocks = <&ccu CLK_CPUX>;
> > > > > > > > +		};
> > > > > > > > +	};
> > > > > > > > +
> > > > > > > > +	reserved-memory {
> > > > > > > > +		#address-cells = <2>;
> > > > > > > > +		#size-cells = <2>;
> > > > > > > > +		ranges;
> > > > > > > > +
> > > > > > > > +		/* 512KiB reserved for ARM Trusted Firmware (BL31)   
> */
> > > > > > > > +		secmon_reserved: secmon@40000000 {
> > > > > > > > +			reg = <0x0 0x40000000 0x0 0x80000>;
> > > > > > > > +			no-map;
> > > > > > > > +		};
> > > > > > > > +	};  
> > > > > > > 
> > > > > > > I'm not a fan of above. If anything changes in future in BL31,
> > > > > > > U-Boot
> > > > > > > would
> > > > > > > need to reconfigure it anyway. Can we just skip it?  
> > > > > > 
> > > > > > I am not a fan neither, but last time I checked this is needed to
> > > > > > boot.
> > > > > > Indeed TF-A inserts this node, with the right values, into U-Boot's
> > > > > > DT.
> > > > > > And that's nicely preserved if you use that DT ($fdtcontroladdr) for
> > > > > > the kernel as well.
> > > > > > But if someone *loads* a DTB into U-Boot (to $fdt_addr_r), then
> > > > > > U-Boot fails to propagate the /reserved-memory node into that copy.
> > > > > > There does not seem to be a global notion of reserved memory in
> > > > > > U-Boot.
> > > > > > Some commands (like tftp) explicitly parse the control DT to find
> > > > > > and
> > > > > > respect reserved memory regions. bootm does that also, but only to
> > > > > > avoid placing the ramdisk or DTB into reserved memory. The
> > > > > > information
> > > > > > ends up in images->lmb, but is not used to generate or amend nodes
> > > > > > in
> > > > > > the target DT.
> > > > > > So the bits and pieces are there, but it will require some code to
> > > > > > be
> > > > > > added to the generic U-Boot code.
> > > > > > 
> > > > > > So what do you think? Leaving this out will prevent loading DTBs
> > > > > > into
> > > > > > U-Boot, at the moment, which sounds bad. I suggest we keep it in,
> > > > > > for
> > > > > > now, it should not really hurt. U-Boot will hopefully start to do
> > > > > > the
> > > > > > right thing soon, then we can either phase it out here (maybe when
> > > > > > we
> > > > > > actually change something in TF-A), or let U-Boot fix it.  
> > > > > 
> > > > > TBH, if "soon" is really soon, I would rather wait with H616 DT until
> > > > > U-  
> > > 
> > > Boot
> > >   
> > > > > supports carrying over reserved memory nodes.  
> > > > 
> > > > But this also carries compatibility issues. U-Boot support the H616 for
> > > > more than a year now, and the earliest possible U-Boot release having
> > > > that
> > > > propagation code would be the one released in October.  
> > > 
> > > I was hoping you would say July (next U-Boot release) :).  
> > 
> > Well, 2022.07 was supposed to be released today, and even if that is
> > delayed by a bit, that's obviously far too late ;-)
> >   
> > > > And then people
> > > > would still need to update first, so that's quite some months out.
> > > > And I was actually hoping to get at least the H616 DT patches off my
> > > > plate, and get them into the tree to have a stable and agreed upon base
> > > > (before this series turns into a teenager ;-)  
> > > 
> > > Yeah, I would like that too.
> > >   
> > > > Then we could for instance update the U-Boot H616 support.
> > > >   
> > > > > Whatever we do now, it will have
> > > > > compatibility issues. If we introduce reserved memory node now, we
> > > > > can't
> > > > > easily drop it later. Bootloaders are not very often updated, but
> > > > > kernels  
> > > 
> > > and
> > >   
> > > > > DTB files are, at least in my experience. So when we decide to drop
> > > > > the  
> > > 
> > > node?
> > >   
> > > > I think of the three possibilities:
> > > > - Drop the node now, and ask people to not load DTBs explicitly
> > > > - Drop the node when U-Boot learned to propagate the reservation
> > > > - Keep the node
> > > > the last one is the least painful: having this node in does not really
> > > > hurt, so we can be very relaxed with this removal decision:
> > > > - If U-Boot does not add the reserved node, we are covered.
> > > > - If U-Boot adds the node, it will do so in a way where it deals with
> > > > existing reservations. So either it doesn't actually change anything, or
> > > > it extends the reservation.
> > > > - Should the TF-A location actually move (and we have no plans or needs
> > > > to
> > > > do that), people would only get this by updating the firmware, at which
> > > > point the U-Boot part would surely be in place already. We don't really
> > > > support updating just BL31 in an existing binary firmware image, so you
> > > > would get an updated U-Boot as well.
> > > > 
> > > > I think the worst case scenario is that users end up with an unneeded
> > > > 512K
> > > > reservation. If they care, a firmware update should solve this problem.
> > > > 
> > > > As for the time to remove that node: we could do that at the time when
> > > > (or rather: if) we actually change the TF-A reservation. At the moment
> > > > there are no plans to do this, and the size reservation is more than
> > > > generous (the current debug build is actually 77 KB or so only). If
> > > > there
> > > > is no change, and the node stays in the .dtsi, it doesn't really hurt,
> > > > see
> > > > above.  
> > > 
> > > I see your point, but I would like to get some input from Samuel first.
> > > 
> > > Samuel, what do you think?
> > >   
> > > > > After 10 years? Alternatively, reserved memory node can be just
> > > > > dropped  
> > > 
> > > and
> > >   
> > > > > anyone loading DTB file from outside would need to make sure it's
> > > > > patched.  
> > > 
> > > But
> > >   
> > > > > that's unexpected from user perspective, although patching DT files is
> > > > > done  
> > > 
> > > by
> > >   
> > > > > some distros.  
> > > > 
> > > > Yeah, let's not go there. As you know, I already dislike the idea of
> > > > explicitly loading DTBs at all, but I understand this is what people,
> > > > and
> > > > distributions, do, so I'd rather have them covered. Hence the node to
> > > > work with existing firmware.  
> > > 
> > > Reusing DTB from U-Boot is only useful when you're happy with completeness
> > > of DT and with the lack of bugs in it. Then you can save troubles with
> > > skipping external DTB load step and life is easier. But as you know,
> > > features and thus nodes are added in steps and sometimes some bugs are
> > > fixed, which means it's extremely handy to have easily updatable DTB
> > > file.  
> > 
> > Yes, definitely, see my reply to Samuel. I just held back with the DT
> > update in U-Boot because of the conflict between "we only take pure
> > kernel tree DTs" and "there is a breaking change" (r_intc binding).
> > 
> > If we find a way forward with the DT stability problem, I am happy to
> > push for a much more frequent DT update, or even update just the DT in
> > an existing firmware installation. This can be automated, since the DTB
> > is just a member in the FIT image, which can be re-assembled with an
> > updated DTB by some tool or script. Or we use capsule updates, of just
> > the DTB, separately (if this is possible)?  
> 
> I would like to have forward compatibility too, but IMO it's not very 
> realistic. Sooner or later we'll find something, like r_intc, again that won't 
> be possible to integrate in forward compatible manner. 

That's a shame, I think we should at least try. And with my x86 background
let me tell you: there are solutions to those compatibility problems ;-)
The more nasty ones might be borderline hackish, but it's a question of
priorities, I guess.

> > > Yes, U-Boot can be
> > > automated, but it's tedious for distro to maintain one bootloader package
> > > per board. Ideally, distro shouldn't care at all about that,  
> > 
> > Yes, I totally agree, distros should not ship firmware. Since leaving
> > this to the board vendors is not realistic, I wonder if we (as "the
> > sunxi community") should step up here, and provide binary builds (purely
> > for convenience reasons) of board firmware? That could be updated from
> > a running Linux, or put on an SD card, or fetched by distros to
> > generate an installer? Wasn't there even some central storage offered
> > lately by Linux, to hold (UEFI) firmware update files?  
> 
> As someone who's working on distro which supports many SoCs from variety of 
> vendors,

But that is relative, isn't it? I count 23 supported Allwinner devices in
LibreELEC, out of the 160 defconfigs in U-Boot or >180 sunxi .dts files in
the kernel.
So as most distributions, even with your ARM device focus, you chose to
limit the number of supported devices, as that approach inherently
doesn't scale.

I see the reasons behind this, because of the special focus of LibreELEC,
and probably the idea of giving a smooth user experience, but you could
potentially cover much more devices by offering a generic UEFI image, as
most *generic* distributions do, and as LE does for x86. But this relies
on having a stable DT for the platform.

I think conceptually this problem has been solved a long time ago: there
is some interface between firmware and the kernel, which allows a generic
kernel to configure itself accordingly. I refuse the idea that Arm based
device should be any different in this respect. Historically, because many
Arm based machines have a strong embedded background, that was not the
case, but I think we should move on from those dark ages (in terms of
support and maintainability).

> I can tell you that we'll ship bootloader integrated into our image 
> for years to come. Anyway, I also like to build U-Boot using my own options. 
> For example, I disable HDMI driver for A64, H3 and H5, because it turns out 
> that at least on H5, it can clash with Linux driver.

That is good to hear, please tell the sunxi U-Boot maintainer, so that we
can fix it ;-)

> Other distros prefer to 
> show some splash screen, etc. One size fits all solution doesn't seems 
> realistic to me. Maybe only if *everything* would be configurable and there 
> would be a way for distro to preconfigure it.
> 
> TBH, building U-Boot, Crust and TF-A is easy and ability to customize them is 
> very handy.
> > > but many boards don't
> > > have designated bootloader storage (SPI NOR flash in AW case), so they
> > > have to be combined on same storage, partition even, as distro.  
> > 
> > Have you tried eMMC boot partitions? I found them equally convenient as
> > SPI flash, and while not too many boards actually have SPI flash,
> > quite some have eMMC (thinking about TV boxes). I recently even
> > used "dual boot" with a BSP installation.
> > And even the smallest eMMCs seem to have 4 MB per boot partition, so
> > plenty of space for U-Boot (plus TF-A plus crust).  
> 
> No, I didn't. I don't see any benefit of using eMMC boot partition over 
> treating eMMC as usual SD card and installing bootloader to sector 16.

The firmware is out of the way of normal (accidental) accesses, as it
lives in a separate block device, which is read-only, initially.
And it doesn't clash with partition tables. This gives the kind of
separation that people are used to on other computers: the firmware
belongs to the device, the OS is provided by the user.
We documented how to install firmware there in U-Boot's sunxi.rst. 

> Anyway, that won't change situation at all. SD card image with integrated 
> bootloader is still king.

Sure, if you don't have any other storage, then SD card it is. But this
still does not require marrying firmware and OS: you could start with a
"just firmware SD card", then install the OS from a USB device, or from a
generic image file copied to some SD partition. And then suddenly the
pure firmware image becomes OS/distro agnostic.
And conceptually this approach doesn't *prevent* separating firmware and
kernel/distro, it just allows you to get away with it.

> There are several reasons for that:
> - cheapest boards are most popular and usually have only SD card for storage 
> (think OrangePi PC). There is nothing that you can do about it, except 
> including bootloader on SD card image.
> - if you want to switch from Android to our distro, you need bootable SD card 
> due to higher boot priority (speaking for AW SoCs)
> - not everyone wants to overwrite eMMC. Some prefer keeping Android, so it can 
> be used later for whatever purpose.
> - some users have several distros for same board, each on it's own SD card. 
> Needless to say, each distro adjusted bootloader to its needs.

All fine, but I don't see how this affects this discussion here. Yes, you
can treat those machines like embedded devices, and bundle firmware and
OS, but this is surely not the only way of deployment we should support.
Being able to just offer one generic UEFI based image seems much more
scalable to me.

> I like to offer flexibility in boot options, especially because it's currently 
> easy, thanks to integrated customized bootloader and external loading of dtb 
> files :)

Though I don't understand why you require external DTB loading: if you
marry distro and firmware anyway, you could as well put your DTB of choice
into U-Boot (in the U-Boot source tree, or replace it in the generated FIT
image). That looks like a one-time effort in your build system?

> > > On the other hand,
> > > when building kernel, you automatically build all relevant DTB files,
> > > which you can then just copy to common place. No device specific handling
> > > needed. Also, U-Boot doesn't sync DT files every release, so latest
> > > U-Boot doesn't necessarly mean latest DT.  
> > 
> > Yes, for the compatibility reasons mentioned. I am more than happy to
> > make this a regular exercise (say at each kernel's -rc3 or so).  
> 
> What about breaking changes? They can be important for new, useful 
> functionality but older kernels won't know what to do.

Yes, that is the core of this discussion. Doing this relies on not having
them in the first place. There is no problem when this affects new
features, or functionality that the old kernel didn't support anyway.
But we must avoid change affecting older kernels.
At least I would like to ask for us to try: in my experience with some
thinking and clever code we can pull this off. Other platforms seem to be
able to commit to this.

As a compromise, I was wondering if we should define some time of grace
period, initially, were we don't guarantee non-breaking changes only.
So the first, say three, kernels could include breaking changes, but
afterwards we stick to support at least this kernel, with every new DT to
come.

> > Sadly, I don't think we're even close to avoiding shipping bootloader in   
> distro images or even external DTB loading.
> > > Above is a bit off topic, but I hope you understand why distros opt to use
> > > external DTB files (speaking from my own experiences).  
> > 
> > Yes, I understand where they (including LE) are coming from, to provide
> > a pragmatic solution to the users' problems. And that's why I wanted to
> > still give the possibility to load a DTB, even though I think this
> > should not be the standard way.  
> 
> I think loading external DTB support is important and shouldn't be ditched 
> anytime soon. If I understand correctly, that's an issue only on SoCs with TF-
> A, which means only 64-bit AW SoCs. Yes, 32-bit AW SoCs are still a thing and 
> still used and no, I don't want TF-A there :).

I think it's a conceptual issue, not TF-A related: A DT was always meant
to be amended by firmware (think of the memory node, or the MAC address).
U-Boot just decided to make those changes very late, just before launching
the kernel, so that this newly loaded DTB is already available. But if the
SPL decides to make changes, or picks a certain DT, you have this problem
as well.

Cheers,
Andre


