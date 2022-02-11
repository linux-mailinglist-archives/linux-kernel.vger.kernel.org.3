Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E014B2483
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349477AbiBKLgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:36:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349469AbiBKLgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:36:03 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7182E9A;
        Fri, 11 Feb 2022 03:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644579362; x=1676115362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bTdjHFPr4nUGXu4pkdc+I1g9MpzgJ+mPYB+7OmSpI0M=;
  b=kUmus4ZgUHJybwx9oGpA7n5rWQbC0XkmCMJnmdpam9V7xIiMpuqmU8Jc
   qllVEuhGnUBwdXzOztoiaFkRACCBgoAnsHeC9RQ2nGeflCUwu05S/3wfS
   UTkkajLoOl9ilvlSqyShMwCmPAhWNezEdj9OidyoEC00Htsh4Sa+lirdv
   3s6drvE5Z3xihd7ZT+0vq8l9QThOTDqmLfgQFV7k5cYuSwn6rWBujgUBy
   qrcBYNHRxvKqAhwtFowyT6fu9f9iBmO0ffKgeOIel8kszWGhiuQrRcdL7
   1JLJEnSxZQE8EAJjgzOWU21sjeo3xPYndb/vYfDtY3WK26BzM3kaqXGYs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249924371"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="249924371"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 03:36:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="500756801"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 03:36:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIUCc-003QOI-Io;
        Fri, 11 Feb 2022 13:35:02 +0200
Date:   Fri, 11 Feb 2022 13:35:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 6/6] dt-bindings: display: ssd1307fb: Add myself as
 binding co-maintainer
Message-ID: <YgZJ5jX9BUZ4/0Ed@smile.fi.intel.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211092253.2988843-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211092253.2988843-1-javierm@redhat.com>
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

On Fri, Feb 11, 2022 at 10:22:53AM +0100, Javier Martinez Canillas wrote:
> The ssd130x DRM driver also makes use of this Device Tree binding to allow
> existing users of the fbdev driver to migrate without the need to change
> their Device Trees.
> 
> Add myself as another maintainer of the binding, to make sure that I will
> be on Cc when patches are proposed for it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> 
> Changes in v4:
> - Add Rob Herring Acked-by tag to patch adding as DT binding co-maintainer.
> 
> Changes in v2:
> - Add myself as co-maintainer of the ssd1370fb DT binding (Sam Ravnborg).
> 
>  Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> index 2ed2a7d0ca2f..9baafd0c42dd 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> @@ -8,6 +8,7 @@ title: Solomon SSD1307 OLED Controller Framebuffer
>  
>  maintainers:
>    - Maxime Ripard <mripard@kernel.org>
> +  - Javier Martinez Canillas <javierm@redhat.com>
>  
>  properties:
>    compatible:
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


