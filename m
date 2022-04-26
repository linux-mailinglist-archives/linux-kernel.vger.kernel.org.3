Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530E0510356
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352931AbiDZQdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353007AbiDZQdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:33:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0221E211
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:30:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s27so6980177ljd.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yq22b/HAxllmL6hgEgORnDmMTH7ARb+QJMH7dTolZlM=;
        b=f9JX3iL//TVo3SLhOeUU2LpFUmTDH96Lj++Z7olpnXao0zd/qV0kZifymTBhBvYooF
         V0KYkCiAuXXOndmp1SvYwVMwnKgeris7HxkMU8406kMsx0IbidjY+T4MkQNUIgGGNCbp
         QYzHFKqYoE+XTPOE/CSSn2+6n8s/6tmFzijWaJ7pl+2rKbP/NFgG7b+rv48DqWvELyUA
         ZjwwDQUZBg/2Rhz5V2y0ykguM5AlHWs5klwjHaA48vgvS2BBoyJF3KKtSFW+Txyuxmr1
         Wl4dii6gNNZl2BmtBltdRHxSoS80T57ZZQbwuU8kuUzB+3tdxMNT3W7tDP0nM4ZsZ6hx
         kA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yq22b/HAxllmL6hgEgORnDmMTH7ARb+QJMH7dTolZlM=;
        b=RcY7YGMEqAjjzoqLMI6GGq55baeuGCZaPI4XEToA9z5ZUXla+GsKWBugnxjBypeVd2
         3rQiEwEzBHB9sgjS5Ib5U5ayWHa4+591ULR2dCw/UDtbFtCHDAitrIl5meDRdoPbePfd
         Xijvg/u2//isRrxX6Exbqzgf8Nl2Kd05wszn1Q7HykUTGh67Pbn1lYx0QzWC256OkDuv
         B4u3tpx4l2fza8ibYIy6yaNUn27mmF2HDQjoaMFhWkz/y1kTsi5SnJ0rRME6VawyqiEk
         5w38qNC83O5hpNMeNvE7Dw+R9u+nOy6W7rxu305VujzEfv8mmcLSRYlUWJaHKwVZvk4e
         4ciQ==
X-Gm-Message-State: AOAM533WUl9rXsSQ3pc1PVAzjyrnihlzfRC2vKjaXfUpJgyDb1oRnq3O
        /KQPrRTWGMV3fFVNe8ip9yVr8lUIx7rge069lI9f4b0+frA=
X-Google-Smtp-Source: ABdhPJxtV0frJu8QtkHSjZ7G17y8dVCS1oHhbqWmGgnLfpgcLuyi2Q2tBOYlosgu/7IoqC6Uh3zrzYlorV3mbCXkJXs=
X-Received: by 2002:a05:651c:553:b0:24f:18c1:d2a1 with SMTP id
 q19-20020a05651c055300b0024f18c1d2a1mr3429125ljp.239.1650990601997; Tue, 26
 Apr 2022 09:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org> <20220424190811.1678416-8-masahiroy@kernel.org>
In-Reply-To: <20220424190811.1678416-8-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 Apr 2022 09:29:50 -0700
Message-ID: <CAKwvOd=Q5WK1790WZP7fj=jY8b2+u-rEnF6XC3uObYwTtYp_eA@mail.gmail.com>
Subject: Re: [PATCH 07/27] modpost: import include/linux/list.h
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

On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Import include/linux/list.h to use convenient list macros in modpost.
>
> I dropped kernel-space code such as {WRITE,READ}_ONCE etc. and unneeded
> macros.
>
> I also imported container_of() from include/linux/container_of.h and
> type definitions from include/linux/types.h.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Ok then, just two small nits about two comments, which may have been
just copied over from the sources.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/list.h | 336 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 336 insertions(+)
>  create mode 100644 scripts/mod/list.h
>
> diff --git a/scripts/mod/list.h b/scripts/mod/list.h
> new file mode 100644
> index 000000000000..c87583a71714
> --- /dev/null
> +++ b/scripts/mod/list.h
> @@ -0,0 +1,336 @@

<snip>

> +/**
> + * list_for_each_entry -       iterate over list of given type

^ Excessive whitespace after the `-`

> + * @pos:       the type * to use as a loop cursor.
> + * @head:      the head for your list.
> + * @member:    the name of the list_head within the struct.
> + */
> +#define list_for_each_entry(pos, head, member)                         \
> +       for (pos = list_first_entry(head, typeof(*pos), member);        \
> +            !list_entry_is_head(pos, head, member);                    \
> +            pos = list_next_entry(pos, member))
> +
> +/**
> + * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry

^ This sounds like two sentences and looks like it's missing
punctuation separating them?

"iterate over list of given type. Safe against removal of list entry"
-- 
Thanks,
~Nick Desaulniers
