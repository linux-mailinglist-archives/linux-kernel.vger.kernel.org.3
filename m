Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52169524457
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347533AbiELEhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbiELEhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:37:23 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0861126135;
        Wed, 11 May 2022 21:37:21 -0700 (PDT)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 24C4b545004064;
        Thu, 12 May 2022 13:37:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 24C4b545004064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652330226;
        bh=tkmfQXshct+rM5sNv86ojAR4iOGgSUB8H7eo3J48fKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UDf+KO+3kbwc37QIFSTV9bWAie+41gj2MeWrvLn98PFJeT68eleeY1AM7wSMxRyjU
         pPRvHVuTnkFix5D9kRIO45SdX/nvQQK1u5W7hb+YlXwaIc0eeRvA9RwDQSylp1+Rw0
         tSiITqUwWvLrx8H7s02aElsbROkTZEgun44WETgkYURxTeWPvY7S+12mOG+cdcCD7G
         q5xMLcI5JElKBcX3fWFRmxP+H0bOsKaLY1zOYZ3TWa6HI+pXOIz+m8XJYQLmoHFdl1
         lqNwhC1lG914gG/BmaAp50Ceg3Mk0V74KjqxzZzakr8LRAdYV/3YtH2W2wFjIN4Xeu
         pZDKO9J8l2e7Q==
X-Nifty-SrcIP: [209.85.216.51]
Received: by mail-pj1-f51.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso3865616pjg.0;
        Wed, 11 May 2022 21:37:06 -0700 (PDT)
X-Gm-Message-State: AOAM5316uxQIGld6VZmgJkqr2jA820EYKMY4fmV4O6TMMr7NeQ4ohFYR
        zgqVBTtSfXRFdYWZfQNFiHgzG2oU6HOm/VNVMs4=
X-Google-Smtp-Source: ABdhPJzNzRosrbp98/vX8YbqZjlsEylacSahmJ3sX4Wd7I5BkGLdD5OHiq8O2NX6qWNfI9oi2eO8MzjRgcclDO8j9pE=
X-Received: by 2002:a17:902:7891:b0:15e:cae9:7620 with SMTP id
 q17-20020a170902789100b0015ecae97620mr28744958pll.136.1652330225331; Wed, 11
 May 2022 21:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220508190631.2386038-1-masahiroy@kernel.org> <20220508190631.2386038-2-masahiroy@kernel.org>
In-Reply-To: <20220508190631.2386038-2-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 May 2022 13:35:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3+rZTzt1Ed-V_pjA8wEFEVj7Uxo8PTtEhdyzFcqqM+g@mail.gmail.com>
Message-ID: <CAK7LNAT3+rZTzt1Ed-V_pjA8wEFEVj7Uxo8PTtEhdyzFcqqM+g@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] modpost: remove left-over cross_compile declaration
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 4:09 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This is a remnant of commit 6543becf26ff ("mod/file2alias: make
> modalias generation safe for cross compiling").
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Applied to linux-kbuild.


>
> Changes in v4:
>   - New patch
>
>  scripts/mod/modpost.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index cfa127d2bb8f..d9daeff07b83 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -174,7 +174,6 @@ static inline unsigned int get_secindex(const struct elf_info *info,
>  }
>
>  /* file2alias.c */
> -extern unsigned int cross_build;
>  void handle_moddevtable(struct module *mod, struct elf_info *info,
>                         Elf_Sym *sym, const char *symname);
>  void add_moddevtable(struct buffer *buf, struct module *mod);
> --
> 2.32.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20220508190631.2386038-2-masahiroy%40kernel.org.



-- 
Best Regards
Masahiro Yamada
