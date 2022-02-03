Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3039B4A7E34
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349141AbiBCDDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiBCDDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:03:40 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943DDC06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 19:03:40 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so8698742pjt.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 19:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=66kPZSC1iKeNoZfaiCMo3QKLREtWuEiSUFYFnGS139g=;
        b=ihbvWhnXjUqGyksHoCxaLOWMHnN3wfgtv7dKrlgWKZbFddRi9Z0b+C34pmZ2s20nFb
         AMNKO1bchTQlG6UoyPAjS99YoIUqdkTarHfGBTFVr9OHmTaOuGBJRT3z3I0WxpFid73E
         Se8912JdZFr8WL2FD6IF6zxaTYCxr6nwSCawc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=66kPZSC1iKeNoZfaiCMo3QKLREtWuEiSUFYFnGS139g=;
        b=wKQoXQI+6k7sNByAQHeCiTCg3phPzmmJe5EXgv6g+3fn9TnM9Oj1MNGC8aKmyzxpkB
         C1PhDnNxqFNkWl3+QVGlo20Iu/M3Ik5G5rmeb/A/mZcj6+68T772zerG06/vYrmZqliH
         L1v3XZxd97CcRPhRREv6IRek8nntniJK2f19mefhfalXqH1TnxjXl+1DFvd9qWETzHgq
         V6qpmmIZ99n3+2Lmhr7dYJnsbeX1wjIOmJhXGskofReMTOig3FTLK7YusGwDdYgqLWh4
         I4aCT2/Ct4uSgUH0Cag4lABsbNmmSADC0rv3RdDvN3SrhPCj+loovtmoyv/YW/W7zqkV
         39vg==
X-Gm-Message-State: AOAM530AmYHTCLMLlQ8bB3lZx9kr0GKI+QpfGRuDzP657itEFqpqkInS
        qBLkAVVDV8A0usr13t+qWs6bDA==
X-Google-Smtp-Source: ABdhPJzWMLlRj3r57r7HmniPlCwu193I5JgQn3G2v/Fu4GCrKAcrUdJ+aJD+pcbrzfANakGXZzdo8A==
X-Received: by 2002:a17:90b:4f4c:: with SMTP id pj12mr4989551pjb.9.1643857420161;
        Wed, 02 Feb 2022 19:03:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lb3sm8336560pjb.47.2022.02.02.19.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 19:03:39 -0800 (PST)
Date:   Wed, 2 Feb 2022 19:03:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/5] Makefile: Enable -Warray-bounds
Message-ID: <202202021902.97BAE673@keescook>
References: <20210818081118.1667663-1-keescook@chromium.org>
 <20210818081118.1667663-5-keescook@chromium.org>
 <20220202160903.GA2337834@roeck-us.net>
 <202202021254.5A1FD4FFBF@keescook>
 <cbf0cf07-2350-ed23-f6be-b2686c6a0cea@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf0cf07-2350-ed23-f6be-b2686c6a0cea@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 03:33:11PM -0800, Guenter Roeck wrote:
> On 2/2/22 12:56, Kees Cook wrote:
> > On Wed, Feb 02, 2022 at 08:09:03AM -0800, Guenter Roeck wrote:
> > > xtensa:allmodconfig:
> > > --------------
> > > Error log:
> > > In file included from include/linux/uaccess.h:11,
> > >                   from include/linux/sched/task.h:11,
> > >                   from arch/xtensa/kernel/process.c:21:
> > > arch/xtensa/kernel/process.c: In function 'copy_thread':
> > > arch/xtensa/kernel/process.c:262:52: error: array subscript 53 is above array bounds of 'long unsigned int[16]'
> > 
> > I assume this is a weird cast. I will also check this one out.
> > 
> 
>                                 int callinc = (regs->areg[0] >> 30) & 3;
>                                 int caller_ars = XCHAL_NUM_AREGS - callinc * 4;
>                                 put_user(regs->areg[caller_ars+1],
>                                          ^^^^^^^^^^^^^^^^^^^^^^^^
>                                          (unsigned __user*)(usp - 12));
> 
> I think the problem is that XCHAL_NUM_AREGS can be up to 64,
> but the size of struct pt_regs->areg[] is fixed to 16.

Yeah, that's what I found too. The comment about pt_regs::areg seems to
hint that things treat pt_regs differently. I've asked on the xtensa list:
https://lore.kernel.org/linux-hardening/202202021501.DA6594BFC@keescook/

-- 
Kees Cook
