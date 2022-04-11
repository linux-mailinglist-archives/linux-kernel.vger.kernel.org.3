Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9614FB98A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbiDKK3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345438AbiDKK3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:29:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336473DDEB;
        Mon, 11 Apr 2022 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649672807; x=1681208807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w/B9OC3B9ubhCDDuz61ASu2Hiu/rM8Lrj6qHHNYq32U=;
  b=PEkdTgVIBKpikfPJb9nnVxnlA7BOopgtITPDU0Q2kruQ2xYupDh9yJQ6
   qfP5fAyJwj3rYVAByYgqb7SUqe9BwckDUuSwI/Dqvyv17zU4iY1KOx3I0
   Vm5eRey3DGlFnO4zf9RWCvGEyIekG+YMytSUVy5ckG/QnBXCUWjA76yB6
   U4uN9DJSM8vn3vXJrjDT9slo6xRKaVfktAoTPsgzMHBzEeljNLVcjIIiz
   8rtG/5hweZad0kRBqP5wBm4MgZlSe1DXFDEu4PC+ZzxwNy28x7pnLmZyv
   77d5ytlLVp2y4KJJaFSOjRmPtIM/wakOiehx+X3kYmepRGuvFcWmh139E
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="348521541"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="348521541"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 03:26:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="644032222"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 03:26:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndrCE-001BAf-W7;
        Mon, 11 Apr 2022 13:22:58 +0300
Date:   Mon, 11 Apr 2022 13:22:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, joel@jms.id.au,
        andrew@aj.id.au, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        alcooperx@gmail.com, christophe.jaillet@wanadoo.fr,
        cai.huoqing@linux.dev, benh@kernel.crashing.org,
        neal_liu@aspeedtech.com, miles.chen@mediatek.com,
        balamanikandan.gunasundar@microchip.com, macpaul.lin@mediatek.com,
        s.shtylyov@omp.ru, jakobkoschel@gmail.com,
        stern@rowland.harvard.edu, quic_wcheng@quicinc.com,
        yashsri421@gmail.com, rdunlap@infradead.org,
        linux-geode@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] usb: gadget: udc: clean up comments
Message-ID: <YlQBgnjpkSurf9PZ@smile.fi.intel.com>
References: <20220410150828.1891123-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410150828.1891123-1-trix@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 11:08:28AM -0400, Tom Rix wrote:
> SPDX
> *.h use /* */ style comments
> 
> For double words, remove
> with, also
> 
> Spelling replacements
> wayt to way
> wakup to wakeup
> Contrl to Control
> cheks to checks
> initiaization to initialization
> dyanmic to dynamic

Something really wrong with indentation above.

...

>  drivers/usb/gadget/udc/amd5536udc.h       | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/core.c | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/ep0.c  | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 4 ++--
>  drivers/usb/gadget/udc/at91_udc.c         | 2 +-
>  drivers/usb/gadget/udc/bdc/bdc_core.c     | 4 ++--
>  drivers/usb/gadget/udc/core.c             | 4 ++--
>  drivers/usb/gadget/udc/trace.h            | 2 +-

I believe that Greg's bot asks to split on per-driver basis.
OTOH I don't see anything that can be problematic if in one
change. So, it's up to maintainers then.

...

> --- a/drivers/usb/gadget/udc/amd5536udc.h
> +++ b/drivers/usb/gadget/udc/amd5536udc.h

>   * amd5536.h -- header for AMD 5536 UDC high/full speed USB device controller

At the same time you may drop the filename(s) from the file(s) as this very
one shows why it's good not to have a filename inside file.

-- 
With Best Regards,
Andy Shevchenko


