Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4709F58AB18
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbiHEMy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbiHEMy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:54:26 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58A7205E7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:54:25 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oJwqN-0004KJ-J5;
        Fri, 05 Aug 2022 08:54:23 -0400
Message-ID: <73b1d17ec26b4f769a3eda7f9e2edbc10f38ea78.camel@surriel.com>
Subject: Re: [PATCH v2]  x86,mm: print likely CPU at segfault time
From:   Rik van Riel <riel@surriel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>, Dave Jones <dsj@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Date:   Fri, 05 Aug 2022 08:54:23 -0400
In-Reply-To: <YuzN4WeH6GER2YJy@gmail.com>
References: <20220804155450.08c5b87e@imladris.surriel.com>
         <YuwpQEYCwTl+m6j5@gmail.com>
         <17b83f59efbc568c1fe3154f82a5300f3b4cfe24.camel@surriel.com>
         <YuzN4WeH6GER2YJy@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bOI4opp1+CSHarGBvhE2"
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


--=-bOI4opp1+CSHarGBvhE2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-08-05 at 09:59 +0200, Ingo Molnar wrote:
>=20
> * Rik van Riel <riel@surriel.com> wrote:
>=20
> > The show_unhandled_signals variable seems to be controlled through=20
> > /proc/sys/debug/exception-trace, and be on by default.
>=20
> Indeed ... then this too should be pointed out in the changelog.
>=20
Will do.

> Plus the patch doesn't build on top of the latest upstream kernel,=20
> x86-defconfig:

Urgh, let me fix that too. I'm not sure what happened
there, I might have done the kernel build in a different
directory than where the code was :(

v3 coming soon.

--=20
All Rights Reversed.

--=-bOI4opp1+CSHarGBvhE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmLtEv8ACgkQznnekoTE
3oPsBAgAgSHhAAHv2v92Taj+CwR7pBc6klm35qMdjF6F4yUfAyOzi5SaPBrzMlNq
Rbbiww12PUp1zeMr5NXxq2phUFbe+cwWl1lMNBY5d5sSLSAglJkhJj0pM7c0OeSB
Pb7RcTjx9AoUyWbQYYApp9fGaMyp4LFF/Zwe6HD4B/LLySFoh+QEL74ZLr41lIGy
dC7AfNxd8NAuy5IR9qEHZ09Hmn+GPG5WBPcJm/dyg3zXLDLPUn45r5bbChWyycuz
9qs57+BysPE0GY10CxZ/PkM1s6Fa4adrZF7ZKxMGc5WrAMnNhT5FHePScGje90m+
qiTgAs8iByDAhj2MJxK1HjWfwM7RhQ==
=N64F
-----END PGP SIGNATURE-----

--=-bOI4opp1+CSHarGBvhE2--
