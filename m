Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20434DC493
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiCQLO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiCQLO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:14:26 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565F7A6E2A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:13:08 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C41DF1C0B7F; Thu, 17 Mar 2022 12:13:06 +0100 (CET)
Date:   Thu, 17 Mar 2022 12:13:05 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2 1/2] x86/split_lock: Make life miserable for split
 lockers
Message-ID: <20220317111305.GB2237@amd>
References: <20220217012721.9694-1-tony.luck@intel.com>
 <20220310204854.31752-1-tony.luck@intel.com>
 <20220310204854.31752-2-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <20220310204854.31752-2-tony.luck@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> In https://lore.kernel.org/all/87y22uujkm.ffs@tglx/ Thomas
> said:
>=20
>   Its's simply wishful thinking that stuff gets fixed because of a
>   WARN_ONCE(). This has never worked. The only thing which works is to
>   make stuff fail hard or slow it down in a way which makes it annoying
>   enough to users to complain.
>=20
> He was talking about WBINVD. But it made me think about how we
> use the split lock detection feature in Linux.
>=20
> Existing code has three options for applications:
> 1) Don't enable split lock detection (allow arbitrary split locks)
> 2) Warn once when a process uses split lock, but let the process
>    keep running with split lock detection disabled
> 3) Kill process that use split locks

I'm not sure what split locks are, and if you want applications to
stop doing that maybe documentation would help.

Anyway, you can't really introduce regressions to userspace to "get
stuff fixed" in applications.
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmIzF8EACgkQMOfwapXb+vLXtgCgu8hgn9uzvyozj3rvbJXWngQE
huUAn2kdrz3cZJ4I3rLkm+d3qORv5dd+
=nuYL
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
