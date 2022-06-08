Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F419543BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiFHS73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiFHS70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:59:26 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C9C3BBF5;
        Wed,  8 Jun 2022 11:59:23 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n144so6814659iod.4;
        Wed, 08 Jun 2022 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=tNp7Xl2ONrziHqUHN3+KG6+K6ACxMxBGEDZRaVtiLTM=;
        b=a0WGY7pQV78GAPPNOoarbrKvv7WINsDSERS1fqq5UgLMq08+sgzqzn07+h0aeSZ6q/
         0ZKXzXAmt3MPxgUgIzAq3lNkrRor9WRQvHAlBmheIg7tcU7SPknO7gJcCn2p0T+Corg0
         thumiRq31tj4NczQLAUSmkZ7EHQb938f+O88bHiTQd+72vVZAyrnvqHQJ91w1UsaiYRb
         NjgYOdfLNvkWBCrZWUuKWMaFYQrwJ56hDLlzkT2T+7ubq8RiQzLNwjfjcjUBIHwbRYz1
         yf/Y/bKDiWCFC0hI0+eUiLNUE+9iNwt0xgrzNg9/7fZ0WP9DfQFC3gaowf2fBdZ+VOg3
         q8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=tNp7Xl2ONrziHqUHN3+KG6+K6ACxMxBGEDZRaVtiLTM=;
        b=79PlYE2meb+4OCFtjYPpBVnHgNfkOuM0Vc6GBGwLkhnWJjSo34wIUTIdfJ0NMS4E+w
         9crTrEzvE+cxit4VBhX3bh+2HTT1xZT8s5X/VN1WW8uTuRV9+96AEkn2cdbNbbmymA30
         0/uaXCcfj6+8KLQS2Zd3x7fA4oVA/yYuNG+cYXtrRcMuJo9m4fW/m5b3hTZ1vV9qtrhD
         zuNUVYzjPhSlPLw6Eo63xRT7smGHYXETFD8o+hrKTOi2shNHM1sSVN0f6Z/RH79uW+KF
         HGcbTq70JXk1SGtiXzM2ilLiBqeYnxs2GkJ5ooCtKBZrOAS1waxO7pRqmmJPUxSuyliI
         eJ5w==
X-Gm-Message-State: AOAM5328RKLIXVdqJl49PCOi+mfSa/ae1BPEfrMAl/CoZRtOhZfWekkQ
        MucC2dGFghknnX+9fVGk+uHzww53sim3EvUPIYu350ZSahs=
X-Google-Smtp-Source: ABdhPJxW16OjrGGZX5DLArE4S3AkQBk7HcuXW56Q+3T+RvHRclRPf7qXKU+SvumA9DgtpOYz6RFLybaDKm7OvZpBPCQ=
X-Received: by 2002:a05:6638:1415:b0:331:d318:83ab with SMTP id
 k21-20020a056638141500b00331d31883abmr4969324jad.126.1654714762766; Wed, 08
 Jun 2022 11:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <368129160298161a9eb40ad4f489458be6be3b6f.1654569774.git.kevin@kevinlocke.name>
In-Reply-To: <368129160298161a9eb40ad4f489458be6be3b6f.1654569774.git.kevin@kevinlocke.name>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 8 Jun 2022 20:58:46 +0200
Message-ID: <CA+icZUXEswwLtmz-njhJydO33tcAPSnZ5PJkfigzpFrQ6pzP4Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: avoid regex RS for POSIX awk
To:     Kevin Locke <kevin@kevinlocke.name>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Jun 7, 2022 at 7:31 AM Kevin Locke <kevin@kevinlocke.name> wrote:
>
> In 22f26f21774f8 awk was added to deduplicate *.mod files.  The awk
> invocation passes -v RS='( |\n)' to match a space or newline character
> as the record separator.  Unfortunately, POSIX states[1]
>
> > If RS contains more than one character, the results are unspecified.
>
> Some implementations (such as the One True Awk[2] used by the BSDs) do
> not treat RS as a regular expression.  When awk does not support regex
> RS, build failures such as the following are produced (first error using
> allmodconfig):
>
>       CC [M]  arch/x86/events/intel/uncore.o
>       CC [M]  arch/x86/events/intel/uncore_nhmex.o
>       CC [M]  arch/x86/events/intel/uncore_snb.o
>       CC [M]  arch/x86/events/intel/uncore_snbep.o
>       CC [M]  arch/x86/events/intel/uncore_discovery.o
>       LD [M]  arch/x86/events/intel/intel-uncore.o
>     ld: cannot find uncore_nhmex.o: No such file or directory
>     ld: cannot find uncore_snb.o: No such file or directory
>     ld: cannot find uncore_snbep.o: No such file or directory
>     ld: cannot find uncore_discovery.o: No such file or directory
>     make[3]: *** [scripts/Makefile.build:422: arch/x86/events/intel/intel-uncore.o] Error 1
>     make[2]: *** [scripts/Makefile.build:487: arch/x86/events/intel] Error 2
>     make[1]: *** [scripts/Makefile.build:487: arch/x86/events] Error 2
>     make: *** [Makefile:1839: arch/x86] Error 2
>
> To avoid this, use printf(1) to produce a newline between each object
> path, instead of the space produced by echo(1), so that the default RS
> can be used by awk.
>
> [1]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/awk.html
> [2]: https://github.com/onetrueawk/awk
>
> Fixes: 22f26f21774f ("kbuild: get rid of duplication in *.mod files")
> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)

-Sedat-

> ---
>  scripts/Makefile.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 1f01ac65c0cd..cac070aee791 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -251,8 +251,8 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
>
>  # To make this rule robust against "Argument list too long" error,
>  # ensure to add $(obj)/ prefix by a shell command.
> -cmd_mod = echo $(call real-search, $*.o, .o, -objs -y -m) | \
> -       $(AWK) -v RS='( |\n)' '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
> +cmd_mod = printf '%s\n' $(call real-search, $*.o, .o, -objs -y -m) | \
> +       $(AWK) '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
>
>  $(obj)/%.mod: FORCE
>         $(call if_changed,mod)
> --
> 2.35.1
>
