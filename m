Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85394874E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbiAGJqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbiAGJqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:46:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EE8C061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 01:46:18 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1n5lpA-0003k4-F7; Fri, 07 Jan 2022 10:46:16 +0100
Message-ID: <30312d09effae6b78309723a7261f85915b8d5b8.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam
 jr
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "ping.bai@nxp.com" <ping.bai@nxp.com>,
        "alice.guo@nxp.com" <alice.guo@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "marex@denx.de" <marex@denx.de>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "horia.geanta@nxp.com" <horia.geanta@nxp.com>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "pankaj.gupta@nxp.com" <pankaj.gupta@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "shengjiu.wang@nxp.com" <shengjiu.wang@nxp.com>,
        "qiangqing.zhang@nxp.com" <qiangqing.zhang@nxp.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jun.li@nxp.com" <jun.li@nxp.com>
Date:   Fri, 07 Jan 2022 10:46:10 +0100
In-Reply-To: <AM6PR06MB469100A5D7A069AF84A83EEFA64C9@AM6PR06MB4691.eurprd06.prod.outlook.com>
References: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
         <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
         <20211207230206.14637-3-andrey.zhizhikin@leica-geosystems.com>
         <aa84249b7e099cf23b49016433b22ae541c0a41d.camel@pengutronix.de>
         <AM6PR06MB469100A5D7A069AF84A83EEFA64C9@AM6PR06MB4691.eurprd06.prod.outlook.com>
Organization: Pengutronix e.K.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-06 at 14:08 +0000, ZHIZHIKIN Andrey wrote:
> Hello Rouven,
> 
> > -----Original Message-----
> > From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> > Sent: Thursday, January 6, 2022 12:27 PM
> > To: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>; linux-
> > kernel@vger.kernel.org
> > Cc: peng.fan@nxp.com; ping.bai@nxp.com; alice.guo@nxp.com; agx@sigxcpu.org;
> > frieder.schrempf@kontron.de; leonard.crestez@nxp.com; festevam@gmail.com;
> > marex@denx.de; herbert@gondor.apana.org.au; horia.geanta@nxp.com;
> > aford173@gmail.com; krzk@kernel.org; linux-imx@nxp.com;
> > devicetree@vger.kernel.org; hongxing.zhu@nxp.com; s.hauer@pengutronix.de;
> > pankaj.gupta@nxp.com; robh+dt@kernel.org; thunder.leizhen@huawei.com;
> > martink@posteo.de; daniel.baluta@nxp.com; linux-arm-kernel@lists.infradead.org;
> > gregkh@linuxfoundation.org; shengjiu.wang@nxp.com; qiangqing.zhang@nxp.com;
> > michael@walle.cc; op-tee@lists.trustedfirmware.org; linux-crypto@vger.kernel.org;
> > kernel@pengutronix.de; jun.li@nxp.com; shawnguo@kernel.org; davem@davemloft.net;
> > l.stach@pengutronix.de
> > Subject: Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam jr
> > 
> > Hi Andrey,
> > 
> > On Wed, 2021-12-08 at 00:02 +0100, Andrey Zhizhikin wrote:
> > > CAAM JR nodes are configured by BootROM and are used by various software
> > > entities during the boot process before they reach the Kernel.
> > > 
> > > Default BootROM configuration have JR0 and JR1 reserved for S-only
> > > access, while JR2 is generally available for both S and NS access. HAB
> > > feature of i.MX8M family does require that JR0 is reserved exclusively
> > > in S-only world, while JR1 and JR2 are both released to NS-World. OP-TEE
> > > can later reclaim the JR2 via dt_enable_secure_status() call, and modify
> > > the DID to hold it in S-World only.
> > > 
> > > The above setup has been discovered during review of CAAM patchset
> > > presented to U-Boot integration [1], and does not correspond to the
> > > status on jr nodes in FDT.
> > > 
> > > This missing status settings leads to the following error message during
> > > jr node probing:
> > > [    1.509894] caam 30900000.crypto: job rings = 3, qi = 0
> > > [    1.525201] caam_jr 30901000.jr: failed to flush job ring 0
> > > [    1.525214] caam_jr: probe of 30901000.jr failed with error -5
> > > 
> > > JR register readout after BootROM execution shows the following values:
> > > JR0DID_MS = 0x8011
> > > JR1DID_MS = 0x8011
> > > JR2DID_MS = 0x0
> > > 
> > > This shows that JR0 and JR1 have TZ_OWN bit set, which marks them to be
> > > reserved for S-World, while JR2 remains accessible from NS-World.
> > > 
> > > Provide the correct status for JR nodes in imx8m derivatives, which have
> > > a following meaning:
> > > - JR0: S-only
> > > - JR1: visible in both
> > > - JR2: NS-only
> > > 
> > > Note, that JR2 is initially marked to be NS-only which does correspond
> > > to DID readout when OP-TEE is not present. Once present, OP-TEE will
> > > reclaim the JR2 and set both "status" and "secure-status" to claim JR2
> > > for S-only access.
> > 
> > While I can understand that you want to fix your use case for when HAB
> > is enabled, note that this is disabling JR0 in the none-HAB case as
> > well.
> 
> This is not totally correct, as this patch does address the reservation of
> JR0 by BootROM in both HAB and non-HAB configurations. My current setup does
> not include HAB functionality enabled, and I still do observe boot errors
> that are listed in commit message. This is due to the fact that the BootROM
> does not release JR0 to NS-World regardless of whether HAB is enabled or not.
> This has been discussed in the U-Boot thread I provided the link in the patch.
> 
> This patch does rather bring the correct HW module description as seeing
> from Linux. 

