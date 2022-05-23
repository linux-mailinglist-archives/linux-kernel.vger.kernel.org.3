Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887BB531BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiEWTir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiEWTij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:38:39 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1C5C8BE8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:28:24 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 31so14491781pgp.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YA8sptKhHzC1OmZEYlMNFFsyNd7K9O0xQukLFhlnV6Y=;
        b=eedz7RLy7CCXsehGjefKyjZWI4RiK+KTyO+PJN39xtbAEFRPJL8X3OwEx4WnYdGP58
         Vm6PrGLmInA1BeAlaQbYo+HTb9mh2O9D5MimuwA53iLWa3no1Avip9OFxSOKdmMvgmUq
         a9FIrW7JjY5LcbQ1ta6xFpvbpz9SgzFHgf1XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YA8sptKhHzC1OmZEYlMNFFsyNd7K9O0xQukLFhlnV6Y=;
        b=c2jlRQ/M4vhsjb9C8XYkYpUxdpY7fyntBVnpw3D9otdoRa2dmOi95wy/1v1yKgRDsy
         SoY59xh4pr6Yr+ULx6QjQ6JyYujN5G73dW0vzx2aI2N7HVkoVp0enNCgoTUgkP99uts1
         ZccJ7wwdIsYAmgEwDlWjDP6vciC7PLb/CUsPpqGxZZ5Dm6ZgDvne0AX/ghA64pHkY5Vi
         9xXynWJpWjZPPrvov8D6P8qUcrVDv3i4cYjsKW9a2nGZQ2MGCwzJ5TyRI4Rlbm54/3d3
         xttdjYKel0urQhj61QQEd0sgmNpHbH1qcOvdE+hlhZ9agEy/LUss/M1bL76mgvhOLsz5
         TovA==
X-Gm-Message-State: AOAM531iUpJfWXcIclmgvRMlKfHPiBjzvy26lCK8f9CvSkwLl5Ke5ws/
        8z2zHF+GcO4fpIGhl9C5FEPKSw==
X-Google-Smtp-Source: ABdhPJyswLGcv+DF3A8puOspS84e0wHsV5qNpC7rTD8p32hWvdW2lVaWi74Bqi0M4hjlU5e9gkTM7A==
X-Received: by 2002:a63:2b06:0:b0:3f5:f2f7:9575 with SMTP id r6-20020a632b06000000b003f5f2f79575mr21200949pgr.519.1653334103920;
        Mon, 23 May 2022 12:28:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e18-20020a056a0000d200b0050dc76281ecsm7608423pfj.198.2022.05.23.12.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 12:28:23 -0700 (PDT)
Date:   Mon, 23 May 2022 12:28:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexander Popov <alex.popov@linux.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Change all version strings match kernel
Message-ID: <202205231225.1CBACF63@keescook>
References: <20220510235412.3627034-1-keescook@chromium.org>
 <20220523143054.GA3164771@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523143054.GA3164771@roeck-us.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 07:30:54AM -0700, Guenter Roeck wrote:
> On Tue, May 10, 2022 at 04:54:12PM -0700, Kees Cook wrote:
> > It's not meaningful for the GCC plugins to track their versions separately
> > from the rest of the kernel. Switch all versions to the kernel version.
> > 
> > Fix mismatched indenting while we're at it.
> > 
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> I see random build failures with this patch in linux-next.
> 
> Error log:
> cc1plus: fatal error: ./include/generated/utsrelease.h: No such file or directory
> 
> The problem doesn't happen all the time. Is there some missing dependency ?

I've seen 0-day reports on this too and but I haven't been able to reproduce
it. AFAICT, utsrelease.h should be generated before the gcc plugins are
built, but clearly something is wrong.

> >  plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
> >  		  -include $(srctree)/include/linux/compiler-version.h \
> > +		  -include $(objtree)/include/generated/utsrelease.h \

I wonder if include/generated/utsrelease.h needs to be explicitly added
as a build dep to the plugin logic?

-- 
Kees Cook
