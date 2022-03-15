Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9AF4D9666
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbiCOIgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiCOIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:36:35 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A6547554;
        Tue, 15 Mar 2022 01:35:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 229ED51C;
        Tue, 15 Mar 2022 09:35:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647333322;
        bh=2B1abWspufHcU+WluNkys+YV9mGWKvBYO+9++Bkm3NY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQshLCVv7y+XpgxHB+4/J8hdZXKj/9Ux7RpMusc18nIvYIbx2SbrZICKrYwDpbHz2
         3g0l4lmMYeH+H+To1GCyd/U+HiiDvpKSaPoogxtT+pp5PE3d3V5w8Hg4JYnARcVw+p
         6/kz7vCp33yNnqmwiapggEtyAhpU0Mv4ZJSbfB8o=
Date:   Tue, 15 Mar 2022 10:35:05 +0200
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
Message-ID: <YjBPuafv1B5dbu/r@pendragon.ideasonboard.com>
References: <cover.1647274406.git.mchehab@kernel.org>
 <85266b480902079391d4206b8aa276ff131a730f.1647274407.git.mchehab@kernel.org>
 <2816975.e9J7NaK4W3@kista>
 <20220315064005.10ecdab2@coco.lan>
 <YjA4IRD//lb8SKgs@pendragon.ideasonboard.com>
 <20220315092736.7e805c81@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315092736.7e805c81@coco.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 09:27:36AM +0100, Mauro Carvalho Chehab wrote:
> Em Tue, 15 Mar 2022 08:54:25 +0200
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:
> 
> > Hi Mauro,
> > 
> > On Tue, Mar 15, 2022 at 06:40:05AM +0100, Mauro Carvalho Chehab wrote:
> > > Em Mon, 14 Mar 2022 18:22:20 +0100 Jernej Škrabec escreveu:
> > >   
> > > > Dne ponedeljek, 14. marec 2022 ob 17:34:42 CET je Mauro Carvalho Chehab 
> > > > napisal(a):  
> > > > > As the end goal is to have platform drivers split by vendor,
> > > > > rename sunxi/ to allwinner/.
> > > > > 
> > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>    
> > > > 
> > > > I would rather not do that. Everything related to Allwinner is called sunxi, 
> > > > albeit there are a few outliers. This is similar to Amlogic/meson situation.  
> > > 
> > > The rationale of having one directory per manufacturer is that, if drivers
> > > for newer platforms with different names from the same manufacturers are 
> > > added, those will still fit under allwinner/ and amlogic/.
> > > 
> > > The Kconfig names for sunxi and meson didn't change, nor the driver's name. 
> > > Also, the directories under allwinner preserve sun<x>i name on them:
> > > 
> > > 	drivers/media/platform/allwinner/
> > > 	├── sun4i-csi
> > > 	├── sun6i-csi
> > > 	├── sun8i-di
> > > 	└── sun8i-rotate
> > > 
> > > and so the directory under amlogic/:
> > > 
> > > 	drivers/media/platform/amlogic/
> > > 	└── meson-ge2d
> > > 
> > > Now, if Allinner decides to release a new platforms named after another star,
> > > let's say, "Vega" and "Rigel", it would be just a matter of adding 
> > > "vega/" and "rigel/" directories under allwinner. No need to touch
> > > media/platform/Kconfig and media/platform/Makefile. Everything will happen
> > > on much more smaller vendor-specific Kconfig/Makefile.  
> > 
> > But the day Allwinner changes its name to Noloser, we'll have a similar
> > problem. 
> 
> Not really. It will still be a single directory per vendor (whatever
> name it is).
> 
> > Thnk about Freescale vs. NXP, or Altera bought by Intel.
> 
> Yeah, when some drivers move from one vendor to another one that
> already exists there, we should probably move the directories, in
> order to keep things well organized.

I'm not sure we should. We still have arch/arm64/boot/dts/freescale/ for
instance. We can answer that question later though, when confronted with
the situation.

> The worse case scenario is really if, let's say, TI decides to sell their
> omap architecture to NXP, keeping the rest. On such case, the best would
> be to move platform/ti/omap* to the directory of its newer owner.
> 
> That's said, when things like that happen, there are usually a change
> at MAINTAINERS, as e-mails, mailing lists and contact people will
> likely change. So, this will very likely generate patches anyway.
> 
> > No
> > naming scheme is totally future-proof. If the accepted standard through
> > the kernel is to use sunxi to refer to Allwinner SoCs, I don't think
> > it's a bit idea to go with that.
> 
> I'm not too concerned about the name here, but rather about the
> process. Needing to do reorg like this is painful, as it causes 
> all pending work to fail merging against upstream, requiring rebases.
> So, we should avoid needing to re-do it by trying our best to avoid
> the need of another global change like that in the future.

Most of the pain we'll go through in the immediate future comes from the
fact that we never really cared about this. I think renames (of vendors
or product lines) will be infrequent enough that picking sunxi for
Allwinner drivers wouldn't be an issue.

There's a similar think with Renesas, which had an SH product line and
then moved to ARM, creating R-Mobile and R-Car (among other product
liens). That's why we still have drivers/dma/sh/ for Renesas DMA
drivers.

> By organizing entries per vendor, while we may need to do puntual
> per-vendor adjustments when they rename and change IP with other
> vendors, the global platform Kconfig/Make will contain a single entry
> per vendor. I can't foresee any need to change this in the future,
> if we take care of keeping the entries there properly sorted.
> 
> With regards to naming the per-vendor directory, while I do prefer to have
> the  directories named after the vendor, and not after a vendor's nick 
> name, It should also be ok to use a vendor's nick name, provided that 
> such name is meant to be used by all their current and future IP.
> 
> Not sure if "sunxi" is actually a vendor's nick name. It sounds
> much likely that it is, instead, a brand name that covers their 
> current media-related SoC. 
> 
> Can someone from the vendor shed a light on it?

Maybe we can let the Allwinner upstream community tell us what name to
pick ? I'm sure they know better than us :-)

-- 
Regards,

Laurent Pinchart
