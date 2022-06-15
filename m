Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB4C54D047
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348579AbiFORpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbiFORpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:45:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AED50B20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:45:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o17so11021048pla.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fe8EEvsxcuFlTaSAhlke2tJTzd1QPZfoBRhxpqrEcBY=;
        b=HUFXMp9Fe2wBsWcrnYV4XNbttCOGDLQv9gxEx/Tl1gbm5NWLzvXHgpk2FIAKJDXWhd
         7gIIwQtqzi+rj1vNixhq42YWbZvJ5UiIuyS7sf8Tj85LeOR5iLOTdDDr/dh6l9QBC8l6
         P3MUE/ravd5SdWUtzHu1s9K2LU8pI7T4m5Cmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fe8EEvsxcuFlTaSAhlke2tJTzd1QPZfoBRhxpqrEcBY=;
        b=xgsmPavVbTEzxPHbZtKhE2tG8Z6xKQecm94fTLD+O+GUBgZeztlTNz90IBJ6c9QW+7
         R9oMVasbsrmzl6/kb4dd3ki1iwSGvDfjAEKwyeSgBpLQ4L/prfJ0d0BrtXzIlYcyQlKa
         zAWh9NtW6JqsTflj6mGeVbFZmthVrUazy7Nrw8jv0O22hRPJS1G8QwZ6BJ7FdlQjVhKf
         SLcGr420ugeORoqlh/89inb660yjW9rhxXEIJGJtjnLkDri6nmJy2py+XxSr++My0Thr
         3nVHPjbqOhZ8zyYo1YXnQf4YMjhtUsZm/cpA+Zgbq/FyoCZXoWtcxd7eD8AZO77LrVUf
         3DdQ==
X-Gm-Message-State: AJIora+tXCnbbpbvSSTprh9By5IJyMW1kGQQ21yO1Nv83xolVEl1WZQx
        40cJxbEF8eJVdUf+geQj5Grsag==
X-Google-Smtp-Source: AGRyM1uhLYsO6XiJfh2usxl7rJZLQZrZ2RxVgPyieYT3/FZ1ZlgdLeqQlHbgS4fl9ZLGquz8DIpYuQ==
X-Received: by 2002:a17:903:1210:b0:168:dc70:e9d8 with SMTP id l16-20020a170903121000b00168dc70e9d8mr697417plh.92.1655315130979;
        Wed, 15 Jun 2022 10:45:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d92-20020a17090a6f6500b001dfffd861cbsm2099412pjk.21.2022.06.15.10.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:45:30 -0700 (PDT)
Date:   Wed, 15 Jun 2022 10:45:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Vitor Massaru Iha <vitor@massaru.org>,
        David Gow <davidgow@google.com>
Subject: Re: lib/overflow_kunit.c:644:1: warning: the frame size of 2832
 bytes is larger than 1024 bytes
Message-ID: <202206151045.36F7623B@keescook>
References: <202206120046.YKeKzlVN-lkp@intel.com>
 <CAGS_qxquSGoHD2NeRiS-basVg-nOP8s4kSGi90e2QuMc-Pt0Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxquSGoHD2NeRiS-basVg-nOP8s4kSGi90e2QuMc-Pt0Pg@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:55:02AM -0700, Daniel Latypov wrote:
> On Sat, Jun 11, 2022 at 9:44 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Kees,
> >
> > First bad commit (maybe != root cause):
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   0885eacdc81f920c3e0554d5615e69a66504a28d
> > commit: 617f55e20743fc50c989b498f9dee289eb644cfd lib: overflow: Convert to Kunit
> > date:   3 months ago
> > config: powerpc-buildonly-randconfig-r006-20220611 (https://download.01.org/0day-ci/archive/20220612/202206120046.YKeKzlVN-lkp@intel.com/config)
> > compiler: powerpc-linux-gcc (GCC) 11.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=617f55e20743fc50c989b498f9dee289eb644cfd
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 617f55e20743fc50c989b498f9dee289eb644cfd
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    lib/overflow_kunit.c:191:19: warning: 's64_tests' defined but not used [-Wunused-const-variable=]
> >      191 | DEFINE_TEST_ARRAY(s64) = {
> >          |                   ^~~
> >    lib/overflow_kunit.c:24:11: note: in definition of macro 'DEFINE_TEST_ARRAY'
> >       24 |         } t ## _tests[]
> >          |           ^
> >    lib/overflow_kunit.c:94:19: warning: 'u64_tests' defined but not used [-Wunused-const-variable=]
> >       94 | DEFINE_TEST_ARRAY(u64) = {
> >          |                   ^~~
> >    lib/overflow_kunit.c:24:11: note: in definition of macro 'DEFINE_TEST_ARRAY'
> >       24 |         } t ## _tests[]
> >          |           ^
> >    lib/overflow_kunit.c: In function 'overflow_size_helpers_test':
> > >> lib/overflow_kunit.c:644:1: warning: the frame size of 2832 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> >      644 | }
> >          | ^
> >    lib/overflow_kunit.c: In function 'overflow_shift_test':
> >    lib/overflow_kunit.c:451:1: warning: the frame size of 7232 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> >      451 | }
> >          | ^
> 
> I have an RFC series out to reduce the stack usage of KUNIT_EXPECT_*
> even further, but they won't help enough here.
> https://lore.kernel.org/linux-kselftest/20220525154442.1438081-1-dlatypov@google.com/
> 
> So If we want to try and "fix" this, I think the only answer would be
> to split up the test funcs as appropriate.
> But I don't really know if that's warranted to fix this warning here,
> which largely indicates a compiler quality problem over a code quality
> one.

I'm happy to review patches, but it does seem more like a compiler
issue. Hmmm.

-- 
Kees Cook
