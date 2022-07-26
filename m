Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6120F5815FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbiGZPGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239216AbiGZPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:06:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CF095A7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:06:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b26so20592938wrc.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLLH6w9D8wsHcfdHvvpiix3mL8VIdF8TFktJ27/NMUY=;
        b=Smm9QaZGjpFwQNWcUlfZoLjKFt08N9MuY4yd/90yMpwd895Gpb3JNDFB8z6u7pJ80z
         JPTBgKAFQQYBNpgL42qQstI1dwE/T/LzEVQ3Ehe3EM3duA5FQCJvEzJjSMKvJVed+8K3
         eBG37HwXJWkvqgcy17y+CwtSe8V0PPJyKQF6cZmtbXfxe/OmsbkYj1a70d352Fwya8KJ
         pCj/yQbYlLs+a2u6sQGGAH83JsbIAhWgUCoZDMVNNJs3oSseo+IFSSFyAjx5OICX7fov
         Am6pQpSKDMKWZcPul1Uktyq4n/ahyITen0FK/27OLxLWqRFsRzzOpmZFLFmmxC4+liZu
         A2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLLH6w9D8wsHcfdHvvpiix3mL8VIdF8TFktJ27/NMUY=;
        b=1MlOJcEyu4mfTQuNybFcBHVeGlvd4kR26IqybtdT8k3Kgob7wQkst9U1ccd299JcZk
         OB8fRx7SW7a50TjlzT099den2mcCrhwtBmIJnj09AoDJGm0Z34zQyZ8RL1wj4AVGHhpZ
         6TQVqc5NhCREEXvFEdbKjs0b3bc3N5hwpu6T/g+62CJIma4hXepWejq4hZaqcSMD3vW8
         eXoj0KYroxGo/abHYgWFX6Dp9CRUKfjFm7VE4cl3QrSXmN2m3i7M0i0Y0E8lQajhThNE
         /053A8WTpihbEroQWn0FdXzwFQYRXCsfN5dpWOZH3FwLhgxwnD2y823UaUIbw/nj1Wun
         vNPg==
X-Gm-Message-State: AJIora+j3jJ3ZUS6PDUlO7MNvC2I95vAhXmnPhgCEmRan0cJdBf1jwUj
        tjEIVTSw2zBfcebehu4eVeThb9k9XjxfqUKYOy9l5w==
X-Google-Smtp-Source: AGRyM1vmrDRnI3xdenHDvM2KzQr+JHjWzLzR2MnzKSq9cS5fts5wIL9cxMvQpMDK6xWREDr3Bo585Ho+vvLFpvOyFpk=
X-Received: by 2002:adf:f705:0:b0:21e:a2f6:2fbd with SMTP id
 r5-20020adff705000000b0021ea2f62fbdmr2496376wrp.375.1658847985740; Tue, 26
 Jul 2022 08:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220721124528.20997-1-colin.i.king@gmail.com>
In-Reply-To: <20220721124528.20997-1-colin.i.king@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 26 Jul 2022 08:06:12 -0700
Message-ID: <CAP-5=fWkw7a_EQj8ZZEjJTS-Fi+27_mLcCziJUZw_GAjBMEc=g@mail.gmail.com>
Subject: Re: [PATCH][next] perf inject: Fix spelling mistake "theads" -> "threads"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 5:46 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a pr_err message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index fd4547bb75f7..2a0f992ca0be 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -1501,7 +1501,7 @@ static int host__finished_init(struct perf_session *session, union perf_event *e
>                 return ret;
>
>         if (!gs->vcpu_cnt) {
> -               pr_err("No VCPU theads found for pid %u\n", gs->machine_pid);
> +               pr_err("No VCPU threads found for pid %u\n", gs->machine_pid);
>                 return -EINVAL;
>         }
>
> --
> 2.35.3
>
