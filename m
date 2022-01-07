Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8484876FB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347324AbiAGLzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347307AbiAGLzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:55:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA0C0611FF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 03:55:41 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1n5nqN-0003j8-DI; Fri, 07 Jan 2022 12:55:39 +0100
Message-ID: <b5e37dc573f9cefc83f73f1113a632a29ba9a833.camel@pengutronix.de>
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
Date:   Fri, 07 Jan 2022 12:55:34 +0100
In-Reply-To: <AM6PR06MB46919E01996D1F1DE326306DA64D9@AM6PR06MB4691.eurprd06.prod.outlook.com>
References: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
         <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
         <20211207230206.14637-3-andrey.zhizhikin@leica-geosystems.com>
         <aa84249b7e099cf23b49016433b22ae541c0a41d.camel@pengutronix.de>
         <AM6PR06MB469100A5D7A069AF84A83EEFA64C9@AM6PR06MB4691.eurprd06.prod.outlook.com>
         <30312d09effae6b78309723a7261f85915b8d5b8.camel@pengutronix.de>
         <AM6PR06MB46919E01996D1F1DE326306DA64D9@AM6PR06MB4691.eurprd06.prod.outlook.com>
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

On Fri, 2022-01-07 at 10:40 +0000, ZHIZHIKIN Andrey wrote:
> Hello Rouven,
> 
> > -----Original Message-----
> > From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> > Sent: Friday, January 7, 2022 10:46 AM
> > To: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>; linux-
> > kernel@vger.kernel.org
> > Cc: peng.fan@nxp.com; ping.bai@nxp.com; alice.guo@nxp.com; agx@sigxcpu.org;
> > krzk@kernel.org; leonard.crestez@nxp.com; festevam@gmail.com; marex@denx.de;
> > herbert@gondor.apana.org.au; horia.geanta@nxp.com; daniel.baluta@nxp.com;
> > frieder.schrempf@kontron.de; linux-imx@nxp.com; devicetree@vger.kernel.org;
> > hongxing.zhu@nxp.com; s.hauer@pengutronix.de; pankaj.gupta@nxp.com;
> > robh+dt@kernel.org; thunder.leizhen@huawei.com; martink@posteo.de;
> > aford173@gmail.com; linux-arm-kernel@lists.infradead.org;
> > gregkh@linuxfoundation.org; shengjiu.wang@nxp.com; qiangqing.zhang@nxp.com;
> > michael@walle.cc; op-tee@lists.trustedfirmware.org; linux-crypto@vger.kernel.org;
> > kernel@pengutronix.de; l.stach@pengutronix.de; shawnguo@kernel.org;
> > davem@davemloft.net; jun.li@nxp.com
> > Subject: Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam jr
> > 
> > 
> > On Thu, 2022-01-06 at 14:08 +0000, ZHIZHIKIN Andrey wrote:
> > > Hello Rouven,
> > > 
> > > > -----Original Message-----
> > > > From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> > > > Sent: Thursday, January 6, 2022 12:27 PM
> > > > To: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>; linux-
> > > > kernel@vger.kernel.org
> > > > Cc: peng.fan@nxp.com; ping.bai@nxp.com; alice.guo@nxp.com; agx@sigxcpu.org;
> > > > frieder.schrempf@kontron.de; leonard.crestez@nxp.com; festevam@gmail.com;
> > > > marex@denx.de; herbert@gondor.apana.org.au; horia.geanta@nxp.com;
> > > > aford173@gmail.com; krzk@kernel.org; linux-imx@nxp.com;
> > > > devicetree@vger.kernel.org; hongxing.zhu@nxp.com; s.hauer@pengutronix.de;
> > > > pankaj.gupta@nxp.com; robh+dt@kernel.org; thunder.leizhen@huawei.com;
> > > > martink@posteo.de; daniel.baluta@nxp.com; linux-arm-
> > kernel@lists.infradead.org;
> > > > gregkh@linuxfoundation.org; shengjiu.wang@nxp.com; qiangqing.zhang@nxp.com;
> > > > michael@walle.cc; op-tee@lists.trustedfirmware.org; linux-
> > crypto@vger.kernel.org;
> > > > kernel@pengutronix.de; jun.li@nxp.com; shawnguo@kernel.org;
> > davem@davemloft.net;
> > > > l.stach@pengutronix.de
> > > > Subject: Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam
> > jr
> > > > 
> > > > Hi Andrey,
> > > > 
> > > > On Wed, 2021-12-08 at 00:02 +0100, Andrey Zhizhikin wrote:
> > > > > CAAM JR nodes are configured by BootROM and are used by various software
> > > > > entities during the boot process before they reach the Kernel.
> > > > > 
> > > > > Default BootROM configuration have JR0 and JR1 reserved for S-only
> > > > > access, while JR2 is generally available for both S and NS access. HAB
> > > > > feature of i.MX8M family does require that JR0 is reserved exclusively
> > > > > in S-only world, while JR1 and JR2 are both released to NS-World. OP-TEE
> > > > > can later reclaim the JR2 via dt_enable_secure_status() call, and modify
> > > > > the DID to hold it in S-World only.
> > > > > 
> > > > > The above setup has been discovered during review of CAAM patchset
> > > > > presented to U-Boot integration [1], and does not correspond to the
> > > > > status on jr nodes in FDT.
> > > > > 
> > > > > This missing status settings leads to the following error message during
> > > > > jr node probing:
> > > > > [    1.509894] caam 30900000.crypto: job rings = 3, qi = 0
> > > > > [    1.525201] caam_jr 30901000.jr: failed to flush job ring 0
> > > > > [    1.525214] caam_jr: probe of 30901000.jr failed with error -5
> > > > > 
> > > > > JR register readout after BootROM execution shows the following values:
> > > > > JR0DID_MS = 0x8011
> > > > > JR1DID_MS = 0x8011
> > > > > JR2DID_MS = 0x0
> > > > > 
> > > > > This shows that JR0 and JR1 have TZ_OWN bit set, which marks them to be
> > > > > reserved for S-World, while JR2 remains accessible from NS-World.
> > > > > 
> > > > > Provide the correct status for JR nodes in imx8m derivatives, which have
> > > > > a following meaning:
> > > > > - JR0: S-only
> > > > > - JR1: visible in both
> > > > > - JR2: NS-only
> > > > > 
> > > > > Note, that JR2 is initially marked to be NS-only which does correspond
> > > > > to DID readout when OP-TEE is not present. Once present, OP-TEE will
> > > > > reclaim the JR2 and set both "status" and "secure-status" to claim JR2
> > > > > for S-only access.
> > > > 
> > > > While I can understand that you want to fix your use case for when HAB
> > > > is enabled, note that this is disabling JR0 in the none-HAB case as
> > > > well.
> > > 
> > > This is not totally correct, as this patch does address the reservation of
> > > JR0 by BootROM in both HAB and non-HAB configurations. My current setup does
> > > not include HAB functionality enabled, and I still do observe boot errors
> > > that are listed in commit message. This is due to the fact that the BootROM
> > > does not release JR0 to NS-World regardless of whether HAB is enabled or not.
> > > This has been discussed in the U-Boot thread I provided the link in the patch.
> > > 
> > > This patch does rather bring the correct HW module description as seeing
> > > from Linux.
> > 
> > I took a look into i.MX8MQ, the bootrom indeed sets 0x8011 for JR0 &
> > JR1:
> > JR0:0000000000008011
> > JR1:0000000000008011
> > JR2:0000000000000000
> > TF-A
> > > CAAM
> > JR0:0000000000000001
> > JR1:0000000000000001
> > JR2:0000000000000001
> > 
> > However at least the upstream TF-A reconfigures the DIDs to 1 for all
> > i.MX8M* derivates.  So while it is technically correct to change the DT
> > values as you describe, the downstream TF-A and upstream TF-A seem to
> > differ in their configuration. I also think it's a bad move to hardcode
> > the JR configuration to the boot ROM config, since AFAIK i.MX8M* can
> > not be run without TF-A. And IMO the upstream kernel should follow what
> > the upstream TF-A does in this case.
> 
> This is indeed an interesting piece of information, thanks a lot!
> 
> From what I understood in previous discussions for this series here in
> the Kernel, and on U-Boot ML: JR0 is required to be held reserved in
> S-World for HAB to operate, and this is clearly communicated by NXP in [1].
> If my understanding is correct, then upstream TF-A either does not support
> or breaks the HAB feature.

