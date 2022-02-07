Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC6D4AB72E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbiBGIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349277AbiBGIqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:46:40 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 00:46:38 PST
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5EFC043181;
        Mon,  7 Feb 2022 00:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644223598; x=1675759598;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ttltnOpaolu1Yl4FfVEtOxItkj60WBcQ3cFt1tKPFdY=;
  b=eET9b4CeoBwBvXbyY/12mm94tG5cxdNur837wsMD4XmmChBQcODeCNw1
   OuNsDYfgXzgop24OwrmsvRF4a489044BU4CVU/EhzTfWaN022y9/l3Bgi
   Q2MukgDIQ7yapa0b7MnBKLUN1ZFggBDIt578+FQVLdnL6K0Z0eVTg5OvU
   QSWcFqEtvaRm4VqReg+omfIz65qDtoQj7e/EUu4k/dKkKAZ7ayLJsuO/x
   qprRfWuhx5C6u3WXS55Op9wwLEiuMPITwutX3/qLSRotLpaN81A+j0n46
   hqwKgqLNd+VeFcPGHfbsJGY+EZaEBfFqkqKvvb+9Ocvp3dQdbUSjOtQs4
   w==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21925656"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Feb 2022 09:45:32 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Feb 2022 09:45:32 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Feb 2022 09:45:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644223532; x=1675759532;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ttltnOpaolu1Yl4FfVEtOxItkj60WBcQ3cFt1tKPFdY=;
  b=BcOAR5lDe/3PVPsYDDNWXHBGAXPVZaPTfn1VEdC1COFf9jwMxaeZM2vZ
   WqCq5PEHYT9UTd4UC/nuDUPK5JjV/LPrZIeuq+KaBfGULRzbEWOK5s4d2
   LWB5bHFo6TVcm+lE0undKhTsrV2GhsQMqo12fJP70W17nSLdc2wmgF7J+
   +IyULwwlV8z4js2vkP6JHtqVo42u9sY/GdswjISHHHM5P6pNfI6AiGHIH
   7H9S/HqnQS0H22dHedBQppZiXVcpiPOf7DYWJFvlRmWAf8BjNONqoVHqp
   hM251iXhJwHpZeIu4E6pw6IK7kMkqfptG9waxWMjV4vnL/x7r/o+0lWml
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21925655"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Feb 2022 09:45:32 +0100
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.201.138])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id D1266280065;
        Mon,  7 Feb 2022 09:45:31 +0100 (CET)
Message-ID: <5944ba0ce568eaf507917799b1dfd89a3d0ca492.camel@ew.tq-group.com>
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
Date:   Mon, 07 Feb 2022 09:45:29 +0100
In-Reply-To: <YgDCLaBHA3DDQAUd@atomide.com>
References: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
         <20220204143108.653qk2ihnlhsr5aa@prior> <YgDCLaBHA3DDQAUd@atomide.com>
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

On Mon, 2022-02-07 at 08:54 +0200, Tony Lindgren wrote:
> Hi,
> 
> * Nishanth Menon <nm@ti.com> [220204 14:30]:
> > Rob, Tony, Arnd, SoC maintainers,
> > 
> > On 15:02-20220203, Matthias Schiffer wrote:
> > > All peripherals that require pinmuxing or other configuration to
> > > work
> > > should be disabled by default. Dependent DTS are adjusted
> > > accordingly.
> 
> Disabling SoC internal devices by default is not a good policy. The
> devices are available even if not pinned out. Disabling device by
> default
> causes runtime PM to not work as the kernel will completely ignore
> the
> disabled devices. And this means you add a dependency to some certain
> version of a bootloader for PM to work.
> 
> Additionally tagging devices as disabled by default (and then again
> re-enabling them in the board specific dts files) is just pointless
> churn and bloat. See for example commit 12afc0cf8121 ("ARM: dts: Drop
> pointless status changing for am3 musb") :)
> 
> If you really want to disable some devices for memory usage or other
> reasons, do it in the board specific dts files.

Attempting to use unmuxed peripherals often leads to ugly errors - I2C
without pullups appearing busy, UARTs in endless break condition, ...
Such errors are often seen as defects in hardware or software by people
who aren't familiar with the internals.

I can see the issue with bootloaders leaving peripherals in an unknown
state, but I'm not happy with keeping such devices enabled in the
kernel either.

Generally I think that it's a bootloader's responsiblity to disable
unneeded devices - the kernel may not even have a driver for some
peripherals, leading to the same behaviour as a "disabled" status. For
this reason I believe that it should always be okay to set unneeded
devices to "disabled", and it should be considered a safe default.

I'm not sure what the consensus on these issues is. I'm more familiar
with NXP's i.MX and Layerscape SoCs, where it's common to have all
muxable peripherals set to "disabled" in the base DTSI, and a quick
grep through a few dts directories gives me the impression that this is
the case for most other vendors as well.

Regards,
Matthias


> 
> > https://lore.kernel.org/linux-arm-kernel/20201112183538.6805-1-nm@ti.com/
> > reversal all over again.
> > 
> > Is there a specific pattern we are intending to use here? Because,
> > if we
> > are going down this path (which would be a major churn across
> > multiple
> > downstream trees as well) - I'd rather have this as a documented
> > standard and not just a TI approach and will need to be done across
> > all
> > K3 devices.
> > 
> > Are you aware of such a documented guideline, rather than "word of
> > mouth"? Maybe I have'nt looked deep enough, but checking..
> 
> For SoCs that don't implement runtime PM the policy can be different
> without causing any harm. But for any SoCs implementing runtime PM,
> an
> unknown state from the bootloader is not going to work.
> 
> Regards,
> 
> Tony


