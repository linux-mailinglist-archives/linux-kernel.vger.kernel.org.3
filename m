Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E954B1F88
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347801AbiBKHqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:46:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiBKHqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:46:51 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C742D4;
        Thu, 10 Feb 2022 23:46:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jw5Kh1C1Kz4xcY;
        Fri, 11 Feb 2022 18:46:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644565608;
        bh=cOHXs+qw3p5jeWTYUNSQ6a37/cxDtUPz6RdojQhCpH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eJRgYQbUQYTVEa/SWoTyHjYeYTyjtQFFVVJY9I/L+JaZ058yusb3BSjJBbIL1CJS0
         fL0TC4ebA3lKSQ0mNGDLIqUdrdz+1YVV6cqH78SxReHJ021qKX0zTgxWOfS76yc9uz
         AHPb6aT5yf+BnJ12RQqOlGRPm9tu6sE/lRAv6u7XH3pKQlkKukEWLOzUK2oC0jTiDu
         ytVDy7ZrbFWiVJivHOAqPV0BNlKw4MWLqpevWQFyivDcy553vyzAbLEBruFgBnVasC
         EZztG1HhcB51abtkRPA1Qf+jU6vwGvLJ47CGxMNHQXgo8EDgMNWBrupEtfKXN7hq3o
         neDvaA6HfJFqQ==
Date:   Fri, 11 Feb 2022 18:46:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boottime warning from todays linux-next
Message-ID: <20220211184647.0a62dad4@canb.auug.org.au>
In-Reply-To: <YgW+DopXpFNZTj4k@bombadil.infradead.org>
References: <20220210184340.7eba108a@canb.auug.org.au>
        <20220210193302.686fa61a@canb.auug.org.au>
        <20220210214125.2b248790@canb.auug.org.au>
        <20220210222953.6e078d20@canb.auug.org.au>
        <YgWdbYfWgHP2jBmI@bombadil.infradead.org>
        <20220211123336.54eff9de@canb.auug.org.au>
        <YgW+DopXpFNZTj4k@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/52ORiMzXrF8KF4+TuM3QYPH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/52ORiMzXrF8KF4+TuM3QYPH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Thu, 10 Feb 2022 17:38:22 -0800 Luis Chamberlain <mcgrof@kernel.org> wro=
te:
>
> On Fri, Feb 11, 2022 at 12:33:36PM +1100, Stephen Rothwell wrote:
> >=20
> > Thanks for noticing that.  I have removed the old version from my copy
> > of mmotm today. =20
>=20
> And ... does that fix your boot?

Yes, the messages are all gone.

Thanks again.
--=20
Cheers,
Stephen Rothwell

--Sig_/52ORiMzXrF8KF4+TuM3QYPH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIGFGcACgkQAVBC80lX
0GznrQf9HQBeck5FeKsEabJk1lVTMmUbTO6bviZ8WMCRjANm1bXl1UFxpnkRdBRP
Kef5LJ01uKyWc78rsbppXsceuauzgG82VeAZEzopD9fuq2Go40GIbW1PkTZWZW8T
5zpjmsarGCBHSvm0MUsQq0NOkwe9SEvKqHNF/Oh1Z9uP+vjqruE0nCHVrmOAN6VG
/vg3bJv9oayGXD3eLdrfxRuMzNJkZn9eD8EgwjzgINreUg1U2a4Soa4qJ/sSMpvb
q5OrMCfufyiJ9Qx2EEctfP0kyXixM0eYiMUPCQdeR1j5bbDan9ga6TOyQp3tVrgm
873HS2iv0M02b7LD2sFdKH17eGkwnQ==
=ym7y
-----END PGP SIGNATURE-----

--Sig_/52ORiMzXrF8KF4+TuM3QYPH--
