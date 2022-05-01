Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B5F516487
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 15:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347404AbiEANTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 09:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbiEANTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 09:19:40 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588C21EC57;
        Sun,  1 May 2022 06:16:13 -0700 (PDT)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 241DFtO4024407;
        Sun, 1 May 2022 22:15:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 241DFtO4024407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651410956;
        bh=AOIjAWrhKV1p2owuFi8VBq5wKJbXGOpCPHDjqLJqvLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oW1yjkY80WIV/jyNezHDi2oYe67Lz96zrD/LzGXzp4p2scrINuSJ5IvaZTmA3OfnE
         s1kcjeR/a58MdxjiM3WjoG76Chy+RFEMJ1wHPNUbJ87f8j/SaddwSO3flaNUVQyGHq
         4ioi9lfMfDsNl7S2f07cPRIsHpknT/HBknk5kDYvZJ7n4oZUP4WEWPFKy+D92OR/G5
         tjVzFDrtYwFXY1S8HTQSInlUAO65AR19iRzrW7sNFzGwBpb0zDgAq68DSM+/w/2clf
         zcwLOmKolZVm51MQPHbnjBBOFf6jkJmaFajb4rUssLFudcm9XrzwxSdGfNDpyPThLB
         5954qjsDhbPnA==
X-Nifty-SrcIP: [209.85.216.41]
Received: by mail-pj1-f41.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so12231552pjb.3;
        Sun, 01 May 2022 06:15:56 -0700 (PDT)
X-Gm-Message-State: AOAM532R6g5sBagJjCyfgti5s0pOpsQ/4ORoyTI4CHcDmfmzqhYU9LVe
        wB3qYyRQ7NCO5ggo0UVh/yUPQzhMjiEdVsc/rKA=
X-Google-Smtp-Source: ABdhPJy5vHMvKZ3oLvS7GLckKahydyX4ESGuqSxLI4QfdpHXAbaXBfQi9IO5a1QJs0ZwOT0FdarzoO+6uYEjXUtGxOg=
X-Received: by 2002:a17:902:bf07:b0:158:d334:852f with SMTP id
 bi7-20020a170902bf0700b00158d334852fmr7657549plb.136.1651410955372; Sun, 01
 May 2022 06:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-7-masahiroy@kernel.org> <CAKwvOdmDiD11Az02U1i8OtxL49V3SH1ORRj8C5jy6Btv3LFY_g@mail.gmail.com>
