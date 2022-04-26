Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756B6510CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356271AbiD0AAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356288AbiD0AAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:00:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A0F4EA1E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:56:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y14so171508pfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Vd79Y282uj8GnLQRXQvOoxbMKGwuxqHo8kRf4cU958=;
        b=iQWMWN8mblU7AZgtWY+rZW8Z55g8FPr1ZFwzxsYu7RXa3DhTX2weqxgZjDVPTSDBSq
         hh7q8PIFIzX0UVjbAXwOTyOlQser4taBBwZ6NHC4L85PMu0aMFQbRvWJ2WNnKOwt0CcF
         ZaefjLWhDq6zS5jp3Ez2IPRw9RevbpBJSVE20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Vd79Y282uj8GnLQRXQvOoxbMKGwuxqHo8kRf4cU958=;
        b=TQNOn0y+aB+9WXRMesxjp2iUztFhJzDVHbCHuDl6mTMjn+OiYRQJLc5ANAc42z+hPU
         um59zEhG88YyV0aQzRG0qt443Z0bYOqUsWdBi3lizTVsGlBsfoFALgDUv9jyRPa53+xd
         j5YS3ZOM/sUFpLypflLl+CNw2moP56ttK3Okha1Dvkl40rVK/OjUF8WPhouWYiNoXfRf
         NnM8WPRMyM2UrE/lJevjmeYgw8Lz/he59rXfSegjM6gX2iwPAADvDbqaQQ9XGccX9l3k
         5YHhQsgqhUpnh914NT22gBK3u4L4JjezG3q4PReK8AZXO9YrhOJGrueNmg+3ACDm3a+g
         2Kkg==
X-Gm-Message-State: AOAM530ZlScn9jL/ggx6dnMNZz5XAyLrPv1C3vjF1Ez5cqpZMvar+Q5n
        r5wpylUt/BJy5lT0v84Xf81VsA==
X-Google-Smtp-Source: ABdhPJxjhL0jTEJii7KascE+L/yC5HoIjePRCqXQx4fkDulOzR2MYVclb7Jj+KHTS3rMjfqrOiox1Q==
X-Received: by 2002:a05:6a00:1152:b0:4be:ab79:fcfa with SMTP id b18-20020a056a00115200b004beab79fcfamr26844218pfm.3.1651017414417;
        Tue, 26 Apr 2022 16:56:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n1-20020a17090a670100b001d96bc27a57sm73410pjj.54.2022.04.26.16.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 16:56:53 -0700 (PDT)
Date:   Tue, 26 Apr 2022 16:56:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dan Li <ashimida@linux.alibaba.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [kees:for-next/lkdtm 6/6] drivers/misc/lkdtm/cfi.c:62:37:
 warning: cast from pointer to integer of different size
Message-ID: <202204261653.91255EEE0@keescook>
References: <202204170710.LwCV5Ec0-lkp@intel.com>
 <202204181515.FC6649DC81@keescook>
 <CAMuHMdVz-J-1ZQ08u0bsQihDkcRmEPrtX5B_oRJ+Ns5jrasnUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVz-J-1ZQ08u0bsQihDkcRmEPrtX5B_oRJ+Ns5jrasnUw@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:03:33PM +0200, Geert Uytterhoeven wrote:
> On Tue, Apr 19, 2022 at 9:20 PM Kees Cook <keescook@chromium.org> wrote:
> > On Sun, Apr 17, 2022 at 07:26:33AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/lkdtm
> > > head:   2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
> > > commit: 2e53b877dc1258d4ac3de98f496bb88ec3bf5e25 [6/6] lkdtm: Add CFI_BACKWARD to test ROP mitigations
> > > config: sparc-randconfig-r026-20220417 (https://download.01.org/0day-ci/archive/20220417/202204170710.LwCV5Ec0-lkp@intel.com/config)
> 
> Just received a failure for m68k-allmodconfig on next-20220426:
> 
> drivers/misc/lkdtm/cfi.c:62:37: error: cast from pointer to integer of
> different size [-Werror=pointer-to-int-cast]
> drivers/misc/lkdtm/cfi.c:62:10: error: cast to pointer from integer of
> different size [-Werror=int-to-pointer-cast]
> drivers/misc/lkdtm/cfi.c:62:37: error: cast from pointer to integer of
> different size [-Werror=pointer-to-int-cast]
> drivers/misc/lkdtm/cfi.c:62:10: error: cast to pointer from integer of
> different size [-Werror=int-to-pointer-cast]
> 
> > > compiler: sparc-linux-gcc (GCC) 11.2.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
> > >         git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
> > >         git fetch --no-tags kees for-next/lkdtm
> > >         git checkout 2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
> > >         # save the config file to linux build tree
> > >         mkdir build_dir
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/misc/lkdtm/
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > >    drivers/misc/lkdtm/cfi.c: In function 'set_return_addr_unchecked':
> > > >> drivers/misc/lkdtm/cfi.c:62:37: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> > >       62 |         ((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
> > >          |                                     ^
> > >    drivers/misc/lkdtm/cfi.c:72:13: note: in expansion of macro 'no_pac_addr'
> > >       72 |         if (no_pac_addr(*ret_addr) == expected)
> > >          |             ^~~~~~~~~~~
> >
> > Hmm. I don't see why this is warning. The macro looks like untagged_addr():
> >
> > #define untagged_addr(addr)     ({ \
> >         u64 __addr = (__force u64)(addr); \
> >         __addr &= __untagged_addr(__addr); \
> >         (__force __typeof__(addr))__addr; \
> > })
> 
> The offending macro is:
> 
> #define no_pac_addr(addr)      \
>           ((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
> 
> On 32-bit, addr is a 32-bit pointer, which is cast to a 64-bit integer first,
> then to a 32-bit pointer again.
> All of these need intermediate casts to uintptr_t.

As in this?

#define no_pac_addr(addr)      \
	((__force __typeof__(addr))((uintptr_t)(addr) | PAGE_OFFSET))



-- 
Kees Cook
