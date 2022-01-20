Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A6B49460D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358310AbiATDUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiATDUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:20:00 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA5EC061574;
        Wed, 19 Jan 2022 19:19:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JfSRq5hcZz4y3V;
        Thu, 20 Jan 2022 14:19:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642648792;
        bh=9Hvbm+Xuhtmx0SV969rssKTFL/L1gqGA6Cl71idCz/8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hYMSnaBsmEUZ59cOoTPKH99N4Y8ru0JD2DS8Y5+5HdzMLJ/sxuOUD/RrpNmxKvQRi
         XhVX2+vW4FHR5sAn/FDI6jKUZZqy40z53TfOWOAQmzHzbujxwP+Ba8p17MAx461s7h
         gv3t13eXhIRTD0jncHariKNgfRF7+tgwnWdYgkfILWXa/aQODYRjyFBN0VUo91I8nI
         WYS12tF59KeC0X6AZtGRNWUAKMDOP+oeQw8gQeh/34lof9ddihQV3zQILcMvaXHSZq
         z1k14Wtr+tgyDdCjxpzpvAoBUgIUCCx0U15nl8c3TOR4kj+3RIt+Px1Hu3pBs8VjJu
         IIenW7L688E9w==
Date:   Thu, 20 Jan 2022 14:19:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20220120141951.30609ba3@canb.auug.org.au>
In-Reply-To: <20211015210104.0f034544@canb.auug.org.au>
References: <20211015210104.0f034544@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3I6dgusHAyO+qlE=quyott0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3I6dgusHAyO+qlE=quyott0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 15 Oct 2021 21:01:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the drm-misc tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> include/drm/drm_modeset_lock.h:74: warning: Function parameter or member =
'stack_depot' not described in 'drm_modeset_acquire_ctx'
>=20
> Introduced by commit
>=20
>   cd06ab2fd48f ("drm/locking: add backtrace for locking contended locks w=
ithout backoff")

I am still getting this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/3I6dgusHAyO+qlE=quyott0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHo1NcACgkQAVBC80lX
0GxVLAf+PCFXWknuqm2TATKAyfYFEbRoFcVbcD2A4xQK/KPyMVY5rljdqhyNARTu
DWm8btg58EBtkhQf0S85JFoQ4xu68o5VodRfbtXEiUwd8+RTcuiW1XhOzTCpVdos
qxSaHDboRT2r9WTGMAEC5m4BhQWX8hgfQu0bw/QfFLBWGo+GnWAZTF2bDnSN4fkt
KotRNI1hwq245qsWy5FulKlJqbq7+m5E8ZSSNdsxvnwTWqHpOR07xOp/9JpIAP9j
OD/JDxdZcBVsbznH+3v+PMf4fzbu1FE/V+YSzcewY4K3jK8JVw6aRL0ut+uMxUya
4Nqo8U//wVPHDwshmNP7HW/KV7MfoA==
=Hfou
-----END PGP SIGNATURE-----

--Sig_/3I6dgusHAyO+qlE=quyott0--
