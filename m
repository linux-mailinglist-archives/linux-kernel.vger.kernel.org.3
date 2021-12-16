Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E004766EC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhLPAYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLPAYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:24:39 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B03C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:24:39 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A6173F6;
        Thu, 16 Dec 2021 01:24:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1639614275;
        bh=jluRvkznhFHQAEudwl6chNVc4AtO829dsSTMAFxI34o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cviJ20aoht5w/BMK49EwlMpGgioG0ErkirGWvjTxg0fDBDNJcRre7ulVmKEVzBYii
         wQlZIlVvsOhBvhNCQoah91L4MF+KINUFx129SgaGMssdrgDAqk2iZyE6qAxlMMDjSm
         gmjQZN3KylbyHCYzrmYFjaAi4Ut+Ggv6xhcWlqGU=
Date:   Thu, 16 Dec 2021 02:24:32 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Alison Wang <alison.wang@nxp.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Lechner <david@lechnology.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        Emma Anholt <emma@anholt.net>,
        Erico Nunes <nunes.erico@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Inki Dae <inki.dae@samsung.com>, Joel Stanley <joel@jms.id.au>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <sean@poorly.run>,
        Stefan Agner <stefan@agner.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>
Subject: Re: [PATCH 00/60] drm: Make all drivers to honour the nomodeset
 parameter
Message-ID: <YbqHQAFtwvTvYddZ@pendragon.ideasonboard.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
 <Ybp7qDs1p3x5GzNJ@pendragon.ideasonboard.com>
 <91c6b455-62cd-cec7-8445-e93c99230a03@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91c6b455-62cd-cec7-8445-e93c99230a03@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Thu, Dec 16, 2021 at 01:13:56AM +0100, Javier Martinez Canillas wrote:
> Hello Laurent,
> 
> On 12/16/21 00:35, Laurent Pinchart wrote:
> 
> [snip]
> 
> >>
> >> I've built tested with 'make allmodconfig && make M=drivers/gpu/drm/', but
> >> only booted in a few devices with and without nomodeset in the cmdline. So
> >> testing and reviewing for all the drivers would be highly appreciated.
> > 
> > The fact that the series is so big makes me think it would be better to
> > handle this in the DRM core. Is there any way we could do so ? Otherwise
> > we'll chase this issue forever in new drivers, and will be plagued with
> > cargo cult problems.
> > 
> 
> Yes, what Thomas suggested is to add a set of drm_module_{pci,platform}_driver()
> macros in include/drm/drm_drv.h, that will just check whether the driver should
> be registered or not and call the {pci,platform}_register_driver() functions.
> 
> That way the change in the drivers would just be something like the following:
> 
> -module_platform_driver(malidp_platform_driver);
> +drm_module_platform_driver(malidp_platform_driver);
> 
> There are some drivers that still need a custom module init functions for various
> reasons (e.g: register a set of devices/drivers, need to be a late init call, etc)
> but at least for most drivers this should be handled transparently as long as they
> use these drm_*_register_driver() macros.

Another option could be to return an error from drm_dev_alloc(). That
may avoid changes in the drivers.

> So just ignore this series and I'll post a v2 soon.

-- 
Regards,

Laurent Pinchart
