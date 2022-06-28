Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA755EC64
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiF1STg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiF1ST0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:19:26 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CB11FCDE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:19:25 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id n15so15907755ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x67D86P08gZAk0fy/7+SSenQLOYBeozWxcHLqMOhLfI=;
        b=nJwaYdp/kOzT40dVHVSiMQwKsKylKgCXY3gHRylZMWNYOpSezYGtaiNCcOsA4knN7G
         KcxLm7S4ATT+FiSTtushtsrAP5JdM1neZLNF4qxdKoEELCAVsq5lDPf4OZ1Jsal6DMgU
         pyKH1NKLQZ+b17yaatEmGqYZM8xCVEzDb7zjt94J4CKpw/JOzzjJ4xWeFooYZzqal7P6
         t7HXddxpGLS0Nf5+m3hZyLuhEusBg6I2OnNtm7Ct0HEXznQCqPfraa4sBm293zLafBVf
         L0w0GCCnKCqXZxkuvZUocSdiEWkRSpNfGNXdLF97JZPI7uo8868PABqZRY3nPHJ7bNpt
         xjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x67D86P08gZAk0fy/7+SSenQLOYBeozWxcHLqMOhLfI=;
        b=HyKD3KSZJr5fe1YJJR5pkXUSiZzhlS01A/Uv7T04P4+1B30hqrHnglPO4oEy+ChztP
         ONoy0fpVb00OR8Q0fKLyWY0depTQoSWJiuajNYLAZPRJqoI+iia+/ej5IudHSE2+4oei
         IDDvaqjsA2g5ymlu1tX2bzFYpJ2UpVBVXq7/oQKkfYLg/7/X/wA0g6oUlFPnyA4mG4AQ
         o50J2SJKYB1GntTmT9B55Xqyhal2vgi9i8UEs9cHjprJiRMwH4qPP6sLOB6/1A++GBhU
         4AM5VXl10Ith5bXNtb0K5BWRFxqJMFwkagGULO6jIn1FiKutjwtLiotmqszQF2z9Kbci
         r/Ww==
X-Gm-Message-State: AJIora+IF51dPR9KPTuocL39+MxRL4qtC/Z0hi2VglmOWYshuLO4g9N8
        VuDt7B1rE9Gjr23aPA/yZjPJhr2vM88lGuLifidn8g==
X-Google-Smtp-Source: AGRyM1tS1HC2P6+Qb5S2KcWB5fOHPNiTC6yOmmHqtPBTHntQ4GjxQxv5CNoVy8rmLDpgkRe3VWH5lYBzceCegBKXJ6M=
X-Received: by 2002:a2e:8555:0:b0:25a:7efc:4670 with SMTP id
 u21-20020a2e8555000000b0025a7efc4670mr10755368ljj.513.1656440363944; Tue, 28
 Jun 2022 11:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <1656314828-3544-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1656314828-3544-1-git-send-email-yangtiezhu@loongson.cn>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 28 Jun 2022 11:19:12 -0700
Message-ID: <CAKwvOdnmtGCUyxw4eXCyjp3nPAHZQ1v3Ui2ELXRNWpceCYsMyQ@mail.gmail.com>
Subject: Re: [PATCH v2] modpost: Add line break in the section mismatch warning
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernelci@groups.io
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

On Mon, Jun 27, 2022 at 4:46 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> The section mismatch warning may be too long, add a line break
> to make it more readable.
>
> Without this patch:
>
>   LD      vmlinux.o
>   MODPOST vmlinux.symvers
> WARNING: modpost: vmlinux.o(___ksymtab+prom_init_numa_memory+0x0): Section mismatch in reference from the variable __ksymtab_prom_init_numa_memory to the function .init.text:prom_init_numa_memory()
> The symbol prom_init_numa_memory is exported and annotated __init
> Fix this by removing the __init annotation of prom_init_numa_memory or drop the export.
>
> With this patch:
>
>   LD      vmlinux.o
>   MODPOST vmlinux.symvers
> WARNING: modpost: vmlinux.o(___ksymtab+prom_init_numa_memory+0x0): Section mismatch in reference
> from the variable __ksymtab_prom_init_numa_memory to the function .init.text:prom_init_numa_memory()
> The symbol prom_init_numa_memory is exported and annotated __init
> Fix this by removing the __init annotation of prom_init_numa_memory or drop the export.

This might aggravate the ability of scripts parsing build logs for
"warning:" case insensitive to accurately report what the warning is.

>
> This is based on Linux 5.19-rc4.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> v2: update the commit message
>
>  scripts/mod/modpost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 620dc8c..4cc894f 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1320,8 +1320,8 @@ static void report_sec_mismatch(const char *modname,
>         get_pretty_name(from_is_func, &from, &from_p);
>         get_pretty_name(to_is_func, &to, &to_p);
>
> -       warn("%s(%s+0x%llx): Section mismatch in reference from the %s %s%s "
> -            "to the %s %s:%s%s\n",
> +       warn("%s(%s+0x%llx): Section mismatch in reference\n"
> +            "from the %s %s%s to the %s %s:%s%s\n",
>              modname, fromsec, fromaddr, from, fromsym, from_p, to, tosec,
>              tosym, to_p);
>
> --
> 2.1.0
>


-- 
Thanks,
~Nick Desaulniers
