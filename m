Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048DC4C9A79
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbiCBBfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbiCBBfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:35:07 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EED286E2B;
        Tue,  1 Mar 2022 17:34:20 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7c964Ghdz4xRC;
        Wed,  2 Mar 2022 12:34:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646184858;
        bh=9ERfiG0ux20qDDrgqpUPmqx2CbOv6dPCn4/BAE2VpNQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Acvj5Xgcd+m1rECKccHdzMN1W+kBCGSU/76PAtK5UvTLVsrkJ1+hylorRXxa3xfiR
         DSQMOd6zz2Y9ijayFlBmIdHWuTtrDrhfDnIpYtrFKU6tH7Wb1awZZ75+rf99mF5d3z
         HKo7qfLxJvDHJg7GLx3l7Ulbw0K/YRsZHJVlmoXWNz7uuYcLCaGX/wb+sHWX57zSt8
         5JM5kzUpHXrPIOO8nxVE39cAer8ZUKf1xjxcY9jsMhTATM+UISL7iO+oRAWMxlpmul
         5wu4CO2oCne1UNJ0FlTqu0UzU4clJJemQKg1qNPfD+9z7DnQcmLuIg/BdDdyvkXCDC
         FPFgg3s+sFoiw==
Date:   Wed, 2 Mar 2022 12:34:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Rajat Jain <rajatja@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm tree
Message-ID: <20220302123417.2c84200b@canb.auug.org.au>
In-Reply-To: <f50d5044-7192-bdb3-7ca9-7217ed311787@redhat.com>
References: <20220202150201.290c7d3d@canb.auug.org.au>
        <20220202150320.3e9bdd62@canb.auug.org.au>
        <f50d5044-7192-bdb3-7ca9-7217ed311787@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7QwcZAmKRbelXU19vvkVHx5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7QwcZAmKRbelXU19vvkVHx5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 2 Feb 2022 09:38:37 +0100 Hans de Goede <hdegoede@redhat.com> wrote:
>=20
> On 2/2/22 05:03, Stephen Rothwell wrote:
> >=20
> > On Wed, 2 Feb 2022 15:02:01 +1100 Stephen Rothwell <sfr@canb.auug.org.a=
u> wrote: =20
> >>
> >> After merging the drm tree, today's linux-next build (htmldocs) produc=
ed
> >> this warning:
> >>
> >> drivers/gpu/drm/drm_privacy_screen.c:X: warning: Function parameter or=
 member 'data' not described in 'drm_privacy_screen_register' =20
> >=20
> > Actually:
> >=20
> > drivers/gpu/drm/drm_privacy_screen.c:392: warning: Function parameter o=
r member 'data' not described in 'drm_privacy_screen_register' =20
>=20
> Thank you for reporting this, I will prepare a patch fixing this.

I am still seeing this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/7QwcZAmKRbelXU19vvkVHx5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIeyZkACgkQAVBC80lX
0Gz/gQf7B58tYUOfd3B9KtVf8Y1meMGpuXxqezMeqYLKdqTE92UDXUsM0HVfMY5T
Vcr+ahslBMkDv2HkB4OW+1FX4jPU2LH+1kBcXcYxaI/ka0I5lIq6crKvSYXYra8p
aP7ur4uuEWT9rLjuj3ys9Cd52TkKDfDZITbyfm62SoFeMjybH6tgy8WmbRyCkEws
jeJTEmj30KrDoTIAU3v9nYDZtQ2NQd3rZRk+R2GL3CDQXgZy6zLr8pIRxAAR2gIv
LIOomgpUWPc6K9XYKgvjbU0wMEu8aWZ+48HMHX7E0MrWcHK1pwm0pPIdvH5Q4pJ0
6j4Qk6i6SLh6hOH6CT9DvMv3jMOE1Q==
=0kj1
-----END PGP SIGNATURE-----

--Sig_/7QwcZAmKRbelXU19vvkVHx5--
