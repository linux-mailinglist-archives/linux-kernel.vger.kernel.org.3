Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A4E4C5850
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 22:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiBZViz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 16:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiBZVix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:38:53 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E894838D;
        Sat, 26 Feb 2022 13:38:17 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id c18so10665642ioc.6;
        Sat, 26 Feb 2022 13:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8q2+VET2eajqK3GJ1OZqDgdE8FY+4FkTKTcCYqMTWi4=;
        b=AU1dafVIVU+mvgw9xKOIhrMm8sSQlttSDxfMvj2Z1gsQP3F3wtONks1DoZ5PFT/X98
         gjyWT5IqkFgciZOgmpIIWbScsex3In52yPl2PEfW707OQ0mhFjbZ8fywV4dnH5teh8oD
         ExlALTdEEi7OC7HjvWVdijGS98rlPJdfZwgdFDrcG2A6nfy8/TS6ir7CG7uo1jmsfYzR
         wAKp1qczo/V0EHdN+idsJDChhPCsDRICPskLQ9W17jMG+H2SqlTFkzM9l4DookJCaQa8
         OGJA9nd5bPmCKHJUmlKsZcfC+FnBrBmaJeCVTSqGW9/BusPslg4LUBJGZAANmS3FfJC9
         5dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8q2+VET2eajqK3GJ1OZqDgdE8FY+4FkTKTcCYqMTWi4=;
        b=zWs4n6TrU5Nd8UIwsAg+5rc1QTKle2HL2Rr8jT75wvbZGhOUYFtzj4O1copEM4RSLC
         CsQ1Gq5oTrzqryXfxb15IZzGCI78HnDYbsV0xgfGKYaAurcUPGO5v/m2lKCg5wep+F9B
         gOHQxVS0ewFt7p91i8KnF3K7wA7aL+vjM9YhRuEzBwyUepRki1WJd6a9sof92jTKHXZE
         m3McAlJ3x5USu4kwSLXEvYVwaeLuYC2CJScGl4gVwWGQJuH6kVsxOouab+1OEryBgFHo
         q4ByM9SmhAZ7lFPAewdsCGvOXoAYAXi3gedAnuC+yeUWqoBPRYOo2iJ52yvMsrUW2g9T
         dypQ==
X-Gm-Message-State: AOAM530RaMw9kWirAPw9gQCGzbotxYcrb0ogR8uTST8OzylLACh5YUUU
        hB0AUxVXd9SFjRDnRQTJGCkrczdpuTk9iGjAgJxbgzSnrRXWvQ==
X-Google-Smtp-Source: ABdhPJz7f/E5M/rv4m6Y3TIuDHyS7l8wtOMp9pqs25FUS/e36Jca1NRlQuIlDxC72LMQVewHjLP/w9P0iEte+XouWZY=
X-Received: by 2002:a05:6602:26d3:b0:63d:aa17:8742 with SMTP id
 g19-20020a05660226d300b0063daa178742mr10166726ioo.198.1645911496848; Sat, 26
 Feb 2022 13:38:16 -0800 (PST)
