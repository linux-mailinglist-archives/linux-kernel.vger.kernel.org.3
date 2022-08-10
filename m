Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1858EE84
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiHJOi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiHJOiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:38:09 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F77D51439
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:38:04 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id q184so17914309oif.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=HJ77uW+ijKtvJrdU/X6wE5SDOpYiEoEbR65dmsHLnXc=;
        b=EFdkWTc8pKhjAWNdwII0Fgafd3o0K8pat2Y3zUktTh5U22O/Dn6OFwnxvQOia9zqZ/
         bALR2G1vmqoyUMNoIF84gp31X4TWu1JvYdGZlT55VtmYAA1qAHfM1YJaNydvem1+5S6P
         qE7PgdK5Doc1WhjvUVVxGXcJSUzt7gac78IxvbQtA2x1Sw7CUWhxvM3IBszmdHAwxc2q
         fuMrNYoXr7fPLFrFY1psSNgXRPLXhv1E+CpaB8qlbjvIV4yiZD7pPT62UxwxETYBYXA6
         DMo3hwmn9QAqDNtlJ32fcIitzWRi5YTXhP3AAk7qrvAHOe5Mj07KbnRQoDNIhxaMq0hi
         MSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=HJ77uW+ijKtvJrdU/X6wE5SDOpYiEoEbR65dmsHLnXc=;
        b=qTZw1GAOL+foR0qdbQ7qY5Is4sYx6BvOcH5cP2qRzUC4HRkjAfzgvSkI29PUZdQBC5
         QkgN+kOTCYaPD7L/+orwMgpRoobD6N+oWJ/C6exsQSOgkLgGbp+ox9WVRtKzmSW3QqZ3
         CpT4GYlyU3/SWoO/88XGR0H+2W0B6fNPWDFfGwH1sruFq6ZbQ9f+L0uxqCpJuY48CKsJ
         z4ln5JSd7/2cf3LXXyhtizHasJ1ToYTqnlNw/WjjEu1Miqlap1xa3j0wUt6CIioUcO3J
         R2i5tywOT9/2g/F9+dxFypdH8a9OwjdSPtyIFTlcn91OsKs14q7RRRkKTZf0nkW10J9W
         dmaQ==
X-Gm-Message-State: ACgBeo3x+VqUXVSmyXLBZ+q/yOYyTrRDTma0j3lzs0kIjnwzHrl8lMMq
        LGeZRhwd5aTBN2g5dRzU+3PEqHxcsqC4u4AOKto=
X-Google-Smtp-Source: AA6agR5GF/EHfKK3PoRM6j/ecO2uWtwIg7tNftkuE9G2qnYN081v5cGdizyVZlbbljNgY70VoBg/tfhJdbN44HGvQR8=
X-Received: by 2002:a05:6808:1888:b0:342:a0c3:f7d4 with SMTP id
 bi8-20020a056808188800b00342a0c3f7d4mr1523332oib.286.1660142283392; Wed, 10
 Aug 2022 07:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com>
 <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
 <CAPM=9txSKv_xwZJ6SndtqsdQm6aK1KJVF91dB5Odhc_Xv6Qdrw@mail.gmail.com>
 <CAFCwf10CsLgt+_qT7dT=8DVXsL0a=w=uXN6HC=CpP5EfitvLfQ@mail.gmail.com>
 <CAPM=9txme2dQD9kyM6gnYyXL34hYP8wcGMbduOUcFsKe+4zTcQ@mail.gmail.com>
 <CAFCwf11TPKTF_Ndi60FneWp5g3SoawJvfJoKVWJ-QjxjpawMmg@mail.gmail.com>
 <CAFCwf13WU3ZEjurEaEnVC56zorwKr-uuQn-ec10r301Fh+XEtA@mail.gmail.com> <TYAPR01MB6201272491EA2F23A14A9D8192659@TYAPR01MB6201.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB6201272491EA2F23A14A9D8192659@TYAPR01MB6201.jpnprd01.prod.outlook.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 10 Aug 2022 17:37:36 +0300
Message-ID: <CAFCwf11AkMapE54nMLg_WryU+PxU1ouZUA-DBxaJVsH0b-JtsQ@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiho Chu <jiho.chu@samsung.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
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

On Wed, Aug 10, 2022 at 5:10 PM <yuji2.ishikawa@toshiba.co.jp> wrote:
>
> > -----Original Message-----
> > From: Oded Gabbay <oded.gabbay@gmail.com>
> > Sent: Wednesday, August 10, 2022 6:42 AM
> > To: Dave Airlie <airlied@gmail.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; ishikawa yuji(=E7=9F=B3=E5=B7=9D =E6=82=
=A0=E5=8F=B8 =E2=97=8B=EF=BC=B2=EF=BC=A4=EF=BC=A3=E2=96=A1=EF=BC=A1=EF=BC=
=A9=EF=BC=B4=EF=BC=A3=E2=97=8B
> > =EF=BC=A5=EF=BC=A1=E9=96=8B) <yuji2.ishikawa@toshiba.co.jp>; Jiho Chu <=
jiho.chu@samsung.com>
> > Cc: dri-devel <dri-devel@lists.freedesktop.org>; Arnd Bergmann
> > <arnd@arndb.de>; Linux-Kernel@Vger. Kernel. Org
> > <linux-kernel@vger.kernel.org>; Jason Gunthorpe <jgg@nvidia.com>
> > Subject: Re: New subsystem for acceleration devices
> >
> > Hi Jiho, Yuji.
> >
> > I want to update that I'm currently in discussions with Dave to figure =
out what's
> > the best way to move forward. We are writing it down to do a proper com=
parison
> > between the two paths (new accel subsystem or using drm). I guess it wi=
ll take
> > a week or so.
> >
> > In the meantime, I'm putting the accel code on hold. I have only manage=
d to do
> > the very basic infra and add a demo driver that shows how to register a=
nd
> > unregister from it.
> > You can check the code at:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/log/?=
h=3Dac
> > cel
> >
> > It has two commits. The first adds the subsystem code and the second ad=
ds the
> > demo driver.
> > The subsystem code is basically drm code copied and renamed and slightl=
y
> > modified, but I really only worked on it for a couple of hours so take =
that into
> > consideration.
> >
> > The important thing is that the demo driver shows the basic steps are r=
eally
> > simple. You need to add two function calls in your probe and one functi=
on call in
> > your release. Of course you will need to supply some function callbacks=
, but I
> > haven't got to fill that in the demo driver. Once you register, you get
> > /dev/accel/ac0 and
> > /dev/accel/ac_controlD64 (if you want a control device). If I were to c=
ontinue
> > this, the next step is to do the open and close part.
> >
> > I will update once we know where things are heading. As I said, I imagi=
ne it can
> > take a few weeks.
> >
> > Thanks,
> > Oded
>
> Hi Odded,
> Thank you for uploading the framework as well as a sample.
> It's exciting to see new software is growing up.
>
> Since Visconti DNN is a platform device, I'll write some test code to ini=
tialize driver and see if it works.
>
> Regards,
> Yuji

Platform or PCI, it doesn't matter. You just call it from the probe.
But really, this is something I did in a few hours and I stopped
because there were some objections and I wanted to first talk about it
with Dave.
I don't know if it's worth it for you to waste time on it at this point.

Thanks,
Oded
