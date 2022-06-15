Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66CC54C62E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348502AbiFOKbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242939AbiFOKbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:31:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F09B50B2D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:30:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1o1QHr-0007Ou-CL; Wed, 15 Jun 2022 12:30:11 +0200
Message-ID: <e433fc81d6e1340f463e45af54be16296a2deaf2.camel@pengutronix.de>
Subject: Re: [PATCH 0/8] interconnect: support i.MX8MP
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "djakov@kernel.org" <djakov@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Abel Vesa <abel.vesa@nxp.com>,
        "abailon@baylibre.com" <abailon@baylibre.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Wed, 15 Jun 2022 12:30:09 +0200
In-Reply-To: <DU0PR04MB94172B0EE6455C43B4B0364088AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
         <DU0PR04MB941799547BD863444C6F268D88AB9@DU0PR04MB9417.eurprd04.prod.outlook.com>
         <c2034c030333f89e0ac7d86c906dd222cc151d52.camel@pengutronix.de>
         <DU0PR04MB94173B94950965B7DB3BA4CB88AA9@DU0PR04MB9417.eurprd04.prod.outlook.com>
         <9cc8d2d2ca9ff2ee71d976b2b0210ce144298c46.camel@pengutronix.de>
         <DU0PR04MB94172B0EE6455C43B4B0364088AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 15.06.2022 um 09:28 +0000 schrieb Peng Fan:
> Hi Lucas,
> 
> > Subject: Re: [PATCH 0/8] interconnect: support i.MX8MP
> > 
> > Hi Peng,
> > 
> > Am Dienstag, dem 14.06.2022 um 23:38 +0000 schrieb Peng Fan:
> > > Hi Lucas,
> > > 
> > > > Subject: Re: [PATCH 0/8] interconnect: support i.MX8MP
> > > > 
> > > > Hi Peng,
> > > > 
> > > > Am Montag, dem 13.06.2022 um 01:23 +0000 schrieb Peng Fan:
> > > > > All,
> > > > > 
> > > > > > Subject: [PATCH 0/8] interconnect: support i.MX8MP
> > > > > 
> > > > > I am going to send out V2 this week to address the comments until now.
> > > > > But before that I would like to see if any one has any comments on
> > > > > the design here.
> > > > > 
> > > > > Georgi, do you have comments on Patch 2 " interconnect: add device
> > > > > managed bulk API"
> > > > > 
> > > > > Lucas, since you had comments when I first use syscon to configure
> > > > > NoC, are you ok with the design to use interconnect in this patchset?
> > > > > 
> > > > I'm still not 100% convinced that the blk-ctrl is the right consumer
> > > > for the interconnect, since it doesn't do any busmastering. However,
> > > > the design looks much better than the syscon based one.
> > > > 
> > > > I mostly worry about being able to extend this to do more than the
> > > > current static configuration if/when NXP decides to release more
> > > > information about the NoC configuration options or someone reverse
> > engineers this part of the SoC.
> > > 
> > > I have asked internally, NoC documentation for i.MX8M* is not allowed to
> > public.
> > > 
> > Yea, sadly I've heard this many times from NXP.
> > 
> > > I
> > > > still hope that we could optimize NoC usage by setting real
> > > > bandwidth and latency limits for the devices connected to the NoC.
> > > > As the blk-ctrl doesn't have any clue about this right now, we can't
> > > > really set any more specific requests than the current INT_MAX ones.
> > > 
> > > Actually looking at ATF NoC settings, the values are suggested by
> > > Design team, Design team give SW team such a group of value and not
> > > suggest SW team to change it. And the value in ATF not touch bandwidth
> > > registers, as you could see from the patchset, only mode,priority,ext_control
> > are configured.
> > > 
> > > Similar to qcom using static settings:
> > > ./drivers/interconnect/qcom/qcm2290.c:668.
> > > .qos.qos_mode = NOC_QOS_MODE_FIXED,
> > > 
> > > I understand that people wanna tune the settings at runtime on demand.
> > > 
> > Right. We had the same situation with QoS settings on the i.MX6, where
> > Freescale/NXP claimed that the values from the design team are optimal and
> > should not be changed, but we actually had some cases where tuning those
> > values to the specific use-case of a board was beneficial. With the i.MX6 we
> > could do this on our own, as things were documented, at least partially.
> > 
> > I don't request you or anyone from the NXP open source team to do something
> > here, as I understand that the no documentation policy is an outside decision
> > that you can not really change. I just want to make sure that if someone was to
> > do something about this situation, we don't make that change harder than
> > necessary by locking us into a DT binding and design that might be hard to
> > change later on.
> 
> Hope I could help on this if you have suggestion on technical direction without
> breaking NXP policy.
> 
> > 
> > > > I guess we could extend things in this way by making the blk-ctrl
> > > > not only be a simple consumer of the interconnect, but aggregate
> > > > requests from the devices in the blk-ctrl domain and forward them to the
> > NOC provider, right?
> > > 
> > > I am not sure. This patchset is actually only for init NoC settings
> > > after power on, because the initial value is invalid.
> > > 
> > > I could think how to resolve the INT_MAX settings in next version, For
> > > your upper suggestion, could we start after this version approved for
> > > land in tree?
> > > 
> > I just want you to think about how we could extend the design laid down in this
> > patchset if/when the peripheral drivers are starting to request their actual
> > bandwidth usage. If the answer to this question is "we'll simply make the blk-ctl
> > part of the interconnect hierarchy and let it aggregate the bandwidth requests
> > and forward them to the NoC driver"
> > then I'm fine with this patchset landing in upstream as-is. I'm just not sure if I'm
> > overlooking something here which would prevent such an extension of the
> > design, as I'm not a expert in the interconnect framework.
> 
> There is only priority level as I write in the driver, the priority level is not suggested
> to runtime change according to i.MX design team.
> For media related settings, there is GPR hurry level settings which is written
> in RM and ATF code.
> 
> In normal case, if you really wanna change priority level, you could use
> other value. I'll update driver to describe priority bit mask.
> In some heavy load mode, you could pre-set a GPR hurry level value to boost
> the transaction.
> 
> But since design team not suggest SW to runtime update the value, also no
> idea to match priority level with SW bandwidth. from driver debug, what
> I could improve is the describe the priority register, then people wanna
> to change, could update it.

