Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B55511770
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiD0MWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiD0MWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:22:12 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 621EE1C100
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:19:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1651061940; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=lDHZNe0nT4irW3eTAgNGDWgdYeKIe/kVZL3tOBWwFRU=; b=i+SX0qnVpz9a+sxTllPXgem9lldxfb7q8yb4Yf92XPXPLGER3B7C9x2DC+KRaRpntSYpPLJm
 5DrSYYzQUimsQaGU9eloyby/vycRjyZ/TFpHubicS/WYyuaFZZDdfRv+5oc770NfaCzWC6/e
 5aYbOQNvzWjED0EbYYpgN/NzFWsFFfX7p8fc+CgzZmeyNM7gTQTAQUR0XP40hpot1pONSpqq
 bLjHUfqvhiJoIhj1b3xdK06qbQdAcK0b9KAe/erHv9vMQDwLV0qYiSNhGaxsweJad8w7NVhU
 HvvEvtxhzDUmdXiaHPpsMgTi3UcUK9vXhRm/54mjv9+62x5f2uLXDQ==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (dynamic-user.170.84.57.140.mhnet.com.br
 [170.84.57.140]) by smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 626934b2e2ec060808280996 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Wed, 27 Apr 2022 12:18:58 GMT
Sender: codeagain@codeagain.dev
Date:   Wed, 27 Apr 2022 09:18:51 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v3 0/3] staging: vme: Cleanup driver tree old structures
Message-ID: <20220427121851.4e2rjbbabw5sh3lk@AN5Bruno>
References: <cover.1650321310.git.codeagain@codeagain.dev>
 <YmA4QIRfx2QPhEJi@kroah.com>
 <3e91b72a86294b542acf460657d0fd94adeb252e.camel@welchs.me.uk>
 <YmJNqMjXEc4KGrJ8@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ozx2ugy2xoiesmr2"
Content-Disposition: inline
In-Reply-To: <YmJNqMjXEc4KGrJ8@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ozx2ugy2xoiesmr2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Apr 22, 2022 at 08:39:36AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 21, 2022 at 08:16:05PM +0100, Martyn Welch wrote:
> > On Wed, 2022-04-20 at 18:43 +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Apr 18, 2022 at 08:29:49PM -0300, Bruno Moreira-Guedes wrote:
> > > > This patch series modify the vme_user driver's place in
> > > > menuconfig (1/3), fixes a missing `depends on` line in a Kconfig
> > > > file
> > > > (2/3), and rearrages the directory tree for the driver allowing a
> > > > more
> > > > straightforward comprehension of its contents (3/3).
> > > >=20
> > > > The 'vme_user/' driver is the only remaining vme-family driver in
> > > > the
> > > > 'staging/' tree, but its structure, entry in menuconfig and
> > > > building
> > > > routines are still attached to the 'vme/' subtree now outside
> > > > 'staging/'. The present patchset fixes it.
> > > >=20
> > > > Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
> > >=20
> > > What about deleting the vme drivers entirely?
> >=20
> > I assume you're suggesting deleting the "vme_user" driver from the
> > staging directory?
>=20
> Yes, at the very least given that no one has tried to fix it up and get
> it out of staging in many years.

While I cannot comment anything on that regard, I imagine the v4 I sent
a couple of days ago will wait for that decision, right?

Should I prepare a patch removing them and also submit so when it's
decided you can just pick one patch or the other?

>=20
> > > Martyn, anyone still using these?
> > >=20
> >=20
> > I'm fairly sure that the actual VME drivers for the hardware bridges
> > (the bits not in staging) are still being used based on the
> > conversations I've had today. I'm just trying to find out whether the
> > vme_user bit is actively being used.
>=20
> If the non-staging vme drivers are still being used, that's great.  But
> if not, those too should be dropped.
>=20
> thanks,
>=20
> greg k-h

--ozx2ugy2xoiesmr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYmk0qwAKCRAZtd3tyEY2
kpwYAQCrlryNZKRr4pjYMNYiw16wCWeN/FdxcwJ91tpjk1knhQD/USmN0/PzLk72
ZMTB2vAScMsQQzm7elD4Ag3eBLrmqQU=
=RKaF
-----END PGP SIGNATURE-----

--ozx2ugy2xoiesmr2--
