Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE91350E856
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244448AbiDYShz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244452AbiDYShd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:37:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D323C73A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:34:28 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id v4so6802801ljd.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7v3XlpuvAVGFYesFm6cKxzANGO6Vtw9VjKoiTmexPg=;
        b=RoxpS2oUaw7T5pPMNHATBxpcgVH3HE+qjJmTyfXgMwsRplFO7/lkx/KY1RF6YtDCA5
         MRPKOqCuGfN3tbgwb2CRuUDfOtWwSiyI/FguD+zM9JelOCc3PpVht4klYeFrFEJtygtd
         Q9r7jwxafw1yJngAcasjDrDKSUoIVB4gmku5YmeSsffZPemITMq8AgF0v6BjHBrgGKWq
         MPSttVokn0wunltWB290eS3ubahNOHakSa9IOSg3ZoQPyL+PKHxoNin8357P7GFqRJaE
         2qA8Ur5jYVVqf1s2W2outHJ4TRTJm71ArVX5x9pNmXa+4VPsGUXGIGEY3BrdmvUo2csh
         3K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7v3XlpuvAVGFYesFm6cKxzANGO6Vtw9VjKoiTmexPg=;
        b=2rSs2JLnSKg051IBeWoZEtXrnqk2K0+sEt6XzKWJSJIfKWZhpl/q+/NY2dOgOmFVAP
         hJ/5DfEHZwzzsh9u9Tlb3KDfU3DfeEeYsd1h3HSUKCrs3C5fzXgssQjDhoTCtOVev/9G
         i2kBD4SVi0Y1jmywT/Ox2q9Mnovi36Li2r+jP/9SWQB3tCkOBxWfVCPRzPjUbd0AZQsZ
         SmTdestwJJWQt4+LWqdG8zlFQY3mNF6MpbNdj1VxHkH2+Eh+Qy4BZaQr2qQV12i5YRpd
         92gBFDmU2kqEMdj1xVykS+OmtbsJdj1fjFEl1Qbg9SEQfDeSygsjNXb1Ne//PPdXfkD9
         kYNw==
X-Gm-Message-State: AOAM5331PmL5KwsUnTCyJcfII2moi/V3pLr1cn2JB1Fz3Nhh1FUYtzz1
        nr4WjKh1vMAYsHveAwJLJrD+on821QodvEgP0cBdkg==
X-Google-Smtp-Source: ABdhPJxWJsAMNKA1K7KOe9udY7Vh7rRYbNz1452U3Mzh0pTj0zkF/8IpBEp80BcjzOTCxJYsmZjQHR15zJX2ylEl4J4=
X-Received: by 2002:a2e:9b57:0:b0:24f:12ea:fd26 with SMTP id
 o23-20020a2e9b57000000b0024f12eafd26mr3192452ljj.352.1650911665998; Mon, 25
 Apr 2022 11:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org> <20220424190811.1678416-7-masahiroy@kernel.org>