Yes, upstream TF-A does not implement the NXP specific SIPs to
communicate with the ROM code to do further image authentication.
Thats also the reason why all JRs are released to normal world, there
is no possible HAB use after TF-A has started.

> I've been following the build documentation in U-Boot, where the downstream
> TF-A is listed as build prequisites [2] without any mentioning of upstream,
> hence I received a readout that matched the BootROM "1-to-1".

Yes, since the downstream TF-A is required to authenticate further
images.

Aside from this the bootrom HAB interface on i.MX8MQ was broken in
interesting ways, I had to implement parsing of the HAB status SRAM
area by hand within barebox.

> I believe that if the information from NXP regarding JR0 reservation for
> HAB is correct (and I have no reasons to doubt it), then upstream TF-A
> should be adapted in order for HAB feature to work, and in that case this
> patch brings correct HW state description as seeing from Linux.

JR0 for HAB in S-World makes sense to me, otherwise the bootrom will
probably refuse to work with the JR.

> And in contrary, if the upstream TF-A is not adjusted to include HAB
> support - then applying this patch would effectively just "remove" one
> JR device, still keeping 2 additional available nodes for HW crypto
> operations in Kernel, with added benefit that both upstream and
> downstream TF-A can be used during the boot without seeing issues later
> in the Kernel.

