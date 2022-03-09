Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9AE4D2DAE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiCILLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiCILLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:11:53 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E42016FDDD;
        Wed,  9 Mar 2022 03:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646824254; x=1678360254;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dxI4nXP7eM1KVmcUxjIZ4iLcGWg/tOi5lpYWVmRNw8c=;
  b=K4hqTKidfQ0/9iCHcB7eN19rBV6RVtmWV1+qNDaS9c+9otlBkfGzEa7R
   BsCPDd4x6iX8gOOcDJfEGguZLfJVNYw7SKCip/z26zxWH7SfM0Z44VeOH
   yebOrTfeaGWfb7LgHWHQ1gnP+q4TPE5OW3fWpnA0LRb7u8z2u2ERDfi1M
   IP3qEGg62hDZUpnFwJIZ5OhrGRBrXOAb/BoDU14nG13/2yxtP1TZao/iQ
   yolM398IFXPdpfP2QbwMLxYLQ6JSzCV099RhhKZiqd8Trqf6fXgqyhzLx
   jj7BxJPuU1IG99Y2KTt5lYCFBSh78Ca3gxghQChWtwzfv8eruzZPTC2iO
   g==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643670000"; 
   d="scan'208";a="22552465"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Mar 2022 12:10:52 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 09 Mar 2022 12:10:52 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 09 Mar 2022 12:10:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646824252; x=1678360252;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dxI4nXP7eM1KVmcUxjIZ4iLcGWg/tOi5lpYWVmRNw8c=;
  b=EGizE3/6voXt8P5WzuiMrx+1raQrzAtvbdyzvQzDkc1e+Am+qA9uvpH+
   Du9caJqQgix6b4p6XpLVNC7OaF6/Iz6jx7k8wbC2qx5YcaQ1+3UZBp/QI
   xChbDLvEqMbZeyuG6+gUbu6F6c+oBlfuO2MzCL/b4JnoZ8aa9yhSdje/6
   787oyRdPNm7rLs1/B6gq2sObS8OjVnzTW6B0uh8K9vBtzBCqqxsk9PcDC
   C0Z8bmHr3d2LbxVhGuFGQ1obHtDKhS47qaiUjmOqNamPBjXPvaqKctowo
   va8zabHam8vbvHcwxuQl+VB9kqbJuuE77yqPkCE/TzKriji5kPv/WW2Dr
   A==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643670000"; 
   d="scan'208";a="22552464"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Mar 2022 12:10:52 +0100
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.201.138])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 6E6CD280065;
        Wed,  9 Mar 2022 12:10:52 +0100 (CET)
Message-ID: <5058591a3e0f0cb82b26cffe888d87b4d1bdd713.camel@ew.tq-group.com>
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
Date:   Wed, 09 Mar 2022 12:10:50 +0100
In-Reply-To: <YihvWFdr1cT7cyk5@atomide.com>
References: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
         <20220204143108.653qk2ihnlhsr5aa@prior> <YgDCLaBHA3DDQAUd@atomide.com>
         <5944ba0ce568eaf507917799b1dfd89a3d0ca492.camel@ew.tq-group.com>
         <YgEBml9HvFzSl289@atomide.com>
         <9923df6525212389b86cb635624bcfb5c27a8bc5.camel@ew.tq-group.com>
         <YgJZbdOlazrde7O/@atomide.com>
         <1356e93cd5b101c3d896e35250c66959ed631544.camel@ew.tq-group.com>
         <YihvWFdr1cT7cyk5@atomide.com>
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

On Wed, 2022-03-09 at 11:11 +0200, Tony Lindgren wrote:
> Hi,
> 
> * Matthias Schiffer <matthias.schiffer@ew.tq-group.com> [220228
> 10:29]:
> > AFAICT, disabling non-operatational devices in the board DTS
> > instead of
> > the SoC DTSI is worse than the alternatives in every way:
> > 
> > - Verbose board DTS: You have to think about all the devices that
> > exist
> > in the SoC, not just the ones you want to use
> > - Adding new nodes without `status = "disabled" to SoC DTSI can
> > potentially cause issues on dependent boards
> > - It doesn't solve the issues that not having `status = "disabled"`
> > in
> > the DTSI is supposed to solve
> 
> My preference is the least amount of tinkering in the dts files
> naturally :) It really does not matter if the extra dts churn is to
> enable or disable devices, it should not be needed at all.
> 
> To summarize, my main point really is the following:
> 
> There should not be any need to tag the SoC internal devices with
> anything
> in the dts files. The device drivers should be able to just deal with
> the
> situation. IMO devices should be tagged with disabled or reserved
> when
> they are not accessible for example because of being used by secure
> mode
> for example. If the the status needs to be set to anything, it really
> is
> a symptom of incomplete handling somewhere.
> 
> Regards,
> 
> Tony


Hi Tony,

while I agree that it would be great if drivers could just detect when
hardware is not available, this is simply not how most drivers work -
when you instantiate the driver via a non-disabled(/reserved/...) DT
node, the driver expects a usable device.

Especially for busses like I2C, there is no way for a driver to
reliably detect whether the bus is usable or not. (There are several
states that can't really be distinguished: Is pinmuxing missing, or
does the device not need any muxing? Is a line low because it is not
actually connected to anything, or is there another master currently
using the bus, or is the bus stuck due to a faulty device?)

Which is why it is the convention for SoC DTSI files disable nodes for
devices that may be unusable. Taking UARTs as an example, a quick grep
for "serial@" nodes in arch/arm/boot/dts/*.dtsi and
arch/arm64/boot/dts/*/*.dtsi shows that the vast majority of these
nodes is disabled by default.

Regards,
Matthias



