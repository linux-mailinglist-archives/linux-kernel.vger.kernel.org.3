Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C362846FE08
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbhLJJoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:44:07 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:55051 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhLJJoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:44:05 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MacjC-1mODZv1B5m-00c70u; Fri, 10 Dec 2021 10:40:29 +0100
Received: by mail-wr1-f53.google.com with SMTP id t9so13910212wrx.7;
        Fri, 10 Dec 2021 01:40:29 -0800 (PST)
X-Gm-Message-State: AOAM530X19LHUa/It40fWECxnIDEb/Mh9yjm3bOT+Uu7K0taXQ4m7xC8
        wn62entpbhqtFpkuxaSsIRB3ue8eb3h/KlbUizo=
X-Google-Smtp-Source: ABdhPJyu9erI7/CFsc2u//RX9hAEbTl60kQfjsJfA51uOVvtblju3dkQViDgpap2rqrDxF4TL+uXBa+raqJFihLoBb8=
X-Received: by 2002:adf:d091:: with SMTP id y17mr13364299wrh.418.1639129228855;
 Fri, 10 Dec 2021 01:40:28 -0800 (PST)
MIME-Version: 1.0
References: <20211210000910.3597609-1-keescook@chromium.org>
In-Reply-To: <20211210000910.3597609-1-keescook@chromium.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Dec 2021 10:40:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3wOVdds2-qz365LoBNGtrx6ksCzCHp7T+qSev+R3ZRPQ@mail.gmail.com>
Message-ID: <CAK8P3a3wOVdds2-qz365LoBNGtrx6ksCzCHp7T+qSev+R3ZRPQ@mail.gmail.com>
Subject: Re: [PATCH] Kconfig.debug: Make DEBUG_INFO selectable from a choice
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:W0Zdjqsc7rPIeTOL2FYSoQpTWZoqEvrVBLxS55cgoeMl+bX85QF
 UPq4ETc19eDLOiQBBEETlV+kxwHDaOSPfxmBE3goe9+4zmmQ3PzXnjD86dWUHKbf64vY4aB
 UzpUiS3toX9edbRAMTRULdszcfnFq/9GZFhUCy6PL37qTkb+QHJHWVJ/+kr7hV53qlrM1w4
 9ApUnWELIyQAXvcUKlLWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gaWyBOcWEeY=:iYCiGNX3+nPJMxOtfLiLdO
 wQqvjr24wUcj6lzSFQET2pkRykM4mphMq8KooLDZdjuLsplN4jQtp5+naK1rP55in7KdEZxGj
 HXMYwdYg/ZN9jTILo4Sb2MCanxgrGnSdMubvDV3bxmQB4NTWdiOvyVx0BKVm8MWxNsZlunvEW
 z6fYpnU5XdX6CpsYfl7H0ucc3bpPi3hPASmJ8QAeVzckd6tEVdsWBAYgzo6AanGldcWXDr459
 pRoDcilgTrb6vMs9sbHhKMuMtfnzJu0d4QSI4EN0Mts6mSA9tJ5mpoU/NrtwbM7h/mUQOMTNa
 57OWKUJFUzlfZgBhOaqZ5P7W32wlYnuzbo0LcuNmy/KFAaRI8qDf0RHGFLUuLaYIR3KDi7OgO
 efpxQVMdDVaBHzBloXAAP5+YgCve1wPUxOUC3O5VxytlgTZ+fXXJbobA1vFdKZybELsGIWD43
 2/725O2VB1OhRj80Cgb0r3bgeDkocgScs9vqZzRRFy1Bn85IpSy6XVxTidf4ITnbEt5JTqPlW
 8MpUNIbd1ikb3pOVb9HdNe/OuAIg1723bcymfwQllyZWmiLMnxr2g0eo7fg29q/z1hzB3J0NZ
 Fz4eVcCn/bVpe3wjkKxEpJUiYQku1Z9pRfZEvFVIsh/McsT0M7LYe30YbcLg/9JFYHe0Y+fCh
 RkxVRfCpKNXkvbbJONUCElq9WA4c26Dw81KDkk6yS7yYDaCGIbOKmaJbrEDMENb9pKwvaal7y
 gv6886HxRE4Z1xiRO7jksI/NWWKciixokqwruTCRCsbe9Gj4SYxxUMnPI0queWClT8SP9d3Yn
 TjdrV9gM0pzwlV0qYt2ZOebKH9X2QVZbZGwBkU/yVZaqpnSCDY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 1:09 AM Kees Cook <keescook@chromium.org> wrote:
>
> Currently it's not possible to enable DEBUG_INFO for an all*config
> build, since it is marked as "depends on !COMPILE_TEST". This generally
> makes sense because a debug build of an all*config target ends up taking
> much longer and the output is much larger. Having this be "default off"
> makes sense. However, there are cases where enabling DEBUG_INFO for such
> builds is useful for doing treewide A/B comparisons of build options,
> etc.
>
> Make DEBUG_INFO selectable from any of the DWARF version choice options,
> with DEBUG_INFO_NONE being the default for COMPILE_TEST. The mutually
> exclusive relationship between DWARF5 and BTF must be inverted, but the
> result remains the same. Additionally moves DEBUG_KERNEL and DEBUG_MISC
> up to the top of the menu because was enabling features _above_ it,
> making it weird to navigate menuconfig.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

One detail:

> +choice
> +       prompt "Debug information"
> +       depends on DEBUG_KERNEL
> +       default DEBUG_INFO_NONE if COMPILE_TEST
> +       default DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT if DEBUG_KERNEL

I think this line should be simplified to

          default DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT

since DEBUG_KERNEL is always enabled at this point. You can also consider
turning the 'menu' into 'menuconfig DEBUG_KERNEL' and dropping the 'depends
on DEBUG_KERNEL' in favor of the implied dependency.

       Arnd
