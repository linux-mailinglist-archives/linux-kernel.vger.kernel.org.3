Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3994B2482
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349465AbiBKLfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:35:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbiBKLfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:35:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35AAE76;
        Fri, 11 Feb 2022 03:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644579350; x=1676115350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oKU+556CH19q9JkpqQw/lSP+Woo1fSuxfhrkttxrgN8=;
  b=BLxMtsMfzYXuG1mmnnkA1tFnvwtM4/yzB42o+WUOdKUhg4M7u1EBB/ly
   +7Qah/b0c+1+0BD32ncdTHNqLzy4WwkeOqNs1qcncgdVyC0bco4YuKzY/
   COs+pteAa5oS0iZsBBWFtlDFlma2fnaiBa4H5UD2eYicoyFdcyepFL5Xy
   qNQDDBqraeqa/dcEY/Zl0R6BOKK5dZWOn9sA4UG/+IK2hY2+7Wd4sbOkp
   dms7uRM81HfF3/pafT2gFzJF8Tr3+RdcCLX0ecwiEwgroknJjALaK4u6p
   tPOX40v1M75PK7MqDLuxQG1UK05ZseLvLE02MOCDcYSUDXRr++edFuDVL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="248548341"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="248548341"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 03:35:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="542052949"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 03:35:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIUCQ-003QO6-FQ;
        Fri, 11 Feb 2022 13:34:50 +0200
Date:   Fri, 11 Feb 2022 13:34:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v4 5/6] MAINTAINERS: Add entry for Solomon SSD130x OLED
 displays DRM driver
Message-ID: <YgZJ2sV956zg9IXO@smile.fi.intel.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211092157.2988713-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211092157.2988713-1-javierm@redhat.com>
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

On Fri, Feb 11, 2022 at 10:21:57AM +0100, Javier Martinez Canillas wrote:
> To make sure that tools like the get_maintainer.pl script will suggest
> to Cc me if patches are posted for this driver.
> 
> Also include the Device Tree binding for the old ssd1307fb fbdev driver
> since the new DRM driver was made compatible with the existing binding.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Adapt MAINTAINERS entry to point to the new drivers/gpu/drm/solomon directory.
> 
> Changes in v2:
> - Add Sam Ravnborg's acked-by to patch adding a MAINTAINERS entry (Sam Ravnborg)
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d03ad8da1f36..05c306986ab0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6102,6 +6102,13 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/repaper.txt
>  F:	drivers/gpu/drm/tiny/repaper.c
>  
> +DRM DRIVER FOR SOLOMON SSD130X OLED DISPLAYS
> +M:	Javier Martinez Canillas <javierm@redhat.com>
> +S:	Maintained
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +F:	drivers/gpu/drm/solomon/ssd130x*
> +
>  DRM DRIVER FOR QEMU'S CIRRUS DEVICE
>  M:	Dave Airlie <airlied@redhat.com>
>  M:	Gerd Hoffmann <kraxel@redhat.com>
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


