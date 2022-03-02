Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE744C9E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 08:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbiCBHVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 02:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiCBHVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 02:21:38 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97120396A3;
        Tue,  1 Mar 2022 23:20:54 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A735D1C0B81; Wed,  2 Mar 2022 08:20:52 +0100 (CET)
Date:   Wed, 2 Mar 2022 08:20:48 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] block: Fix non-kernel-doc comment
Message-ID: <20220302072047.GA32222@amd>
References: <20220214091522.100669-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20220214091522.100669-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Fixes the following W=3D1 kernel build warning:
>=20
> kernel/power/swap.c:120: warning: This comment starts with '/**', but
> isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst.
> +++ b/kernel/power/swap.c

> @@ -170,7 +170,7 @@ static int swsusp_extents_insert(unsigned long swap_o=
ffset)
>  	return 0;
>  }
> =20
> -/**
> +/*
>   *	alloc_swapdev_block - allocate a swap page and register that it has
>   *	been allocated, so that it can be freed in case of an error.
>   */

The ones before look ok, but this and next one perhaps should be
converted to kerneldoc?

BR,
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmIfGs8ACgkQMOfwapXb+vIRVQCfYc6BXODZ81bQacVSDH+toteq
XskAoJ19XIxZrFIUblSPdzx7s658llkz
=3Htv
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
