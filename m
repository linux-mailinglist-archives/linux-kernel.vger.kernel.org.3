Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534E94E7579
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359425AbiCYOzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349429AbiCYOzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:55:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C31E3D9;
        Fri, 25 Mar 2022 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648220059; x=1679756059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iMJdzvSh02iTfUIow/wuk32++Xjz5o8yCK9oUkyArVs=;
  b=I1JKq4WSWPsaMph9fAYA+ZgKD27T17h5BncEn9AVsi/9THv3UAC8vERu
   HMvRHLthqBYAKGOcBmHM5h7LHRaGAnqH4uGB3aqJb0tMROEKZmStj9QyB
   Oz/avdf/WtDT7obTehu3Z+nXymiffna2EJ/KDVFAXtzZWNLyaLnM8mI1g
   FjsTX4DpAN1Q0giqe6GIIBQRW9EPznLou5E+wZ2Y/HcZviCasf/ycV1D6
   HsWvJBo3o4ypCyxvfSrAbqkgQXfrjLg9Xqd+UKyXqn07q3yM+0K0oJ3cL
   gig8BytkOCuLCZH7eCVbF7AjfxMOem2NGynECCxv/q7BxRxXkSQEbUS/t
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="258840228"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="258840228"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 07:54:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="650260471"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 07:54:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nXlJt-006S3T-Gm;
        Fri, 25 Mar 2022 16:53:41 +0200
Date:   Fri, 25 Mar 2022 16:53:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 1/1] Makefile.extrawarn: Turn off -Werror when extra
 warnings are enabled
Message-ID: <Yj3XdSYyxfv5/Al8@smile.fi.intel.com>
References: <20220325131348.3995-1-andriy.shevchenko@linux.intel.com>
 <CAK7LNAR9HS7LK5D-07i8_tFcwd=uiHEFu05n0t_UuFZExcfBpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAR9HS7LK5D-07i8_tFcwd=uiHEFu05n0t_UuFZExcfBpw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 11:34:06PM +0900, Masahiro Yamada wrote:
> On Fri, Mar 25, 2022 at 10:13 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > When `make W=1 ...` is executed the level 1 warnings become errors,
> > due to recent change in some of the defconfigs, and fail the build.
> > Since there are a lot of warnings on the level 1 are still present
> > in the defconfigs at least for x86, let disable -Werror in such case.
> 
> 
> commit b339ec9c229aaf399296a120d7be0e34fbc355ca
> made WERROR default to COMPILE_TEST.
> 
> WERROR should not be enabled for regular builds.
> 
> b9080ba4a6ec should be reverted.

Hmm... works for me, but have you read this discussion:

https://lore.kernel.org/r/YjsCpoRK7W4l6tSh@zn.tnic

?

-- 
With Best Regards,
Andy Shevchenko


