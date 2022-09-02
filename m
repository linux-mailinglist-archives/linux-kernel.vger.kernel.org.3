Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361AD5AB5AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiIBPuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbiIBPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:49:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B375247D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:40:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z8so3209086edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZZViECBQIPeE26/U6PwpBaWGPbv4WEHDCGVI4qLmJb4=;
        b=Hng+Qdrwf6aoRL5qjOrDdX9dneBrnXK9dEZGpGEBFIBlyH39qCfY8ZchTBiQ96Q0QZ
         mo1ow8E2D91zJz9YHExUeoBbqrfgZfUkW/zpThocnMs6/uZURRu3lnitylvOlee0a2YS
         lKyPusHcdynwJfmX3iErtGSVR6WZ0pz0wERuQ+gOVoitU+TXKIMwyvIXxJ6kk3/xB1YN
         jVYY2LL5WiN4duAlJTouZHUSOGLWZAnS3r024F5fHcDu6W/sH2j8IaYiIBvia+Jl5ABU
         AzAcOSRqtsQoQZ3ygVlgucKeGyZsGK/jQqOSKFjZ+4s4BXtjIAoDokHMGxn5B73siZhJ
         rs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZZViECBQIPeE26/U6PwpBaWGPbv4WEHDCGVI4qLmJb4=;
        b=LUXm7FU0P/FdI/VsPF3txJLcKWNh0gofhTRTg4Fv9iMqDdAsOEitQ+/nJEignSJCw+
         J8oMNB/KLxYmRepskW49JS+kXMzqH3GaVcD9nAPS87Y8TVVfYDxQRVupXx92TbE/BlNv
         Ttqf6TUnZL1cw8hroXcRGNxQ/AULz0PoJVxrFaKUgQk7ZWh6IeMXMbcQN/PC/QE09oJg
         0f+1B04Mu46i2XFpEbzDX3kfj6s8YJa8PRbeXDeUse5bFDn8J3Cx2ItPjmDy8VU5zx2v
         sIYddoJhuNbQUz5/3XrPw43+qw/Qe0pvhxOGcsHav3ez38B5VqWsgjUGa0X6XHDHLPvV
         Q2tQ==
X-Gm-Message-State: ACgBeo2WZLD07LO16T+fMyS8GAABVO/Zrh7pVzE5YA5Ikilp+ZiXawjk
        +x2SvkKbFKntF3trozEVDscz/YdTW/vWsoDLlUJv4A==
X-Google-Smtp-Source: AA6agR4xxlZQqkE3iOmxpnuJDnHFAJqpyc3JD/HdUdWEisfmE3Z6rtHXdERjcLrMLI5v9gj6USv11x2Cp3VoRzACFOg=
X-Received: by 2002:a05:6402:3227:b0:448:706c:185d with SMTP id
 g39-20020a056402322700b00448706c185dmr20812932eda.357.1662133205628; Fri, 02
 Sep 2022 08:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
 <YxEh+pLyOyPalW1u@dev-arch.thelio-3990X> <CABCJKucP5nXGiCTTCEPUGYo5Z9A9qaQkJ6_kXTOfw-o-=TYH0g@mail.gmail.com>
 <YxG2DUEBnIpAMKF2@hirez.programming.kicks-ass.net>
In-Reply-To: <YxG2DUEBnIpAMKF2@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 2 Sep 2022 08:39:29 -0700
Message-ID: <CABCJKudRywi7FgNOb8V7vmS39k59fbO1D3dwfmMZmBpApRX5eQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] KCFI support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 12:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 01, 2022 at 05:33:29PM -0700, Sami Tolvanen wrote:
>
> > > I do see a few new objtool warnings as well:
> > >
> > > vmlinux.o: warning: objtool: apply_relocate_add+0x34: relocation to !ENDBR: memcpy+0x0
> > > vmlinux.o: warning: objtool: ___ksymtab+__memcpy+0x0: data relocation to !ENDBR: memcpy+0x0
> > > vmlinux.o: warning: objtool: ___ksymtab+memcpy+0x0: data relocation to !ENDBR: memcpy+0x0
> >
> > That's interesting. I can only reproduce this warning with
> > allmodconfig+LTO, even though the relocation exists in all builds (the
> > code makes an indirect call to memcpy) and memcpy (aliased to
> > __memcpy) doesn't start with endbr. I'll have to take a closer look at
> > why this warning only appears with LTO.
>
> From just looking at the patches I'd say patch #19 breaks it. IIRC you
> forgot to make the SYM_TYPED_FUNC things emit ENDBR.
>
> Look at how x86/asm/linkage.h is overriding SYM_FUNC_START*().

Yes, that's the reason, I'll fix this next week. I was mostly
wondering why I'm not getting this warning with my other test configs,
but it looks like IBT isn't enabled by default.

Sami
