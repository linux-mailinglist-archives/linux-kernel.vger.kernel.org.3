Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBADD4DDB32
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbiCROGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiCROGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:06:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32FE2BC1F7;
        Fri, 18 Mar 2022 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647612284; x=1679148284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jcrYNvI61V8kUynPI7hV1XW2k5B5q68nF1eRgoRh4Cw=;
  b=dDJEJ29HrsHRd+6r/qCdPy516QHGxDqaRq/EUT0n6sbNFbLea75XmbCD
   wq51msbMP6SYCDpDdeiLmbEq1an4FDMnYF3eOx3XORFnZsSB58t8oQIvS
   h0eaq22hEdgeQHBGOP5FmUyVfZb9vguSF0Ec+nTFz2KcXnfQU1/m8p1V8
   FoMbUJ9jItDq1htGWfd1wePRDnhVujtvt1M9UamaV7+9SvD5H99g5YDUG
   9nQ/XLxCJ+EHy3SRYIdkqLGVgW+7bV76MF5Js/M2L0eRKOYTbx81WxJ8+
   4Gp166EaeF/SOZxnn2JkVAmhdrZzxjBy4fcCjmBe8JopsjrEYEs+hxHpW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257089815"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257089815"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:04:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="499258563"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:04:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nVDCc-002GJv-Mm;
        Fri, 18 Mar 2022 16:03:38 +0200
Date:   Fri, 18 Mar 2022 16:03:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] gpiolib: acpi: use correct format characters
Message-ID: <YjSROmYwwGhpsXMl@smile.fi.intel.com>
References: <20220316213055.2351342-1-morbo@google.com>
 <YjL6K49CkH+YC4FQ@smile.fi.intel.com>
 <CAKwvOdkjb3uR+kqjfdKL5gqA8R+00c5=3E7uGGW+mGZ3QRsjqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkjb3uR+kqjfdKL5gqA8R+00c5=3E7uGGW+mGZ3QRsjqg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:11:21AM -0700, Nick Desaulniers wrote:
> On Thu, Mar 17, 2022 at 2:07 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Mar 16, 2022 at 02:30:55PM -0700, Bill Wendling wrote:

> > NAK.

I hope you read my follow up to this.

> Andy,
> Our goal is to enable -Wformat for CC=clang.  Please see also:
> commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
> unnecessary %h[xudi] and %hh[xudi]")

Not that I agree on that commit for %h[h]x

	signed char ch = -1;
	printf("%x\n", ch);
	printf("%hhx\n", ch);

That's why my first reaction on this change was NAK.

> and the lore link it cites.
> https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/
> (I saw your follow up; this patch is one of the less controversial
> ones though since the types are not ones that are promoted).

That said, I hope you are very well aware of the case.

-- 
With Best Regards,
Andy Shevchenko


