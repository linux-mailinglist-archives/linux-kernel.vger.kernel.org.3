Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F343758D68E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbiHIJbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242057AbiHIJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:31:00 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C9A2634;
        Tue,  9 Aug 2022 02:30:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 388445C00F2;
        Tue,  9 Aug 2022 05:30:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 09 Aug 2022 05:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660037459; x=
        1660123859; bh=rJk3KTwHsZQ0HpRz3sS/El3Wfb68222Qk78rFXYzHm0=; b=T
        Ub8iXctQQ29K4gzIIQ1OWW9D7KCFAwuTLlEi0jHS0P/hV3+Y5gTKQ//b1/mckMSK
        RCrWnuqhwFmHjbSUiyFjev/ikDu9r0E5uvXnA+SMxW9RyBUv1bOf+4oHiHZPSVDf
        V99b8EppxX1cpVD5FnF1S3KYkOHUdmYLHmkFJ/bjgivLvrjz1s7GbWajSMuRz5xd
        ZmsDR/mARvDKBc+h7IQ2VkAe8I7jOYan9o384rC75W94x7ksvu6icfnYzxBkvhjY
        MO225fNJpXdt1o9VcfKnuvAGhJhZLbqltFozjA0cZ/xIdvANksfes7iX8mqaQP+r
        7Z+mDMiwyYi3IzW1o1aqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660037459; x=
        1660123859; bh=rJk3KTwHsZQ0HpRz3sS/El3Wfb68222Qk78rFXYzHm0=; b=N
        wCaZpbd41qKDonEceQw/sctsQ/3KZEILdZ2FDyaB8AB2D2i01UJSS9kb6Gbrhi5E
        ZrnZDMqwbtjhhDCn8gu0tMNvZRlaaXbvpMmdbQld3gRADJ2UOteKpI+pCLV4z4hE
        tzzwBrabSngSDJieOEKb8gLCwmhr7vgd78UjI5Bicb89ixC8PXH35FGT6H7dFy2d
        znphQzNtUfDVyXkNDGX3td/YF6lItclloK0eIyqNwOm5G0eufeCVUa1w0cjrv7Ti
        Y1lt409dm1TgbVcjttaVl/fXMuP0iQPSb1g5JBP5cxdaGoJYsuffBbnwafe/tPza
        iImryDeHvp5/ULrXtz9gg==
X-ME-Sender: <xms:UynyYkKylv2ocEXbRbbjwcPjv4zfcod-onDOSHyyCCrb2U5jpICeCA>
    <xme:UynyYkJOHzZ84meqSAKcw7vwvNTtYH5f6Roa36DGOa-a_Dmzw7tuXnrR0En0qz7D1
    xAzYYvfmv5mU4HJGus>
X-ME-Received: <xmr:UynyYkv224Ph77DOvfLzePhzZ2eYbhxw8dWpzNNZDX7GsJ-OT1Y-plJcaffSckmO86Lasw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeekfeffueejveeujeeugeelleehtdegvdeludektddtfffhieefledvudehfeejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:UynyYhas9h_Nblg78tpK7Z3CmDZCQo5h0z4Jw_vcA4zlsz5rbDXqCw>
    <xmx:UynyYrbNLi-hu-xPgie28SvbUylGsad4hc247IHk1SfoI9qiV-h8yg>
    <xmx:UynyYtC2bRxdKH9EOXywUGuDr_HYc9cRrENGZm0axTNvztT-Su-AXg>
    <xmx:UynyYnEmaFAyXGe54Knq1t3hI5_fb1n_ARLc4xEdoH-grGHBSoaRrg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 05:30:56 -0400 (EDT)
Message-ID: <ec86a70c304b2adc69f4f4a6e1076b799a56cd09.camel@ljones.dev>
Subject: Re: [PATCH v3 2/6] asus-wmi: Implement TUF laptop keyboard LED modes
From:   Luke Jones <luke@ljones.dev>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Aug 2022 21:30:49 +1200
In-Reply-To: <CAHp75VdrWMD7A2PJ-nPa0aLYZPqmgC7+pZ2SMDMtGWjHrx=xxA@mail.gmail.com>
References: <20220809025054.1626339-1-luke@ljones.dev>
         <20220809025054.1626339-3-luke@ljones.dev>
         <CAHp75VdrWMD7A2PJ-nPa0aLYZPqmgC7+pZ2SMDMtGWjHrx=xxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2022-08-09 at 11:22 +0200, Andy Shevchenko wrote:
> On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev> wrote:
> >=20
> > Adds support for changing the laptop keyboard LED modes. These
> > are visible effects such as static, rainbow, pulsing, colour
> > cycles.
> >=20
> > These sysfs attributes are added to asus-nb-wmi:
> > - keyboard_rgb_save
> > - keyboard_rgb_mode
> > - keyboard_rgb_speed
>=20
> ...
>=20
> > +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/devic=
es/platform/<platform>/keyboard_rgb_speed
> > +Date:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Aug 2022
> > +KernelVersion: 6.1
> > +Contact:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Luke Jones" <luke@ljones=
.dev>
> > +Description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Set the speed of the selected RGB effect, the speed
> > will not apply
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 until the keyboard_rgb_save attribute is set
> > (write-only):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 0 - slow
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 1 - mediu=
m
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 2 - fast
>=20
> > \ No newline at end of file
>=20
> ^^^
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 save;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_wmi *asus =3D dev_get=
_drvdata(device);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct led_classdev *cdev =3D &as=
us-
> > >keyboard_rgb_led.dev.led_cdev;
>=20
> No blank line in the definition block and try to keep "the longest
> line first", a.k.a. reversed xmas tree ordering.
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 mode;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_wmi *asus =3D dev_get=
_drvdata(device);
>=20
> Ditto.
>=20
> I would really recommend you spending some time to read the existing
> code (better recent one) and look for the common patterns.
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* These are the known usable mod=
es across all TUF/ROG */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mode >=3D 12 || mode =3D=3D 1=
0)
>=20
> The second condition was different in previous versions. Or am I
> confused by another patch series?
>=20

It's a mistake on my part..

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus->keyboard_rgb_le=
d.mode =3D 10;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus->keyboard_rgb_le=
d.mode =3D mode;
>=20
> ...
>=20
> > +
> > +
>=20
> Single blank line is enough.
>=20
> ...
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct mc_subled *mc_led_info =3D asus-
> > >keyboard_rgb_mode.subled_info;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct led_classdev_mc *mc_cdev =3D &asus-
> > >keyboard_rgb_mode.dev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct mc_subled *mc_led_info =3D asus-
> > >keyboard_rgb_led.subled_info;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct led_classdev_mc *mc_cdev =3D &asus-
> > >keyboard_rgb_led.dev;
>=20
> Not sure why this change happened...

I thought I wrote this in changelog. Either way, it is meant to be in
first patch. git can be damned frustrating to use.

I will try to fix all these little things and let the series bake at
least a week before next version.

Kind regards,
Luke.


