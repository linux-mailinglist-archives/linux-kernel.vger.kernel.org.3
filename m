Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B23656F960
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiGKIzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiGKIzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:55:46 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E6112D06
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:55:45 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 64so7625071ybt.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cv1OrhuTxvAMnq/XV7eYJa01PGsvFINmFEWluG8JPMA=;
        b=EAxU2LtklBhZsJsW158Man1t4r+QqlcybCsdYWfEWBA3+e9RRcvhZNxonbkfC0QMSW
         WDTmIGP+tLbksUpqYUjayaUEzW9aULlQu/oAyVltE354G87ZTPcb+v0khMCUiORTFLBa
         yhAiZakt+9yTltC0YGGKy6Z1dkM+queCFxCqSZrjrsNZ3f63OHSurGEiw/yLYkPigt72
         bjSQMGCcGEDFtNqNRTi4V02gmqzyJvPDyGkfybTgSZDUOlt86a+s1t48ch3hqjw0a0Gz
         mYvgnqAOu5ucZ/qrce/toSj2/KS+XGdLCWeILza2G3ZPpWGJAJsYbFF6oRL1RlCkOija
         Stig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cv1OrhuTxvAMnq/XV7eYJa01PGsvFINmFEWluG8JPMA=;
        b=WykkqkoR2ptxqpJjAkpXqL+I2k2DCbWd1wba4YtRLS6V92c3sdowUrHtvvBQ2iv4t/
         wKdOieipUus6HPnysrWemV7MKbzv1ii3/ZHa2irXwMeimkQyQqXnC9gNPh/Gjc9OgfMc
         cVjTQIrrX39PpTdeNKC9RPDI1C/QCiJDo3ZaoKdxUJprgnvXek+8tj9BVtpqhwESi0Vh
         TY282jJT499c+avloaN6kvSYB77qHHX7Io5RAVcLTKyMX6mo0I9BplQ3BS+CKeNnHxhY
         mMJTWhjfZrNhyf2aY7bBc0wjV0dMSyQDBOwjdpGiPF7RaJy+4h0oCk5eRTd++KXJi50L
         fI2A==
X-Gm-Message-State: AJIora+7rsrVRcPjYabNwBUwJbxwYHG+GduFi3Fk0bwmfzds04KBghJn
        4Im3GRN3GlL6PuvH4H/dynEctPC2YRwTDts1GYI=
X-Google-Smtp-Source: AGRyM1shciR+SU6jXy85ObEzvwGv8DpQML9P5aEtXEzoDX7qb/toZVWwuN3ltCpMVXgMM3sy8b6SOU2iffgHnVorAuY=
X-Received: by 2002:a05:6902:1143:b0:66e:eb08:4c23 with SMTP id
 p3-20020a056902114300b0066eeb084c23mr10557804ybu.570.1657529744903; Mon, 11
 Jul 2022 01:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220711044711.466822-1-yury.norov@gmail.com>
In-Reply-To: <20220711044711.466822-1-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 10:55:08 +0200
Message-ID: <CAHp75Vf8EhRYWdQN6Oc79GzWCvo-sRJDvy7_Aek_Z63GCu2dMQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] lib/find: add find_nth_bit()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Mon, Jul 11, 2022 at 6:51 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> Kernel lacks for a function that searches for Nth bit in a bitmap.
> Usually people do it like this:
>         for_each_set_bit(bit, mask, size)
>                 if (--n == 0)
>                         return bit;
>
> Which is not so elegant, and very slow.
>
> This series adds fast routines for this task, and applies them where
> appropriate.
>
> While here, move thin wrappers around find_bit() in nodemask.c to a
> corresponding header, and because nodemask.c is empty after that,
> remove it.
>
> v1: https://lore.kernel.org/lkml/20220706182300.70862-4-yury.norov@gmail.com/T/
> v2: - count Nth bit from 0 (was 1);
>     - use 'invert' trick in _find_nth_bit(), as in _find_next_bit();
>     - cleanup comments;
>     - fns() is kept inline - looking at __ffs() generic implementation,
>       I decided to keep it untouched.

Two observations:
1) your patches are not versioned (hint: use `git format-patch
--thread -vX --cover-letter ...`, where X is a version you want to
give);
2) fns() is not good abbreviation, because among ffs (First) and fls
(Last), fns would be read as Next, which is misleading, I'm not sure
fnths(), which is correct, is good for readers.

-- 
With Best Regards,
Andy Shevchenko
