Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2D759CBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiHVWm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbiHVWmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:42:54 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CF95141B;
        Mon, 22 Aug 2022 15:42:53 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-33365a01f29so334613457b3.2;
        Mon, 22 Aug 2022 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HSdoxsJ0k6gi0gsdGDs4RmvY3VdrRt/X1WP13pkBsqU=;
        b=C3O0dWqKjUV3GXIxPrazUCrC1qZ8vJXzfPUCnaeFt/paXuYseHJFcPGlmSxCM14FGF
         WJbmQlxGHA2MgIuv+R+K5DzQkVq8q6aSUY/f6hG8Xr9LTg/y31VSixfUpY72oo5SjjOE
         egfTtL0WveMBMQE1lZgccfd5I4v6eFLVO9C/BIosaS50mLcQuMN7ImL6MMihx7HYao7o
         TiQS65HRw+zHe7q0hZ5iVJIZhZMikl588HNHGk/AM7peHpw8OiF6HBUCCWBaxvBufxgs
         5kE7xT5n8cdsBza4ZP1G1jXZj4o+sq9t+ozeeWlSqN3PovjjkP7tZb3ptMxUa5A0O5r6
         HygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HSdoxsJ0k6gi0gsdGDs4RmvY3VdrRt/X1WP13pkBsqU=;
        b=MurVcqXqDcgMGJ8Psbme+rkLG9NcEJhKnHE6AlMSsyWvK35bwqX5+La3d2wGGUKtB0
         Sx+pY10DGTRWiGCgDsrdEQq+b6ZLCp/QsprMi+Q/49Id46kXnCV534t88tfmw51XLWui
         Q/91DGeyrNzHj2Okg9sTp3aQMR9hWBeuUrTp2sGW++4wlD1D9iYSqQPdaiimtZLzgHpy
         lkX9qnGPELVGFb8IYUW137wcNSzL9X9uv0lPaHHvythap8HWFe3XqBpiu7OUYRDTaRbX
         AQoUVC8f2OhxoDLNY980gkN7Kh17PlQ55VSTFyJ/6NHDnhccXDkO+vCT48TyWStl02rb
         iVmA==
X-Gm-Message-State: ACgBeo1aiYfCbNuGh0xREM9sZSerrQTKc8t+vp5sBW3PlQGvES9ogfu1
        wS96g6FyjfrBUpkg0jUbftHlvzRRkVuJ4bmpNzU=
X-Google-Smtp-Source: AA6agR5j2z1EgEY6ADYmvGvAzZLL2kTZhI6Ws+fREQaJa7ShHYh+KSQlTaAXsJcSSTgeLsWdxumZ0lziQUjPKdz+S7s=
X-Received: by 2002:a25:8a85:0:b0:671:715e:a1b0 with SMTP id
 h5-20020a258a85000000b00671715ea1b0mr21425930ybl.98.1661208172405; Mon, 22
 Aug 2022 15:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
 <20220815013317.26121-1-dmitrii.bundin.a@gmail.com> <CAKwvOdnnSAozX8bQ9HeSw12BV9OjpzyDmXk_BGczjVVQNN+7tQ@mail.gmail.com>
 <CANXV_Xw2wzwDdJkyV1nHPQm2JTt48SLrNc7YwrfcxOwuFA-z3w@mail.gmail.com>
 <CAKwvOdkiq_byi1QeCvSGb2fd+0AJ1k9WNnsHJMeaaQcPRy1Wxg@mail.gmail.com> <CAKwvOdkPwbD-c0V-up2Ufzb-Uh7LLyD12X0FKeBa=hn+cSPA9Q@mail.gmail.com>
In-Reply-To: <CAKwvOdkPwbD-c0V-up2Ufzb-Uh7LLyD12X0FKeBa=hn+cSPA9Q@mail.gmail.com>
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date:   Tue, 23 Aug 2022 01:42:41 +0300
Message-ID: <CANXV_XzdTTYc2w7Ur8zY=ijOofg91yfF7RLhedbVH0rmi3c2yA@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: add debug level and macro defs options
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
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

On Tue, Aug 23, 2022 at 12:36 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> or perhaps that simply needs to be `-g -gsplit-dwarf`?  In which case,
> that if/else could just be re-arranged.

How about simply assigning DEBUG_CFLAGS   := -g at the very beginning
without any conditions? This would provide the default with the
possibility of overriding later and -gsplit-dwarf does not necessarily
come with -g implicitly.

> Honestly, I really don't think we need to be wrapping every compiler
> command line flag under the sun in a kconfig option.

This indeed sounds reasonable to me. So the key point here is to not
bloat the kconfig with options related to every compiler flag. But I
think it still might be useful to provide some option that would
include sort of full debug information compilers may produce. With
this approach there would be, in fact 3 different levels of debug
information supported by Kconfig: reduced, default and full. The full
level would increase everything like -g3, and -fdebug-macro for Clang,
and probably others.

> Or add -g1 to CONFIG_DEBUG_INFO_REDUCED.

I ran some tests and there was indeed some decrease in size. That
combination probably might be useful.

Any thoughts?

Regards
Dmitrii
