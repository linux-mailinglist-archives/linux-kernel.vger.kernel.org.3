Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A15A543D73
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiFHUOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiFHUOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:14:22 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C225106578
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 13:14:19 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2ff7b90e635so221142727b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 13:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N8K5cZqw0Zv6ga4Y9aVmpphL86F2VWeXaDyWt7dTz8k=;
        b=mW8rKXvAYlKK1N6/RtDgQk7Sf3Vpm8JbGsmqS2kfwORJDgQUO4/CMHxoBLWWVZwuFE
         +cSc1D3+RJnSDgsn5EZ62UqoVOfcLwGoYAldYSlSpfcuXEnimEGd5FkPzUH4ayy0sQyX
         XPbYa3XZ8x+PBISfpG7fcSW4R20LF92Mb12Icx1fk7s2DWOF2ibh0UjXYU9kVv3Jq+Eg
         dA0fJUZfKWwUayscnLdK/8k7627URN7Dl4d+1nNCDacNQXzxNIT+/Ii8G609qpLLEhof
         DMAf72puGtsJpVTgrpjhSeuZq5ZNlHOcv9wg9Yj1TcKEJWb/y9IPHYwP157jKZYq69/B
         1xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N8K5cZqw0Zv6ga4Y9aVmpphL86F2VWeXaDyWt7dTz8k=;
        b=uRWDctgWUVlivGmrDUsHovMTkj5vbQ8DUlF3emIjl+veRTnmygI41WucgkaAE0a8f0
         zOze+m1rA10L/rdwiaPrzMhJ+RG8hUgLZRKBvX8GabAWbKTY/vU1MYxwJ2TLseeLJ/aN
         6R9NJU0NMbGHm1O25ZNm54DAy4VdbP1vBM3zM5XQ09UkOqUuxkxgGLhkkyE9O2EwMlPD
         EwT3HexNzM26/4kiCAIfnCawZrHQJFoAwaYawx1Zn2RTG5dBC09rFULbVA481rME8rZ3
         /ZldCCIdkOuyHQ5JKNQLZO649NwsI0on6ygd2xh9pMY7klqrDAvlLhVB7WTanwHXMVDS
         z7rQ==
X-Gm-Message-State: AOAM530j30dgGeDAkvalMmuba8lbeqy3r1dbsqZp06UPuGn7lHe2FTus
        SCSWBmf/gzjz32MAy4cH51rsThWTRn+RolYqnWiaXg==
X-Google-Smtp-Source: ABdhPJzi1mdMC4ZOzU6Z9pRPUOwuv0+Sb7MhJT3BJzYbXHGCTrS8hdzOQ2vCgEOFRVLVOP6yE53kZO+qLX/5sKVwWqw=
X-Received: by 2002:a81:6357:0:b0:30f:dbe5:b8ff with SMTP id
 x84-20020a816357000000b0030fdbe5b8ffmr37301344ywb.67.1654719258298; Wed, 08
 Jun 2022 13:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220608150008.57629-1-1030steven@gmail.com> <3193fcc9-c672-19d9-a2e2-ad67809dd20b@infradead.org>
 <F0C192DB-6043-4629-A009-DCB4BA33A9A9@gmail.com>
In-Reply-To: <F0C192DB-6043-4629-A009-DCB4BA33A9A9@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 8 Jun 2022 22:14:06 +0200
Message-ID: <CAKfTPtCr0PiharzDecxdC1u2NnRz_qttQieH568_Q8szdVGpSg@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: Fix bracket typo
To:     =?UTF-8?B?6b6N5biG6LuS?= <1030steven@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022 at 18:30, =E9=BE=8D=E5=B8=86=E8=BB=92 <1030steven@gmail.=
com> wrote:
>
>
> Randy Dunlap <rdunlap@infradead.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=888=
=E6=97=A5 =E4=B8=8B=E5=8D=8811:33 =E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> On 6/8/22 08:00, Steven Lung wrote:
>
> The second bracket describing the range is inverted, this patch
> will fix it.
>
> Signed-off-by: Steven Lung <1030steven@gmail.com>
> ---
> kernel/sched/pelt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 0f3107682..ed82cfba9 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -233,7 +233,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
>  * When syncing *_avg with *_sum, we must take into account the current
>  * position in the PELT segment otherwise the remaining part of the segme=
nt
>  * will be considered as idle time whereas it's not yet elapsed and this =
will
> - * generate unwanted oscillation in the range [1002..1024[.
>
>
> Is the above the same as                   range [1002..1024).
> ?  I.e. 1002-1023 inclusive (or 1024 excluded)?

yes, 1024 was excluded from the range because we reached 1024 when
period_contrib =3D=3D 1024 but when period_contrib =3D=3D 1024 we decayed a=
nd
period_contrib becomes 0 and the load_avg went down to 1002.

Before the changes, the load_avg  for default weight was
1024*(LOAD_AVG_MAX-1024+period_contrib)/LOAD_AVG_MAX
if period_contrib =3D=3D 0 ie the beg of the window we've got a load_avg of=
 1002
if period_contrib =3D=3D 1023 ie the end of the window we've got a load of
int(1023.97)=3D=3D1023

In French, we use [1002..1024[ but english version is [1002..1024)

>
> + * generate unwanted oscillation in the range [1002..1024].
>  *
>  * The max value of *_sum varies with the position in the time segment an=
d is
>  * equals to :
>
>
> --
> ~Randy
>
>
> In the patch that the author submitted[1] for this comment, he mentioned =
that the value 1024 can be obtained.
> So I think we should use brackets instead of parenthesis.
>
> [1]: https://lore.kernel.org/all/20200506155301.14288-1-vincent.guittot@l=
inaro.org/T/#u
>
> --
> Steven
>
