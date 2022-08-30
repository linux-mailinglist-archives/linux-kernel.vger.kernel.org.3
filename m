Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEA85A6F12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiH3VXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiH3VXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:23:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF13F32D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:23:16 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j14so6936721lfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Un8D+RzoqoDUZVj/+1gveT/n77oAnfjQBOt6BHJvn2c=;
        b=fGy0gzgjiZ+53KOeASW0wrxA5YqP8wgYcrG1eR/loYwSPFjuCdKYFJ62OU7yHQ+0ka
         o8e+A/1BsHDB5g9vdtI6G0sHtgJkat3w3QyA2bphzWW1/EpS6xzQnJDcSpz/pyAQtfI1
         M30PdRC5OmXfwEXGYzk0zNCnvCcyIO4Lr/tvdc0D7uDFrL01MnE1JACO+d+33BcAbCRM
         XiNI4kMQD5Ub0jGMnogmwuYO8Uf+qFdg+IpNtarFA4ZtXmcHPSPFHpjKc+PsDOvXIGkl
         FmVvwr7R6Sx7SuznxdjpC8dFiPbE7jXN8J3Ymf0jA9ZYZDtuFy+CrG8ZT4dVBZP9Kjqm
         5EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Un8D+RzoqoDUZVj/+1gveT/n77oAnfjQBOt6BHJvn2c=;
        b=j66ZY1frHAeYcf4qOm+nKZUtneCTXAIn9BYsSDOdZNk3j+dcrc0wHgtHvaOBwRxW+2
         wrEW0Sy8LhWPX0jglvUDjiakdjZxByqwg33VjtANzxKITkKFznqoADc5JBBO1lbQ4aP9
         miVoA1cehgzKkpM/tqgwpoA9u+xA9YnGivocnlSh3MVvsqirKa5lEQS5c6gcJfNH0b0I
         1tu3QYlCwP4Np3SLwwdoLKKlpLqQ0z3lI1TyQNdGvRkwSRnKiOgw/qRNaUF4w7YHjOzd
         igvwZrtYak09o25fviKsp5A4DckJTBqHeAp/jVbv8ZPrlIRnuRvhWIoeaWH/2GowWr4o
         7eYA==
X-Gm-Message-State: ACgBeo20KrTkm5Q8Y+jVrc+cTt7nxsMi000XapAX4tLqIPgvgPwo8+dO
        sImyQ766YkqiAJMSNYxQzHB5vLdxA/ZfsUvAWdEbC4KSP8U0EA==
X-Google-Smtp-Source: AA6agR64s8JEMC5T5a0Ai1fiyPfmvH5US21eWBVd68Tgd2kr0cXRr6/uoKT0hGc49vAteJ/2bT56Ey4Ef8aytqi1Dqo=
X-Received: by 2002:a05:6512:158b:b0:48b:38:cff8 with SMTP id
 bp11-20020a056512158b00b0048b0038cff8mr7716291lfb.100.1661894594746; Tue, 30
 Aug 2022 14:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220830190811.323760-1-masahiroy@kernel.org>
In-Reply-To: <20220830190811.323760-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 30 Aug 2022 14:23:03 -0700
Message-ID: <CAKwvOdnuAZqv1B3AZHSD+WzHXK_Fg+9xWJNYPVhXNxoYXam0hQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: raise minimum supported version of
 binutils to 2.25.1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Tue, Aug 30, 2022 at 12:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Binutils 2.23 was released in 2012. Almost 10 years old.
>
> We already require GCC 5.1, which was released in 2015.
>
> Bump the binutils version to 2.25.1, which was also released in 2015.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Documentation/process/changes.rst | 4 ++--

This document has also been translated into Italian. Let's keep them in sync?
Documentation/translations/it_IT/process/changes.rst

Either way.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

grepping for binutils shows lots of potentially stale references to
even older versions of binutils. There may be more cleanups lurking
than just the ppc ld-ifversion check.


>  scripts/min-tool-version.sh       | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 19c286c23786..5fb6a60677ef 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -33,7 +33,7 @@ GNU C                  5.1              gcc --version
>  Clang/LLVM (optional)  11.0.0           clang --version
>  GNU make               3.81             make --version
>  bash                   4.2              bash --version
> -binutils               2.23             ld -v
> +binutils               2.25.1           ld -v
>  flex                   2.5.35           flex --version
>  bison                  2.0              bison --version
>  pahole                 1.16             pahole --version
> @@ -94,7 +94,7 @@ Bash 4.2 or newer is needed.
>  Binutils
>  --------
>
> -Binutils 2.23 or newer is needed to build the kernel.
> +Binutils 2.25.1 or newer is needed to build the kernel.
>
>  pkg-config
>  ----------
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 250925aab101..8b1edd1f7281 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -14,7 +14,7 @@ fi
>
>  case "$1" in
>  binutils)
> -       echo 2.23.0
> +       echo 2.25.1
>         ;;
>  gcc)
>         echo 5.1.0
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
