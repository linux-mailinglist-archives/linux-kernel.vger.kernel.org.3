Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1335F4C01D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiBVTNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiBVTNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:13:15 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7352534666
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:12:49 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2d07ae0b1c0so186006947b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIuf7B6ggNpBhnBC4BV4Wx/yI126tWB3veseg963gIw=;
        b=oO4DLFIdF57cng91nz+ABsKhV3TEZMT4YH2lr4gu+QyKiHY/p9DVOaozbT73qgUo+w
         xQ27MwmBRWjReen46DDOboOnddmO9/G+2my87QZxKBkXv4l+/ZIkzCE+YibDvGS82tr0
         HZoBeNSLHqIdxa1Bqoclcc2rWWVKuuZ97ifQkHXI6/n3++k7W9wF8snW9tx1VykggiAd
         hu4BJF221YTv/PUYb8MOBSrE1s9NmmfgNSMv7MEWWG2IgolZVZtOzOZbfb9F9dGBcui2
         No4HnBw2U9LDz6tICVmKGe/4TXVP/KGT/hXXO865Xl+3ZFSgHikjXcCE37PmLXsefax7
         bpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIuf7B6ggNpBhnBC4BV4Wx/yI126tWB3veseg963gIw=;
        b=yT58B5IGi8DdWECRhP4osLE5moFlxWV6dJRT1yyv5ERuMnGxo2mYc3hqtFjL0fCdNH
         DGHa4yoj0Af5CIrDvSuGSJweSmEID44MMYgOHoHLfzl/CqNQgttzVrkUWJuy4R8MwLPj
         W3V24O+Pk0KT14GpRWNz5roq+ayJ/e4HNCNdDuBLFEoFODiMYMGU6+DzBROX/WIaD1zb
         UglRFAZpLgKY6HnGlYywhOsrggI2kw4PZDN5ANFuckRZjTQ2Lx4zmsPdoKblArqdRnSO
         N8t3Zp4S76KVhNE3fUellm9OxenImj76JvcVAA3Zg6HJCwDr0hbXvYBU1D+on8hNXUFZ
         6ZAQ==
X-Gm-Message-State: AOAM532LY57BhE9fFUY5870Q3kLhsMGtn3IlO/BC5wZgT3pRK0ifF3NL
        wIAiDYv6c5XXFXM9LhodMrEHjA2A0td9IKOXSUE=
X-Google-Smtp-Source: ABdhPJwogRs4v3RoIbi9LLn5frjoRnppXVlb2XUr+i5bRqLbpZZJ4wuR98W0v903ktfUAXqLtpj99zYOXAJ1elSwzCI=
X-Received: by 2002:a81:184f:0:b0:2d0:e2b1:1995 with SMTP id
 76-20020a81184f000000b002d0e2b11995mr24474079ywy.364.1645557168674; Tue, 22
 Feb 2022 11:12:48 -0800 (PST)
MIME-Version: 1.0
References: <20220217153842.3252424-1-trix@redhat.com> <51018469-3bab-e56d-7407-b16170b5d74c@amd.com>
 <CADnq5_OGEURo76mzc4Sb2Jar465Xt4vkSMECDi5jCMH332zUAg@mail.gmail.com>
 <CAKwvOdnYTC7mku1=eVaDLGQFHdoN3u8Afoo582OAQ+ApJmfhQQ@mail.gmail.com> <CADnq5_PniW+-8G5AhOSwuovESpfeMxL4r6P30b3F1coa_NmMEQ@mail.gmail.com>
In-Reply-To: <CADnq5_PniW+-8G5AhOSwuovESpfeMxL4r6P30b3F1coa_NmMEQ@mail.gmail.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Tue, 22 Feb 2022 14:12:37 -0500
Message-ID: <CAOWid-cXYze56YmUACWP4emNeGHXMFf4q5aZfFGUwVXWNFAvSg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_ras_block_late_init error handler
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "Joshi, Mukul" <mukul.joshi@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        llvm@lists.linux.dev, Dave Airlie <airlied@linux.ie>,
        Tom Rix <trix@redhat.com>, xinhui pan <Xinhui.Pan@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Chai, Thomas" <YiPeng.Chai@amd.com>,
        John Clements <john.clements@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 2:06 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Feb 17, 2022 at 2:04 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> >
> > Alex,
> > Has AMD been able to set up clang builds, yet?
>
> No.  I think some individual teams do, but it's never been integrated
> into our larger CI systems as of yet as far as I know.

I have just added clang build to our CI last night so hopefully we
should be catching these now.

Kenny

>
> Alex
>
>
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
