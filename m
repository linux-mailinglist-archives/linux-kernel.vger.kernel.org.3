Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC90598C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbiHRS5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiHRS5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:57:15 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66282C00C1;
        Thu, 18 Aug 2022 11:57:14 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-335624d1e26so66154557b3.4;
        Thu, 18 Aug 2022 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jK0n39xQ810MROGPsbeMRM5qQPZlNI1veyppbstNpHA=;
        b=X0UqfG9ae4aeJjWWYWcm7t7ngzCRgqJ0PGL4FEzY2q8pDCUF+w8GwGA8o7zJZhoQB+
         lW94C2Edsin8khebe+w6bWBFfq5zOy+rqDYLWUerDVWbJr/uiLFsW/mWTE7sQpBsKNWD
         drKyYXQhShk9sO3noKDEPSsfL4OkUPQn1GHfkJVvLTjd6/JGi/VXx4OS7Ub8GxRHQhmn
         w4DEptzeV2AqeYjI/b1lv67U6NavhMMjHEWF+mDBuCWTnIz0YZYUhkvBw/n0UdS+h95R
         F4IqIJXofGSY2TrOLdzIgR0VaCe8fvHtqLpHMi1sbj5XzdlQrAD2tdjV/pva7Y9uQ0s6
         Iw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jK0n39xQ810MROGPsbeMRM5qQPZlNI1veyppbstNpHA=;
        b=CUjY8Bw5fmDK1XwtJmXYTecIiy5qhGLsH1YWC2qpeEUCXO8zKRtJdiP3Z6wO17t0o8
         4euV6i9I3i8EH8F//iMx8Ttw4lbmqOOrcXHLbC5nnWu/VfK/N5VaTgIaBoF+tj6Pg1rr
         JoHzC9em5d4UkPRxqgJXdQf7sH3dQWvHd7HxDSkggs45yj0oow6ck8BdvHJGlj9Zy5R4
         bwCWUQHDHlRsT8Ax+fIAtLXzZGhPrmMwXVRo6a/er3FYehwjisddnxS2nqP6bxreIyqH
         GZ5LkDKqheZh6bAhpsinqO2SodViD0JKZko9/j4wfJfFBbtLH+4VxEWSga1I3CXFEdsC
         fJnQ==
X-Gm-Message-State: ACgBeo0dblMfSNb4ibpPFOKjROXbiqCOh2C9tr6DzkCR9joSyYm8nhvR
        8N7hTc/wHdKeX3JpY/Xi2kYBviXE1s0cGJg9uDo=
X-Google-Smtp-Source: AA6agR7II+Y32947N8bMB/RkKLPAm/USuhInjF24TROpCOOsXqL/2Y6U2RnLr4HNyQQGUbQULXgzQCV6+S6+4bh/8Kc=
X-Received: by 2002:a25:22c5:0:b0:694:dfa2:9d0 with SMTP id
 i188-20020a2522c5000000b00694dfa209d0mr420217ybi.107.1660849033550; Thu, 18
 Aug 2022 11:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
 <20220815013317.26121-1-dmitrii.bundin.a@gmail.com> <CAK7LNAQzVto=rEpASc-JOF_TW0KhNT93jD0E2gfk8UES3PWFiw@mail.gmail.com>
In-Reply-To: <CAK7LNAQzVto=rEpASc-JOF_TW0KhNT93jD0E2gfk8UES3PWFiw@mail.gmail.com>
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date:   Thu, 18 Aug 2022 21:57:02 +0300
Message-ID: <CANXV_XzGHQ8_X2t37DwRjS7kKFX0kWDpwHEg3k+zZ4YfV98gjw@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: add debug level and macro defs options
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?B?Ru+/ve+/ve+/vW5nLXJ177+977+977+9IFPvv73vv73vv71uZw==?= 
        <maskray@google.com>, Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Thu, Aug 18, 2022 at 7:14 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> -g1 is only possible via DEBUG_INFO_LEVEL, but
> presumably it is not your main interest
> (and not sure if there is anybody interested)
> because the main motivation for your v1
> is to generate macro debug data.

I tested the build process with -g1 and it turned out to generate an
image that is 20% lesser in size.
This is indeed not really my use-case, but are you sure it might not
be helpful in general?

The reason to add DEBUG_INFO_LEVEL was also motivated by the
GCC11+/Clang12+ behavior of -gsplit-dwarf to provide an orthogonal
debug level config.
"The later -g<level> wins" behavior in turns works identically for
both older and newer compiler versions so such an implementation
provides version independent build behavior.
Testing on gcc-11, -gdwarf-<level>/-gdwarf still implies -g2.
It seemed a clearer way to me to explicitly set a debug level that
just wins instead of relying on implicits.

Regards
Dmitrii
