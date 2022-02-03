Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3004A84DB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350699AbiBCNG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:06:26 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:60373 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbiBCNGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643893584; x=1675429584;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z06StxFMGy+m8o+xsY3wZtIwumn4uvS3FLDwZeNIuPI=;
  b=Ge82OH7qrEbWqIffcaS3tKZ7JCaoiaSgx1o3CcCKB+QZt/BfqYj8lpKG
   77R8f5zRC2FFgCqQcuKcxoq93cArm3QgKcsK28Aj95KA8wspJGKHp7SmO
   a+JPUFNHx2fe6QcaN7kxN4Vy64D1vUs1yacb5oDXzilLHtTXUPSnPZ7rG
   lkyvoF1jrHKKC5iTo34C5I0hUKFtO6KENzqHSEMuDplyH99BFcDuJvmVJ
   C2mUUePkiDcxr8Yvl3PjTl1YQNZoEdHEu+8dMn+nfNstWUsx+gQyY0doy
   hKlDAEHKHFqvcpDq9IEdVPHHOhE2xpBKooB+nh9H7lAtHSZE+aN6/Eyhn
   w==;
X-IronPort-AV: E=Sophos;i="5.88,340,1635199200"; 
   d="scan'208";a="21880081"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Feb 2022 14:06:23 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 03 Feb 2022 14:06:23 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 03 Feb 2022 14:06:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643893583; x=1675429583;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z06StxFMGy+m8o+xsY3wZtIwumn4uvS3FLDwZeNIuPI=;
  b=DMgevesNCdZSNDFtTIuxsNVVwX2fy5RVKurymmUKmuCK5pLP4zDC6qHE
   4B4cp5wc02d6SN3c52wOZy13fiwSfb+XRs9dxVLI29ubWFKuGwkerwOhg
   A+0ZcPyhzKmCkHehf+25ayeLdD17vUMYhTfRa2+0k2eI5iTg2sjd+fTM7
   ncex7MSfXTILoYHhfq+wYnUA+bOswUdiBZxVJAtLd0v2f35Ijac3rxYCQ
   D/+fYHXtb8xO9ykV6h1DCChbZfoQ5fQ1xO7Zq/S7789+KkRyXSk4TSszH
   HIdchQgLdOK9KhW8Lmf6Sh4eteOZI1P2WbiQMEBhKkOO18lT9naW6oRDF
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,340,1635199200"; 
   d="scan'208";a="21880080"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Feb 2022 14:06:23 +0100
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.201.138])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 97CCE280065;
        Thu,  3 Feb 2022 14:06:22 +0100 (CET)
Message-ID: <76703db31c4562dba1301e839c70381cf8e403b3.camel@ew.tq-group.com>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am65: disable optional
 peripherals by default
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 03 Feb 2022 14:06:20 +0100
In-Reply-To: <e427670b-0570-df33-c114-fd0633ac1d44@siemens.com>
References: <5beef188724ef42b0c2147ca9bf6e6ca25c75dec.1641900122.git.matthias.schiffer@ew.tq-group.com>
         <20220202203217.sf2cr4orwl4usvyf@starry>
         <e427670b-0570-df33-c114-fd0633ac1d44@siemens.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-03 at 12:39 +0100, Jan Kiszka wrote:
> On 02.02.22 21:32, Nishanth Menon wrote:
> > On 12:25-20220111, Matthias Schiffer wrote:
> > > All peripharals that require pinmuxing or other configuration to
> > > work
> > > should be disabled by default. Dependent DTS are adjusted
> > > accordingly.
> > > 
> > > The following nodes are now "disabled" according to dtx_diff and
> > > were not
> > > overridden to "okay", as they define no pinctrl:
> > > 
> > > k3-am654-base-board:
> > > - mcu_i2c0
> > > - mcu_spi0..2
> > > - cal
> > > - main_i2c3
> > > - ehrpwm0..5
> > > - main_uart1..2
> > > - main_spi1..4
> > > 
> > > k3-am65-iot2050*:
> > > - mci_spi1..2
> > > - cal
> > > - ehrpwm0..5
> > > - main_spi0..4
> > > 
> > > Signed-off-by: Matthias Schiffer <
> > > matthias.schiffer@ew.tq-group.com>
> > 
> > Jan: you ok with this series? Please ack.
> > 
> 
> Just rebased the still-too-long backlog to our system fully working
> over 
> mainline.

Thanks for testing. As noted earlier, I will send a v2 of this patch
that fixes one more inconsistency.

> Basically looks good, but this might be a regression of the 
> patch:
> 
> [    1.810083] OF: /bus@100000/pcie@5600000: phandle pcie-mode@4070
> needs 1, found 0
> ...
> [    1.854840] OF: /bus@100000/pcie@5600000: phandle pcie-devid@210
> needs 1, found 0
> 
> Jan
> 

That seems to be an older issue, rather than a regression of this
patch:

k3-am65-main.dtsi defines:

    ti,syscon-pcie-id = <&pcie_devid>;
    ti,syscon-pcie-mode = <&pcie0_mode>

While according the driver binding docs something like the following is
expected:

    ti,syscon-pcie-id = <&scm_conf 0x0210>;
    ti,syscon-pcie-mode = <&scm_conf 0x4060>;

I assume that the k3-am65-main.dtsi section was imported from ti-linux
without accounting for the mainline driver's different binding.

Matthias

