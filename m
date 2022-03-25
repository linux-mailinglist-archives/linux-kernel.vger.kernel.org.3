Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC0D4E7D11
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiCYUCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiCYUBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:01:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D126F237FC3;
        Fri, 25 Mar 2022 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648237911; x=1679773911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lrl+aGeTbvJwiVMu8xaP539HJmgEuuOyUPsz3gqZvvs=;
  b=JM57FRYiBGcwfvjgQFuXwPsE0kYLEryANF2Xq0lZB+3G1QkHV/YgCM8Z
   lHR2ia1fhKl9A05IkVJ8oXJK9wfSbvr5jrJOYIWZIfxhUuGwAI8lxRgzQ
   4v+2A4yeyD/FTLdPW3VwOWXgJZD/+w88XXjpXlPgQnsCjM1CKJDMasGJE
   DiOkHcRSOFrtXSSITlBUFkDrrO9EFnyl0AGbNxG4YIIE5uU8Mav/60ePE
   myzqb8uV0xbwJdgaZ6AWrnZ4L+evgguBUVTup/mfH8P5rHp9EwJCoCT/a
   hJ0l6RML67Ao+btb5o7BSImXPcD9rqeAC1Bxr3S/bGxu2PQeoEVMcy6Zc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="256261523"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="256261523"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 10:52:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="602123064"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 10:52:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nXo6N-006Wfs-Po;
        Fri, 25 Mar 2022 19:51:55 +0200
Date:   Fri, 25 Mar 2022 19:51:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 1/1] Makefile.extrawarn: Turn off -Werror when extra
 warnings are enabled
Message-ID: <Yj4BO0wW9Lw/+X4O@smile.fi.intel.com>
References: <20220325131348.3995-1-andriy.shevchenko@linux.intel.com>
 <CAHk-=wgLZC4d-JjoDyJ-0_JNX+nOnkTQdTGKvOE3fBVNvAq-xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLZC4d-JjoDyJ-0_JNX+nOnkTQdTGKvOE3fBVNvAq-xw@mail.gmail.com>
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

On Fri, Mar 25, 2022 at 10:18:06AM -0700, Linus Torvalds wrote:
> On Fri, Mar 25, 2022 at 6:13 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > +#
> > +# Turn off -Werror when extra warnings are enabled
> > +#
> > +ifneq ($(KBUILD_EXTRA_WARN),)
> > +       KBUILD_CFLAGS += -Wno-error
> > +endif
> 
> NAK.
> 
> If you enabled CONFIG_WERROR, then you get CONFIG_WERROR.
> 
> If you enabled W=1, then you get extra warnings.
> 
> If you enabled both, then you get extra warnings and they are errors.
> 
> This patch is just stupid.

Fair enough.

-- 
With Best Regards,
Andy Shevchenko


