Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CF2531B46
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiEWT4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiEWT4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:56:15 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E07F03;
        Mon, 23 May 2022 12:56:13 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e5e433d66dso19784064fac.5;
        Mon, 23 May 2022 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zRBh8AwpK6xpIyvhzfT5sGoLhPyLy+zwey6L/6TZMgw=;
        b=YYTdGEOAZtyo8VOgCx3GKDLWSlrBV3lXoOKoNgN7l6R1FnNJvlN4cO9cILgzJAQHco
         699PBoOY9W9TNAa+56m+jiWk5rcujC51z14wRSDhOCT8q/Hl00ZOwQ/JhujVNz65xdF0
         jLlfeTxRcspBfcH0Dg9hSunZs4Brqz6fXObavs0rJ/iFVG4X2BOM6T37r9imxlBFQuwf
         COu+6AYqW8suVQpOdWEcPVFYue9zNcx9IFNvhzMTvaSVD6PhO5dM5FXe/R8E6vlp/SSU
         w85kjiuZOxzDOgvJ9MAkwGGbQgP9+9+6zgrTfoId8aETQYjD553xEdGgm7ixUZZQlO21
         MXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zRBh8AwpK6xpIyvhzfT5sGoLhPyLy+zwey6L/6TZMgw=;
        b=KFr+s1DVu9iwigdhhRJ31tHNWSqy+hd5M8kZepVsBCoinX2Y8i0GJNJ9HVyXJt1zE4
         yjGrbN4M/FF4ZADcy02ezX5xxnWCKww3/3z2LoyVoWMvgOjd3CXI3y2M/vNbsFQeZDRs
         k2w87Y49iNVUFwo64SsdU7lQfxMzS+zk1FBZXm8R5A7p4RDcUIbc3AxC85S95FZQguPz
         Y2PUOT9tuPhvb9OLCQgrikQxTjWo0T4UY4C5mEImXJG3GFc26oRIepWs0zXMWXac1RPN
         7qt/L3TtBvJnRVrvwmBb34nsCUySNUJS4A+tMS1NAN4VKaxTuzALqQ6t+/zGCnVOO0Y8
         9X1g==
X-Gm-Message-State: AOAM530slKv6xgKNL/oq0f3EaWDJVnPUYkpxTOpnNMgAduqNCE7RmJ/s
        TmE9WB+ZPBPmx7tQlyZMQje2xqcR5AdrLQ==
X-Google-Smtp-Source: ABdhPJzfb9D5wC4ehZi9Kc2SXqgcYXTPny76OyqZVvtUPuHVARkIv4Kdh0QeukMe35nZAEZixtcj3w==
X-Received: by 2002:a05:6870:461b:b0:e9:a015:36a6 with SMTP id z27-20020a056870461b00b000e9a01536a6mr379156oao.185.1653335772799;
        Mon, 23 May 2022 12:56:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w19-20020a056870431300b000f26a4e2cdfsm1472797oah.18.2022.05.23.12.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 12:56:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 23 May 2022 12:56:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Change all version strings match kernel
Message-ID: <20220523195610.GA3719222@roeck-us.net>
References: <20220510235412.3627034-1-keescook@chromium.org>
 <20220523143054.GA3164771@roeck-us.net>
 <202205231225.1CBACF63@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205231225.1CBACF63@keescook>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 12:28:20PM -0700, Kees Cook wrote:
> On Mon, May 23, 2022 at 07:30:54AM -0700, Guenter Roeck wrote:
> > On Tue, May 10, 2022 at 04:54:12PM -0700, Kees Cook wrote:
> > > It's not meaningful for the GCC plugins to track their versions separately
> > > from the rest of the kernel. Switch all versions to the kernel version.
> > > 
> > > Fix mismatched indenting while we're at it.
> > > 
> > > Cc: linux-hardening@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > I see random build failures with this patch in linux-next.
> > 
> > Error log:
> > cc1plus: fatal error: ./include/generated/utsrelease.h: No such file or directory
> > 
> > The problem doesn't happen all the time. Is there some missing dependency ?
> 
> I've seen 0-day reports on this too and but I haven't been able to reproduce
> it. AFAICT, utsrelease.h should be generated before the gcc plugins are
> built, but clearly something is wrong.
> 
I have seen it only in my test builds, only on arm targets so far,
and I have been unable to reproduce it manually.

> > >  plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
> > >  		  -include $(srctree)/include/linux/compiler-version.h \
> > > +		  -include $(objtree)/include/generated/utsrelease.h \
> 
> I wonder if include/generated/utsrelease.h needs to be explicitly added
> as a build dep to the plugin logic?
> 
Looks like it, but I have no idea how to set that up or test/confirm it.

Guenter