Even with the downstream TF-A there is no reason to keep JR0 asigned to
the secure world, unless you are running OP-TEE. JR0 assignement for
HAB shouldn't be required after the bootloader has run, unless you want
to HAB authenticate images from a running Linux kernel.

The reason NXP hardcodes the configuration downstream is of course to
support HAB & OP-TEE, but this is still not a reason to hardcode this
assignement into the kernel device tree. They probably also hardcode it
in their downstream kernel versions.

I can understand that it seems easier to hardcode this in the kernel,
but as I said before, if you are running OP-TEE you need to adjust the
DT anyway since nodes need to be added and you might as well adjust the
jobring configuration than.

Kind regards,
Rouven

> 
> > 
> > > 
> > > > IMO this should be handled correctly by the bootloader and/or OP-
> > > > TEE. The default upstream configuration for OP-TEE is to not use the
> > > > CAAM at runtime as well, since linux runtime PM disablement of the CAAM
> > > > will lock up OP-TEE when it tries to access the CAAM.
> > > 
> > > If by handling you mean releasing JR0 reservation - then yes, it should be
> > > done by either SPL or TF-A as they do run in S World. In such a case, DTB
> > > bindings need to be adapted further according to the new state. Until this
> > > done - this patch does provide a correct state of HW to the Kernel.
> > 
> > Upstream TF-A simply releases all JRs to the normal world, matching the
> > current DTB description.
> > 
> > Kind Regards,
> > Rouven Czerwinski
> > 
> > 
> [snip]
> 
> Regards,
> Andrey
> 
> Link: [1]: https://lore.kernel.org/u-boot/VI1PR04MB5342C8C6E651EC2CC4477EB5E79A9@VI1PR04MB5342.eurprd04.prod.outlook.com/
> Link: [2]: https://source.denx.de/u-boot/u-boot/-/blob/master/doc/board/nxp/imx8mm_evk.rst

-- 
Pengutronix e.K.           | Rouven Czerwinski          |
Steuerwalder Str. 21       | http://www.pengutronix.de/ |
31137 Hildesheim, Germany  | Phone: +49-5121-206917-0   |

