Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39D752BC13
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbiEROFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiEROFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:05:43 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B09187DAC;
        Wed, 18 May 2022 07:05:42 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2fee9fe48c2so25773907b3.3;
        Wed, 18 May 2022 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pg9cHDfOmQbKA6sIGv2JPMMr6K3pv/vo5Tu+jGJ0f+A=;
        b=e6/AhQfYrT8846Hg+aIPVzaVNoSL5XsanMKp811Mrs9WvxdjaycBT017rBix3zEiGm
         TlvUgokaIm0K6peenTPOV5Ao6qQL5/D+u/4MWTUKSpxKnpuBEt3BR9axyNsMFMyrZj+v
         ey+zthjQY63V86f9OZHFh+GpFlqMdOfccOiv7C+pzQJbWG3tRMkDFCQqFYLfcODly9NM
         j7Pkzpo9rEAIxXDdu+xQeuP5y7iE7HC9oidLejvRrPNl8OgpjI2UoXjr4ItMpnam5NUy
         JJapsiATGADzMGfya24pgCtEJo/LSp/aPzQpJvTvuErsZhuoYCREpg4lcUHMH9s3UJ/t
         oBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pg9cHDfOmQbKA6sIGv2JPMMr6K3pv/vo5Tu+jGJ0f+A=;
        b=DprFq9kExwc1QyirZTH8cVen0FMwZX/+VB3wgJdYlnUeKkcbQZjxoHbKB0mgxtHL76
         u0U3IeABez4ad89gOohTBIdJrO9+p4z80hnZ+nUWr4457VkdrNPQq4apnYnpJOq8X4fq
         Bmyl3ema0O6rxWHywqpL2+IndzZB9JiUfT/EFXd88ibVl1GSJrDTkMBmAk7rDE2qNfNf
         lBz+yDuho5+FnluLxiuLeMU7lyN8owmfDhRkeRfU+0UOdJRBhoQ1pxcntgqya1mUC0mu
         mpmBaMfqE34jul1h9IdfDzt2/oVoMcncrh3EbIT2ESaIZNiUSqkOKPxHgbON1biFlIMm
         Tv0g==
X-Gm-Message-State: AOAM532JNqRBOko1nzcERMNRMCErb4ZBfLrX+UeBtdoAlZUArOh40pff
        HqFK+Tz71/DZDXZ3thPqc8aGkq8eAoWQ2q/IY78=
X-Google-Smtp-Source: ABdhPJxEmLouzj7heJFGZupA9PDoDM88xPg6Yc39MR+Z8uhjn/4fz1Pwv8qxww7dqmcsrzi9Z+H4+RDs0k2WOPNJi4I=
X-Received: by 2002:a81:4f0b:0:b0:2ff:2770:c267 with SMTP id
 d11-20020a814f0b000000b002ff2770c267mr8566295ywb.212.1652882741213; Wed, 18
 May 2022 07:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652712771.git.siyanteng@loongson.cn> <b0c1324d1d63846d700ab354446a6deaf30754c0.1652712771.git.siyanteng@loongson.cn>
 <8735h8vu0x.fsf@meer.lwn.net>
In-Reply-To: <8735h8vu0x.fsf@meer.lwn.net>
From:   yanteng si <siyanteng01@gmail.com>
Date:   Wed, 18 May 2022 22:05:29 +0800
Message-ID: <CAEensMzjCR+LWXw-xS95xMOea20yxUJ8c-f7EmYgP7EkpUePaw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Become the docs/zh_CN maintainer
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Yanteng Si <siyanteng@loongson.cn>, Alex Shi <alexs@kernel.org>,
        Alex Shi <seakeel@gmail.com>, Wu XiangCheng <bobwxc@email.cn>,
        Yeechou Tang <tangyeechou@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> =E4=BA=8E2022=E5=B9=B45=E6=9C=8818=E6=97=
=A5=E5=91=A8=E4=B8=89 03:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Yanteng Si <siyanteng@loongson.cn> writes:
>
> > It's time to become a maintainer of Chinese documentation, and Yanteng'=
s plan
> > is to help everyone with the utmost enthusiasm and patience.
> >
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > Reviewed-by: Alex Shi <alexs@kernel.org>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9ce78f2275dc..ff1364d9f7cc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4649,6 +4649,7 @@ F:      Documentation/dev-tools/checkpatch.rst
> >
> >  CHINESE DOCUMENTATION
> >  M:   Alex Shi <alexs@kernel.org>
> > +M:   Yanteng Si <siyanteng@loongson.cn>
> >  S:   Maintained
> >  F:   Documentation/translations/zh_CN/
>
> I've applied this.  I am curious, though: what is your sense for what
> being designated a "maintainer" means?  Do you envision something beyond
> reviewing patches (for which an "R:" entry would be most appropriate)?
>
> In any case, you help with the documentation is appreciated!

Jonathan Corbet, Alex Shi, and guys in the mail list.

We, all kernel developers who love Chinese documentation, are now
involved in a very interesting project: the localization of kernel
documentation into Chinese.

For a long time, we have been working on translating as much of the
English documentation into Chinese as possible, while neglecting to
maintain the growing amount of Chinese documentation, which is
becoming progressively more difficult to maintain. It's not just the
quantity that is difficult, but also the time. For example, if a
document is not updated in a timely manner, developers who have
difficulty with English will get old or even wrong guidelines, which
is not only a waste of time and effort for developers, but may also
result in the kernel not getting the code contributed by developers in
a timely manner.

During the translation, we found ourselves disagree on the translation
of some terms from time to time, especially on terms being translated
into Chinese for the first time; and sometimes it might not be easy to
reach agreement on such circumstances and provide a translation that
is trustworthy, up-to-date, and elegant in a short time.

At the same time, I've noticed that the translating kernel
documentations is a great entry point to  many newbies, which is a
good thing, but adds to the burden of reviewing Chinese documentation
patches, as most of them tend to have great enthusiasm but are
unfamiliar with the patch creation and submission process. Of course,
we have very detailed documentation guidelines and they are translated
into Chinese, but they still need some help from us in their practice
process.

But that is the past. And now we are looking only to the future.

I will do my best to keep all the Chinese documentation as up-to-date
as the English documentation, and I will keep an eye on the latest
changes to each original document and quickly sync them to the Chinese
documentation. At the same time, I will work to move forward with a
plan to produce a glossary of terms, and to revise the current
documentation where a single English word is translated into multiple
Chinese words. Finally, I will provide every developer with as much
help as I can with my utmost enthusiasm and patience.


Thanks,
Yanteng
