Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5765B10A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIGXrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIGXri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:47:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0827EB0B06
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:47:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f24so16153943plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=QA7YsklnD2cfDCjZnRS3vgbzndyD3I08QYNTHl1zCqo=;
        b=ZLBdFbRl5paMgO0B2nkuSUB92aTwmtmqanZFesgw5UFus70dkXrDyjCNdhChN3pJI2
         t8e2tFazYgcQ2/I+HCWkNpNnhTL+sGFQ2IQmiy8gFk422S7/bBjOweZRLDXszByhh4xi
         VaMpTtbZBDMm4nqrs2mAgMKZ9VkS11Y3DZbhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QA7YsklnD2cfDCjZnRS3vgbzndyD3I08QYNTHl1zCqo=;
        b=sAtiEJWhRdTItDPmq/+Nl4hQcfcpYuo9E7zbgIdxGOvvgjQWD2b1fNxTyDw890ZCo4
         MM1XC/2GHdEZfbhVXD2eoKQt2KBK5PtvACTb9EZgJXsK9kdbxhihk6JaLLgYrTKaeClU
         A/6gHI1+7FZtXglU7FV5qSCoQ6Nx0gFSBhD0qyC4PHfpItoQ6GuuOyS/i9S2ogEF/Wzq
         5ZKY1nZ8Rq3GsuhE2B99AqK0iWZNKi+bVQ+XQtSqj9uTpkit61toG3hZN3YBsgSMePOg
         /Ka5emRADbBNPJVF0dal2JJefZPB37DqR1G08A5E6NDZ1GDAslvEIu4JqEdz8E83kWR3
         Ls7w==
X-Gm-Message-State: ACgBeo2rWlTRx+yPubsggEND4rMZL92EKPRtepXp4GlFEtiSmulugXtm
        cxZu3kEVtu9B7j9w+G7L0/GcCA==
X-Google-Smtp-Source: AA6agR6FxJPicYC0Cds/ZMsA1yhEHsGrUHcNbVNraLL0wYnkuXuYdtKZvewZkYvWfNoqDsOEyKfeIg==
X-Received: by 2002:a17:903:556:b0:176:84c9:df3 with SMTP id jo22-20020a170903055600b0017684c90df3mr6335255plb.98.1662594455557;
        Wed, 07 Sep 2022 16:47:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r28-20020aa79edc000000b0053e38ac0ff4sm4585765pfq.115.2022.09.07.16.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:47:34 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:47:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.0-rc4
Message-ID: <202209071646.A95761A@keescook>
References: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
 <20220905071915.2312316-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 09:46:01AM +0200, Geert Uytterhoeven wrote:
> On Mon, 5 Sep 2022, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.0-rc4[1] to v6.0-rc3[3], the summaries are:
> >  - build errors: +3/-16
> 
>   + /kisskb/src/arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33
> 
> sh4-gcc11/sh-allyesconfig (-Werror)

Sent a patch for this:
https://lore.kernel.org/linux-hardening/20220907234345.96798-1-keescook@chromium.org/

>   + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 258:25
> 
> s390x-gcc11/s390-allyesconfig (inlined from 'copy_process' at /kisskb/src/kernel/fork.c:2200:2)

This error appears to have vanished?

> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b90cb1053190353cc30f0fef0ef1f378ccc063c5/ (all 135 configs)

Status	Date/time	Target
OK	Sep 7, 13:54	linus/s390-allyesconfig/s390x-gcc11

-- 
Kees Cook
