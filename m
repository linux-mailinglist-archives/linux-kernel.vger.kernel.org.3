Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DC357FC6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiGYJbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGYJbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:31:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1375813E8A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:31:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oFuQT-0005av-7V; Mon, 25 Jul 2022 11:30:57 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oFuQS-00038s-Lg; Mon, 25 Jul 2022 11:30:56 +0200
Date:   Mon, 25 Jul 2022 11:30:56 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
Message-ID: <20220725093056.ywr7zo37e4rbrvei@pengutronix.de>
References: <20220725035931.3988435-1-peng.fan@oss.nxp.com>
 <20220725085050.izj7kmgeuxxug6rh@pengutronix.de>
 <DU0PR04MB9417BBDAE35E932F7601F94788959@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417BBDAE35E932F7601F94788959@DU0PR04MB9417.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-25, Peng Fan wrote:
> Hi Marco,
> 
> > Subject: Re: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
> > 
> > Hi Peng,
> > 
> > thanks for the patch.
> > 
> > On 22-07-25, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > i.MX93 mediamix blk ctrl has registers to set QoS(priority) value.
> > > It support default QoS value and cfg QoS value. Set an initial value
> > > from i.MX design team. If LCDIF/ISI/PXP wanna a different QoS value in
> > > future, they could use interconnect to request bandwidth.
> > 
> > I need to ask here. Does the iMX93 use the same interconnect as the
> > iMX8M* does?
> 
> No. i.MX93 use different interconnect, it has different design, 
> the QoS priority register are distributed in blk ctrl. 

Did just the interface change e.g. how you configure the interconnect or
is it a complete new interconnect?

> The reference manual would be public soon I think, then you could
> have more information.

Looking forward to it :)

Regards,
  Marco
