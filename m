Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AFF52229A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348189AbiEJRbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348125AbiEJRb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:31:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09951ADA7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:27:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id p18so20827062edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HiJXspw+XXqRAk8vbWsIcG6KKaomwpOqMcuau12q5j4=;
        b=l4OjCZhdF+uEbp7Nc5W8GzH4w1orFwvhDBIJnO+/nYkVEJkhGx11/s5f9/qz/B84+o
         lxowYN95PdzNUl8RQvisra6uT+XW3IZdhiN+iey4DZgCK7BU+USuwe72eEtbCdIihVkk
         AvwQWyV/bgFjypdruN3oD4Xi9q8Quwc+3ucw6xXxnXoHt93MdHSZlQWnm0f577YpU50J
         9GwBTnVC/kPmnSxOTaInURBfI9PRLKPQZrpt7eUQgBZNEXil3ZXaecz2VpIkSR6KrtWE
         j7szHqt8jianLsWTCWEQKRbfi0RDljYgkqIKVnq9JbBCrskrLJcAJz95KWQkIgpQ53fO
         9lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HiJXspw+XXqRAk8vbWsIcG6KKaomwpOqMcuau12q5j4=;
        b=otWm2PROLJEzE+XwGrlX51Mo01w9phuW905RCSfZYlgYG/bg3lLeFW64eu/lWOzq18
         iu3uM2KEUD99kVgmoEfK9WGx+skQWDOuDL/HkaQRhA4yHxtMy3goM6UERhAddqHi5SzX
         tNh78yZJ8/aDe8lHIAzLNwo4tnh+fIzJYPFYMzXyKFaCVlcJgCJPHbwZwXVe5vx9hUyF
         JoxwqOR3pjRxFSefqEmHrC3xXOkUkRkYbIC2bHY+WGacNXaw8Ro/z30YCpzSxOUuOPR+
         /9Yy93PnqSuLJkh8qwGQNjhoIQO/3QCBZVH7H/SmA7IXKLlBW6Csp+Qz/0xhRTsoRC4p
         aMbw==
X-Gm-Message-State: AOAM531EQyZP137RaYcwdEPSyVH4b/ttPLAtdBGNq9Hfl24vimQ7y9c7
        VeIg2t/ZzD6LqzYTKwfncg3dRva8sBz99HSObeVIMA==
X-Google-Smtp-Source: ABdhPJx2kSgAU2XY/27rj6V2tZzvTpxBTH9s2dEI4WHLt7Xvikp7+Mq8td5ekP+J6cRnKA+sx1pJ5K2Mc8vf9imokWg=
X-Received: by 2002:a05:6402:3590:b0:427:ba05:6f19 with SMTP id
 y16-20020a056402359000b00427ba056f19mr24886754edc.334.1652203643134; Tue, 10
 May 2022 10:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220509204909.2464496-1-dlatypov@google.com> <CABVgOSnwFe18Em327c3bx7z0A9VfujbjdKgofoSRafFOsOjfwQ@mail.gmail.com>
In-Reply-To: <CABVgOSnwFe18Em327c3bx7z0A9VfujbjdKgofoSRafFOsOjfwQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 10 May 2022 10:27:12 -0700
Message-ID: <CAGS_qxr+MOnWgz3B7+J12-Tj3VGERVRqrYg4uF0_FkBxa2hRdQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: misc cleanups
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
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

On Mon, May 9, 2022 at 11:22 PM David Gow <davidgow@google.com> wrote:
>
> On Tue, May 10, 2022 at 4:49 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > This primarily comes from running pylint over kunit tool code and
> > ignoring some warnings we don't care about.
> > If we ever got a fully clean setup, we could add this to run_checks.py,
> > but we're not there yet.
> >
> > Fix things like
> > * Drop unused imports
> > * check `is None`, not `== None` (see PEP 8)
> > * remove redundant parens around returns
> > * remove redundant `else` / convert `elif` to `if` where appropriate
>
> Personally, I find the explicit 'elif' much more readable in most of
> these cases, but if we're annoying a linter, I guess we should change
> them...

Same, some of them felt a tad more readable, but using `if` is a bit
more explicit about the actual control flow.
For short branches, like most of the ones here, they don't make too
much of a difference, but for longer blocks of code, this can help.

E.g. if one sees
  elif check2():
     do_thing2()
one might think they can tack on a
  do_cleanup()
and have it run for all branches, if they're not careful.

>
> > * rename make_arch_qemuconfig() param to base_kunitconfig (this is the
> >   name used in the subclass, and it's a better one)
> > * kunit_tool_test: check the exit code for SystemExit (could be 0)
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> All of these changes seem correct to me, even if I'm not sure I'd
> bother with most of them if they weren't causing pylint to show
> errors.
>
> Given that apparently it does, though, I'm okay with it going through.
> (I'll just grumble quietly in my corner. :-))

To be fair, we could ignore more of these warnings.
If we ever try to get the code clean wrt linter warnings, we'd already
need to tweak the settings.

But I think I've taken care of most of the reasonable warnings in this patch.