In-Reply-To: <CAKwvOdmDiD11Az02U1i8OtxL49V3SH1ORRj8C5jy6Btv3LFY_g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 1 May 2022 22:14:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAL_VVtLxM5eUyBnUzduQw7h28yuXNGVWK44pZERqbOA@mail.gmail.com>
Message-ID: <CAK7LNATAL_VVtLxM5eUyBnUzduQw7h28yuXNGVWK44pZERqbOA@mail.gmail.com>
Subject: Re: [PATCH 06/27] modpost: use bool type where appropriate
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 3:34 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> /On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Use 'bool' to clarify that the valid value is true or false.
> >
> > Here is a small note for the conversion.
> >
> > Strictly speaking, module::gpl_compatible was not boolean because
> > new_module() initialized it to -1. Maybe, -1 was used to represent the
> > license is 'unknown', but it is not useful.
> >
> > Since commit 1d6cd3929360 ("modpost: turn missing MODULE_LICENSE() into
> > error"), unknown module license is not allowed anyway.
> >
> > I changed the initializer "= -1" to "= true". This has no functional
> > change.
> >
> > The current code:
> >
> >     if (!mod->gpl_compatible)
> >             check_for_gpl_usage(exp->export, basename, exp->name);
> >
> > ... only checks whether gpl_compabilt is zero or not:
>
> s/gpl_compabilt/gpl_compatible/
>
> Also the trailing `:` should perhaps be `.`.
>
> Shouldn't gpl_compatible default to false, until proven otherwise?
> What happens if you default to false? Perhaps an identifier like
> `maybe_gpl_compatible` would be more descriptive?


The init value should be 'true'.

In v2, I split this change into a separate patch,
and added some comments.

https://patchwork.kernel.org/project/linux-kbuild/patch/20220501084032.1025918-3-masahiroy@kernel.org/

I hope it answered your question.




> Also, if we're going to rename a few vars, consider using prefixes
> like is_*, has_*, or should_* for some of these to improve the
> readability for boolean variables.


OK, I renamed it to is_gpl_compatible in v2.






> Otherwise LGTM.
>
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.c | 60 +++++++++++++++++++++----------------------
> >  scripts/mod/modpost.h | 10 ++++----
> >  2 files changed, 35 insertions(+), 35 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index f9cbb6b6b7a5..52dd07a36379 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -23,20 +23,20 @@
> >  #include "../../include/linux/license.h"
> >
> >  /* Are we using CONFIG_MODVERSIONS? */
> > -static int modversions;
> > +static bool modversions;
> >  /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
> > -static int all_versions;
> > +static bool all_versions;
> >  /* If we are modposting external module set to 1 */
> > -static int external_module;
> > +static bool external_module;
> >  /* Only warn about unresolved symbols */
> > -static int warn_unresolved;
> > +static bool warn_unresolved;
> >  /* How a symbol is exported */
> >  static int sec_mismatch_count;
> > -static int sec_mismatch_warn_only = true;
> > +static bool sec_mismatch_warn_only = true;
> >  /* ignore missing files */
> > -static int ignore_missing_files;
> > +static bool ignore_missing_files;
> >  /* If set to 1, only warn (instead of error) about missing ns imports */
> > -static int allow_missing_ns_imports;
> > +static bool allow_missing_ns_imports;
> >
> >  static bool error_occurred;
> >
> > @@ -187,7 +187,7 @@ static struct module *new_module(const char *modname)
> >         /* add to list */
> >         strcpy(mod->name, modname);
> >         mod->is_vmlinux = (strcmp(modname, "vmlinux") == 0);
> > -       mod->gpl_compatible = -1;
> > +       mod->gpl_compatible = true;
> >         mod->next = modules;
> >         modules = mod;
> >
> > @@ -203,10 +203,10 @@ struct symbol {
> >         struct symbol *next;
> >         struct module *module;
> >         unsigned int crc;
> > -       int crc_valid;
> > +       bool crc_valid;
> >         char *namespace;
> > -       unsigned int weak:1;
> > -       unsigned int is_static:1;  /* 1 if symbol is not global */
> > +       bool weak;
> > +       bool is_static;         /* true if symbol is not global */
> >         enum export  export;       /* Type of export */
> >         char name[];
> >  };
> > @@ -230,7 +230,7 @@ static inline unsigned int tdb_hash(const char *name)
> >   * Allocate a new symbols for use in the hash of exported symbols or
> >   * the list of unresolved symbols per module
> >   **/
> > -static struct symbol *alloc_symbol(const char *name, unsigned int weak,
> > +static struct symbol *alloc_symbol(const char *name, bool weak,
> >                                    struct symbol *next)
> >  {
> >         struct symbol *s = NOFAIL(malloc(sizeof(*s) + strlen(name) + 1));
> > @@ -239,7 +239,7 @@ static struct symbol *alloc_symbol(const char *name, unsigned int weak,
> >         strcpy(s->name, name);
> >         s->weak = weak;
> >         s->next = next;
> > -       s->is_static = 1;
> > +       s->is_static = true;
> >         return s;
> >  }
> >
> > @@ -250,7 +250,7 @@ static struct symbol *new_symbol(const char *name, struct module *module,
> >         unsigned int hash;
> >
> >         hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
> > -       symbolhash[hash] = alloc_symbol(name, 0, symbolhash[hash]);
> > +       symbolhash[hash] = alloc_symbol(name, false, symbolhash[hash]);
> >
> >         return symbolhash[hash];
> >  }
> > @@ -419,7 +419,7 @@ static void sym_set_crc(const char *name, unsigned int crc)
> >                 return;
> >
> >         s->crc = crc;
> > -       s->crc_valid = 1;
> > +       s->crc_valid = true;
> >  }
> >
> >  static void *grab_file(const char *filename, size_t *size)
> > @@ -716,9 +716,9 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
> >                         sym_add_exported(name, mod, export);
> >                 }
> >                 if (strcmp(symname, "init_module") == 0)
> > -                       mod->has_init = 1;
> > +                       mod->has_init = true;
> >                 if (strcmp(symname, "cleanup_module") == 0)
> > -                       mod->has_cleanup = 1;
> > +                       mod->has_cleanup = true;
> >                 break;
> >         }
> >  }
> > @@ -2008,9 +2008,9 @@ static void read_symbols(const char *modname)
> >                         error("missing MODULE_LICENSE() in %s\n", modname);
> >                 while (license) {
> >                         if (license_is_gpl_compatible(license))
> > -                               mod->gpl_compatible = 1;
> > +                               mod->gpl_compatible = true;
> >                         else {
> > -                               mod->gpl_compatible = 0;
> > +                               mod->gpl_compatible = false;
> >                                 break;
> >                         }
> >                         license = get_next_modinfo(&info, "license", license);
> > @@ -2053,7 +2053,7 @@ static void read_symbols(const char *modname)
> >                                                        sym->st_name));
> >
> >                         if (s)
> > -                               s->is_static = 0;
> > +                               s->is_static = false;
> >                 }
> >         }
> >
> > @@ -2073,7 +2073,7 @@ static void read_symbols(const char *modname)
> >          * the automatic versioning doesn't pick it up, but it's really
> >          * important anyhow */
> >         if (modversions)
> > -               mod->unres = alloc_symbol("module_layout", 0, mod->unres);
> > +               mod->unres = alloc_symbol("module_layout", false, mod->unres);
> >  }
> >
> >  static void read_symbols_from_files(const char *filename)
> > @@ -2305,7 +2305,7 @@ static void add_depends(struct buffer *b, struct module *mod)
> >                 if (s->module->seen)
> >                         continue;
> >
> > -               s->module->seen = 1;
> > +               s->module->seen = true;
> >                 p = strrchr(s->module->name, '/');
> >                 if (p)
> >                         p++;
> > @@ -2422,10 +2422,10 @@ static void read_dump(const char *fname)
> >                 mod = find_module(modname);
> >                 if (!mod) {
> >                         mod = new_module(modname);
> > -                       mod->from_dump = 1;
> > +                       mod->from_dump = true;
> >                 }
> >                 s = sym_add_exported(symname, mod, export_no(export));
> > -               s->is_static = 0;
> > +               s->is_static = false;
> >                 sym_set_crc(symname, crc);
> >                 sym_update_namespace(symname, namespace);
> >         }
> > @@ -2503,7 +2503,7 @@ int main(int argc, char **argv)
> >         while ((opt = getopt(argc, argv, "ei:mnT:o:awENd:")) != -1) {
> >                 switch (opt) {
> >                 case 'e':
> > -                       external_module = 1;
> > +                       external_module = true;
> >                         break;
> >                 case 'i':
> >                         *dump_read_iter =
> > @@ -2512,28 +2512,28 @@ int main(int argc, char **argv)
> >                         dump_read_iter = &(*dump_read_iter)->next;
> >                         break;
> >                 case 'm':
> > -                       modversions = 1;
> > +                       modversions = true;
> >                         break;
> >                 case 'n':
> > -                       ignore_missing_files = 1;
> > +                       ignore_missing_files = true;
> >                         break;
> >                 case 'o':
> >                         dump_write = optarg;
> >                         break;
> >                 case 'a':
> > -                       all_versions = 1;
> > +                       all_versions = true;
> >                         break;
> >                 case 'T':
> >                         files_source = optarg;
> >                         break;
> >                 case 'w':
> > -                       warn_unresolved = 1;
> > +                       warn_unresolved = true;
> >                         break;
> >                 case 'E':
> >                         sec_mismatch_warn_only = false;
> >                         break;
> >                 case 'N':
> > -                       allow_missing_ns_imports = 1;
> > +                       allow_missing_ns_imports = true;
> >                         break;
> >                 case 'd':
> >                         missing_namespace_deps = optarg;
> > diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> > index a85dcec3669a..4085bf5b33aa 100644
> > --- a/scripts/mod/modpost.h
> > +++ b/scripts/mod/modpost.h
> > @@ -1,4 +1,5 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > +#include <stdbool.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <stdarg.h>
> > @@ -116,11 +117,10 @@ struct module {
> >         struct module *next;
> >         int gpl_compatible;
> >         struct symbol *unres;
> > -       int from_dump;  /* 1 if module was loaded from *.symvers */
> > -       int is_vmlinux;
> > -       int seen;
> > -       int has_init;
> > -       int has_cleanup;
> > +       bool from_dump;         /* true if module was loaded from *.symvers */
> > +       bool is_vmlinux;
> > +       bool seen;
> > +       bool has_init, has_cleanup;
> >         struct buffer dev_table_buf;
> >         char         srcversion[25];
> >         // Missing namespace dependencies
> > --
> > 2.32.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
