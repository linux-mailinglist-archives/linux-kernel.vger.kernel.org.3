Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A863494AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359226AbiATJ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359527AbiATJ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:26:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19B3C061574;
        Thu, 20 Jan 2022 01:26:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C518B81D1A;
        Thu, 20 Jan 2022 09:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C5EC340E5;
        Thu, 20 Jan 2022 09:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642670804;
        bh=BcyvFDDwhdjpKYZJc4GkgLr1FsdGQLqlk/uEpVwTb7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qd1hHBxWE3qKbN/Srqn5IuS5Y9XSw5xNgNs4BciP9fxV5GfSJ0FlRNMm2Jqwst8aj
         898OmrfYMizKz/YqgflSfiN+2Bs50lcCDQFiEanzYtGgVymsH+Zrq8Pq4f1zaFMVKI
         1LCa0YbCiC854LGkbvbfJYdZ3o5t+vWmC43eqx6OxD386buDGKyLVFe9ztOzRxo+RO
         hy3Nv+YjPsRnZTJpYBQPbRNP+yHsFckj3Yy4Zn6GNp2hDsXm9C+AWKPTTwnn4iTCR1
         6DjxmRLJdt4vPwUcFmMWeeJ5xf/PbGEQbjR9OUPmAo12C3YXZhhryswRC4NpWYbPKl
         tOscG0WRyd1Xg==
Received: by pali.im (Postfix)
        id 75E20791; Thu, 20 Jan 2022 10:26:41 +0100 (CET)
Date:   Thu, 20 Jan 2022 10:26:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings for
 marvell,armada-3700-uart-clock
Message-ID: <20220120092641.o4ffzeyakhuuf3c7@pali>
References: <20211015093701.pfvkighxsndj4ujg@pali>
 <163433494758.1688384.5994009027317282677@swboyd.mtv.corp.google.com>
 <20211016064210.7ahqfqcvf66wtt66@pali>
 <20220115080213.0CCAFC36AE3@smtp.kernel.org>
 <20220115115018.he4hnnhlvrb6kann@pali>
 <20220115130509.4a240730@thinkpad>
 <20220115122618.plhiqnjh2755bv5h@pali>
 <20220119231655.EFFF3C004E1@smtp.kernel.org>
 <20220120000651.in7s6nazif5qjkme@pali>
 <20220120060149.0FF24C340E0@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220120060149.0FF24C340E0@smtp.kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 January 2022 22:01:47 Stephen Boyd wrote:
> Quoting Pali Rohár (2022-01-19 16:06:51)
> > On Wednesday 19 January 2022 15:16:54 Stephen Boyd wrote:
> > > Quoting Pali Rohár (2022-01-15 04:26:18)
> > > > On Saturday 15 January 2022 13:05:09 Marek Behún wrote:
> > > > > On Sat, 15 Jan 2022 12:50:18 +0100
> > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > 
> > > > > > On Saturday 15 January 2022 00:02:11 Stephen Boyd wrote:
> > > > > > > Quoting Pali Rohár (2021-10-15 23:42:10)  
> > > > > > > > 
> > > > > > > > If I was designing this driver and DTS bindings I would have choose
> > > > > > > > something like this:
> > > > > > > > 
> > > > > > > > uart@0x12000 {  
> > > > > > > 
> > > > > > > Drop the 0x
> > > > > > >   
> > > > > > > >     reg = <0x12000 0x18>, <0x12200 0x30>;
> > > > > > > >     clock-controller {
> > > > > > > >         ...
> > > > > > > >     };  
> > > > > > > 
> > > > > > > Drop this node and put whatever properties are inside into the parent
> > > > > > > node.
> > > > > > >   
> > > > > > > >     serial1 {
> > > > > > > >         ...
> > > > > > > >         status = "disabled";
> > > > > > > >     };
> > > > > > > >     serial2 {
> > > > > > > >         ...
> > > > > > > >         status = "disabled";
> > > > > > > >     };
> > > > > > > > };
> > > > > > > > 
> > > > > > > > Meaning that 0x12000 node would be 3 subnodes and all registers would be
> > > > > > > > defined in top level nodes and would be handled by one driver.
> > > > > > > > 
> > > > > > > > This is really how hardware block looks like. But it is not backward
> > > > > > > > compatible...  
> > > > > > > 
> > > > > > > Sounds good to me. I presume we need the serial child nodes so we can
> > > > > > > reference them from the stdout-path?  
> > > > > > 
> > > > > > Yes, exactly, separate nodes for serial1 and serial2 are still required.
> > > > > > 
> > > > > > But dropping clock controller is not possible as for higher baudrates we
> > > > > > need to use and configure uart clock controller. Without it we just get
> > > > > > comparable feature support which is already present in driver.
> > > > > 
> > > > > What Stephen means is making clock controller out of the uart node
> > > > > directly. No need to add separate subnode just for clock controller.
> > > > 
> > > > This is already implemented in v7 patch series. Clock controller is
> > > > already outside of uart nodes.
> > > 
> > > I mean to combine the uart node and the clock-controller node together
> > > 
> > >       uart-wrapper {
> > >               reg = <0x12000 0x18>, <0x12200 0x30>;
> > >               #clock-cells ...
> > > 
> > >               serial1 {
> > >                       ...
> > >               };
> > > 
> > >               serial2 {
> > >                       ...
> > >               };
> > >       };
> > 
> > Ok, now I see what you mean.
> > 
> > But problem is that this is not backward compatible change. And would
> > not work per existing DT bindings definitions, which defines how
> > bootloader should set configured clocks.
> > 
> > As I wrote in emails 3 months ago, this new "proposed" DTS definition is
> > something which I would have chosen if I had designed this driver and
> > bindings in past. But that did not happen and different approach is
> > already widely in used.
> > 
> > To support existing DTS definitions and bootloaders, it is really
> > required to have current structure backward compatible like it is
> > defined in current DT bindings document. And my changes in this patch
> > series are backward compatible.
> 
> I'm lost. Is the bootloader the one that's expecting some particular
> serial node format and updating something? What is the bootloader doing?

