Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114454FA6CB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbiDIKfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 06:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbiDIKfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:35:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0A1F0441;
        Sat,  9 Apr 2022 03:33:35 -0700 (PDT)
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M9Fvl-1na8Of1Vdn-006M2o; Sat, 09 Apr 2022 12:33:34 +0200
Received: by mail-wm1-f42.google.com with SMTP id p189so7013115wmp.3;
        Sat, 09 Apr 2022 03:33:34 -0700 (PDT)
X-Gm-Message-State: AOAM533Ja5jzzEYAxhkXx5fOeZq+nAJ9hDw1ENGH1q/Ib/N/HOU9RKCo
        wskc2Y693qi6VbXoHsLeYWlj/3yR099O/dedkpM=
X-Google-Smtp-Source: ABdhPJwsUBXnmbEbaFsBC7s730nC5Ut/zN3omGoreJ6+U2b6OTYxTOE1rScNMNh2ech3kws1903fK9PVsjEC8+gNr7M=
X-Received: by 2002:a05:600c:4ecc:b0:38e:354d:909 with SMTP id
 g12-20020a05600c4ecc00b0038e354d0909mr21220146wmq.33.1649500414009; Sat, 09
 Apr 2022 03:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com>
 <CAK7LNARvFcQgEB1b0L6giwx0vD7wU9L-OZ5jvm1c5+StLjeOYQ@mail.gmail.com> <YlCJm8iQBPSOWIT5@hirez.programming.kicks-ass.net>
In-Reply-To: <YlCJm8iQBPSOWIT5@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 9 Apr 2022 12:33:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3xoUJ=aDROkWQ1Awpu0kiciohL7hJNsQ0Zn0K05bWObQ@mail.gmail.com>
Message-ID: <CAK8P3a3xoUJ=aDROkWQ1Awpu0kiciohL7hJNsQ0Zn0K05bWObQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JxkzLmbAzjoD4nIIGLoGD0RXkk7NCWmU9t5QU/LAlA3pXV1AvfZ
 BGImKImCiJzMqGDBRRh5IEtydcco7uziUCiMD6eo7VjffoLcBrZbmFc6O4ed2FV/0ACPUVX
 OTKkkw31TPX+38DMqKt3f18iS2tg1vTg00ln0IfWwdt56MDlCcURHGPABkLxW0nYjfK5QBL
 wdPBqNUO1DfGn7Zg1Rz8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GAYr7Af3suE=:uQxsxpCKe6vXIj9n+dqWgE
 tzAXROn81cOtMmsSy6YCxFQGBD1Z8wVugVrjBDVbZKeCafssOlu/DMPQhxY5lG4vXtWrKM9rm
 NRaPri6Awt/OYtxNPGGx9ld3+1FnUQoImfhwvj3iODbU12iBn95doLGeb/WahLIk4n7e1kVqF
 Ihll4F/ZAa8UTU2Qw3Qxs2xcZZpUmCPTxgEadNB9N0oQyAvH5FbnFf9NXnY6k0cjPomK4zO6J
 w8jUwAfrzuV2MqYjlyVUDi4gybcGW6QOD8tNdwr9GzQxccHpQXby9enqKdr3fSj+dbrQrjKse
 R1sJ51umz7UUlUht3hIzQjLX6cWeB0ye6Gy+DlYZ6Z7D55aZuZ2Hb9JYwdrleTKO/y95Nu7DO
 ujnGkiQ1uxwMM0b1Ug61LdDzzYjwbAivpkVcGDCBBh5tw5ITW3EcQxyj/OAE6q5Sllis3QeD5
 4L7zPj3IvYbvvwmskmN5s43C7CnfXOX+onsO0jyXc1kkA2tbnaWzdNHFZb6eDIL1AYrLVYijU
 uVNI3O/VzoJQtxEzZAvzL6W1su5uhbY3A1ZdNERBmy/knY2twE2fw6HAK/w8sc5U9C026A6ho
 UETANKcDncdCqfwleCMYhrd+Vj1grIqPmBHeAKSD/sM5EFD3fxo0pN4sAwBZiTt7mEnXdlmLX
 r/ZEsYpxHJr9G80bvEWvaE4eX8vZt1vqbhzRKzQTxjbWlsDMJlrynXaa637QYlvRU/4g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 9:14 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Apr 09, 2022 at 03:29:21AM +0900, Masahiro Yamada wrote:
> > Is [2] caused by dead code that was not optimized out
> > due to the unusual inlining decisions by the compiler ?
>
> The complaint is due to SMAP validation; objtool will scream if there's
> a CALL in between STAC/CLAC. The thinking is that since they open a
> security window, we want tight code between them. We also very much
> don't want tracing and other funnies to happen there. As such, any CALL
> is dis-allowed.
>
> This weird option is having us upgrade quite a few 'inline' to
> '__always_inline'.

There is also __attribute__((flatten)), which you can add to the caller
to tell gcc to inline everything it can into this function, without
having to inline it everywhere else.

Would that work here? It sounds like this is what STAC/CLAC actually
requires.

         Arnd