MIME-Version: 1.0
References: <20220226123755.85213-1-masahiroy@kernel.org>
In-Reply-To: <20220226123755.85213-1-masahiroy@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 26 Feb 2022 22:37:40 +0100
Message-ID: <CA+icZUUm1zpbSyOW3xKUsqo9bBjAehw6KvVBjGxpYy4XBjO4yw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: change .config format to use =n instead of "is
 not set"
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Feb 26, 2022 at 2:34 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The .config file uses "# CONFIG_FOO is not set" form to represent
> disabled options. In the old days, it was useful because the .config
> was directly included from Makefiles. For example, you can use
> "ifdef CONFIG_FOO" in Makefiles to check if the option is enabled.
>
> Commit c955ccafc38e ("kconfig: fix .config dependencies") introduced
> include/config/auto.conf, which mirrors the .config, but trims down
> all disabled options.
>
> Since then, include/config/auto.conf defines CONFIG options during the
> build. The .config is used just for storing the user's configuration.
> I do not see a strong reason to use a particular pattern of comment
> for disabled options.
>
> With this commit, Kconfig will output disable options in a more natural
> form, "CONFIG_FOO=n".
>
> Kconfig accepts both "# CONFIG_FOO is not set" and "CONFIG_FOO=n" as a
> valid input. You do not need to update arch/*/configs/*_defconfig files
> for now. "git bisect" should be able to cross the commit in both ways
> without any issue.
>

Good.

Lot of people use/used the notation CONFIG_FOO=n, so did I.

Thanks for keeping the "compatibility" with old usage "# CONFIG_FOO is not set".

Normally, I use git diff (or scripts/diffconfig in Git tree) to
compare two kernel-configs, so seeing

-CONFIG_FOO=y
+CONFIG_FOO=n

...might be at first view unfamiliar/unusual.
With the old notation it was easier to see that Kconfig is unset.

Is this patch on top of kbuild-next Git?

( Untested )

- Sedat -

> A problem may occur if you parse the .config for the "# ... is not set"
> patterns.
>
> I adjusted streamline_config.pl, merge_config.sh, scripts/kconfig/tests/.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/kconfig/confdata.c                    | 15 +++++----------
>  scripts/kconfig/merge_config.sh               | 19 +++++++++++--------
>  scripts/kconfig/streamline_config.pl          |  2 +-
>  .../tests/choice/alldef_expected_config       |  6 +++---
>  .../tests/choice/allmod_expected_config       |  4 ++--
>  .../tests/choice/allno_expected_config        |  6 +++---
>  .../tests/choice/allyes_expected_config       |  8 ++++----
>  scripts/kconfig/tests/choice/oldask1_config   |  2 +-
>  .../tests/inter_choice/expected_config        |  2 +-
>  .../kconfig/tests/new_choice_with_dep/config  |  2 +-
>  .../tests/no_write_if_dep_unmet/__init__.py   |  7 +++----
>  .../no_write_if_dep_unmet/expected_config     |  2 +-
>  12 files changed, 36 insertions(+), 39 deletions(-)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index c4340c90e172..00f93c03aa57 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -658,9 +658,7 @@ static char *escape_string_value(const char *in)
>         return out;
>  }
>
> -enum output_n { OUTPUT_N, OUTPUT_N_AS_UNSET, OUTPUT_N_NONE };
> -
> -static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
> +static void __print_symbol(FILE *fp, struct symbol *sym, bool output_n,
>                            bool escape_string)
>  {
>         const char *val;
> @@ -672,11 +670,8 @@ static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
>         val = sym_get_string_value(sym);
>
>         if ((sym->type == S_BOOLEAN || sym->type == S_TRISTATE) &&
> -           output_n != OUTPUT_N && *val == 'n') {
> -               if (output_n == OUTPUT_N_AS_UNSET)
> -                       fprintf(fp, "# %s%s is not set\n", CONFIG_, sym->name);
> +           !output_n && *val == 'n')
>                 return;
> -       }
>
>         if (sym->type == S_STRING && escape_string) {
>                 escaped = escape_string_value(val);
> @@ -690,17 +685,17 @@ static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
>
>  static void print_symbol_for_dotconfig(FILE *fp, struct symbol *sym)
>  {
> -       __print_symbol(fp, sym, OUTPUT_N_AS_UNSET, true);
> +       __print_symbol(fp, sym, true, true);
>  }
>
>  static void print_symbol_for_autoconf(FILE *fp, struct symbol *sym)
>  {
> -       __print_symbol(fp, sym, OUTPUT_N_NONE, false);
> +       __print_symbol(fp, sym, false, false);
>  }
>
>  void print_symbol_for_listconfig(struct symbol *sym)
>  {
> -       __print_symbol(stdout, sym, OUTPUT_N, true);
> +       print_symbol_for_dotconfig(stdout, sym);
>  }
>
>  static void print_symbol_for_c(FILE *fp, struct symbol *sym)
> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
> index e5b46980c22a..aac60de3b7c7 100755
> --- a/scripts/kconfig/merge_config.sh
> +++ b/scripts/kconfig/merge_config.sh
> @@ -110,8 +110,11 @@ if [ ! -r "$INITFILE" ]; then
>  fi
>
>  MERGE_LIST=$*
> -SED_CONFIG_EXP1="s/^\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)=.*/\1/p"
> -SED_CONFIG_EXP2="s/^# \(${CONFIG_PREFIX}[a-zA-Z0-9_]*\) is not set$/\1/p"
> +SED_CONFIG_EXP="s/^\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)=.*/\1/p"
> +
> +# Disabled options were previously written as "# CONFIG_... is not set", but
> +# now is "CONFIG_...=n". Convert the format before the merge steps.
> +SED_CONVERT_NOT_SET="s/^# \(${CONFIG_PREFIX}[a-zA-Z0-9_]*\) is not set$/\1=n/"
>
>  TMP_FILE=$(mktemp ./.tmp.config.XXXXXXXXXX)
>  MERGE_FILE=$(mktemp ./.merge_tmp.config.XXXXXXXXXX)
> @@ -120,7 +123,7 @@ echo "Using $INITFILE as base"
>
>  trap clean_up EXIT
>
> -cat $INITFILE > $TMP_FILE
> +sed "$SED_CONVERT_NOT_SET" $INITFILE > $TMP_FILE
>
>  # Merge files, printing warnings on overridden values
>  for ORIG_MERGE_FILE in $MERGE_LIST ; do
> @@ -129,8 +132,8 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
>                 echo "The merge file '$ORIG_MERGE_FILE' does not exist.  Exit." >&2
>                 exit 1
>         fi
> -       cat $ORIG_MERGE_FILE > $MERGE_FILE
> -       CFG_LIST=$(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $MERGE_FILE)
> +       sed "$SED_CONVERT_NOT_SET" $ORIG_MERGE_FILE > $MERGE_FILE
> +       CFG_LIST=$(sed -n -e "$SED_CONFIG_EXP" $MERGE_FILE)
>
>         for CFG in $CFG_LIST ; do
>                 grep -q -w $CFG $TMP_FILE || continue
> @@ -155,9 +158,9 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
>                         echo Value of $CFG is redundant by fragment $ORIG_MERGE_FILE:
>                 fi
>                 if [ "$BUILTIN_FLAG" = "false" ]; then
> -                       sed -i "/$CFG[ =]/d" $TMP_FILE
> +                       sed -i "/$CFG=/d" $TMP_FILE
>                 else
> -                       sed -i "/$CFG[ =]/d" $MERGE_FILE
> +                       sed -i "/$CFG=/d" $MERGE_FILE
>                 fi
>         done
>         cat $MERGE_FILE >> $TMP_FILE
> @@ -191,7 +194,7 @@ make KCONFIG_ALLCONFIG=$TMP_FILE $OUTPUT_ARG $ALLTARGET
>
>
>  # Check all specified config values took (might have missed-dependency issues)
> -for CFG in $(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $TMP_FILE); do
> +for CFG in $(sed -n -e "$SED_CONFIG_EXP" $TMP_FILE); do
>
>         REQUESTED_VAL=$(grep -w -e "$CFG" $TMP_FILE)
>         ACTUAL_VAL=$(grep -w -e "$CFG" "$KCONFIG_CONFIG" || true)
> diff --git a/scripts/kconfig/streamline_config.pl b/scripts/kconfig/streamline_config.pl
> index 3387ad7508f7..0f20142764f2 100755
> --- a/scripts/kconfig/streamline_config.pl
> +++ b/scripts/kconfig/streamline_config.pl
> @@ -617,7 +617,7 @@ foreach my $line (@config_file) {
>      $_ = $line;
>
>      if (/CONFIG_IKCONFIG/) {
> -       if (/# CONFIG_IKCONFIG is not set/) {
> +       if (/# CONFIG_IKCONFIG is not set/ || /CONFIG_IKCONFIG=n/) {
>             # enable IKCONFIG at least as a module
>             print "CONFIG_IKCONFIG=m\n";
>             # don't ask about PROC
> diff --git a/scripts/kconfig/tests/choice/alldef_expected_config b/scripts/kconfig/tests/choice/alldef_expected_config
> index 7a754bf4be94..75d98d488488 100644
> --- a/scripts/kconfig/tests/choice/alldef_expected_config
> +++ b/scripts/kconfig/tests/choice/alldef_expected_config
> @@ -1,5 +1,5 @@
>  CONFIG_MODULES=y
> -# CONFIG_BOOL_CHOICE0 is not set
> +CONFIG_BOOL_CHOICE0=n
>  CONFIG_BOOL_CHOICE1=y
> -# CONFIG_TRI_CHOICE0 is not set
> -# CONFIG_TRI_CHOICE1 is not set
> +CONFIG_TRI_CHOICE0=n
> +CONFIG_TRI_CHOICE1=n
> diff --git a/scripts/kconfig/tests/choice/allmod_expected_config b/scripts/kconfig/tests/choice/allmod_expected_config
> index f1f5dcdb7923..ed8ffcb18a3a 100644
> --- a/scripts/kconfig/tests/choice/allmod_expected_config
> +++ b/scripts/kconfig/tests/choice/allmod_expected_config
> @@ -1,7 +1,7 @@
>  CONFIG_MODULES=y
> -# CONFIG_BOOL_CHOICE0 is not set
> +CONFIG_BOOL_CHOICE0=n
>  CONFIG_BOOL_CHOICE1=y
> -# CONFIG_OPT_BOOL_CHOICE0 is not set
> +CONFIG_OPT_BOOL_CHOICE0=n
>  CONFIG_OPT_BOOL_CHOICE1=y
>  CONFIG_TRI_CHOICE0=m
>  CONFIG_TRI_CHOICE1=m
> diff --git a/scripts/kconfig/tests/choice/allno_expected_config b/scripts/kconfig/tests/choice/allno_expected_config
> index b88ee7a43136..37b2749277dd 100644
> --- a/scripts/kconfig/tests/choice/allno_expected_config
> +++ b/scripts/kconfig/tests/choice/allno_expected_config
> @@ -1,5 +1,5 @@
> -# CONFIG_MODULES is not set
> -# CONFIG_BOOL_CHOICE0 is not set
> +CONFIG_MODULES=n
> +CONFIG_BOOL_CHOICE0=n
>  CONFIG_BOOL_CHOICE1=y
> -# CONFIG_TRI_CHOICE0 is not set
> +CONFIG_TRI_CHOICE0=n
>  CONFIG_TRI_CHOICE1=y
> diff --git a/scripts/kconfig/tests/choice/allyes_expected_config b/scripts/kconfig/tests/choice/allyes_expected_config
> index e5a062a1157c..a2b36c017ffb 100644
> --- a/scripts/kconfig/tests/choice/allyes_expected_config
> +++ b/scripts/kconfig/tests/choice/allyes_expected_config
> @@ -1,9 +1,9 @@
>  CONFIG_MODULES=y
> -# CONFIG_BOOL_CHOICE0 is not set
> +CONFIG_BOOL_CHOICE0=n
>  CONFIG_BOOL_CHOICE1=y
> -# CONFIG_OPT_BOOL_CHOICE0 is not set
> +CONFIG_OPT_BOOL_CHOICE0=n
>  CONFIG_OPT_BOOL_CHOICE1=y
> -# CONFIG_TRI_CHOICE0 is not set
> +CONFIG_TRI_CHOICE0=n
>  CONFIG_TRI_CHOICE1=y
> -# CONFIG_OPT_TRI_CHOICE0 is not set
> +CONFIG_OPT_TRI_CHOICE0=n
>  CONFIG_OPT_TRI_CHOICE1=y
> diff --git a/scripts/kconfig/tests/choice/oldask1_config b/scripts/kconfig/tests/choice/oldask1_config
> index b67bfe3c641f..f0a4e5e9f2c1 100644
> --- a/scripts/kconfig/tests/choice/oldask1_config
> +++ b/scripts/kconfig/tests/choice/oldask1_config
> @@ -1,2 +1,2 @@
> -# CONFIG_MODULES is not set
> +CONFIG_MODULES=n
>  CONFIG_OPT_BOOL_CHOICE0=y
> diff --git a/scripts/kconfig/tests/inter_choice/expected_config b/scripts/kconfig/tests/inter_choice/expected_config
> index 5dceefb054e3..4cf72e16f300 100644
> --- a/scripts/kconfig/tests/inter_choice/expected_config
> +++ b/scripts/kconfig/tests/inter_choice/expected_config
> @@ -1,4 +1,4 @@
>  CONFIG_MODULES=y
>  CONFIG_CHOICE_VAL0=y
> -# CONFIG_CHOIVE_VAL1 is not set
> +CONFIG_CHOIVE_VAL1=n
>  CONFIG_DUMMY=y
> diff --git a/scripts/kconfig/tests/new_choice_with_dep/config b/scripts/kconfig/tests/new_choice_with_dep/config
> index 47ef95d567fd..47599c856033 100644
> --- a/scripts/kconfig/tests/new_choice_with_dep/config
> +++ b/scripts/kconfig/tests/new_choice_with_dep/config
> @@ -1,3 +1,3 @@
>  CONFIG_CHOICE_B=y
> -# CONFIG_CHOICE_D is not set
> +CONFIG_CHOICE_D=n
>  CONFIG_CHOICE_E=y
> diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py b/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
> index ffd469d1f226..9ba7542d47d5 100644
> --- a/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
> +++ b/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
> @@ -2,14 +2,13 @@
>  """
>  Do not write choice values to .config if the dependency is unmet.
>
> -"# CONFIG_... is not set" should not be written into the .config file
> -for symbols with unmet dependency.
> +=n should not be written into the .config file for symbols with unmet
> +dependency.
>
>  This was not working correctly for choice values because choice needs
>  a bit different symbol computation.
>
> -This checks that no unneeded "# COFIG_... is not set" is contained in
> -the .config file.
> +This checks that no unneeded =n is contained in the .config file.
>
>  Related Linux commit: cb67ab2cd2b8abd9650292c986c79901e3073a59
>  """
> diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config b/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
> index 473228810c35..9d057fad723c 100644
> --- a/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
> +++ b/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
> @@ -2,4 +2,4 @@
>  # Automatically generated file; DO NOT EDIT.
>  # Main menu
>  #
> -# CONFIG_A is not set
> +CONFIG_A=n
> --
> 2.32.0
>
