Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BF7472E97
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbhLMOKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:10:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:3399 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238725AbhLMOKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:10:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="238961836"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="238961836"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 06:05:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="609028967"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 06:05:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwlwO-005dxK-9w;
        Mon, 13 Dec 2021 16:04:32 +0200
Date:   Mon, 13 Dec 2021 16:04:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Marc Zyngier <maz@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Tony Lindgren <tony@atomide.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Thierry Reding <treding@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-unisoc@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Keerthy <j-keerthy@ti.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 1/3] gpio: Get rid of duplicate of_node assignment in
 the drivers
Message-ID: <YbdS8E6lHGzWniba@smile.fi.intel.com>
References: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Meve=W3yvPmakFap-s6cOY1GUq7c1VjJE2dEH4f0+shag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Meve=W3yvPmakFap-s6cOY1GUq7c1VjJE2dEH4f0+shag@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:50:57PM +0100, Bartosz Golaszewski wrote:
> On Thu, Dec 2, 2021 at 10:17 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > GPIO library does copy the of_node from the parent device of
> > the GPIO chip, there is no need to repeat this in the individual
> > drivers. Remove these assignment all at once.
> >
> > For the details one may look into the of_gpio_dev_init() implementation.

> If there are no objections, I am willing to apply this to give it some
> time in next and get the work on dropping the OF APIs from gpiolib
> going.

There was a v2 sent out.

  Message-Id: <20211206131852.74746-1-andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


