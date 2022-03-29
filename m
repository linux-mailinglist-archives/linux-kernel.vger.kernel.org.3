Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC35E4EB231
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbiC2QuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239884AbiC2QuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:50:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4768924F283;
        Tue, 29 Mar 2022 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648572496; x=1680108496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=l79PCfT680tSg5itoW3f+C4BVaO65e08V3oBAzUaQsg=;
  b=mvTq5SvPLjHI/l9uBUOpTYZmJJVadA8YNncWNLQx+QiakguhpbM4VspM
   VaxWLPlpIUPknbSNYXY3NLh/XGiiR9Z7RL7idOykqABsWWOMNgzYdcyvp
   D+PoTKtf+XVq0a594l4/aPxSBaO/X5vbH3x1x/2i9ja96LFpDBNCxuRY0
   hvqOCk97ETR1e8ODEmPKXEC+vKERFzlk8vk572oATFZyvvc89WHbS/0af
   TKmcNBCwKUhfAxsXq9qKfhNP5H+wKm49qkVW1hCaVms9q4fQQxCmgU/Ku
   LnBhVjXPbgA6+vmE1VxbaCFFosB1r1aJ7Ld+Cfqa4eeVHMa9wZAn/2Ikq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="284206058"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="284206058"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 09:42:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="554327473"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 09:42:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nZEuu-008rb0-Vw;
        Tue, 29 Mar 2022 19:42:00 +0300
Date:   Tue, 29 Mar 2022 19:42:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>,
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 09/13] pinctrl: meson: Rename REG_* to MREG_*
Message-ID: <YkM22GwhxV+YKl8l@smile.fi.intel.com>
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
 <20220329152926.50958-10-andriy.shevchenko@linux.intel.com>
 <94e888fe-d8fc-5379-302f-66d64f2ae10b@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94e888fe-d8fc-5379-302f-66d64f2ae10b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 06:13:19PM +0200, Neil Armstrong wrote:
> On 29/03/2022 17:29, Andy Shevchenko wrote:
> > Rename REG_* to * as a prerequisite for enabling COMPILE_TEST.
> 
> What error do you hit ?

arch/x86/include/asm/arch_hweight.h:9:17: error: expected identifier before string constant
9 | #define REG_OUT "a"
  |                 ^~~
drivers/pinctrl/meson/pinctrl-meson.h:69:9: note: in expansion of macro ‘REG_OUT’
69 |         REG_OUT,

And some more.

> MREG_ is rather ugly, something like PINCONF_REG_ or more simpler MESON_REG_ would be more appropriate.

Fine with me.

-- 
With Best Regards,
Andy Shevchenko