But we all know that you could do more interesting things in regulator
mode with bandwidth setting changed according to use-case, right? ;)

> 
> Is this ok?
> 
I don't worry too much about the specific implementation in the drivers
right now, as this is something we can change later on. What I'm
worried about is more the DT description. With the description in this
patchset we put the blk-ctrl in charge of requesting the bandwidth
limits, as it's the consumer of the interconnect. But it doesn't really
have any information about the real bandwidth/latency/whatever other
QoS settings of the peripherals, so it can't do a proper request.

If it is possible to extend the current design in the future by making
the blk-ctrl be a interconnect provider to the peripherals in the power
domains _without_ changing the DT description between the blk-ctrl and
NoC node, then I'm fine with the design in this patchset.

Regards,
Lucas

> Thanks,
> Peng.
> 
> > 
> > Regards,
> > Lucas
> > 
> > > 
> > > Thanks,
> > > Peng
> > > 
> > > 
> > > > 
> > > > Regards,
> > > > Lucas
> > > > 
> > > > > Thanks,
> > > > > Peng.
> > > > > 
> > > > > > 
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > 
> > > > > > This patchset is to support i.MX8MP NoC settings, i.MX8MP NoC
> > > > > > initial value after power up is invalid, need set a valid value
> > > > > > after related
> > > > power domain up.
> > > > > > 
> > > > > > This patchset also includes two patch[1,2] during my development
> > > > > > to enable the ICC feature for i.MX8MP.
> > > > > > 
> > > > > > I not include ddrc DVFS in this patchset, ths patchset is only
> > > > > > to support NoC value mode/priority/ext_control being set to a
> > > > > > valid value that suggested by i.MX Chip Design Team. The value
> > > > > > is same as NXP downstream one inside Arm Trusted Firmware:
> > > > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%
> > > > > > 2Fso
> > > > > > 
> > > > 
> > urce.codeaurora.org%2Fexternal%2Fimx%2Fimx-atf%2Ftree%2Fplat%2Fimx%2
> > > > > > 
> > > > 
> > Fimx8m%2Fimx&amp;data=05%7C01%7Cpeng.fan%40nxp.com%7C6cfad0fcec
> > > > 0d472
> > > > > > 
> > > > 
> > 408a208da4e2cd96d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> > > > C63790
> > > > > > 
> > > > 
> > 8251778425186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> > > > QIjoiV2
> > > > > > 
> > > > 
> > luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=U
> > > > vIx%
> > > > > > 
> > > > 
> > 2BAz9rx3Z8Oy7VSCRB90O8M5VICIUaUOiTmYw%2FeI%3D&amp;reserved=0
> > > > > > 8mp/gpc.c?h=lf_v2.4#n97
> > > > > > 
> > > > > > A repo created here:
> > > > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%
> > > > > > 2Fgi
> > > > > > 
> > > > 
> > thub.com%2FMrVan%2Flinux%2Ftree%2Fimx8mp-interconnect&amp;data=05
> > > > %7C
> > > > > > 
> > > > 
> > 01%7Cpeng.fan%40nxp.com%7C6cfad0fcec0d472408a208da4e2cd96d%7C68
> > > > 6ea1d
> > > > > > 
> > > > 
> > 3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637908251778425186%7CUnkn
> > > > own%7CT
> > > > > > 
> > > > 
> > WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> > > > V
> > > > > > 
> > > > 
> > CI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=W2iYPMJ6dn%2F4OTalTD2yqB
> > > > Hx%2Bo3%
> > > > > > 2BuBTuP%2BAe4bBz2Gc%3D&amp;reserved=0
> > > > > > 
> > > > > > Peng Fan (8):
> > > > > >   dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
> > > > > >   interconnect: add device managed bulk API
> > > > > >   interconnect: imx: fix max_node_id
> > > > > >   interconnect: imx: set src node
> > > > > >   interconnect: imx: introduce imx_icc_provider
> > > > > >   interconnect: imx: set of_node for interconnect provider
> > > > > >   interconnect: imx: configure NoC mode/prioriry/ext_control
> > > > > >   interconnect: imx: Add platform driver for imx8mp
> > > > > > 
> > > > > >  .../bindings/interconnect/fsl,imx8m-noc.yaml  |   6 +
> > > > > >  drivers/interconnect/bulk.c                   |  34 +++
> > > > > >  drivers/interconnect/imx/Kconfig              |   4 +
> > > > > >  drivers/interconnect/imx/Makefile             |   2 +
> > > > > >  drivers/interconnect/imx/imx.c                |  68 +++--
> > > > > >  drivers/interconnect/imx/imx.h                |  25 +-
> > > > > >  drivers/interconnect/imx/imx8mm.c             |   2 +-
> > > > > >  drivers/interconnect/imx/imx8mn.c             |   2 +-
> > > > > >  drivers/interconnect/imx/imx8mp.c             | 232
> > > > > > ++++++++++++++++++
> > > > > >  drivers/interconnect/imx/imx8mq.c             |   2 +-
> > > > > >  include/dt-bindings/interconnect/fsl,imx8mp.h |  59 +++++
> > > > > >  include/linux/interconnect.h                  |   6 +
> > > > > >  12 files changed, 424 insertions(+), 18 deletions(-)  create
> > > > > > mode
> > > > > > 100644 drivers/interconnect/imx/imx8mp.c  create mode 100644
> > > > > > include/dt-bindings/interconnect/fsl,imx8mp.h
> > > > > > 
> > > > > > --
> > > > > > 2.25.1
> > > > > 
> > > > 
> > > 
> > 
> 


