Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766114D94E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbiCOG4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiCOGz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:55:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659023EBAA;
        Mon, 14 Mar 2022 23:54:44 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF2E22E0;
        Tue, 15 Mar 2022 07:54:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647327282;
        bh=0t0XozP0brbzPT8rNKSKC6uluNF3U4uw5OCNPmKli3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k6xzUlo1WwbpSNXkyl5FgDcCyzSCWNx10je1BagTxSi7PiXQGTsSLAdH7vy0VEWKE
         tyu6+D+q4R+SBr+cV1Fi7Mv3dPCc9Op1qRgQN/lxfvSwZVivPDwNp4KnXpAhXtdtqw
         dQny82l5U8TbVR+C7foHXUUBD49LdBzkjEM9iPG0=
Date:   Tue, 15 Mar 2022 08:54:25 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Ondrej Jirman <megous@megous.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Yong Deng <yong.deng@magewell.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 47/67] media: platform: rename sunxi/ to allwinner/
Message-ID: <YjA4IRD//lb8SKgs@pendragon.ideasonboard.com>
References: <cover.1647274406.git.mchehab@kernel.org>
 <85266b480902079391d4206b8aa276ff131a730f.1647274407.git.mchehab@kernel.org>
 <2816975.e9J7NaK4W3@kista>
 <20220315064005.10ecdab2@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315064005.10ecdab2@coco.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Tue, Mar 15, 2022 at 06:40:05AM +0100, Mauro Carvalho Chehab wrote:
> Em Mon, 14 Mar 2022 18:22:20 +0100 Jernej Škrabec escreveu:
> 
> > Dne ponedeljek, 14. marec 2022 ob 17:34:42 CET je Mauro Carvalho Chehab 
> > napisal(a):
> > > As the end goal is to have platform drivers split by vendor,
> > > rename sunxi/ to allwinner/.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>  
> > 
> > I would rather not do that. Everything related to Allwinner is called sunxi, 
> > albeit there are a few outliers. This is similar to Amlogic/meson situation.
> 
> The rationale of having one directory per manufacturer is that, if drivers
> for newer platforms with different names from the same manufacturers are 
> added, those will still fit under allwinner/ and amlogic/.
> 
> The Kconfig names for sunxi and meson didn't change, nor the driver's name. 
> Also, the directories under allwinner preserve sun<x>i name on them:
> 
> 	drivers/media/platform/allwinner/
> 	├── sun4i-csi
> 	├── sun6i-csi
> 	├── sun8i-di
> 	└── sun8i-rotate
> 
> and so the directory under amlogic/:
> 
> 	drivers/media/platform/amlogic/
> 	└── meson-ge2d
> 
> Now, if Allinner decides to release a new platforms named after another star,
> let's say, "Vega" and "Rigel", it would be just a matter of adding 
> "vega/" and "rigel/" directories under allwinner. No need to touch
> media/platform/Kconfig and media/platform/Makefile. Everything will happen
> on much more smaller vendor-specific Kconfig/Makefile.

But the day Allwinner changes its name to Noloser, we'll have a similar
problem. Thnk about Freescale vs. NXP, or Altera bought by Intel. No
naming scheme is totally future-proof. If the accepted standard through
the kernel is to use sunxi to refer to Allwinner SoCs, I don't think
it's a bit idea to go with that.

> See for instance, TI. We had initially a single driver, and everywhere it
> was called "omap", which was had gained different versions (omap2, omap3, 
> ...). Then, TI decided to use other names for newer IP (davinci, am437x), 
> and now the current development is at cal and vpe.
> 
> If we had placed a ti/ directory by the time omap were added (and the
> same for the other vendors), we would have avoided the need of this
> reorg.

-- 
Regards,

Laurent Pinchart