I took a look into i.MX8MQ, the bootrom indeed sets 0x8011 for JR0 &
JR1:
JR0:0000000000008011
JR1:0000000000008011
JR2:0000000000000000
TF-A
>CAAM
JR0:0000000000000001
JR1:0000000000000001
JR2:0000000000000001

However at least the upstream TF-A reconfigures the DIDs to 1 for all
i.MX8M* derivates.  So while it is technically correct to change the DT
values as you describe, the downstream TF-A and upstream TF-A seem to
differ in their configuration. I also think it's a bad move to hardcode
the JR configuration to the boot ROM config, since AFAIK i.MX8M* can
not be run without TF-A. And IMO the upstream kernel should follow what
the upstream TF-A does in this case.

> 
> > IMO this should be handled correctly by the bootloader and/or OP-
> > TEE. The default upstream configuration for OP-TEE is to not use the
> > CAAM at runtime as well, since linux runtime PM disablement of the CAAM
> > will lock up OP-TEE when it tries to access the CAAM.
> 
> If by handling you mean releasing JR0 reservation - then yes, it should be
> done by either SPL or TF-A as they do run in S World. In such a case, DTB
> bindings need to be adapted further according to the new state. Until this
> done - this patch does provide a correct state of HW to the Kernel.

Upstream TF-A simply releases all JRs to the normal world, matching the
current DTB description.

Kind Regards,
Rouven Czerwinski


