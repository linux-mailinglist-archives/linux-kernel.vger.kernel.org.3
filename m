Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2978D4B318E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 00:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354292AbiBKXze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 18:55:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345542AbiBKXzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 18:55:32 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F835D62;
        Fri, 11 Feb 2022 15:55:29 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21BNtDX9100106;
        Fri, 11 Feb 2022 17:55:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644623713;
        bh=1vHM54CwcHIN0I3vPq+6F3y9c45xrEOak2ZCfgkFXns=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ArVGPduCVXYbNZVR72h4nSVLYRdr6R13CzR6BaEjc10JNQyOCKWsateCyzJI7dF73
         VCqfqdFr9d6kMltvGzx5lJi+5Y95mIdlcmf8Csf1Bod1zrSjPmGpjxTq0xFd7wMzpN
         gLveCS8kr76w0irvB+aPgBiT9P98zLQxK08d3iaw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21BNtDBq014636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Feb 2022 17:55:13 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 11
 Feb 2022 17:55:13 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 11 Feb 2022 17:55:13 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21BNtDaZ016680;
        Fri, 11 Feb 2022 17:55:13 -0600
Date:   Fri, 11 Feb 2022 17:55:13 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] arm64: dts: ti: Introduce base support for AM62x SoC
Message-ID: <20220211235513.cplmvgfuwe3dhzbs@nearby>
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-5-vigneshr@ti.com>
 <bc6cb6e1adcf6860a595b71246778733@kernel.org>
 <20220210193459.nl6baranvmqs46bi@coastal>
 <87bkzdljt1.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87bkzdljt1.wl-maz@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:33-20220211, Marc Zyngier wrote:
> On Thu, 10 Feb 2022 19:34:59 +0000,
> Nishanth Menon <nm@ti.com> wrote:
> > 
> > On 19:10-20220209, Marc Zyngier wrote:
> > [...]
> > 
> > > > +&cbass_main {
> > > > +	gic500: interrupt-controller@1800000 {
> > > > +		compatible = "arm,gic-v3";
> > > > +		#address-cells = <2>;
> > > > +		#size-cells = <2>;
> > > > +		ranges;
> > > > +		#interrupt-cells = <3>;
> > > > +		interrupt-controller;
> > > > +		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
> > > > +		      <0x00 0x01880000 0x00 0xC0000>;	/* GICR */
> > > 
> > > Usual rant: you are missing the GICC, GICH and GICV regions
> > > that are implemented by the CPU. Cortex-A53 implements them
> > > (they are not optional), so please describe them.
> > > 
> > 
> > 
> > -ECONFUSED. TRM for GIC500 refers to just GICD, GICR and ITS range[1].
> 
> And I'm not talking about the GIC, but of the CPU interface. The fact
> that we describe both in the GIC binding doesn't mean they are
> implemented by the same IP block (and the architecture is quite clear
> about that).
> 
> > Same thing is indicated by Generic Interrupt Controller Architecture
> > Specification[2] See table 1-1 (page 23).
> > 
> > I think you are expecting GICV3's backward compatibility mode (Table 1-2
> > in page 24), But in K3 architecture, are_option meant for backward
> > compatibility is set to true (aka no backward compatibility). I think
> > this did popup sometime back as well (first k3 SoC)[3]. I think the more
> > clearer description is available in [4].
> 
> No, this description is for the architecture as a whole. ARE being
> disabled *int the GIC* doesn't mean it is disabled overall, and the
> CPU is free to implement the CPU interface by any mean it wants as
> long as it communicates with the GIC using the Stream Protocol.
> Cortex-A32, A34, 35, A53, A57, A72 and A73 all implement both the
> sysreg and MMIO CPU interfaces. Later ARM CPUs don't. Both can work
> with GIC500.
> 
> > I believe the argumentation that GICC/H/V is mandatory for A53 if GIC500
> > is used is not accurate. Please correct me if I am mistaken.
> 
> GIC500 is not involved at all, and A53 always implements both the
> system register and MMIO interfaces. See the A53 TRM, chapter 9. The
> only way to disable this interface is to assert GICCDISABLE, which
> disables the whole of the CPU interface. Given that you have a (more
> or less) functional system, it probably isn't the case.
> 
> See Table 9-1, which tells you where these registers are as an offset
> from PERIPHBASE. Dumping these registers should show you that they are
> indeed implemented and not solely a figment of my own imagination.

Thanks for explaining.. I don't see this is working in practise.. Let me
know if I am making a mistake in my interpretation.

Quote from our internal integration spec (yep it leaves it to ARM cluster's
use):
""
Note: GIC periphery base tieoff to ARM corepacs for GIC v2 compatibility
requires a dedicated unallocated space to be passed as input to ARM corepac.
The CC internal region 0F00_0000-0x0F03_FFFF is assigned as GIC periphery
base tieoff to the corepac.
When GIC-500 is in v3 mode, and A72 with GICCDISABLE=0 and PERIPHBASE set:
- the CPU interface registers are accessed via ICC* system register.
- the GICC* regions (PERIPHBASE - PERIPHBASE+0x3FFFF) are reserved
  and access will be Read as Zero / Write Ignored.
So any writes/reads to this region would be trapped by ARM corepacs.
""

Anyways, Here is my report. I checked across all K3 devices (a72 and
a53)
AM65x: PERIPH_BASE = 0x6f000000 (a53)
j721e: PERIPH_BASE = 0x6f000000 (a72)
J7200: PERIPH_BASE = 0x6f000000 (a72)
j721s2: PERIPH_BASE = 0x6f000000 (a72)
AM64: PERIPH_BASE = 0x100000000 (a53)
AM62: PERIPH_BASE = 0x100000000 (a53)

(side note: am64/62 needed the 0x6f.. address space for PCIe stuff.. but
the address chosen has nothing in SoC fabric)

Tested at u-boot shell prompt (running at EL2):

If I understood the expectation correctly..I should be seeing offsets
off [1]. Taking 'CPU Interface'/GICC as an example, [2] should be the
registers I should be seeing. aka, at offset 0xfc from PERIPHBASE, i
should see 0x0034443B.

Note: on K3 devices (in the 32bit address space), as in the
description above, we have a null endpoint handler in the bus fabric
that responds with 0x0 for read requests for invalid/reserved addresses.

What I see is 0x0 (and not IIDR) in all the address ranges - which matches ARM
sending that region requests straight down to SoC level and SoC
returning "ignore"..

On AM62, I attached Lauterbach. and tried to look at the addresses: [3]
from cpu view and from bus view.

I also checked from kernel side with devmem to make sure to dump while
kernel GICV3 is active.. I see the same thing as well..

Is there something TFA or someone has to do to "enable" this? I tried
re-reading porting-guide.rst yet again to make sure we have'nt missed
anything.

[1] https://developer.arm.com/documentation/ddi0500/j/Generic-Interrupt-Controller-CPU-Interface/GIC-programmers-model/Memory-map?lang=en
[2] https://developer.arm.com/documentation/ddi0500/j/Generic-Interrupt-Controller-CPU-Interface/GIC-programmers-model/CPU-interface-register-summary
[3] https://pasteboard.co/3O44PAwLeAXz.png


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
