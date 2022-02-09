Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30AF4AF4EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiBIPQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiBIPQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:16:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFE6C06157B;
        Wed,  9 Feb 2022 07:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644419806; x=1675955806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ips/vlMbcMaW6wh2et2HO87qwxGUzpVO0/saNuNMm8=;
  b=l+me4jh1LM4AzXUaHy1JK5FbuiSTrzXCOnQ/trQxJlUL7/Wz4TXRsgiH
   /e9dVxr7tR611kcCuHDFSywz5B0bggjEa7JyFz7ebMyfhaBkkT+UxyFnQ
   RjqV+dvkuWE1gme2kTeo4PoKSj3IYbR21oQ0qlaTqR15R7hlNLO9vUQHl
   xk88BMmxCFkoMY0OpvfDls79wFkxc8OMsEcrNB9Uklna1AEJ3Xt14/U5o
   O+MYnFaTa/3RXf6ncigHs8VFYi0upsFNnAeKpltW9qLVLaOLAaVhX+NoL
   En+cx76sl5kPJQELy6zA/JbuYLcnvwogAvHwcamIEvWzuhP36cVn+lGRp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249173324"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249173324"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 07:16:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="568265096"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 07:16:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nHoh4-002eX3-6v;
        Wed, 09 Feb 2022 17:15:42 +0200
Date:   Wed, 9 Feb 2022 17:15:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v3 4/7] drm/solomon: Add SSD130X OLED displays I2C support
Message-ID: <YgPanXaAYQxHTjMd@smile.fi.intel.com>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-5-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209090314.2511959-5-javierm@redhat.com>
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

On Wed, Feb 09, 2022 at 10:03:11AM +0100, Javier Martinez Canillas wrote:
> The ssd130x driver only provides the core support for these devices but it
> does not have any bus transport logic. Add a driver to interface over I2C.

Thanks!

...

> + * Authors: Javier Martinez Canillas <javierm@redhat.com>

s?!

...

> +#include <linux/i2c.h>
> +#include <linux/module.h>

regmap.h ?
err.h?

...

> +	ssd130x = ssd130x_probe(&client->dev, regmap);

> +

Redundant blank line.

> +	if (IS_ERR(ssd130x))
> +		return PTR_ERR(ssd130x);

...

> +	{ /* sentinel */ },

No comma for terminator entry.


-- 
With Best Regards,
Andy Shevchenko


