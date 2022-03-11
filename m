Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E981A4D637E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349384AbiCKOfH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Mar 2022 09:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349378AbiCKOfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:35:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6531C8877
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:34:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nSgKt-0008D8-KP; Fri, 11 Mar 2022 15:33:43 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nSgKo-0004KT-D1; Fri, 11 Mar 2022 15:33:37 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nSgKm-0008ny-48; Fri, 11 Mar 2022 15:33:36 +0100
Message-ID: <7dedaf783d9bc7d26adb427003c17bcdc3f82193.camel@pengutronix.de>
Subject: Re: [PATCH v2 07/38] media: platform: place NXP drivers on a
 separate dir
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Date:   Fri, 11 Mar 2022 15:33:36 +0100
In-Reply-To: <723fbc3e03d8817916a085e218befd6400d299a3.1647006877.git.mchehab@kernel.org>
References: <cover.1647006877.git.mchehab@kernel.org>
         <723fbc3e03d8817916a085e218befd6400d299a3.1647006877.git.mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2022-03-11 at 15:07 +0100, Mauro Carvalho Chehab wrote:
> In order to cleanup the main platform media directory, move NXP
> driver to its own directory.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists
> were C/C on the cover.
> See [PATCH v2 00/38] at:  
> https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/
> 
[...]
> diff --git a/drivers/media/platform/nxp/Makefile
> b/drivers/media/platform/nxp/Makefile
> new file mode 100644
> index 000000000000..147bd7ad4ef4
> --- /dev/null
> +++ b/drivers/media/platform/nxp/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_VIDEO_IMX_PXP)            += imx-pxp.o
> +obj-$(CONFIG_VIDEO_VIU)                        += fsl-viu.o
> +obj-$(CONFIG_VIDEO_MX2_EMMAPRP)                += mx2_emmaprp.o

Should these be sorted as well?

regards
Philipp
