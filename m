Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECCB5624BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiF3VBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbiF3VBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:01:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7944D160
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:01:05 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o23so162041ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZFkOJbXe9nmFRGKnxbAJYpcg18CME76O0E+IzUSCG8=;
        b=GGPZarUrkc2Zm9hlgshU1fPpAcTlWk9nVnNzAV5EgyAziyVDpcU4BEopOU2uW+9NvL
         uYjo4P7zY+4bW9UnVW86RlM6EI9T1AkYt46ylkqDQZmnYA/aqUPG2O/XqI99DDjUfZ+c
         ndBsjQ777kE1E15si3CtwtuwSLCdUGNhO9Ei9PsW939T+qSLpDenPO41LEcRExH0MnWB
         w8MF801q6aGpEduv1XeHuEq0VlW8w7LbE2HixkheLwanam5tEoLZy+hb2RVgHNd9NosU
         W/erzJr4/snxak35Q+XpK5u/yNxVWiBRrjCJpdjDiSFRQP8x5IMsP/b9nMw9f2FP4hv4
         NiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZFkOJbXe9nmFRGKnxbAJYpcg18CME76O0E+IzUSCG8=;
        b=3UFlEC2k8ioaffK4t1FBlEKBQWsV+BzGsLHqaMND8LDtOkfoOTN002TyyIai2IikpO
         MqeltyzAQp/T/mZaBzX8SXRA9iOEYvql5UyX9YcuxiHEJW6VPJJjFm2PpsNgwWHesFuK
         zrZs7QiEMrOJBrwD5vKT5oZfJeNWAx/WYHvE/AazpRF3nAyO9i/u92F6lznfgJ5dTEVj
         oRccW76X62O2AbIp+y6zT0dFkvrhJy2rGDJjSMQXkd2nUILBZBmSm3NVYxx87DKfLB3O
         vFyhrhx5LpW1CeE6K0OJmzjcY/JELxjJsdM9aND7FR9j/AZkQBiZhGIiqriT4yg7rcJO
         YjAw==
X-Gm-Message-State: AJIora/q++iFwhrMW7Kb1eshpjPhxkVmRFJnfElRRnuW9b8i8XrNk1ej
        QuE0TfPTJX/87R/WrdFQGI716fERKrfoxZNWMujMtA==
X-Google-Smtp-Source: AGRyM1tGB92DSGZlsUKGAkYURVePihudY6if9FjJiAEYO7lZo8o+tJdQ8QEMN43dPrHtcJRjyFb92KaQgBIYOedfpXo=
X-Received: by 2002:a2e:8e94:0:b0:25a:83fd:eeec with SMTP id
 z20-20020a2e8e94000000b0025a83fdeeecmr6438933ljk.493.1656622862490; Thu, 30
 Jun 2022 14:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220630081846.317517-1-masahiroy@kernel.org>
In-Reply-To: <20220630081846.317517-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Jun 2022 14:00:51 -0700
Message-ID: <CAKwvOdm=Ee9aJ7R18-zD06+ZubdTWsypkfR19kJ_6G7YaS9jhw@mail.gmail.com>
Subject: Re: [PATCH] Revert "scripts/mod/modpost.c: permit '.cranges' secton
 for sh64 architecture."
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Jun 30, 2022 at 1:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This reverts commit 4d10c223baab8be8f717df3625cfece5be26dead.
>
> Commit 37744feebc08 ("sh: remove sh5 support") removed the sh64 support
> entirely.
>
> If ".cranges" section is used for other architectures, it is easy to
> get it back.

I don't think that will be an issue. BFD has a comment about this
being a sh64-only section.  I couldn't find any other reference to
such a section.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 620dc8c4c814..e15227ee58fc 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -742,7 +742,6 @@ static const char *const section_white_list[] =
>  {
>         ".comment*",
>         ".debug*",
> -       ".cranges",             /* sh64 */
>         ".zdebug*",             /* Compressed debug sections. */
>         ".GCC.command.line",    /* record-gcc-switches */
>         ".mdebug*",        /* alpha, score, mips etc. */
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
