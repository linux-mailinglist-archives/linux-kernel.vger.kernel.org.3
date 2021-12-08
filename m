Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B413746D5F1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhLHOqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:46:06 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:53696 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhLHOqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:46:05 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0B6421C0B77; Wed,  8 Dec 2021 15:42:32 +0100 (CET)
Date:   Wed, 8 Dec 2021 15:42:31 +0100
From:   Pavel Machek <pavel@denx.de>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [ANNOUNCE] 5.10.83-rt58
Message-ID: <20211208144231.GA323@amd>
References: <YalDQe/lyXqAxB0K@uudg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <YalDQe/lyXqAxB0K@uudg.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> I'm pleased to announce the 5.10.83-rt58 stable release.
>=20
> This release is just an update to the new stable 5.10.83
> version and no RT specific changes have been made.

Thank you. CIP project started doing 5.10.X based releases, and we
include -rt tree, too. To make my job tiny bit easier, would it be
possible to CC: pavel@denx.de on release announcemnts?

Tree is available at
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt
=2E

What may be more interesting is that we are running tests over at
gitlab:

https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/linux-5.10.y-cip-rt

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGwxFcACgkQMOfwapXb+vJP0QCfSe9w3nkvs4oP91ub6A/xCvxC
a9YAnicVd6jnmRzTpRTOCsdSOwEsWeM9
=96G3
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
