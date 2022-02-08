Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FC14AD424
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352529AbiBHI5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352440AbiBHI44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:56:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B273C03FEC5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:56:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so29326403wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFHu5hccvMsF7o2tu2U34+ZB4v04LjByM/vohLM1Hos=;
        b=aua/lLM29hlA2EW20MciGDxo6kSzKs1ShqohU6FEZbdY5WLoRRoDL7ebR2JO0cF+oh
         wkIrJ0UBqiDGFL8PwmGoHRqSnLEQmZ5Z6XMuxU8aNtoJbOJM6NJ7pa60AgZ7AhTHEjFi
         r3odVwT6OaxSNlvXWmYX3DRmsw2YQyeUXzWkJUQmrO1Q2Bi/1aqMN0uB++77G7lcPV7E
         crmmvn2hp++MUAs6ygCjD7y2qMVyW2wJbXEm1/B/GZ6ka+iQL7KGHf8atLTlC66RtY2A
         4ZtWcaknXVU8ZJkh04X7IHREQBGv4O67W9DIBqj+4qn7LzAmHBaNwFOeldWf81ngD/Rq
         KCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFHu5hccvMsF7o2tu2U34+ZB4v04LjByM/vohLM1Hos=;
        b=fHG62aN/PAijmRYD3tTlgpXe1cNFa3vxuoiQecwdSbDARKdGPbtbZEyVn5B0R1G3nP
         W4UbTJ1CKyiBa2Gj0un7ePmGA+hU06buP59dJPn0pUvbkg4DRYtMrdEEECU6qcv0gU8h
         9sDw8G91PL9OcZqO1qkGK0emoni2ip6woblAIlQG3BqOCS82HwcSBemou0P5rM0fOkV+
         zHqrGf8yAWp7uJjEqa7MRK7EZSr21e+TUgYgO0j2Ni/iOh6j27f2u+lgy3SnXta01rLD
         9JnsE0mMh8Yp4etZAcq4zeGYIcIyQG2B7quWhzXNsMisrUTLdiPT75UhYT0J1Y19/FF4
         VYAQ==
X-Gm-Message-State: AOAM532V3YJpAt/TyXXiLRuepjftyKaW7GAGD0yUq10gGE/Aj5oRmQie
        TpP/aTqB1SjkBVQVILdDGAo=
X-Google-Smtp-Source: ABdhPJzcjRB5ryj93ByKb+iLvzPIzvNewL5R2090HkYH0pfHPHuv1PHY+jyAwrOJSDmMgjTGKWdOWA==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr2522322wrx.318.1644310614006;
        Tue, 08 Feb 2022 00:56:54 -0800 (PST)
Received: from leap.localnet (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id p8sm13652398wrr.16.2022.02.08.00.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:56:53 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        Leonardo Araujo <leonardo.aa88@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] Staging: r8188eu: core: 'associcated' may be misspelled - perhaps 'associated'?
Date:   Tue, 08 Feb 2022 09:56:51 +0100
Message-ID: <2023396.KlZ2vcFHjT@leap>
In-Reply-To: <YgIpMuShlOamHV68@kroah.com>
References: <20220207234210.26097-1-leonardo.aa88@gmail.com> <2122312.NgBsaNRSFp@leap> <YgIpMuShlOamHV68@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=EC 8 febbraio 2022 09:26:26 CET Greg KH wrote:
> On Tue, Feb 08, 2022 at 09:09:10AM +0100, Fabio M. De Francesco wrote:
> > On marted=EC 8 febbraio 2022 00:42:10 CET Leonardo Araujo wrote:
> > > This patch fixes the following checkpatch.pl warning:
> > >=20
> > > CHECK: 'associcated' may be misspelled - perhaps 'associated'?
> > >=20
> > > Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
> > > ---
> > >  drivers/staging/r8188eu/core/rtw_ap.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >=20
> > "Staging: r8188eu: core: 'associated' may be misspelled - perhaps 'asso=
ciated'?"=20
> > it's not the way patch subjects are created for inclusion in Linux.
>=20
> I do not see anything wrong with this.  What do you think is not
> acceptable?

My opinion is that the formal construction of a patch is important not less=
 than
the code in it. However it's not that big deal, in this case. But for what =
my=20
opinion is worth, having a subject that says what the patch must do and usi=
ng an
imperative language is quite important.

I specified that it is not my job to accept or reject and said "if I were y=
ou []".
If you think that new contributor may be creative with the subjects of patc=
hes, this
is up to you to decide (obviously).

My intent was just to provide help to improve how to write subjects. I hope=
 that=20
Leonardo is going to become a productive member of this Community, so I tho=
ught=20
that a little help for improving how to write subjects wouldn't hurt. =20

>=20
> > Please follow what is clearly described in the "Philosophy of Linux ker=
nel=20
> > patches" document at https://kernelnewbies.org/PatchPhilosophy...
>=20
> The in-kernel documentation describes this well also.
>=20
> > "In patch descriptions and in the subject, it is common and preferable =
to use=20
> > present-tense, imperative language. Write as if you are telling git wha=
t to do=20
> > with your patch.".
> >=20
> > It's not my job to accept or reject patches for this subsystem and I do=
n't want=20
> > to tell you what to write but, if I were you, I'd send a v2 with a subj=
ect like=20
> > "Fix misspelled word in comments" (or something else similar to this su=
bject).
> >=20
> > Furthermore, please take note that the name of this subsystem is "stagi=
ng" (it=20
> > is not "Staging").
>=20
> Either is fine, I will not reject a change for an upper-case letter like
> this.
>=20
> > Decide by yourself whether or not the other two patches that you submit=
ted this=20
> > morning have to be sent anew as v2 with due changes in the subjects.
>=20
> I do not see a problem with this change at all, nothing needs to be
> resubmitted.

You are the maintainer, so it's up to you. Nothing needs to be resubmitted =
but=20
I hope that next time his subjects will better conform to the guidelines.

Thanks,

=46abio

>=20
> greg k-h
>=20




