Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C544AC038
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389249AbiBGNvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387223AbiBGNrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:47:51 -0500
Received: from condef-04.nifty.com (condef-04.nifty.com [202.248.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B97FC043181;
        Mon,  7 Feb 2022 05:47:50 -0800 (PST)
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-04.nifty.com with ESMTP id 217DjHnk028207;
        Mon, 7 Feb 2022 22:45:17 +0900
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 217DipVo022226;
        Mon, 7 Feb 2022 22:44:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 217DipVo022226
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644241492;
        bh=QUV0hp+xB/5tu9Im52sNMR58mRLFLhMZGaIvBrJvw+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nbGi8UszpMuf1YuXNXjb4bnFhY+c9dLrABng6IGMik7U4321n/7HbUJiEz0rSAuDC
         6cD4A4QDQ5ZU+ZIB75NLw9biK8HJe7RvuCE6Oaeah8sBtulkHBzMZaJ8ZqccnvR94T
         8QHeSyXccMD9FivQxZQGxxCazVcbFqbzQ7w0olPVGraN8HduDChc5E+KU+1iik4bN4
         RbJ84oePIAp5VJe3sLn6qaSWVUjD15FoE3+552Fyqti31sjqQKNUXnqw13oGq4IG/9
         Mln10pW/GTzDiusmCo5z6XHTdkO+l0XGMWniv/oLV5MWBUqeAn5Nbur2rn3TDOHf/2
         m6XeKpUxo8I+g==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id p22-20020a17090adf9600b001b8783b2647so7391102pjv.5;
        Mon, 07 Feb 2022 05:44:51 -0800 (PST)
X-Gm-Message-State: AOAM530WE848O1SolBsVKEVFNF6ZZb6/8pvz4oMm0Bq6Xar8WVOofkpr
        rjl/ndOur2T772pNwIXXNB4EMCtAEppOeT0YQew=
X-Google-Smtp-Source: ABdhPJwoBSTLjNxzRqh4wM22ZLkK8Kabb+gW2Gmp9KwL9maZhBzOFDPATsJn2nYLB4bdQjZ3p4Q6cWFtQph98OF4fnk=
X-Received: by 2002:a17:90b:1647:: with SMTP id il7mr18618035pjb.119.1644241491011;
 Mon, 07 Feb 2022 05:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20220128220131.10956-1-brenda.streiff@ni.com>
In-Reply-To: <20220128220131.10956-1-brenda.streiff@ni.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 7 Feb 2022 22:44:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNASdD=xHb24sj80CsG90QVDBXFhFV10MvybdwGf2xx27Kw@mail.gmail.com>
Message-ID: <CAK7LNASdD=xHb24sj80CsG90QVDBXFhFV10MvybdwGf2xx27Kw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: let 'shell' return enough output for deep path names
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 7:02 AM Brenda Streiff <brenda.streiff@ni.com> wrot=
e:
>
> The 'shell' built-in only returns the first 256 bytes of the command's
> output. In some cases, 'shell' is used to return a path; by bumping up
> the buffer size to 4096 this lets us capture up to PATH_MAX.
>
> The specific case where I ran into this was due to commit 1e860048c53e
> ("gcc-plugins: simplify GCC plugin-dev capability test"). After this
> change, we now use `$(shell,$(CC) -print-file-name=3Dplugin)` to return
> a path; if the gcc path is particularly long, then the path ends up
> truncated at the 256 byte mark, which makes the HAVE_GCC_PLUGINS
> depends test always fail.
>
> Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>

Thanks, applied to linux-kbuild,
(but I dropped the change to tests)





> ---
>  scripts/kconfig/preprocess.c                                  | 2 +-
>  scripts/kconfig/tests/preprocess/builtin_func/Kconfig         | 3 +++
>  scripts/kconfig/tests/preprocess/builtin_func/expected_stdout | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
> index 0590f86df6e4..748da578b418 100644
> --- a/scripts/kconfig/preprocess.c
> +++ b/scripts/kconfig/preprocess.c
> @@ -141,7 +141,7 @@ static char *do_lineno(int argc, char *argv[])
>  static char *do_shell(int argc, char *argv[])
>  {
>         FILE *p;
> -       char buf[256];
> +       char buf[4096];
>         char *cmd;
>         size_t nread;
>         int i;
> diff --git a/scripts/kconfig/tests/preprocess/builtin_func/Kconfig b/scri=
pts/kconfig/tests/preprocess/builtin_func/Kconfig
> index baa328827911..e9791a97f731 100644
> --- a/scripts/kconfig/tests/preprocess/builtin_func/Kconfig
> +++ b/scripts/kconfig/tests/preprocess/builtin_func/Kconfig
> @@ -25,3 +25,6 @@ $(warning,$(shell,printf 'hello\nworld\n\n4\n\n\n'))
>  # 'lineno' to the line number.
>  $(warning,filename=3D$(filename))
>  $(warning,lineno=3D$(lineno))
> +
> +# 'shell' can return more than 256 bytes of output
> +$(info,$(shell,printf 'hello%01024dworld\n' '0'))
> diff --git a/scripts/kconfig/tests/preprocess/builtin_func/expected_stdou=
t b/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
> index 82de3a7e97de..8e03e4dfe8f6 100644
> --- a/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
> +++ b/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
> @@ -1 +1,2 @@
>  hello world 0
> +hello0000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000world
> --
> 2.20.1
>


--=20
Best Regards
Masahiro Yamada