If bootloader uses or configures UART to different clock it needs to
update "clocks" property in DT. Otherwise UART would be unusable and
there would be no dmesg output.

A3720 heavily depends that bootloader patches at boot time DTB file to
the layout of the current hardware.

> > 
> > To change DTS structure, it would be needed to provide uart nodes in DTS
> > files two times: once in old style (the current one) and second time in
> > this new style.
> 
> That's not a good idea. Why do we need to support both at the same time?

Because old bootloaders do not and will never support this new style. It
is not only linux kernel project who provides DTB files. Also bootloader
itself has own DTB files and use it for booting (e.g kernel). For some
boards is in-kernel-tree DTS file only as a reference. So it is
important that kernel can use and support DTS files from old version and
also from the new patched version. Gregory (A3720 DTS files maintainer)
always ask me what happens if I try to boot new patched kernel drivers
with old unmodified DTS files and wants to know if nothing is broken by
introduced changed.

> > 
> > But such thing would even more complicate updating driver and it needs
> > to be implemented.
> > 
> > Plus this would open a question how to define default stdout-path if
> > there would be 4 serial nodes, where one pair would describe old style
> > and second pair new style; meaning that 2 cross nodes would describe
> > same define.
> 
> Huh? We shouldn't have both bindings present in the DTB.

Ideally yes, I would like to see to prevent it. But for backward
compatibility we really need old bindings still present (as explained
above).

So really I see two options here: Make changes in patches backward
compatible (old nodes stay in DT and also kernel would be able to use
old DT). Or let old bindings untouched in DT and new backward
incompatible definitions would have to be in separate nodes.

> > 
> > For me this looks like a more complications and I do not see any benefit
> > from it.
> > 
> > It is really important to break backward compatibility, just to try
> > having new cleaner API at the cost of having more complications and
> > requirement for more development and also important maintenance?
> 
> It's important to not make DT nodes have reg properties that overlap.
> Maybe this is a DT purist viewpoint and I'm totally off base! I think
> Rob did ack this binding already so I must be coming from the wrong
> angle.

I know this. In case it happens that driver for "one DT node" needs to
access regs of "another DT node" then regmap interface is used and
driver access regs of "another DT node" via regmap. No overlapping is in
DT. But here it is not possible to use regmap as "another DT node" is in
"disabled" state on some boards. And so regmap driver is not bound to
it.

In beginning there was not overlapping in DT because people have not
looked properly that some registers of uart2 are in uart1 space and did
not exported them to driver (bootloader initialized them to some sane
values and nobody noticed that they are required).

This overlapping starting to be required after I properly looked how
driver is working, how it maps to HW and how to implement choosing
clocks and allowing to change baudrate to higher values.

> Nothing prevents register overlap from happening in practice, but it's
> good to avoid such a situation as it clearly divides the I/O space by
> assigning an address range to a particular device. In this case, we see
> the two uarts are really one device, but we need two nodes in DT for
> stdout-path, so we make some child nodes and have the driver figure out
> which serial port to use for the console.
> 
> We shouldn't be adding more nodes to DT to get drivers to probe for
> device I/O spaces that have already been described in DT. When this
> happens, we learn that some I/O range is actually a combination of
> functions, like uart and clks, and thus we should be able to add any
> required properties to the existing DT node to support that new feature
> that wasn't described before in the binding.
