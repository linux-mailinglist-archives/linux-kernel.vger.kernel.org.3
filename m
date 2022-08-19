Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F392A59A8F6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243157AbiHSWwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243127AbiHSWwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:52:17 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436D610B519;
        Fri, 19 Aug 2022 15:52:16 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-33365a01f29so158236267b3.2;
        Fri, 19 Aug 2022 15:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ePCvzW/muyp3tHWutyEFwLQrrnxA3ArTLs/J6HTRfLY=;
        b=SfiS+2alq9htL30QUKpIzaZuP0u+uU0NCMdQbyKqhjNx1WVYuFMypqJ++I2zmlD5HR
         9EbF5AxpHXlEEWbfAucgwKtDi5+WBpUfAxM4rU50kJzaPf5s3ewjBNfqOSTq8JP0esyV
         vxFl7+urp6LmiQsFJ45WjtPikSukan5lkMRISDwUG82TpAo8pA+VLDKlB5lBRKDPbGnt
         6XCwsGn1g6s1sSC7C/gu8+xPYgadWY8qZzPkH0Uq7B2fM8hoXT5qN2gSQO0BamXMbLZZ
         LOrTxLUyddhiWJJaKiFaHYiFvkQICKV5+rnAtYuo49/lSn6Y2bd5XNSS3bq+D8Erb75h
         exLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ePCvzW/muyp3tHWutyEFwLQrrnxA3ArTLs/J6HTRfLY=;
        b=5DP9umjBja69OQDEIln8NTnE4pgHDy2so5eAmbqvfjhVfDRjnXXBWH5I6vQHt+H6rR
         Dpd207En9AyXhj+FaeRLUSN4B1WIaDz31qOiOXeL5H2DLX+NxHkQeiTDA/bQGgxYxzLX
         InwVhpy67YOUVWHnCcQY7nEsftzl6treUrlkKz7gA9tnfbpHL9MoWqaWbQyrnYPibE/e
         klrMrGSCiNU4DZMo835C9FCpsMVtJQDiD1ae7raUwJ35A8csa0Vi68dhAlhnMJXvGWx8
         lqS9ernRQn0jSUfkV3/+wagiBFoCFtQsGK86KriKseiGLpJn6q/cELr6hMwZg/BiscK1
         DmKQ==
X-Gm-Message-State: ACgBeo1oXugSReVPUYnfB43Na92pgiPRhV/JyPhoEhYwbIjx0ervbD6R
        pEhfGg5sndm09rzSZqBkkSXGnXcZHtfBKPnFZ0ZI7Y4fOILi0B3t1tRDLDXL
X-Google-Smtp-Source: AA6agR4afgOfJkc1z2NyLelaUeWkE/UX7xu/DhdJa5LYX3dRn/DDZ6MqrQtqwibT6A2u/RJbfYWYN3143SCmPeprUoU=
X-Received: by 2002:a25:ac9e:0:b0:68e:ccf4:ea04 with SMTP id
 x30-20020a25ac9e000000b0068eccf4ea04mr9510879ybi.287.1660949535520; Fri, 19
 Aug 2022 15:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
 <20220815013317.26121-1-dmitrii.bundin.a@gmail.com> <CAKwvOdnnSAozX8bQ9HeSw12BV9OjpzyDmXk_BGczjVVQNN+7tQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnnSAozX8bQ9HeSw12BV9OjpzyDmXk_BGczjVVQNN+7tQ@mail.gmail.com>
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date:   Sat, 20 Aug 2022 01:52:04 +0300
Message-ID: <CANXV_Xw2wzwDdJkyV1nHPQm2JTt48SLrNc7YwrfcxOwuFA-z3w@mail.gmail.com>
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

On Fri, Aug 19, 2022 at 8:42 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Is any of this really necessary?

Consider the case if CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y.
Prior to GCC11/Clang12 -gsplit-dwarf implied -g2. So on newer
compilers with -gsplit-dwarf in use there would be no debug symbols
produced. -gdwarf-4/5 still implies -g2, but in case
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y neither of the options are
set. So it seems like a reasonable choice to provide a debug info
level config that would explicitly set the level without relying on
implicits. The default value of the config is set to -g2 to not change
the build behavior that was before introducing the option. And it
works for both older and newer versions of GCC/Clang in the same way.
The benefits of the -g1 option are indeed questionable except that it
produces an image with ~20% less in size.

> It seems like a great way to bloat
> vmlinux artifacts built with CONFIG_DEBUG_INFO even further.
The defaults were chosen to not change the build behavior that was
before introducing the options. Or did you mean something else?

> The
> above link mentions "when debugging with GDB."  In that case, please
> don't add new Kconfigs for these; just set -g3 when
> CONFIG_GDB_SCRIPTS=y.

CONFIG_GDB_SCRIPTS does not necessarily mean that -g3 is wanted, -g2
(default) is usually a reasonable choice. The -g3 option is very
useful when debugging macro-intensive code, but requires much more
disk space to build. I documented it explicitly in the help section of
DEBUG_INFO_LEVEL. GCC and Clang use different options to include macro
definitions so it was handled depending on the compiler used.

Regards
Dmitrii
