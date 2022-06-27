Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488C255C8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbiF0RsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239557AbiF0RsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:48:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3216BC8E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:48:13 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a2so17933333lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aKB/QLCWmLrVGWONqEu+ORb8Q8cClKmFQluSXDoGZQ=;
        b=i6zQDWekT3tX0R35o7h69Vg58Aqg2ifNeXuz7vS/si1KOVWhvAIIiDsflaLJYiHEbF
         jtjOiSayX4xlpArK1PT3iJ27XuJWEt23imCAIL7lafzyP4kucEHso7QrpwhTX+6NvMNx
         06OBRaK2cA6nnRAqYFWF9D697LNkjqIH18dBawktIMAZNmNkD3GGiqrkHimod//LyRIe
         exFaGKq7UudYhVsmiYu2+S+0ZEqAu/o0h69JuVOSCoKmeIasfVhfLSBrK+SEe4+NbeOl
         FEIF1cSbWGeOfLw9LXKWx/fDHD6VK2Vl4uEc5LPQ25b3Qsnbb8BI80sfLOKzhgCKfbRX
         glFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aKB/QLCWmLrVGWONqEu+ORb8Q8cClKmFQluSXDoGZQ=;
        b=vPK3RlTcwCs2/iuNW3MVjICm+rZNQ2/ooN0jYw7swzXEALTTfvYb49s35279r+L9U/
         Sj5PX4Or8XG8FyiE5BfmqvuS+2Abslx9aJtF6yjR5RLhVx6wN6dIMk8XU86S8WcCfAsF
         5BC/AF7Tb3+dslQbwYMei40YTuB3qtqTtcoYce9JTDWgzIh6uQwPDZyUrADZTNfpPTIl
         AVmHQZr8H0i3VEbW8dyABCos1ZJEKidgnAnhihxTOwRu1Jdh1jJiR3Ah/rR9FNIJYyb6
         r4SZDzD4wDTerkklX9Ij8plzlOL5DZANQbrbb8IwtfNhZY4yB7ztL6H0RTCCi0ZqGpTz
         jMww==
X-Gm-Message-State: AJIora9/lLBQ9igS8pH2BzODNVTRE1L47AHOZ5magWDuxtDzU0QUZk4s
        SAxCYVgVKBSxh4rVXTKXTObCRv8qTV59pGknj1qVpw==
X-Google-Smtp-Source: AGRyM1vOwBmc/srzedpGTqPpTfRqYGh2g1w/wn6UMZGTSUFahPMJtlm9T22FvntsocrRqlh0nhqWSfHHdvpG1QdZLwU=
X-Received: by 2002:ac2:495d:0:b0:47f:a2bc:762c with SMTP id
 o29-20020ac2495d000000b0047fa2bc762cmr8801666lfi.93.1656352091777; Mon, 27
 Jun 2022 10:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220618005457.2379324-1-vipinsh@google.com>
In-Reply-To: <20220618005457.2379324-1-vipinsh@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Mon, 27 Jun 2022 10:47:35 -0700
Message-ID: <CAHVum0euKMV+rCLXMQ4NuDAqowyeCkO1LheSafR2tm=R4aUfJw@mail.gmail.com>
Subject: Re: [PATCH] scripts/tags.sh: Include tools directory in tags generation
To:     gregkh@linuxfoundation.org, rkovhaev@gmail.com
Cc:     dmatlack@google.com, linux-kernel@vger.kernel.org
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

On Fri, Jun 17, 2022 at 5:55 PM Vipin Sharma <vipinsh@google.com> wrote:
>
> Add tools directory in generating tags and quiet the "No such file or
> directory" warnings.
>
> It reverts the changes introduced in commit 162343a876f1
> ("scripts/tags.sh: exclude tools directory from tags generation") while
> maintainig the original intent of the patch to get rid of the warnings.
> This allows the root level cscope files to include tools source code
> besides kernel and a single place to browse the code for both.
>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>
> I have found myself many times to browse tools and other part of the
> kernel code together. Excluding tools from the root level cscope makes
> it difficult to efficiently move between files and find user api
> definitions.
>
> Root cause of these warning is due to generated .cmd files which use
> relative paths in some files, I am not sure how to make them absolute
> file paths which can satisfy realpath warnings. Also, not sure if those
> warnings are helpful and should be kept. Passing "-q" to realpath seems
> easier solution. Please, let me know if there is a better alternative.
>
> Thanks
>
>  scripts/tags.sh | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index 01fab3d4f90b5..e137cf15aae9d 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -25,13 +25,6 @@ else
>         tree=${srctree}/
>  fi
>
> -# ignore userspace tools
> -if [ -n "$COMPILED_SOURCE" ]; then
> -       ignore="$ignore ( -path ./tools ) -prune -o"
> -else
> -       ignore="$ignore ( -path ${tree}tools ) -prune -o"
> -fi
> -
>  # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
>  if [ "${ALLSOURCE_ARCHS}" = "" ]; then
>         ALLSOURCE_ARCHS=${SRCARCH}
> @@ -100,7 +93,7 @@ all_compiled_sources()
>                 find $ignore -name "*.cmd" -exec \
>                         grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
>                 awk '!a[$0]++'
> -       } | xargs realpath -es $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
> +       } | xargs realpath -esq $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
>         sort -u
>  }
>
> --
> 2.37.0.rc0.104.g0611611a94-goog
>

Hi Greg,

Any update on the patch?

Thanks
Vipin
