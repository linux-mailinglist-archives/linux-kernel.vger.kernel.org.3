Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716784C6717
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiB1Kbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiB1Kbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:31:35 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3E855743;
        Mon, 28 Feb 2022 02:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646044255; x=1677580255;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b+78FRAJXZYzl+Y9IyY17fr3tqSyDnu1Vfd2nwZsqI4=;
  b=ADHAmz5ZoHE4x2wPgvnFItq7N5tW8vmmTmAXdMxem277LYxBwUvpzplo
   wNUdSGKueLy6Fg6wf5BS8LeT9r8inxmzOugmsFblazO8nzlHnlCYSxSAi
   WGszyq+xYxooDaz4DLtaTB7JxTyRF57icnVYWf0GC45YNk4VIii6NU/HS
   WrIERi1u7nhZ4MXqYfUJvAuxtHcHM6hZIIVoEv343Mo2SgTwliWDQoGRL
   jil5jGL9bEfLAQ8Tp8ydP6PgaKC6N5n8dOBjc8qm+iWyegA5kSjMP1O7b
   1WO0RNf0zhIGIoRUutAof4sX25Y8vznNmdPJUBOOTP6Qn0wCyGDi6TDmP
   g==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643670000"; 
   d="scan'208";a="22347755"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 28 Feb 2022 11:30:52 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 28 Feb 2022 11:30:53 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 28 Feb 2022 11:30:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646044253; x=1677580253;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b+78FRAJXZYzl+Y9IyY17fr3tqSyDnu1Vfd2nwZsqI4=;
  b=drl60c3M2hZ1JsyApj7b/J3NNsuyJx2l7VmECVLQS/Tf/QjBKp2M9Ifw
   /i/OIfQfR9ADcRPleNljFyW9yUWvnoptEHSGSSVOIjZum9/e3RB4+VYVX
   ePlD92B2152XpAoBPYlrecr4XnywkkqK984/I3seSZaukFrIlWm1XG27I
   2Tpkxsq1GSAUaLbiSqU6YDc2q1EOQ2YF/Unsu8Y3u/N9RceqITRQxJuIz
   lklF1nnsCeMwiE1kuj51yntelt7kh1BeIuvEE/VPqeDRvfA/GiHSKxk3q
   L+snH9cH/3oVI5iiGXCZka975PPARx9b+41uiT0wbXLa1ge2QRxq8goNo
   g==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643670000"; 
   d="scan'208";a="22347754"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Feb 2022 11:30:52 +0100
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.201.138])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id A7F5E280074;
        Mon, 28 Feb 2022 11:30:52 +0100 (CET)
Message-ID: <1356e93cd5b101c3d896e35250c66959ed631544.camel@ew.tq-group.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am65: disable optional
 peripherals by default
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, jan.kiszka@siemens.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Date:   Mon, 28 Feb 2022 11:30:50 +0100
In-Reply-To: <YgJZbdOlazrde7O/@atomide.com>
References: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
         <20220204143108.653qk2ihnlhsr5aa@prior> <YgDCLaBHA3DDQAUd@atomide.com>
         <5944ba0ce568eaf507917799b1dfd89a3d0ca492.camel@ew.tq-group.com>
         <YgEBml9HvFzSl289@atomide.com>
         <9923df6525212389b86cb635624bcfb5c27a8bc5.camel@ew.tq-group.com>
         <YgJZbdOlazrde7O/@atomide.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-08 at 13:52 +0200, Tony Lindgren wrote:
> * Matthias Schiffer <matthias.schiffer@ew.tq-group.com> [220208
> 10:53]:
> > On Mon, 2022-02-07 at 13:25 +0200, Tony Lindgren wrote:
> > > * Matthias Schiffer <matthias.schiffer@ew.tq-group.com> [220207
> > > 08:45]:
> > > > Generally I think that it's a bootloader's responsiblity to
> > > > disable
> > > > unneeded devices - the kernel may not even have a driver for
> > > > some
> > > > peripherals, leading to the same behaviour as a "disabled"
> > > > status.
> > > > For
> > > > this reason I believe that it should always be okay to set
> > > > unneeded
> > > > devices to "disabled", and it should be considered a safe
> > > > default.
> > > 
> > > Not possible, think kexec for example :) How would the previous
> > > kernel
> > > even know what to disable if Linux has no idea about the devices?
> > 
> > Well, optimally, bootloader and all kernels would agree on the
> > devices
> > that are actually available, but I get your point.
> > 
> > > If there are issues you're seeing, it's likely a bug in some of
> > > the
> > > device drivers for not checking for the necessary resources like
> > > pinctrl for i2c lines.
> > 
> > I don't think it's common for individual drivers to care about
> > pinctrl
> > unless switching between different pin settings is required at
> > runtime.
> > Many drivers can be used on different hardware, some of which may
> > require pinmuxing, while others don't.
> 
> Yeah that's true, some configurations only do pin muxing in the
> bootloader. So pins are not a good criteria for devicetree status
> enabled
> for when the device is operational.
> 
> Probably a better criteria for devicetree "operational" status is the
> device can be clocked and configured or idled. Some devices like GPUs
> can render to memory with no external pin configuration for example.
> 

