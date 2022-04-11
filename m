Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2544FB980
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiDKK1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345558AbiDKK0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:26:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F443EC2;
        Mon, 11 Apr 2022 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649672590; x=1681208590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W9PBitEIG3h2GlCxu7zEfN69pBWFXH7+lRg/Bcxe/tU=;
  b=f72pHBvbzdSnGiJbbZGOcVbarU12CQVURpB/E3Mor0lbiFUfSKpBKLCp
   6pCwb/GQXoLFAL7pCrnqlokfyygyEjJ45Fe72MHYn3ALI1YlBr8qPigsw
   /Civ/Z6elREx7yGDI56V7S3YB9vnFSxZh29aa22UaVzO2smO+mhftg3Py
   rFT9PAS1cJeznNqYOn+eljY8ZhMDdy3uhRTUZ0OzbhG6J5JnTVEc98U9q
   MYkTE5HH9G9YoiXAs5QYtk37GFIl/Epe+LbQviuH2GU6hi7UvjAEejRhG
   bXxI9g44jgjylo+j+xQ4/0Y1PaPYGhxfbUWQGMjCHz4y6XKAFvo+pR2kV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="242018883"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="242018883"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 03:23:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="525460425"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 03:22:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndr8Z-001B7S-AA;
        Mon, 11 Apr 2022 13:19:11 +0300
Date:   Mon, 11 Apr 2022 13:19:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 09/13] pinctrl: meson: Rename REG_* to MESON_REG_*
Message-ID: <YlQAn9+4kdB0F/4d@smile.fi.intel.com>
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
 <20220401103604.8705-10-andriy.shevchenko@linux.intel.com>
 <CAMuHMdX8zWA-3_=Je7sB_72G8Ky7-syqCH-RXGxNMazUipW-2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX8zWA-3_=Je7sB_72G8Ky7-syqCH-RXGxNMazUipW-2g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 11:04:00AM +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 1, 2022 at 12:36 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Currently compilation test fails on x86 due to name collision. The usual
> > way to fix that is to move both conflicting parts to their own namespaces.
> >
> > Rename REG_* to MESON_REG_* as a prerequisite for enabling COMPILE_TEST.

> >         NUM_REG,
> 
> MESON_NUM_REG?

Hmm... Only one place where it's defined and used, but I can do it, sure.

$ git grep -n -w NUM_REG
drivers/pinctrl/meson/pinctrl-meson.h:72:       NUM_REG,
drivers/pinctrl/meson/pinctrl-meson.h:105:      struct meson_reg_desc regs[NUM_REG];

-- 
With Best Regards,
Andy Shevchenko


