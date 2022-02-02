Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606664A759E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbiBBQRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:17:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:12098 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231455AbiBBQRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643818654; x=1675354654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DBfsC8a66ExyypbPhJbhCI57mnu5iWgHbE6gVmzyI2I=;
  b=YVMf+l1+ZKlvAuNqSqpMqmK2q82XtSwzBOO/3r70+NvFOox/UnJQVUi0
   rCd5MKXhkLnqyU86xXPqW5SvSYDubPmUqvhPpHXZ+pazqZMEN/XNmraWu
   sBFoyTn6vkICS19EntOqG8Rsx/F4fffzgU+sZtPWDzd6r8N8/yhWAN+Ud
   laO70xLGSd0UpO0NpMSjqUyzH5lfyvuQ2t1XqSs56fw5zuj97SoHXRZWo
   doJzrBKBhp5SgZy0GwMeWdPSWogy/SPRJ+bSh9E4urUFZfuZ3ObdJ3dBT
   AY1nL3MoWU+m9jetMbS7Mgyi7mWfuUJ3Oejoi3kB9dyrpS+0WqpSRuQNq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="334311447"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="334311447"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 08:17:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="769324845"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 08:17:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nFIJ2-0008eW-RG;
        Wed, 02 Feb 2022 18:16:28 +0200
Date:   Wed, 2 Feb 2022 18:16:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
Message-ID: <YfquXPrMX6PdD/6u@smile.fi.intel.com>
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202160149.GA2322037@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 08:01:49AM -0800, Guenter Roeck wrote:
> On Sun, Jan 30, 2022 at 10:36:53AM -0800, Kees Cook wrote:

...

> > +static const int strlen_ce = strlen("tada, a constant expression");
> 
> This results in:
> 
> lib/test_string.c:188:30: error: initializer element is not constant
>   188 | static const int strlen_ce = strlen("tada, a constant expression");
> 
> for several of my tests. I don't think you can mandate that a compiler
> implements this.

With -O2 probably one can, otherwise I agree.

-- 
With Best Regards,
Andy Shevchenko


