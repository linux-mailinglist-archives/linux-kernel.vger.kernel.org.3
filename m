Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4972B565146
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiGDJti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiGDJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:49:36 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2081E2AD9;
        Mon,  4 Jul 2022 02:49:35 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id l144so3426422ybl.5;
        Mon, 04 Jul 2022 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=upxJ9MJ8gsVDlXDiuKX4+gbfevRMZmGiVadxBV+kpe8=;
        b=qpHNh54MzgRw/unTs6ylIG6lsq0QzcEUzvY+KsDq+HVjI7Jeoy22/FDGFzk62XnWZq
         pRXixYTwJaB2+72PZyhVEebJnEgQK/wovb6AB3Qi8YwUZ5x0mh8p+F8eUK9TIH/DeH+o
         051TXq25MjKoz+zRqzBHqD9mZr/dYcVtzBjSGnXvYaejkZRfekks6tiRn33g6s1VMf6z
         nHPP2a+YQ+/ZL6Vzaa3wntbjRl6pfO1dqTWZRUstwgyLbHozFt2CPubQ85gm5KNW5ech
         yCRwCdu3KbbXoyjmYFxijPOj0lACMBnzlgB5rZrJ5qpxDXc+203vzEhNV5erIntoBmKf
         zyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=upxJ9MJ8gsVDlXDiuKX4+gbfevRMZmGiVadxBV+kpe8=;
        b=76a2vQSYnG7xor+x2mYihYess3dvlwTVaZXUmpj7lnuLnl+R/gFxiJQPQmH4+xfmAA
         Az1Vdq2MybC7G8M+crPPYkGow9Ool+CsV/oUQxCkAE6Z6zFY6urUwUZDXIuV6xx6glBL
         I5+MKV1WtgEqM1iqaI3lrE9B9RMIFkXvl6znyq2m0fx8vmYFGM9XSRdqTYJM40ureIsQ
         bXrs/o6CApMqKUIedzNucWKxQQWLMIyEUlRZ4G2NSwcQAev9UZpe8PeuX/qqWWGHvJpg
         B46f3zG1SDNWE2+cLDz/3o/o1mymd7Ejj9L5gO5zYJd3SEO7zfNI0aGyRUZfBeIaGiIf
         JR5w==
X-Gm-Message-State: AJIora+fo9uladoZgWkKib6U+AuHC6aSuqA5zyRrexej4x6wjvVYYoTa
        FHyXQ9XRlfWR79xQvM9oA666vEICQe/nImQ5gNo=
X-Google-Smtp-Source: AGRyM1uuTnlo8UbsTNpCu9w7y6Imn3pGteU2AlhpEORjfZffq++K3qlqc72uL681GfWtLoni83k3M/c8Qd4oL79LzwE=
X-Received: by 2002:a25:5809:0:b0:66c:8709:3611 with SMTP id
 m9-20020a255809000000b0066c87093611mr28080763ybb.608.1656928174292; Mon, 04
 Jul 2022 02:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
 <20220627151819.22694-8-lukas.bulwahn@gmail.com> <20220628091647.xf5cygybqemwprgb@numero86.vaga.pv.it>
In-Reply-To: <20220628091647.xf5cygybqemwprgb@numero86.vaga.pv.it>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 4 Jul 2022 11:49:23 +0200
Message-ID: <CAKXUXMzAzT6c=Atwbnif0MQg50B9UpG6_rV65_OvkaJPTzaPcw@mail.gmail.com>
Subject: Re: [RFC PATCH 07/11] docs: it_IT: align to submitting-drivers removal
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:16 AM Federico Vaga <federico.vaga@vaga.pv.it> w=
rote:
>
> On Mon, Jun 27, 2022 at 05:18:15PM +0200, Lukas Bulwahn wrote:
> >Adjust the Italian translation to the removal of submitting-drivers in t=
he
> >English kernel documentation.
> >
> >Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >---
> > .../it_IT/kernel-hacking/hacking.rst             |  3 +--
> > .../translations/it_IT/process/5.Posting.rst     |  5 ++---
> > .../translations/it_IT/process/8.Conclusion.rst  |  3 +--
> > .../translations/it_IT/process/howto.rst         |  3 +--
> > .../translations/it_IT/process/index.rst         |  1 -
> > .../it_IT/process/submitting-drivers.rst         | 16 ----------------
> > .../it_IT/process/submitting-patches.rst         |  6 ++----
> > 7 files changed, 7 insertions(+), 30 deletions(-)
> > delete mode 100644 Documentation/translations/it_IT/process/submitting-=
drivers.rst
> >
> >diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst=
 b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
> >index d5c521327f6a..4bec4669cf48 100644
> >--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
> >+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
> >@@ -795,8 +795,7 @@ anche per avere patch pulite, c'=C3=A8 del lavoro am=
ministrativo da fare:
> >    di un semplice impegno su una parte del codice.
> >
> > -  Infine, non dimenticatevi di leggere
> >-   ``Documentation/process/submitting-patches.rst`` e possibilmente anc=
he
> >-   ``Documentation/process/submitting-drivers.rst``.
> >+   ``Documentation/process/submitting-patches.rst``.
> >
> > Trucchetti del kernel
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >diff --git a/Documentation/translations/it_IT/process/5.Posting.rst b/Do=
cumentation/translations/it_IT/process/5.Posting.rst
> >index 1476d51eb5e5..a036f38fc82e 100644
> >--- a/Documentation/translations/it_IT/process/5.Posting.rst
> >+++ b/Documentation/translations/it_IT/process/5.Posting.rst
> >@@ -16,9 +16,8 @@ e di procedure per la pubblicazione delle patch; segui=
rle render=C3=A0 la vita
> > pi=C3=B9 facile a tutti quanti.  Questo documento cercher=C3=A0 di copr=
ire questi
> > argomenti con un ragionevole livello di dettaglio; pi=C3=B9 informazion=
i possono
> > essere trovare nella cartella 'Documentation', nei file
> >-:ref:`translations/it_IT/process/submitting-patches.rst <it_submittingp=
atches>`,
> >-:ref:`translations/it_IT/process/submitting-drivers.rst <it_submittingd=
rivers>`, e
> >-:ref:`translations/it_IT/process/submit-checklist.rst <it_submitcheckli=
st>`.
> >+:ref:`translations/it_IT/process/submitting-patches.rst <it_submittingp=
atches>`
> >+e :ref:`translations/it_IT/process/submit-checklist.rst <it_submitcheck=
list>`.
>
> Fixing plural. The final correct statement must be:
>
> nel file :ref:`translations/it_IT/process/submitting-patches.rst <it_subm=
ittingpatches>`.
>
> Notice 'nei file' -> 'nel file'
>
>

Are you sure about this proposed change here? In my patch, I just
changed the enumeration from three objects (submittingpatches,
submittingdrivers, submitchecklist) to two objects (submittingpatches,
submitchecklist).

So, it should stay plural, right?

Lukas
