Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C997578DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiGRWso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbiGRWsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:48:42 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA331376
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:48:41 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31c86fe1dddso123248037b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edZahbrQ/Oxqhwn8MhPjck0l3I5PeJIs16FI5e85ufw=;
        b=dNQwlBY9kDu8bojaiObuXmrW7zmzTtAlMLCkw80R/UgOHQ+l77VyyE7i9lHDgtEaI3
         SNr13LlwaKbRUNBKfmUGD2uYhkWztkB4m5zDcJaOPGRrjDpQagz6ff+NODi5U5uHxTLO
         tozFZxyRcxkgO/um/F8eMmUJZxTat1zMugfp8tq75DQjFoSG2LUyEQKNGYt2FVkUla1L
         wWQvGVVWIF7wTAN/Lp+jt/1kpDscYgdcmI2ETdnf3jIWHvxnfg/m21OsUxBRe150iFSl
         5Qh4EdG8fTE/SU/YPyQ6ViCOuv1sCUd01BHAi6Vme9UagqeOj5cwdGvLxeA0HYxolVIZ
         WVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edZahbrQ/Oxqhwn8MhPjck0l3I5PeJIs16FI5e85ufw=;
        b=cGW8CFIzThFCoKQdcwG6+r+HfgwWupOd/FshQAXizxItcBjxKOIz+SrWd7F1C+okGE
         Ai7g5NlkjBtS4H7B905QZk8H3sX/ZYReyyVjalXvUc55bQ63NmNIIr84CiNJhgqHNjtO
         PkZGnCYvGffFy/nHZ0za0myKzfjbW/B1a0iHfaTnon2bHNuulnL3XG+cpiHc4N3YSxSZ
         Jo7rY8VmFJc6s0dBu6M1MtE0EXtEHXijgVUPahCGvMOWtXaY4ocIuic6M5ammecD8+E8
         ihC5IBvKiYF/sKyc4vh9g2iTMCJyErNxkkg2kXHhH5r9DodJ6wc9HgpmFmkvH5mq9af+
         Zxsg==
X-Gm-Message-State: AJIora8Vd+gNYDbmRp7dDJ0ejFkhtNjUquAJJpXvopK0u3qkPbEQ0XLw
        z/2iTYM3Q5N+YMXzRztPM1bEDik1tHSEZ9QukpN0o0lrCPc=
X-Google-Smtp-Source: AGRyM1s74Z5E2Q1njOl4+AD4+vxACogqzvfB3qjspqjJHRyQVVB11gu7TWnm6W1oRniOtASVK//Gsko951vVkmhmda8=
X-Received: by 2002:a0d:fe82:0:b0:31e:3ff9:7e0 with SMTP id
 o124-20020a0dfe82000000b0031e3ff907e0mr4601529ywf.284.1658184521073; Mon, 18
 Jul 2022 15:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx> <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
In-Reply-To: <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 18 Jul 2022 15:48:04 -0700
Message-ID: <CABCJKufACEoUz=SVakAFVKhhwFb6biaPdiC_1cA=NRAUiak5hQ@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 2:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 18, 2022 at 10:44:14PM +0200, Thomas Gleixner wrote:
> > And we need input from the Clang folks because their CFI work also puts
> > stuff in front of the function entry, which nicely collides.
>
> Right, I need to go look at the latest kCFI patches, that sorta got
> side-tracked for working on all the retbleed muck :/
>
> Basically kCFI wants to preface every (indirect callable) function with:
>
> __cfi_\func:
>         int3
>         movl $0x12345678, %rax
>         int3
>         int3
> \func:

Yes, and in order to avoid scattering the code with call target
gadgets, the preamble should remain immediately before the function.

> Ofc, we can still put the whole:
>
>         sarq    $5, PER_CPU_VAR(__x86_call_depth);
>         jmp     \func_direct
>
> thing in front of that.

Sure, that would work.

> But it does somewhat destroy the version I had that only needs the
> 10 bytes padding for the sarq.

There's also the question of how function alignment should work in the
KCFI case. Currently, the __cfi_ preamble is 16-byte aligned, which
obviously means the function itself isn't.

Sami
