Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5BA565C36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiGDQeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbiGDQd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:33:56 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA06A47B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:33:55 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31c8340a6f7so45842337b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uTJEKBpneiIbXMc3b2N5EXRSBaOvIi8yNaCS7kWKrlA=;
        b=R52eKy4xAiav4e/HV+jayJLA2b8Sdq82fLJZWJR+bm325zxVmgQoXDLnAqFkzZMcPC
         AKlyCKH0kOHc0Tz2AdGT4VRQEilaf8ohCIfP9CV2OwJZy8wNwuqCZsfawbn0haPAlP+8
         WyVPxTiZbjHL8dyvE3WFdD0Eqdox0BKyGagKKzRPpK3qZWVitAxgBbC9NVnegpWBXFO9
         YMFIMtBTxYxfmKjIGehB8wI6UrWsrOnBU7S6ediWsijCn1jpowC/htKyC5Algzmxe8J0
         4DLcB4+QyhkDFgmpY9sj3fh8ntfcRXDdfUOerF3AlS3D8FbtjAP6zn+LkhrslzytmNup
         MTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uTJEKBpneiIbXMc3b2N5EXRSBaOvIi8yNaCS7kWKrlA=;
        b=Z9LWFu351ron0WGUBRBClU+rGSuUcNFIGBza7nkq6yg5RMEC5VwXMtAUVlHSvQkDFX
         JtoljhzLuEux1oqti0ZPTWh2KgwSqm1U/t8Pcwa+D926+t2T25KTya8/e0meMpMv2DfO
         hpRwakkYoPXrAkC4BusdgfjPSfLKZXBf2+rJkKXq8MUg498G1dB/A0ZcYrkHTzAG5vsP
         h/Y3O5lS4WnSSjZfDTayL/okSlVY6VTZ/3pRB8fo+XztfZc8zJwBc/UBwUVi47Ory/RO
         mLI/ECRGayKo4f1aUzoIb2OS6DhYa39gBTjwWtaEZnh3sE/B7MAR6nvaKzlfGdsSiuTV
         N1mA==
X-Gm-Message-State: AJIora9SzTeHICz4M89l0zUGkUsSiW7BcxaU0eifLTyXPYKrdyiDq9UO
        NHYHy5qVefPD1FgZpetX3sd9H2IDrQ4kZhBHK6LHYA==
X-Google-Smtp-Source: AGRyM1s63YE2/xTgqt0oPZZQkusLgbG2t/58xXkztX16ZAIyPj87TDuKl8Uv6/qEf+3SpdiC1pugrIWRYD+I3KpDsM8=
X-Received: by 2002:a81:a847:0:b0:31c:7dd5:6d78 with SMTP id
 f68-20020a81a847000000b0031c7dd56d78mr15980661ywh.50.1656952434098; Mon, 04
 Jul 2022 09:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
 <YsJWCREA5xMfmmqx@ZenIV> <CAG_fn=V_vDVFNSJTOErNhzk7n=GRjZ_6U6Z=M-Jdmi=ekbS5+g@mail.gmail.com>
 <YsLuoFtki01gbmYB@ZenIV> <CAG_fn=VTihJSzQ106WPaQNxwTuuB8iPQpZR4306v8KmXxQT_GQ@mail.gmail.com>
 <YsMPRuOdXJIuEe2s@kroah.com>
In-Reply-To: <YsMPRuOdXJIuEe2s@kroah.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 4 Jul 2022 18:33:18 +0200
Message-ID: <CAG_fn=VhRynRP_8dPH5gb28=LUU1O69GiX5JR24naJCLuamAEg@mail.gmail.com>
Subject: Re: [PATCH v4 43/45] namei: initialize parameters passed to step_into()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 6:03 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 04, 2022 at 05:49:13PM +0200, Alexander Potapenko wrote:
> > This e-mail is confidential. If you received this communication by
> > mistake, please don't forward it to anyone else, please erase all
> > copies and attachments, and please let me know that it has gone to the
> > wrong person.
>
> This is not compatible with Linux kernel development, sorry.
>
> Now deleted.

Sorry, I shouldn't have added those to public emails.
Apologies for the inconvenience.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