> > 
> > Kind regards,
> > Rouven Czerwinski
> > 
> > > 
> > > Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
> > > Link: [1]: https://lore.kernel.org/u-boot/AM6PR06MB4691FC905FE5658BE4B15C11A6609@AM6PR06MB4691.eurprd06.prod.outlook.com/
> > > ---
> > > Changes in V3:
> > > - No change, new patch introduced
> > > 
> > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 4 ++++
> > >  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 4 ++++
> > >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 4 ++++
> > >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++++
> > >  4 files changed, 16 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > index 5b9c2cca9ac4..51465974c4ea 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > @@ -914,18 +914,22 @@ sec_jr0: jr@1000 {
> > >                                       compatible = "fsl,sec-v4.0-job-ring";
> > >                                       reg = <0x1000 0x1000>;
> > >                                       interrupts = <GIC_SPI 105
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     status = "disabled";
> > > +                                     secure-status = "okay";
> > >                               };
> > > 
> > >                               sec_jr1: jr@2000 {
> > >                                       compatible = "fsl,sec-v4.0-job-ring";
> > >                                       reg = <0x2000 0x1000>;
> > >                                       interrupts = <GIC_SPI 106
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     secure-status = "okay";
> > >                               };
> > > 
> > >                               sec_jr2: jr@3000 {
> > >                                       compatible = "fsl,sec-v4.0-job-ring";
> > >                                       reg = <0x3000 0x1000>;
> > >                                       interrupts = <GIC_SPI 114
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     secure-status = "disabled";
> > >                               };
> > >                       };
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > index ba23b416b5e6..e5edf14319b1 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > @@ -808,18 +808,22 @@ sec_jr0: jr@1000 {
> > >                                        compatible = "fsl,sec-v4.0-job-ring";
> > >                                        reg = <0x1000 0x1000>;
> > >                                        interrupts = <GIC_SPI 105
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                      status = "disabled";
> > > +                                      secure-status = "okay";
> > >                               };
> > > 
> > >                               sec_jr1: jr@2000 {
> > >                                        compatible = "fsl,sec-v4.0-job-ring";
> > >                                        reg = <0x2000 0x1000>;
> > >                                        interrupts = <GIC_SPI 106
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                      secure-status = "okay";
> > >                               };
> > > 
> > >                               sec_jr2: jr@3000 {
> > >                                        compatible = "fsl,sec-v4.0-job-ring";
> > >                                        reg = <0x3000 0x1000>;
> > >                                        interrupts = <GIC_SPI 114
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                      secure-status = "disabled";
> > >                               };
> > >                       };
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > index 977783784342..3c23bf5c3910 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > @@ -661,18 +661,22 @@ sec_jr0: jr@1000 {
> > >                                       compatible = "fsl,sec-v4.0-job-ring";
> > >                                       reg = <0x1000 0x1000>;
> > >                                       interrupts = <GIC_SPI 105
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     status = "disabled";
> > > +                                     secure-status = "okay";
> > >                               };
> > > 
> > >                               sec_jr1: jr@2000 {
> > >                                       compatible = "fsl,sec-v4.0-job-ring";
> > >                                       reg = <0x2000 0x1000>;
> > >                                       interrupts = <GIC_SPI 106
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     secure-status = "okay";
> > >                               };
> > > 
> > >                               sec_jr2: jr@3000 {
> > >                                       compatible = "fsl,sec-v4.0-job-ring";
> > >                                       reg = <0x3000 0x1000>;
> > >                                       interrupts = <GIC_SPI 114
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     secure-status = "disabled";
> > >                               };
> > >                       };
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > index 95d8b95d6120..16c4c9110ce7 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > @@ -999,18 +999,22 @@ sec_jr0: jr@1000 {
> > >                                       compatible = "fsl,sec-v4.0-job-ring";
> > >                                       reg = <0x1000 0x1000>;
> > >                                       interrupts = <GIC_SPI 105
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     status = "disabled";
> > > +                                     secure-status = "okay";
> > >                               };
> > > 
> > >                               sec_jr1: jr@2000 {
> > >                                       compatible = "fsl,sec-v4.0-job-ring";
> > >                                       reg = <0x2000 0x1000>;
> > >                                       interrupts = <GIC_SPI 106
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     secure-status = "okay";
> > >                               };
> > > 
> > >                               sec_jr2: jr@3000 {
> > >                                       compatible = "fsl,sec-v4.0-job-ring";
> > >                                       reg = <0x3000 0x1000>;
> > >                                       interrupts = <GIC_SPI 114
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     secure-status = "disabled";
> > >                               };
> > >                       };
> > > 
> > 
> > --
> > Pengutronix e.K.           | Rouven Czerwinski          |
> > Steuerwalder Str. 21       | http://www.pengutronix.de/ |
> > 31137 Hildesheim, Germany  | Phone: +49-5121-206917-0   |
> 
> 
> -- andrey

-- 
Pengutronix e.K.           | Rouven Czerwinski          |
Steuerwalder Str. 21       | http://www.pengutronix.de/ |
31137 Hildesheim, Germany  | Phone: +49-5121-206917-0   |

