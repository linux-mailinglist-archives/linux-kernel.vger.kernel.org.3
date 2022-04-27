Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CDD511755
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbiD0Mod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiD0Mob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:44:31 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id AFECF24F1B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:41:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1651063280; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=+WEZIGOLRvKkp+v4jTpU5YBZwoC4o0Kps9wljdBLhfQ=; b=JVQHYEJ+tLNW8fYAnMecaFNJDOC6w0AX1Sr3RcJl4mLjZ0p1KdwKt8zLsxbd2RzhpEP01QsW
 X7f6uz5IdFd67ccwtqIgANIy1DlQPBLNz6fNQMzNL96VO2AYVjQ7qlCeaWDZXthvlzjQFdjQ
 9Vfzk40sGszd+ZGFBvoek6i1E7Zrn7Fp0LYQw76f4j5npfIQHTZei2DaM1rrdtraoUWk7/0i
 RSu+txerMt10pjgau8u67fOiaR26IKhcIIgmCJnX50z8FieaajrIhMAv8lQwPppV3OPs1qPS
 kAT+FJ9kMDf/adKWmJiCYU+OqIow07MaaQuUs6AFuRzg9VAANzfzAQ==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (dynamic-user.170.84.57.140.mhnet.com.br
 [170.84.57.140]) by smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 626939efc172fc5066278f6b (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Wed, 27 Apr 2022 12:41:19 GMT
Sender: codeagain@codeagain.dev
Date:   Wed, 27 Apr 2022 09:41:14 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v3 0/3] staging: vme: Cleanup driver tree old structures
Message-ID: <20220427124114.woiiuxr6pnxvadwg@AN5Bruno>
References: <cover.1650321310.git.codeagain@codeagain.dev>
 <YmA4QIRfx2QPhEJi@kroah.com>
 <3e91b72a86294b542acf460657d0fd94adeb252e.camel@welchs.me.uk>
 <YmJNqMjXEc4KGrJ8@kroah.com>
 <20220427121851.4e2rjbbabw5sh3lk@AN5Bruno>
 <Ymk3qimGl1tTjpSL@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e2cpdvjfn6d6asay"
Content-Disposition: inline
In-Reply-To: <Ymk3qimGl1tTjpSL@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e2cpdvjfn6d6asay
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2022 at 02:31:38PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 27, 2022 at 09:18:51AM -0300, Bruno Moreira-Guedes wrote:
> > Hello,
> >=20
> > On Fri, Apr 22, 2022 at 08:39:36AM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Apr 21, 2022 at 08:16:05PM +0100, Martyn Welch wrote:
> > > > On Wed, 2022-04-20 at 18:43 +0200, Greg Kroah-Hartman wrote:
> > > > > On Mon, Apr 18, 2022 at 08:29:49PM -0300, Bruno Moreira-Guedes wr=
ote:
> > > > > > This patch series modify the vme_user driver's place in
> > > > > > menuconfig (1/3), fixes a missing `depends on` line in a Kconfig
> > > > > > file
> > > > > > (2/3), and rearrages the directory tree for the driver allowing=
 a
> > > > > > more
> > > > > > straightforward comprehension of its contents (3/3).
> > > > > >=20
> > > > > > The 'vme_user/' driver is the only remaining vme-family driver =
in
> > > > > > the
> > > > > > 'staging/' tree, but its structure, entry in menuconfig and
> > > > > > building
> > > > > > routines are still attached to the 'vme/' subtree now outside
> > > > > > 'staging/'. The present patchset fixes it.
> > > > > >=20
> > > > > > Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
> > > > >=20
> > > > > What about deleting the vme drivers entirely?
> > > >=20
> > > > I assume you're suggesting deleting the "vme_user" driver from the
> > > > staging directory?
> > >=20
> > > Yes, at the very least given that no one has tried to fix it up and g=
et
> > > it out of staging in many years.
> >=20
> > While I cannot comment anything on that regard, I imagine the v4 I sent
> > a couple of days ago will wait for that decision, right?
>=20
> I do not know what you are referring to, sorry.  My staging patch queue
> is empty right now.
Ohhh, okay, no problem, I have sent a v4 around 6 days ago and thought
you were waiting on this definition.

>=20
> > Should I prepare a patch removing them and also submit so when it's
> > decided you can just pick one patch or the other?
>=20
> Let's wait on a removal patch for now.
Sure, I'll be waiting for Martyn's response then, if he says it's still
in use I resend the last one.

>=20
> thanks,
>=20
> greg k-h
>=20

Sincerely,
Bruno

--e2cpdvjfn6d6asay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYmk56gAKCRAZtd3tyEY2
kqVNAP46+sz8lMkQkxa5zH4kz4AFOWtKxLiRqU6b7K/l26HhuwEAv7+U9qRfX/7Y
lsog4ftgrh/j+V3GBskATqmDs0m4jAg=
=GyLo
-----END PGP SIGNATURE-----

--e2cpdvjfn6d6asay--
