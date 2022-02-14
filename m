Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E964B50B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiBNMwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:52:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiBNMwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:52:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C870F390
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:52:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A930B80B77
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CC5C340E9;
        Mon, 14 Feb 2022 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644843123;
        bh=qZZL3k/srsL0cacI2dYaRDA5v2y/I+P6sZLsJJUzXNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwXlG5Css/P/t5WlUetNlWNmAG0HoTD16Szv2Tnxxyc9/DRgW6bLnFULMjpdOIDpw
         vf+n9CubAhjdXLSaD3/82rrLRhzIqHqw608fE8WG2E2rrckgu98nHA6ZwPEFJ2MKQ/
         GsYrmUBMK0a2txnuwcASEz11KKE/xQZJkSok5EYnClp732ugrTwsQLbkNoIf2xIuc3
         exQXqkgu3UiKUkbTOmy62ewYSYqbdHTTwC9U22TzUyitPWc5qCizEQNOm4vbfIcmUG
         RqWghYueiugr9zMLmDRJ2JI18Vua3o39cswxRY9ehv1b/TjOxrar3ss4hswIOK5vnq
         6nW9xOSF2CK3A==
Date:   Mon, 14 Feb 2022 12:51:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     trix@redhat.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: irq: cleanup comments
Message-ID: <YgpQb700FoVnuszJ@sirena.org.uk>
References: <20220212143144.2648689-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l1KNKQvblXkYQ60s"
Content-Disposition: inline
In-Reply-To: <20220212143144.2648689-1-trix@redhat.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l1KNKQvblXkYQ60s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 12, 2022 at 06:31:44AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>=20
> Replace the second 'which' with 'the'.
> Change 'acknowleding' to 'acknowledging'.

This is two separate changes sent in a single patch, please don't do
that - send two patches if you have two changes.

--l1KNKQvblXkYQ60s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKUG4ACgkQJNaLcl1U
h9CoDwf/RCz97zzMExmBE7Ym4jfJg6wzIDIG+AhJYv5Mw1gDPxQBU8r0rlVEfuYt
9D/oA8cb08RVNg7I6uIXrPZz9+36eqFHLpE3APXlBtUepLTNilFhPU8xfv9wz1Vd
JIuA7igc5b+RnFiREXhFaYTAPrkMzRFR7LWbEXc/3SiKhglpmSNFkD65Bsf/4uIb
JQxZ6dQmQKYmki0OVz/eLj4S5F4e50/OxETOeDQvFzsOQF/CMdmazZkuv6s8msWP
ZJl7+NkTt2vmXWHu+1+WQ2m/S6KuSnABXdDATVW6zq5o/0fIrkU8q7xMlBA1QWAK
8PUHcyObXe3ZFbK5bGpjs79R24nLOQ==
=Tn71
-----END PGP SIGNATURE-----

--l1KNKQvblXkYQ60s--
