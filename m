Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD441475A74
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243285AbhLOORN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:17:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:44608 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243291AbhLOORI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:17:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="237973151"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="237973151"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 06:17:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="567937520"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 06:16:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mxV4Z-006d5b-Tn;
        Wed, 15 Dec 2021 16:15:59 +0200
Date:   Wed, 15 Dec 2021 16:15:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Radim Pavlik <radim.pavlik@tbs-biometrics.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        - <patches@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linux-mediatek@lists.infradead.org, linux-oxnas@groups.io,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Sean Wang <sean.wang@kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        arm-soc <soc@kernel.org>
Subject: Re: [PATCH v1 1/2] pinctrl: Get rid of duplicate of_node assignment
 in the drivers
Message-ID: <Ybn4ny0YY/Sbld+Q@smile.fi.intel.com>
References: <20211213163929.7509-1-andriy.shevchenko@linux.intel.com>
 <CAMuHMdW_CKcXwOSUAbCreHVM62E35yjiCfpXC_wM0zK-V43CnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW_CKcXwOSUAbCreHVM62E35yjiCfpXC_wM0zK-V43CnA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:28:34AM +0100, Geert Uytterhoeven wrote:
> On Mon, Dec 13, 2021 at 5:40 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > GPIO library does copy the of_node from the parent device of
> > the GPIO chip, there is no need to repeat this in the individual
> > drivers. Remove these assignment all at once.
> >
> > For the details one may look into the of_gpio_dev_init() implementation.

> >  drivers/pinctrl/renesas/pinctrl-rza2.c     | 1 -
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, there is v2 with this patch w/o changes. I take a liberty to
extrapolate the tags to it. I need to send a v3 in case Linus hasn't
taken the first patch before it happens.

-- 
With Best Regards,
Andy Shevchenko


