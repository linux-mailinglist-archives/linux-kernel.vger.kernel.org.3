Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84759E77A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244886AbiHWQgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244991AbiHWQf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:35:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461D6F25D;
        Tue, 23 Aug 2022 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661266066; x=1692802066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/OQEUPblx8ZWr1PbZjofhsyr29E34e1HQ6mir9IbSOk=;
  b=PULi/HT3akw28FknFLQ1n/mtWUkLbon/s3OICb/bBG/296MwXgbWLKVQ
   RH4LCqEZLp2HMMma8c6qP06AmgJGRRIISU0AWLcms0gAnmlXvBgiFz3mz
   xVAg28z+nHRzwzxN9D9FMosUC/M13xPQBPiCYnVDRpSlqgYVpexfFBPO/
   yYD4PRWmnXkLxJKm47ojy698TailU5WkaJo80wIaK3ulsgzWoMERpfXCi
   E0UyijNxBuh82ZBpXaz5brgLN0JMBRE/tH8HzOL1EY73tuf2Goi5HN1lg
   CkUgna+n1GzrmIWO86dZl5wtCiPgMnwZ9bbohRKK/kpltafx+AezNTnAh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="294494394"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="294494394"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:47:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="751707348"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:47:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQVBq-002TwM-2I;
        Tue, 23 Aug 2022 17:47:38 +0300
Date:   Tue, 23 Aug 2022 17:47:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        simon.guinot@sequanux.org
Subject: Re: [PATCH v4 1/5] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Message-ID: <YwToilxquEZGqzQD@smile.fi.intel.com>
References: <20220823102344.17624-1-henning.schild@siemens.com>
 <20220823102344.17624-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823102344.17624-2-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 12:23:40PM +0200, Henning Schild wrote:
> Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> very similar to the ones from Fintek. In other subsystems they also
> share drivers and are called a family of drivers.
> 
> For the GPIO subsystem the only difference is that the direction bit is
> reversed and that there is only one data bit per pin. On the SuperIO
> level the logical device is another one.
> 
> On a chip level we do not have a manufacturer ID to check and also no
> revision.

...

> - * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882, F71889 and F81866
> + * GPIO driver for Fintek and Nuvoton Super-I/O chips

I'm not sure it's good idea to drop it from here. It means reader has to get
this info in a hard way.

...

> +#define gpio_dir_invert(type)	((type) == nct6116d)
> +#define gpio_data_single(type)	((type) == nct6116d)

What's prevents us to add a proper prefix to these? I don't like the idea of
them having "gpio" prefix.

...

> +		pr_info(DRVNAME ": Unsupported device 0x%04x\n", devid);
> +			pr_debug(DRVNAME ": Not a Fintek device at 0x%08x\n", addr);
> +	pr_info(DRVNAME ": Found %s at %#x\n",
> +		pr_info(DRVNAME ":   revision %d\n",

Can we, please, utilize pr_fmt()?

> +			(int)superio_inb(addr, SIO_FINTEK_DEVREV));

Explicit casting in printf() means wrong specifier in 99% of cases.

-- 
With Best Regards,
Andy Shevchenko


