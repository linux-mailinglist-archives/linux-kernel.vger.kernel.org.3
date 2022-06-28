Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE1B55CB41
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbiF1K2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344829AbiF1K2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:28:01 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D96131DF5;
        Tue, 28 Jun 2022 03:28:00 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ef5380669cso111838177b3.9;
        Tue, 28 Jun 2022 03:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uq+xZHigTTpCAmtgN4D47Lm53BumUoy2eBX57KhGVyI=;
        b=bEZMdY0AsnmHQSDuNs3ALNxY3jOH4b1yJ1Sh2S126UqBzMb61Q8wXRVmXzjGPnDue0
         NY529BPwVMBQXrJOcO4/xaPoIwRnQ7hyXa9OvpatdsGZToG8GL69pDOYNuOWgSjmQYSU
         Dfadg8sT9wOXF5gMwf9T3JZ+v9qOW/NhrbDOOAV9MsvkRT3bXN/WjpxfAyhB9bt4mo/r
         AYb2pdABHJZ7Pumu7lLpVR5rHsqyE8l4G4COwxRZVNps+q3d5YrtmqEwP4I4tH2koitC
         At1YU1uDKp2P/xrUTQ0S2vslp97DT/xro8y8JSQMnk9mjw+RY7zUzCKisSSOPg2iq8sY
         I4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uq+xZHigTTpCAmtgN4D47Lm53BumUoy2eBX57KhGVyI=;
        b=on7dd8yjoXQcyo6QX0Ey6cw21zzhaVsFtMs/eV538qaTaidQcE0n99clWiCIFXfI6B
         Gi19uwfuos1SNkTIJ7zDOwlJM3tf4RUkKJ9d6qu1ubwHnAZKE9gEVeuQxCrzQPySgHiT
         08EJ8GpXsF5QUkSGx4GeDATjRWhjTmN2SkLVbuNlNIcE3u0w9vLCZzQOgcke2/rab4eO
         WzZcpyjVBPCjbiaaAIx6sjeFw8Gx41Dur6sCwclUn59oUQOru2euUluh5EIcZ8z1I4eP
         mvDgc4ABT1fTlnfhaKipXKiUNwUnbXJul9XT/2SeQJYW+gkLwo93z1yZL6a3nHfh0cD5
         V6jQ==
X-Gm-Message-State: AJIora8CvhwLY6v5aKSSNdV4I2/63Wqf+qInQ8MFEYr5lj2sIdjwTZWh
        8mTYc8yghAmv5iVArNTOw0e/A98iDNUEgqCm6Bw=
X-Google-Smtp-Source: AGRyM1ucCVzXMr/NhcszjDc2qRDm27m/aeve12MQnZ2GKwbnpTPR8B9RxhcXTBtMuPPEBbhPocAc9bS5jzIx26CFi6k=
X-Received: by 2002:a81:9201:0:b0:31b:a963:c7e1 with SMTP id
 j1-20020a819201000000b0031ba963c7e1mr13320294ywg.335.1656412079367; Tue, 28
 Jun 2022 03:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
 <20220627151819.22694-8-lukas.bulwahn@gmail.com> <20220628091647.xf5cygybqemwprgb@numero86.vaga.pv.it>
In-Reply-To: <20220628091647.xf5cygybqemwprgb@numero86.vaga.pv.it>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 28 Jun 2022 12:27:48 +0200
Message-ID: <CAKXUXMwY1L0MczFRkr0HDcHRgp1mNRx5hEAck4Z9nyorUV1TOg@mail.gmail.com>
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
> >
> >
> > Quando pubblicarle
> >diff --git a/Documentation/translations/it_IT/process/8.Conclusion.rst b=
/Documentation/translations/it_IT/process/8.Conclusion.rst
> >index 039bfc5a4108..efaad6c7702c 100644
> >--- a/Documentation/translations/it_IT/process/8.Conclusion.rst
> >+++ b/Documentation/translations/it_IT/process/8.Conclusion.rst
> >@@ -13,8 +13,7 @@ e argomenti correlati. Primo tra questi sar=C3=A0 semp=
re la cartella Documentation
> > che si trova nei sorgenti kernel.
> >
> > Il file :ref:`process/howto.rst <it_process_howto>` =C3=A8 un punto di =
partenza
> >-importante; :ref:`process/submitting-patches.rst <it_submittingpatches>=
` e
> >-:ref:`process/submitting-drivers.rst <it_submittingdrivers>` sono
> >+importante; :ref:`process/submitting-patches.rst <it_submittingpatches>=
` sono
> > anch'essi qualcosa che tutti gli sviluppatori del kernel dovrebbero leg=
gere.
>
> Fixing plural. the final correct statement must be:
>
> :ref:`process/submitting-patches.rst <it_submittingpatches>` =C3=A8 anch'=
esso
> qualcosa che tutti gli sviluppatori del kernel dovrebbero leggere.
>
> Notice "sono anch'essi" -> "=C3=A8 anch'esso"
>

Thanks for your help.

Once Jonathan has reviewed and principally acknowledged this series, I
will adjust the Italian documentation, amend the commit and send out
the new patch series.

Lukas