I don't think any properties currently exist that could or should be
used to decide whether a device is operational. Clocks etc. are usually
internal to the SoC and thus already set in the SoC DTSI. Pins and
power supplies may be specific to a mainboard, but can also be
optional. Whether an I2C bus can be operational may solely depend on
whether external pullups are connected to the pins or not.

The idea of an "incomplete" status like you mention below sounds better
to me. I also thought about adding something like a "probe_disabled()"
that is called instead of probe() for "disabled" devices, but I assume
that would cause a boot time penalty on systems that have many
"disabled" devices and don't actually need this...


> Following Linux running on a PC analogy.. If ACPI has some device
> that
> causes driver warnings on Linux boot, do we patch the ACPI table and
> pretend the device does not exist? Or do we patch the device driver
> to
> deal with the random buggy bootloader state for the device? :)
> 
> > Also, what is the expected behavior of a driver that is probed for
> > an
> > unusable device? Wouldn't this require some as-of-yet nonexisting
> > status between "okay" and "disabled" that conveys something like
> > "probe
> > this device, initialize (and disable) PM, but don't register
> > anything",
> > so no unusable devices become visible to userspace (and possibly
> > other
> > kernel drivers)?
> 
> I did some experimental patches several years ago to add devicetree
> status for incomplete, but eventually came to the conclusion that it
> was not really needed. Feel free to revisit that if you have the
> spare cycles :)
> 
> Having the drivers check for the resources like clocks and then just
> idle the device after probe solved the issues I was seeing for
> warnings
> and kexec. In some cases the device may need to be reset or at least
> properly reconfigured in the probe as the state can be unknown from
> the
> bootloader. That's about all there is to it. Sure you could save some
> memory with less instances for some devices, so maybe the status =
> "incomplete" could be used to do the trick for that.

I don't really care about memory usage. What I do care about is that
incorrect userspace usage doesn't cause ugly kernel warnings (for
example timeouts for i2cdetect on unmuxed bus) when we can avoid it,
because such issues always lead to support requests.

Not being able to hide non-operational devices from userspace feels
like a regression from older hardware.

> 
> > > > I'm not sure what the consensus on these issues is. I'm more
> > > > familiar
> > > > with NXP's i.MX and Layerscape SoCs, where it's common to have
> > > > all
> > > > muxable peripherals set to "disabled" in the base DTSI, and a
> > > > quick
> > > > grep through a few dts directories gives me the impression that
> > > > this is
> > > > the case for most other vendors as well.
> > > 
> > > This approach only works for SoCs that don't need the kernel to
> > > idle
> > > devices for runtime PM.
> > 
> > I'm pretty sure that most modern SoCs I looked at have runtime PM,
> > and
> > it is simply expected that unusable devices are never enabled in
> > the
> > first place, so there is no need for the kernel to know about them.
> 
> Yeah well that assumption is the difference in getting runtime PM to
> work in a sane way across multiple SoCs and devices :)
> 
> Devices tagged with status = "disabled" are completely ignored by the
> kernel. Interconnect and bus related code may not know the details on
> how to reset and idle the child devices. Relying on firmware to do
> the
> reset and idle of unused devices may be too generic, can be buggy,
> and
> probably depends on the firmware revision.

Well, so far it seems like the `status = "disabled"` is just being
pushed from the SoC DTSIs to the board DTSs on TI hardware. For the
AM64 platform (which is fairly similar to the AM65), both mainboards
that currently exist disable unused UARTs, I2C/SPI busses, PWMs, ...
(Some of these might be disabled to make them usable from the R5/M4
cores, but I don't think that the case for all of them - "reserved"
would be more appropriate than "disabled" in these cases anyways)

AFAICT, disabling non-operatational devices in the board DTS instead of
the SoC DTSI is worse than the alternatives in every way:

- Verbose board DTS: You have to think about all the devices that exist
in the SoC, not just the ones you want to use
- Adding new nodes without `status = "disabled" to SoC DTSI can
potentially cause issues on dependent boards
- It doesn't solve the issues that not having `status = "disabled"` in
the DTSI is supposed to solve

Regards,
Matthias


> 
> Regards,
> 
> Tony

