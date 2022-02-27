Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A104C5946
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 05:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiB0Ed3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 23:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiB0Ed0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 23:33:26 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7CD64C7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 20:32:45 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id i1so8050079plr.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 20:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V0NXTTUtgA/oGX4k6vizOWmOH7IBA/cr6jGaV8/q6Dk=;
        b=X5aHHgUHO3GW2wcXJuA03R6s3sgCr5tVp2HbVQrkQEZMuu2LgJC2N0WJ4T+8JSJGPm
         1R/VJnu9nZkHk4iRSysho7l3SZVUc4BIOMRRQDXpcQs58l+xML8UHWq0sMI64XAU6X5F
         M+euc4ystkce1cTNrJnxmGMGZKmejdgF6A3ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V0NXTTUtgA/oGX4k6vizOWmOH7IBA/cr6jGaV8/q6Dk=;
        b=P5Px4s5cQOw/duj4eJSCHY1qtB9oFK0QS9HeTNhg2uhkScsqw+AqH3cjmuN2Cuc/Hq
         PHsVoD+caLFbWspnP+Uehi7YDqCcUm7IO/uGBtMqaaA2yUICbr7hCOmLuu4OOfYwXGDt
         hjhmGzgBEDfmxf2ZKTglGBqpQdVkiCv0G8AmuzMmHKt+W73SD0LQrSo9dXOsQjCZjJBS
         b7aYIvGJPpbqYc5rr2SnnVYJwMpDjYdrYygtQeUBXy1/vIF1JA5DpEb3X7k0/P58AK8O
         0n9eT1cExUHU+uQOTdO1uVbaN+Wk6FqRoBulFEbZcgTBgEyH51Da3CrlS/ArL7E/Iej/
         29Xg==
X-Gm-Message-State: AOAM531FLvfq4UHZMkvk1CKp+5k+3YXOcPCd1Wf8ykl7y88GGJWL6ZFi
        QX0w6MSllL7zzRAr4R7KOHzQSi5t/So/3w==
X-Google-Smtp-Source: ABdhPJxPX/Wfc0ac5Oc0+o1xz/dTND1kMRds8wHhylRrZKCJaZaMAlIfBDdnpE5Wp3ix500Rxl1WXw==
X-Received: by 2002:a17:902:cf05:b0:14d:5249:3b1f with SMTP id i5-20020a170902cf0500b0014d52493b1fmr14649864plg.135.1645936365066;
        Sat, 26 Feb 2022 20:32:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090acd0500b001b9c05b075dsm13281756pju.44.2022.02.26.20.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 20:32:44 -0800 (PST)
Date:   Sat, 26 Feb 2022 20:32:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [kees:for-next/hardening 8/8] mm/usercopy.c:61:29: error:
 'current_stack_pointer' undeclared; did you mean
 'current_user_stack_pointer'?
