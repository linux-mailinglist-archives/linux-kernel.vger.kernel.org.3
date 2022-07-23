Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F98457EC8D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbiGWHog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiGWHod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:44:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0094F1B5;
        Sat, 23 Jul 2022 00:44:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bu1so9194454wrb.9;
        Sat, 23 Jul 2022 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tei8gU0z/ZZIONH6z+6TkIT0lbdV8NKJKoJnizWNnK8=;
        b=D9I1oN72Ingdt2jgFG/SHwWaWOicdYnHo4aWcILnsJm4hhP3fu0jFxL+MfEMW9/HCb
         4proD9X/CVY0pIwd+9PSmlYZlHFIqbadwOWS2u9ifCv9a4DTX7tYyKp4JBi1sdOBhxgo
         bse7FusIgVUXpOCCoxvcXncuFRbcSHNH2saLkHyJY1wUQ8+mdRJpjtb/MZja+xoWz6Xg
         DWSmzE4Dew2IkFambF9RLXohV8uYkTaaP1iaRIk6alcIm+iXyAWwKdQ7vs7or2zXRLoc
         nxM8RtsxLCnYl5d88AcPkbaMBQw1xcjwlH0RGQ/ComepbrmTCIyEtAiHRyCUZmr2ohMv
         oMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tei8gU0z/ZZIONH6z+6TkIT0lbdV8NKJKoJnizWNnK8=;
        b=Jhdt3eRyTzGkoeYSnERAtrswLruIslJUdxu4toBpKuFJG/l10BBHnMWMi/TM2B/DNz
         TYkXmhTmJwziJF5JJJRK9ZseLTqPiSbnazJCBZdLTkxbsI2AD59WOM6EdGvIi1u80VaA
         pbHxb4yTipFuTlzL4LxNKsYNndQrvdtSxAoY5MrHF2wI1iO3EDSiPZjETzA7jOq/H0aO
         nfUcxOXyVKMaQKgUNDg3fDgyKG9+pfqGcLh9yiUlC2nhAaz4FMgMas3TOHp2W1SlbB1n
         MWERq/8N7BARyp8pzXkIgnhUdJbX9jhYPn+DaGCYHKI/QbWuCpU1TodufYo9vQr5EcOW
         RiOg==
X-Gm-Message-State: AJIora8CoxaXoxX4z6P7Ygbuz6D5qxdDjzLI35eH7T1cyWVPlTUzlM9S
        QwHXcoQ+6SAx+d+F2tBV+oTmF7ZFKR3BnQ==
X-Google-Smtp-Source: AGRyM1uG+qSB9PlXY5p3neoZG2v5dChhA+3d1+xtdwn1vMGM4cVHu5hzFk2yf4cA5lJVz3BbVLe9rg==
X-Received: by 2002:a5d:4352:0:b0:21e:4984:e607 with SMTP id u18-20020a5d4352000000b0021e4984e607mr2019855wrr.66.1658562270420;
        Sat, 23 Jul 2022 00:44:30 -0700 (PDT)
Received: from reki (62-44-238.netrun.cytanet.com.cy. [62.228.44.238])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003a31f71c5b8sm13450506wmq.27.2022.07.23.00.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 00:44:30 -0700 (PDT)
Date:   Sat, 23 Jul 2022 10:44:28 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <20220723104428.26941d85@reki>
In-Reply-To: <Ytuip1C2LPmAxQxV@kroah.com>
References: <20220719194337.64c490e0@canb.auug.org.au>
        <20220719132559.3348c163@reki>
        <YtaUYmzTfKmx0Ek0@kroah.com>
        <20220723101428.347d941e@reki>
        <Ytuip1C2LPmAxQxV@kroah.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Sat, 23 Jul 2022 09:26:31 +0200
Greg KH <greg@kroah.com> wrote:

> On Sat, Jul 23, 2022 at 10:14:28AM +0300, Maxim Devaev wrote:
> > On Tue, 19 Jul 2022 13:24:18 +0200
> > Greg KH <greg@kroah.com> wrote:
> >  =20
> > > On Tue, Jul 19, 2022 at 01:25:59PM +0300, Maxim Devaev wrote: =20
> > > > =D0=92 Tue, 19 Jul 2022 19:43:37 +1000
> > > > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >    =20
> > > > > Hi all,
> > > > >=20
> > > > > After merging the usb tree, today's linux-next build (htmldocs) p=
roduced
> > > > > this warning:
> > > > >=20
> > > > > Documentation/ABI/testing/configfs-usb-gadget-mass-storage:17: WA=
RNING: Malformed table.
> > > > > Text in column margin in table line 14.
> > > > >=20
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > file            The path to the backing file for the LUN.
> > > > >                 Required if LUN is not marked as removable.
> > > > > ro              Flag specifying access to the LUN shall be
> > > > >                 read-only. This is implied if CD-ROM emulation
> > > > >                 is enabled as well as when it was impossible
> > > > >                 to open "filename" in R/W mode.
> > > > > removable       Flag specifying that LUN shall be indicated as
> > > > >                 being removable.
> > > > > cdrom           Flag specifying that LUN shall be reported as
> > > > >                 being a CD-ROM.
> > > > > nofua           Flag specifying that FUA flag
> > > > >                 in SCSI WRITE(10,12)
> > > > > forced_eject    This write-only file is useful only when
> > > > >                 the function is active. It causes the backing
> > > > >                 file to be forcibly detached from the LUN,
> > > > >                 regardless of whether the host has allowed it.
> > > > >                 Any non-zero number of bytes written will
> > > > >                 result in ejection.
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >=20
> > > > > Introduced by commit
> > > > >=20
> > > > >   421c8d9a20da ("usb: gadget: f_mass_storage: forced_eject attrib=
ute")
> > > > >    =20
> > > >=20
> > > > Sorry. Should I send a patch?   =20
> > >=20
> > > Yes please. =20
> >=20
> > JFYI the patch has been sent to linux-docs@, etc. I forgot to add you t=
o CC. =20
>=20
> Then I'll not be able to take it into my tree to fix this up :(

Ooops. Okay, I've sent it as with v2 tag and added your linuxfoundation add=
r to CC.