In-Reply-To: <20220424190811.1678416-7-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Apr 2022 11:34:14 -0700
Message-ID: <CAKwvOdmDiD11Az02U1i8OtxL49V3SH1ORRj8C5jy6Btv3LFY_g@mail.gmail.com>
Subject: Re: [PATCH 06/27] modpost: use bool type where appropriate
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Use 'bool' to clarify that the valid value is true or false.
>
> Here is a small note for the conversion.
>
> Strictly speaking, module::gpl_compatible was not boolean because
> new_module() initialized it to -1. Maybe, -1 was used to represent the
> license is 'unknown', but it is not useful.
>
> Since commit 1d6cd3929360 ("modpost: turn missing MODULE_LICENSE() into
> error"), unknown module license is not allowed anyway.
>
> I changed the initializer "= -1" to "= true". This has no functional
> change.
>
> The current code:
>
>     if (!mod->gpl_compatible)
>             check_for_gpl_usage(exp->export, basename, exp->name);
>
> ... only checks whether gpl_compabilt is zero or not:

s/gpl_compabilt/gpl_compatible/

Also the trailing `:` should perhaps be `.`.

Shouldn't gpl_compatible default to false, until proven otherwise?
What happens if you default to false? Perhaps an identifier like
`maybe_gpl_compatible` would be more descriptive?

Also, if we're going to rename a few vars, consider using prefixes
like is_*, has_*, or should_* for some of these to improve the
readability for boolean variables.

Otherwise LGTM.

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 60 +++++++++++++++++++++----------------------
>  scripts/mod/modpost.h | 10 ++++----
>  2 files changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index f9cbb6b6b7a5..52dd07a36379 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -23,20 +23,20 @@
>  #include "../../include/linux/license.h"
>
>  /* Are we using CONFIG_MODVERSIONS? */
> -static int modversions;
> +static bool modversions;
>  /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
> -static int all_versions;
> +static bool all_versions;
>  /* If we are modposting external module set to 1 */
> -static int external_module;
> +static bool external_module;
>  /* Only warn about unresolved symbols */
> -static int warn_unresolved;
> +static bool warn_unresolved;
>  /* How a symbol is exported */
>  static int sec_mismatch_count;
> -static int sec_mismatch_warn_only = true;
> +static bool sec_mismatch_warn_only = true;
>  /* ignore missing files */
> -static int ignore_missing_files;
> +static bool ignore_missing_files;
>  /* If set to 1, only warn (instead of error) about missing ns imports */
> -static int allow_missing_ns_imports;
> +static bool allow_missing_ns_imports;
>
>  static bool error_occurred;
>
> @@ -187,7 +187,7 @@ static struct module *new_module(const char *modname)
>         /* add to list */
>         strcpy(mod->name, modname);
>         mod->is_vmlinux = (strcmp(modname, "vmlinux") == 0);
> -       mod->gpl_compatible = -1;
> +       mod->gpl_compatible = true;
>         mod->next = modules;
>         modules = mod;
>
> @@ -203,10 +203,10 @@ struct symbol {
>         struct symbol *next;
>         struct module *module;
>         unsigned int crc;
> -       int crc_valid;
> +       bool crc_valid;
>         char *namespace;
> -       unsigned int weak:1;
> -       unsigned int is_static:1;  /* 1 if symbol is not global */
> +       bool weak;
> +       bool is_static;         /* true if symbol is not global */
>         enum export  export;       /* Type of export */
>         char name[];
>  };
> @@ -230,7 +230,7 @@ static inline unsigned int tdb_hash(const char *name)
>   * Allocate a new symbols for use in the hash of exported symbols or
>   * the list of unresolved symbols per module
>   **/
> -static struct symbol *alloc_symbol(const char *name, unsigned int weak,
> +static struct symbol *alloc_symbol(const char *name, bool weak,
>                                    struct symbol *next)
>  {
>         struct symbol *s = NOFAIL(malloc(sizeof(*s) + strlen(name) + 1));
> @@ -239,7 +239,7 @@ static struct symbol *alloc_symbol(const char *name, unsigned int weak,
>         strcpy(s->name, name);
>         s->weak = weak;
>         s->next = next;
> -       s->is_static = 1;
> +       s->is_static = true;
>         return s;
>  }
>
> @@ -250,7 +250,7 @@ static struct symbol *new_symbol(const char *name, struct module *module,
>         unsigned int hash;
>
>         hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
> -       symbolhash[hash] = alloc_symbol(name, 0, symbolhash[hash]);
> +       symbolhash[hash] = alloc_symbol(name, false, symbolhash[hash]);
>
>         return symbolhash[hash];
>  }
> @@ -419,7 +419,7 @@ static void sym_set_crc(const char *name, unsigned int crc)
>                 return;
>
>         s->crc = crc;
> -       s->crc_valid = 1;
> +       s->crc_valid = true;
>  }
>
>  static void *grab_file(const char *filename, size_t *size)
> @@ -716,9 +716,9 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
>                         sym_add_exported(name, mod, export);
>                 }
>                 if (strcmp(symname, "init_module") == 0)
> -                       mod->has_init = 1;
> +                       mod->has_init = true;
>                 if (strcmp(symname, "cleanup_module") == 0)
> -                       mod->has_cleanup = 1;
> +                       mod->has_cleanup = true;
>                 break;
>         }
>  }
> @@ -2008,9 +2008,9 @@ static void read_symbols(const char *modname)
>                         error("missing MODULE_LICENSE() in %s\n", modname);
>                 while (license) {
>                         if (license_is_gpl_compatible(license))
> -                               mod->gpl_compatible = 1;
> +                               mod->gpl_compatible = true;
>                         else {
> -                               mod->gpl_compatible = 0;
> +                               mod->gpl_compatible = false;
>                                 break;
>                         }
>                         license = get_next_modinfo(&info, "license", license);
> @@ -2053,7 +2053,7 @@ static void read_symbols(const char *modname)
>                                                        sym->st_name));
>
>                         if (s)
> -                               s->is_static = 0;
> +                               s->is_static = false;
>                 }
>         }
>
> @@ -2073,7 +2073,7 @@ static void read_symbols(const char *modname)
>          * the automatic versioning doesn't pick it up, but it's really
>          * important anyhow */
>         if (modversions)
> -               mod->unres = alloc_symbol("module_layout", 0, mod->unres);
> +               mod->unres = alloc_symbol("module_layout", false, mod->unres);
>  }
>
>  static void read_symbols_from_files(const char *filename)
> @@ -2305,7 +2305,7 @@ static void add_depends(struct buffer *b, struct module *mod)
>                 if (s->module->seen)
>                         continue;
>
> -               s->module->seen = 1;
> +               s->module->seen = true;
>                 p = strrchr(s->module->name, '/');
>                 if (p)
>                         p++;
> @@ -2422,10 +2422,10 @@ static void read_dump(const char *fname)
>                 mod = find_module(modname);
>                 if (!mod) {
>                         mod = new_module(modname);
> -                       mod->from_dump = 1;
> +                       mod->from_dump = true;
>                 }
>                 s = sym_add_exported(symname, mod, export_no(export));
> -               s->is_static = 0;
> +               s->is_static = false;
>                 sym_set_crc(symname, crc);
>                 sym_update_namespace(symname, namespace);
>         }
> @@ -2503,7 +2503,7 @@ int main(int argc, char **argv)
>         while ((opt = getopt(argc, argv, "ei:mnT:o:awENd:")) != -1) {
>                 switch (opt) {
>                 case 'e':
> -                       external_module = 1;
> +                       external_module = true;
>                         break;
>                 case 'i':
>                         *dump_read_iter =
> @@ -2512,28 +2512,28 @@ int main(int argc, char **argv)
>                         dump_read_iter = &(*dump_read_iter)->next;
>                         break;
>                 case 'm':
> -                       modversions = 1;
> +                       modversions = true;
>                         break;
>                 case 'n':
> -                       ignore_missing_files = 1;
> +                       ignore_missing_files = true;
>                         break;
>                 case 'o':
>                         dump_write = optarg;
>                         break;
>                 case 'a':
> -                       all_versions = 1;
> +                       all_versions = true;
>                         break;
>                 case 'T':
>                         files_source = optarg;
>                         break;
>                 case 'w':
> -                       warn_unresolved = 1;
> +                       warn_unresolved = true;
>                         break;
>                 case 'E':
>                         sec_mismatch_warn_only = false;
>                         break;
>                 case 'N':
> -                       allow_missing_ns_imports = 1;
> +                       allow_missing_ns_imports = true;
>                         break;
>                 case 'd':
>                         missing_namespace_deps = optarg;
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index a85dcec3669a..4085bf5b33aa 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -1,4 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdarg.h>
> @@ -116,11 +117,10 @@ struct module {
>         struct module *next;
>         int gpl_compatible;
>         struct symbol *unres;
> -       int from_dump;  /* 1 if module was loaded from *.symvers */
> -       int is_vmlinux;
> -       int seen;
> -       int has_init;
> -       int has_cleanup;
> +       bool from_dump;         /* true if module was loaded from *.symvers */
> +       bool is_vmlinux;
> +       bool seen;
> +       bool has_init, has_cleanup;
>         struct buffer dev_table_buf;
>         char         srcversion[25];
>         // Missing namespace dependencies
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
