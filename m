Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A9D4EC8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348424AbiC3Pxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348415AbiC3Pxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:53:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD85E15A3C;
        Wed, 30 Mar 2022 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648655522; x=1680191522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aHOCvdmEcRy5ZvBUbTf9zFkDOMo9CAy71FTo/IenFRo=;
  b=L1+XjfbPxJ0kzgV7LL2sAqCWSdraTfNgzM6bnfGb40Jq8TBJqwvitsCC
   uo3pOiHpuItE7fsiALkf8yZEmQm3g0yF2G6dK3OUGxxpMWQU8166fszug
   kJu16kOpLkFzts1EXqlnFZWSpiad8XQiVuBjZ0N10KjZv5iLeZeSPAG6E
   rkM2h4w39gNynO2whfHEcO2Az6bJp9D7/S801+mztsCzKtG2PXD8h1/AK
   dtEgpEXRmvlTaMnfPyd78Np8KoivIWgu3MBORSybpcIwo4G1q80LpTK7t
   c/rPyArFw3RvOYa9l/czQ4nVwqfLvN8GxGjfdR3mrBPcNBYU8bDJBZwA5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="257154356"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="257154356"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:52:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="788049544"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:51:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nZabQ-009UCS-Cy;
        Wed, 30 Mar 2022 18:51:20 +0300
Date:   Wed, 30 Mar 2022 18:51:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
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
Message-ID: <YkR8eDT6fS8uRpOT@smile.fi.intel.com>
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
 <20220329152926.50958-10-andriy.shevchenko@linux.intel.com>
 <94e888fe-d8fc-5379-302f-66d64f2ae10b@baylibre.com>
 <YkM22GwhxV+YKl8l@smile.fi.intel.com>
 <CAMuHMdWVA834tkeag=WOnHFGuhwZ93PkrgO24OV69Fye1hruLw@mail.gmail.com>
 <1b0bc704-a740-ea15-1e90-166905be27d0@baylibre.com>
 <YkQgfwUs8KbhF/b/@smile.fi.intel.com>
 <6812bb31-5d2b-4737-c2ad-8727d105847d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6812bb31-5d2b-4737-c2ad-8727d105847d@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 05:22:56PM +0200, Neil Armstrong wrote:
> On 30/03/2022 11:18, Andy Shevchenko wrote:

...

> > > > > > What error do you hit ?
> > > > > 
> > > > > arch/x86/include/asm/arch_hweight.h:9:17: error: expected identifier before string constant
> > > > > 9 | #define REG_OUT "a"
> > > > >     |                 ^~~
> > > > 
> > > > Perhaps REG_{OUT,IN} in arch/x86/include/asm/arch_hweight.h should be
> > > > renamed instead, as this is a generic header file that can be included
> > > > anywhere, while the REG_{OUT,IN} definitions are only used locally,
> > > > in the header file?
> > > 
> > > Even better, those REG_OUT/REG_IN should be undefined at the end of the header since only
> > > used in the headers inline functions:
> > > ==============><==================================
> > > diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
> > > index ba88edd0d58b..139a4b0a2a14 100644
> > > --- a/arch/x86/include/asm/arch_hweight.h
> > > +++ b/arch/x86/include/asm/arch_hweight.h
> > > @@ -52,4 +52,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
> > >   }
> > >   #endif /* CONFIG_X86_32 */
> > > 
> > > +#undef REG_IN
> > > +#undef REG_OUT
> > > +
> > >   #endif
> > > ==============><==================================
> > 
> > Can you submit a formal patch, please?
> 
> I'll submit it separately

Sure!

> > And I think it would be good to have my patch as well, so we do not depend on
> > the fate of the other one.
> 
> Yes sure

Thanks for acknowledging and review!

-- 
With Best Regards,
Andy Shevchenko


