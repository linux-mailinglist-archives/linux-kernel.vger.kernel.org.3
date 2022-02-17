Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01E64BAB5E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243706AbiBQU7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:59:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiBQU7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:59:07 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD637BC2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:58:52 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EDD991C0B7F; Thu, 17 Feb 2022 21:58:50 +0100 (CET)
Date:   Thu, 17 Feb 2022 21:58:50 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.4.302-rt232 (END OF LIFE)
Message-ID: <20220217205850.GA21437@duo.ucw.cz>
References: <164396730424.21109.15121913505546223213@beryllium.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <164396730424.21109.15121913505546223213@beryllium.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is an update to the v4.4 stable update[1]. No RT specific changes.
>=20
> The v4.4-rt branch is END OF LIFE. There wont be any v4.4-rt updates
> from the stable-rt community anymore as the stable v4.4 branch reached
> END OF LIFE as well. As Greg indicated the CIP project is considering to
> support v4.4 a bit longer.

That's correct. We'll maintain 4.4 and 4.4-rt going forward, at least
on hardware our members care about.

CIP project is committed to maintain 4.4.x kernel till January of 2027
[1]. We are maintaining -cip branch [2], that is stable kernel with about
1000 of patches to support our reference hardware [3] and -cip-rt
branch, with is merge of -rt and -cip trees.

If you for some reason need 4.4.x with bug and security fixes, and are
running similar hardware to our reference hardware (x86-64 and armv7),
-cip tree may be good base for that work. Testing of the -cip tree is
welcome, as is joining the CIP project.

[1] https://wiki.linuxfoundation.org/civilinfrastructureplatform/start
[2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-4.4.y-cip-rt
[3] https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting=
/cipreferencehardware

?

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYg63CgAKCRAw5/Bqldv6
8qJLAJ4i2mB1+SbWVVhqYU1RViC7+vcHFwCgnL0nNMSa73k8Sx9y/4krYpVNDcw=
=MqB2
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
