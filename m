Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD015AF918
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 02:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiIGAsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 20:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIGAsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 20:48:01 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACC2915FA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 17:48:00 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id i1so13363103vsc.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 17:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hxTBhCI0F5j/2VZXRiH27pSDCjgcW9IAx9MdqUjicTA=;
        b=pR0smMM+P4+BPyuL8kqpu+hfHMn3uKgzZOeKg9mikK3AiGbd0DWuHgG+Ra594j7mlA
         keOMF9a3Y46gU9rbxjugz3wWlG3T8QukRsf3y8Rfub8s5BCFL8nILhBJReOt4k0Ze/4f
         7j6gzOn5rU/1tMtEbAZpVPzWik3n5wsuI3/2D34KI4Mk4/sv1YIekuy9NHbKrejDL4eM
         JG4WPD1rj8LdelhXF7X/zzPKqfX3mE25wiGo9gBB6Q4637lCO/1A/H4yz+9lIzEryDVc
         ptvvZh3+MYf2U3to8X3w5gliceYUgwUFd2sOTcSUCGTLsRAEH1naWSPjYzDNVXDYY4am
         udgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hxTBhCI0F5j/2VZXRiH27pSDCjgcW9IAx9MdqUjicTA=;
        b=7SV+j8ug/DphsfnF/x+9i/7J5Os3kvMMT0lPvz+pungDL0740Z2mkXdL4cgWF95OMX
         5d997L/f8Xv3QD3rAm9od3UvSWbnxNY4w7Kkab9SMmWFURJq1oR0pvj+/Fo5prPbQyYu
         6QXIWRyCt4MoNc1xDd7OixgsUln6w0f5t5vPoVZZVD7gWYB8AevgTBF+KjwxE4f8yPYs
         H5W2wAcP+V35LX86dTqXMl1UR69yvOjHyH3sy7CXTQi6wEy2F1UN8e3anpbxjBnVEu5R
         8gF+rP1g9xpIn9kxPkY5chFkY7Q0MGJtsi5uC7Lp+zAF0iGmYhxKoB1M8A9ya1byTh46
         blwQ==
X-Gm-Message-State: ACgBeo2pp14LDFI+5q60jYixUonUwRv3q2nSpeixSi4+aAS2A2sBqfyz
        DY6ox6/s4hhA0VL/+ciQZuaQ7CkluNg5vaF2abzPvGCMsub0OQ==
X-Google-Smtp-Source: AA6agR5yr8YF6+0QafYupObEbHLSCcL/AToRyHImwx66OLyyvYDWNl4DuIdWi+YN40kdYlI1lSoXTQPNzh1f9ypKSFY=
X-Received: by 2002:a05:6102:304e:b0:397:6b53:5f81 with SMTP id
 w14-20020a056102304e00b003976b535f81mr360723vsa.80.1662511679176; Tue, 06 Sep
 2022 17:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X> <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
 <YoPAZ6JfsF0LrQNc@hirez.programming.kicks-ass.net> <YoPCTEYjoPqE4ZxB@hirez.programming.kicks-ass.net>
 <20220518012429.4zqzarvwsraxivux@treble> <20220518074152.GB10117@worktop.programming.kicks-ass.net>
 <20220518173604.7gcrjjum6fo2m2ub@treble> <YoVuxKGkt0IQ0yjb@hirez.programming.kicks-ass.net>
In-Reply-To: <YoVuxKGkt0IQ0yjb@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 6 Sep 2022 17:47:23 -0700
Message-ID: <CABCJKueB-tZmxESGP_W9JUghu-6y1Dj1DeahRsGb3bOUttctMA@mail.gmail.com>
Subject: Re: [PATCH] objtool: Fix symbol creation
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
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

On Wed, May 18, 2022 at 3:10 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 18, 2022 at 10:36:04AM -0700, Josh Poimboeuf wrote:
> > On Wed, May 18, 2022 at 09:41:52AM +0200, Peter Zijlstra wrote:
> > > +static int elf_update_symbol(struct elf *elf, struct section *symtab,
> > > +                        struct section *symtab_shndx, struct symbol *sym)
> > >  {
> > > -   Elf_Data *data, *shndx_data = NULL;
> > > -   Elf32_Word first_non_local;
> > > -   struct symbol *sym;
> > > -   Elf_Scn *s;
> > > -
> > > -   first_non_local = symtab->sh.sh_info;
> > > -
> > > -   sym = find_symbol_by_index(elf, first_non_local);
> > > -   if (!sym) {
> > > -           WARN("no non-local symbols !?");
> > > -           return first_non_local;
> > > -   }
> > > +   Elf_Data *symtab_data = NULL, *shndx_data = NULL;
> > > +   Elf64_Xword entsize = symtab->sh.sh_entsize;
> > > +   Elf32_Word shndx = sym->sec->idx;
> >
> > So if it's a global UNDEF symbol then I think 'sym->sec' can be NULL and
> > this blows up?
>
> Oh indeed, sym->sec ? sym->sec->idx : SHN_UNDEF it is.

elf_update_symbol seems to be a bit broken even after this. I noticed
it converts SHN_ABS symbols into SHN_UNDEF, which breaks some KCFI
builds. In fact, the function drops all the special st_shndx values
except SHN_XINDEX.

Specifically, read_symbols sets sym->sec to find_section_by_index(elf,
0) for all SHN_UNDEF and special st_shndx symbols, which means
sym->sec is non-NULL and sym->sec->idx is always 0 (= SHN_UNDEF) for
these symbols. As elf_update_symbol doesn't look at the actual
st_shndx value, it ends up marking the symbols undefined.

This quick hack fixes the issue for me, but I'm not sure if it's the
cleanest solution. Any thoughts?

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c25e957c1e52..7e24b09b1163 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -619,6 +619,11 @@ static int elf_update_symbol(struct elf *elf,
struct section *symtab,
        Elf64_Xword entsize = symtab->sh.sh_entsize;
        int max_idx, idx = sym->idx;
        Elf_Scn *s, *t = NULL;
+       bool is_special_shndx = sym->sym.st_shndx >= SHN_LORESERVE &&
+                               sym->sym.st_shndx != SHN_XINDEX;
+
+       if (is_special_shndx)
+               shndx = sym->sym.st_shndx;

        s = elf_getscn(elf->elf, symtab->idx);
        if (!s) {
@@ -704,7 +709,7 @@ static int elf_update_symbol(struct elf *elf,
struct section *symtab,
        }

        /* setup extended section index magic and write the symbol */
-       if (shndx >= SHN_UNDEF && shndx < SHN_LORESERVE) {
+       if ((shndx >= SHN_UNDEF && shndx < SHN_LORESERVE) || is_special_shndx) {
                sym->sym.st_shndx = shndx;
                if (!shndx_data)
                        shndx = 0;

Sami
