Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F57509E97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388813AbiDULhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiDULhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:37:05 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4977140F9;
        Thu, 21 Apr 2022 04:34:15 -0700 (PDT)
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N95Rn-1nwCUj0Mhr-0165Bq; Thu, 21 Apr 2022 13:34:14 +0200
Received: by mail-wm1-f45.google.com with SMTP id x3so2998405wmj.5;
        Thu, 21 Apr 2022 04:34:14 -0700 (PDT)
X-Gm-Message-State: AOAM530TYyfrwUkm75Vfw/bnUsGOVLZJwg1Vc9JFQYXVOErH1VeSvFNb
        w78J6zI+Cl8YGBNDoH0BZtMB5MajgN8scAhyRrY=
X-Google-Smtp-Source: ABdhPJwnGtY6P1co6gbbhHKNQHOma5ABD5kBnSOX51UNJdytJx9YbJ50fB/NRrPgASW9wxD+qnXzHSDChk0i/W4ed5Q=
X-Received: by 2002:a05:600c:25c5:b0:38f:f0b9:4c8c with SMTP id
 5-20020a05600c25c500b0038ff0b94c8cmr8493643wml.20.1650540853681; Thu, 21 Apr
 2022 04:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <874k2nhgtg.fsf@catern.com> <CAG48ez1PcDV5LvUomM6MsoA0pbg_7oJyfBLt6M2e3541gxx-LA@mail.gmail.com>
In-Reply-To: <CAG48ez1PcDV5LvUomM6MsoA0pbg_7oJyfBLt6M2e3541gxx-LA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Apr 2022 13:33:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1dLWs8DuQH5SV_d-S08sLj3rJy5O4s=Tva+Ry0EhO6Fg@mail.gmail.com>
Message-ID: <CAK8P3a1dLWs8DuQH5SV_d-S08sLj3rJy5O4s=Tva+Ry0EhO6Fg@mail.gmail.com>
Subject: Re: Explicitly defining the userspace API
To:     Jann Horn <jannh@google.com>
Cc:     Spencer Baugh <sbaugh@catern.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rkRtVxXPzzTjdqPTwePteQpbtX/huo5f1Ne66vl1b6fuC8fx5IH
 XsL0NnyuwVTRCIsgfx+EvWCOlo4XeNi+ZtQ3wnw67TcrxBhkBHt+2k9uq0KSMNd5wjMa1SU
 Rs4ndLJTFTIv/ST/r4hNB9+uHJEOqGNqyIL67uVXMr8jSd+W0mF+9Hj3Arjj/h6JLMh0P3D
 BgJFHZSd+1gKzq56+Vz/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kfwfobX88qs=:xd2xVaCwo8riOPXw8yq0pj
 vq0UeXH7F64U4MMhE/muBVU59AIwRac+BhT2lRuSORW4mHCZF98rnW069ViT9uThlq7g+squj
 G6RcavV+2iZcXeIxWqOal9F7h9nsYRc3cYa3wckd+ghtRRetm0gkI0k9nAx1Rk5VW1GH756X+
 XKPFTiW8WZHVV1cQaqUY9lLyuBDeX6NJ55mBA1TjyWieqZeTpG5skQJoLPKykTbpqcZ6Y4DPc
 JpP59WRYrWy+Oj4onxT4FUKZRh//oPF47JFKlcnstX5gNivS0Puvrx8ljI9iFSUcM9tYWFVoR
 lPdB2J2I4xD5cxLM2ZI8rTumwfmUiRuDVzhhujYjL9BdSLyNuscf0z8EOPKMO9Ct6BK1DYyLV
 IzB+Wel6SYDCQQPk6ggzqBcqxuJi+DhTHpwKlxQ2C3D9HvFka6MQPWGwMM/TblIHGFGpMJVgJ
 rx9t7u2NhzCsEewaexUywnlCRaGx0LLa+9kchltv139iL4fVPmFK9H46xvdPXKkj7FwiDGM19
 4RnyN45/1/HSHQB2jc+H0YUopiNhZwc8DXDDf2xX/pnPkYcjyKrPoVDIdzUDZdRtwbvlhz6S3
 wfQJGWKnLjzTz6+MU/l0JOhy23VPYW8jrX3791T7uj7SiczFI9Nii2IPLxyDILT9HZbWVWbYR
 xjO8Y6GnkRXoh3azsjaa+epy1IZWD7Eif3S/k3tpxJJnuEF+g5cMX8a17GRYhQLpIjmB4lp/d
 xbIZEoijp7UpnJXflvXYYIDs85/6eNizgBnPn/odtV+FZXBZBK32PlvKF7DI6rggcR3suscBT
 8xOGmw9fDRbZw98x+zw8REQNOzxYOCsNWepBhqr8pAAI8tmlWY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 7:18 PM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Apr 20, 2022 at 6:30 PM Spencer Baugh <sbaugh@catern.com> wrote:
> > Linux guarantees the stability of its userspace API, but the API
> > itself is only informally described, primarily with English prose.  I
> > want to add an explicit, authoritative machine-readable definition of
> > the Linux userspace API.
> >
> > As background, in a conventional libc like glibc, read(2) calls the
> > Linux system call read, passing arguments in an architecture-specific
> > way according to the specific details of read.
> >
> > The details of these syscalls are at best documented in manpages, and
> > often defined only by the implementation.  Anyone else who wants to
> > work with a syscall, in any way, needs to duplicate all those details.
> >
> > So the most basic definition of the API would just represent the
> > information already present in SYSCALL_DEFINE macros: the C types of
> > arguments and return values.
>
> FWIW, I believe ftrace already gets that basic information from the
> SYSCALL_DEFINE macros via struct syscall_metadata, and exports it to
> root-privileged userspace (although I think it won't actually tell you
> what the syscall number is that way):

One possible way I have considered in the past is to change the
SYSCALL_DEFINE() macros so they live in include/linux/syscalls.h,
where they expand to the wrappers for argument sanitizing (clearing
the upper bits etc) and end up calling normal functions.

When combined with the information in the syscall.tbl, this can help
provide a machine-readable list of implemented system calls and at the
same time ensure that the prototypes match what the actual functions
have.

The main missing bit for this is to convert asm-generic/unistd.h to
the syscall.tbl format, and to ensure that there is a unique mapping
between sys_*() function names and prototypes. The latter bit is
/almost/ there and should be easy to get right by renaming a couple
of nonstandard syscall entry points.

       Arnd
