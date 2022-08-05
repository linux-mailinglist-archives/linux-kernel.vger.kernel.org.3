Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB8258AFC8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241032AbiHESey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbiHESev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:34:51 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D227AC25
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:34:50 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oK29p-0000cd-8o;
        Fri, 05 Aug 2022 14:34:49 -0400
Message-ID: <28914dc436a3f8b3ef39bb5d24b2dbc21cff180e.camel@surriel.com>
Subject: Re: [RFC PATCH 2/5] entry: Add calls for save/restore auxiliary
 pt_regs
From:   Rik van Riel <riel@surriel.com>
To:     ira.weiny@intel.com, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Date:   Fri, 05 Aug 2022 14:34:48 -0400
In-Reply-To: <20220805173009.3128098-3-ira.weiny@intel.com>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
         <20220805173009.3128098-3-ira.weiny@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CBglU9idFPVSVkUgby26"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CBglU9idFPVSVkUgby26
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-08-05 at 10:30 -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>=20
> Some architectures have auxiliary pt_regs space available to store
> information on the stack during exceptions.=C2=A0 This information is
> easier
> to obtain and store within C code rather than in arch specific
> assembly.
>=20
> Define empty calls to architecture specific save and restore
> auxiliary
> pt_regs functions.=C2=A0 Call these functions on generic entry/exit.
>=20
> NOTE: Due to the split nature of the Xen exit code
> irqentry_exit_cond_resched() requires an unbalanced call to
> arch_restore_aux_pt_regs().
>=20
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>=20
Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-CBglU9idFPVSVkUgby26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmLtYskACgkQznnekoTE
3oNJzgf/dq+ctvpJyQvpn3EdDgKiNPW+eCTFYvQHZPXLzrUhcyJf0kzB//4r03QI
xcfzCBuV/igrUS8LD+SqT9KYCH4IpanQrvuH5KE7NIzA2FuTsvOvAwVAqD03jVRY
KIwvpM+Veamrscn6d013rTOpujh2fgStq6ckH0rHopFsVFEBeOsuj+tu3dLsU9e6
4I30R+/UELurMUBIt2cQFLcyh2Sf87BJ2owelkq/2hPgqsay0VGV4GaRykyYI7hK
RRvpw1ugWy2saqJhF9AgdZBihtjHBE7uqSXhvzmvzd1+VH7vDU8NOMoA3sBRJIYy
GW4aWaaIR/867n6s5hZPjj7kndy+wQ==
=+cai
-----END PGP SIGNATURE-----

--=-CBglU9idFPVSVkUgby26--
