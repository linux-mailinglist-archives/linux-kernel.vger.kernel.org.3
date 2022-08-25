Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25065A0AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbiHYHzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiHYHzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:55:52 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125D113DCC;
        Thu, 25 Aug 2022 00:55:49 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 01BAA1C0003; Thu, 25 Aug 2022 09:55:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1661414148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kzzOjev5G5gIAWst/oIl84t7VEw8u84D0Oqzi9ztX0k=;
        b=Tdn+buxE6AXHinzzjNYJ3xsdjTfjBFTgmB1w1aE36nhLBRXjpznE5KGngRC97Tb8IQ/1ar
        60bPOzvquyO/qW0S3hPBD59adLzDjC8gFyGrTZN6UmxIGHLziIXuBOuf5adQD2MQWAT9+f
        6gs268uNdUOjTmwZMwAXg62FbR3V4Lk=
Date:   Thu, 25 Aug 2022 09:55:47 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     PaddyKP Yao <ispaddy@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, PaddyKP_Yao@asus.com,
        acpi4asus-user@lists.sourceforge.net, andy.shevchenko@gmail.com,
        corentin.chary@gmail.com, linux-kernel@vger.kernel.org,
        luke@ljones.dev, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Message-ID: <20220825075547.GA28653@duo.ucw.cz>
References: <d7e2a109-c1b7-9f8c-c2b2-b765f016a9a3@redhat.com>
 <20220711115125.2072508-1-PaddyKP_Yao@asus.com>
 <e120ac7c-7abb-4999-efe8-6b3b697d12d6@redhat.com>
 <20220824100622.GB1049@bug>
 <20220824105908.GA111@AA2000783-NB2.corpnet.asus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20220824105908.GA111@AA2000783-NB2.corpnet.asus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2022-08-24 18:59:08, PaddyKP Yao wrote:
> Hi Pavel,
>=20
> On Wed, Aug 24, 2022 at 12:06:22PM +0200, Pavel Machek wrote:
> >=20
> > It would be good to get the API right before it hits mainline release.
> >=20
>=20
> What do you mean about API you mentioned?

We really don't want to see asus: prefix in the sysfs.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYwcrAwAKCRAw5/Bqldv6
8kvJAKCt663cvQNSSOOrzfjGI/g3haJHUQCeLJzq6UsDeGo3QuzK9uT5Z3pQJXw=
=YAXV
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