Message-ID: <202202262032.F5B53F8@keescook>
References: <202202270550.5SPauZxm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202270550.5SPauZxm-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 05:47:56AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
> head:   3dd3738f624d9cf94b96e023880d1ec69c21327e
> commit: 3dd3738f624d9cf94b96e023880d1ec69c21327e [8/8] m68k: Implement "current_stack_pointer"
> config: m68k-sun3x_defconfig (https://download.01.org/0day-ci/archive/20220227/202202270550.5SPauZxm-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=3dd3738f624d9cf94b96e023880d1ec69c21327e
>         git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
>         git fetch --no-tags kees for-next/hardening
>         git checkout 3dd3738f624d9cf94b96e023880d1ec69c21327e
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Ah! Good catch. The new macro needed to be outside the #ifdef; I missed.
Fixed now.

-Kees

> 
> All errors (new ones prefixed by >>):
> 
>    mm/usercopy.c: In function 'check_stack_object':
> >> mm/usercopy.c:61:29: error: 'current_stack_pointer' undeclared (first use in this function); did you mean 'current_user_stack_pointer'?
>       61 |                 if ((void *)current_stack_pointer < obj + len)
>          |                             ^~~~~~~~~~~~~~~~~~~~~
>          |                             current_user_stack_pointer
>    mm/usercopy.c:61:29: note: each undeclared identifier is reported only once for each function it appears in
>    mm/usercopy.c: In function '__check_object_size':
>    mm/usercopy.c:297:47: error: 'current_stack_pointer' undeclared (first use in this function); did you mean 'current_user_stack_pointer'?
>      297 |                                 ptr - (void *)current_stack_pointer :
>          |                                               ^~~~~~~~~~~~~~~~~~~~~
>          |                                               current_user_stack_pointer
> 
> 
> vim +61 mm/usercopy.c
> 
> f5509cc18daa7f Kees Cook    2016-06-07  24  
> f5509cc18daa7f Kees Cook    2016-06-07  25  /*
> f5509cc18daa7f Kees Cook    2016-06-07  26   * Checks if a given pointer and length is contained by the current
> f5509cc18daa7f Kees Cook    2016-06-07  27   * stack frame (if possible).
> f5509cc18daa7f Kees Cook    2016-06-07  28   *
> f5509cc18daa7f Kees Cook    2016-06-07  29   * Returns:
> f5509cc18daa7f Kees Cook    2016-06-07  30   *	NOT_STACK: not at all on the stack
> f5509cc18daa7f Kees Cook    2016-06-07  31   *	GOOD_FRAME: fully within a valid stack frame
> 2792d84e6da5e0 Kees Cook    2022-02-16  32   *	GOOD_STACK: within the current stack (when can't frame-check exactly)
> f5509cc18daa7f Kees Cook    2016-06-07  33   *	BAD_STACK: error condition (invalid stack position or bad stack frame)
> f5509cc18daa7f Kees Cook    2016-06-07  34   */
> f5509cc18daa7f Kees Cook    2016-06-07  35  static noinline int check_stack_object(const void *obj, unsigned long len)
> f5509cc18daa7f Kees Cook    2016-06-07  36  {
> f5509cc18daa7f Kees Cook    2016-06-07  37  	const void * const stack = task_stack_page(current);
> f5509cc18daa7f Kees Cook    2016-06-07  38  	const void * const stackend = stack + THREAD_SIZE;
> f5509cc18daa7f Kees Cook    2016-06-07  39  	int ret;
> f5509cc18daa7f Kees Cook    2016-06-07  40  
> f5509cc18daa7f Kees Cook    2016-06-07  41  	/* Object is not on the stack at all. */
> f5509cc18daa7f Kees Cook    2016-06-07  42  	if (obj + len <= stack || stackend <= obj)
> f5509cc18daa7f Kees Cook    2016-06-07  43  		return NOT_STACK;
> f5509cc18daa7f Kees Cook    2016-06-07  44  
> f5509cc18daa7f Kees Cook    2016-06-07  45  	/*
> f5509cc18daa7f Kees Cook    2016-06-07  46  	 * Reject: object partially overlaps the stack (passing the
> 5ce1be0e40fe64 Randy Dunlap 2020-08-11  47  	 * check above means at least one end is within the stack,
> f5509cc18daa7f Kees Cook    2016-06-07  48  	 * so if this check fails, the other end is outside the stack).
> f5509cc18daa7f Kees Cook    2016-06-07  49  	 */
> f5509cc18daa7f Kees Cook    2016-06-07  50  	if (obj < stack || stackend < obj + len)
> f5509cc18daa7f Kees Cook    2016-06-07  51  		return BAD_STACK;
> f5509cc18daa7f Kees Cook    2016-06-07  52  
> f5509cc18daa7f Kees Cook    2016-06-07  53  	/* Check if object is safely within a valid frame. */
> f5509cc18daa7f Kees Cook    2016-06-07  54  	ret = arch_within_stack_frames(stack, stackend, obj, len);
> f5509cc18daa7f Kees Cook    2016-06-07  55  	if (ret)
> f5509cc18daa7f Kees Cook    2016-06-07  56  		return ret;
> f5509cc18daa7f Kees Cook    2016-06-07  57  
> 2792d84e6da5e0 Kees Cook    2022-02-16  58  	/* Finally, check stack depth if possible. */
> 2792d84e6da5e0 Kees Cook    2022-02-16  59  #ifdef CONFIG_ARCH_HAS_CURRENT_STACK_POINTER
> 2792d84e6da5e0 Kees Cook    2022-02-16  60  	if (IS_ENABLED(CONFIG_STACK_GROWSUP)) {
> 2792d84e6da5e0 Kees Cook    2022-02-16 @61  		if ((void *)current_stack_pointer < obj + len)
> 2792d84e6da5e0 Kees Cook    2022-02-16  62  			return BAD_STACK;
> 2792d84e6da5e0 Kees Cook    2022-02-16  63  	} else {
> 2792d84e6da5e0 Kees Cook    2022-02-16  64  		if (obj < (void *)current_stack_pointer)
> 2792d84e6da5e0 Kees Cook    2022-02-16  65  			return BAD_STACK;
> 2792d84e6da5e0 Kees Cook    2022-02-16  66  	}
> 2792d84e6da5e0 Kees Cook    2022-02-16  67  #endif
> 2792d84e6da5e0 Kees Cook    2022-02-16  68  
> f5509cc18daa7f Kees Cook    2016-06-07  69  	return GOOD_STACK;
> f5509cc18daa7f Kees Cook    2016-06-07  70  }
> f5509cc18daa7f Kees Cook    2016-06-07  71  
> 
> :::::: The code at line 61 was first introduced by commit
> :::::: 2792d84e6da5e0fd7d3b22fd70bc69b7ee263609 usercopy: Check valid lifetime via stack depth
> 
> :::::: TO: Kees Cook <keescook@chromium.org>
> :::::: CC: Kees Cook <keescook@chromium.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

-- 
Kees Cook
