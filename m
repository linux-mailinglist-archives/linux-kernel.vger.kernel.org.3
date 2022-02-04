Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBF64A91C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356307AbiBDAyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:54:55 -0500
Received: from shelob.surriel.com ([96.67.55.147]:56656 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiBDAyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:54:54 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nFmsH-0004YO-4W; Thu, 03 Feb 2022 19:54:53 -0500
Message-ID: <e4851b501665a808cb21188d9aa621e4255be1b2.camel@surriel.com>
Subject: Re: [PATCH] perf: fix GPF in perf_cgroup_switch()
From:   Rik van Riel <riel@surriel.com>
To:     Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, peterz@infradead.org,
        Yonghong Song <yhs@fb.com>
Date:   Thu, 03 Feb 2022 19:54:52 -0500
In-Reply-To: <20220204004057.2961252-1-song@kernel.org>
References: <20220204004057.2961252-1-song@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+vczTz+joB43epBxXPAm"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+vczTz+joB43epBxXPAm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-02-03 at 16:40 -0800, Song Liu wrote:
> Fix this with list_for_each_entry_safe().
>=20
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Rik van Riel <riel@surriel.com>
> Signed-off-by: Song Liu <song@kernel.org>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-+vczTz+joB43epBxXPAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmH8eVwACgkQznnekoTE
3oNSvQgAptQ1eITlb4orPTA42eiT0z+eBDSNLL65J6JP/uNwRG5RqG/FswefYCEm
oAH5o4D8aps6W5NcYgx+8fyIuwOI/fqqpTfQVku9Yt/HjuQb3smcj1Fv3ol7fV3q
u93VOPpfyeG52xlnt42xZtPgVs0iqKF5sSj3wukyb+XGAdGIeudCdAabISSPFnr5
66HfRHF/d5kgo3DXtV5MoETS56lfkHgjZ/mmlsaJb7UJ8lPQJtnh1/Sp4s9cuown
pcVKhFblkCUVjSS62DZt/8gykwYPpNMDhOGmt2tHKGpV+V2MQjQU00KVRapQ611e
JBL+6bxrfrO1Z/8ZVii+/Bx2lmat3w==
=g9Eu
-----END PGP SIGNATURE-----

--=-+vczTz+joB43epBxXPAm--
