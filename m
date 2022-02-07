Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2364ACAD8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiBGVDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiBGVDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:03:07 -0500
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 13:03:05 PST
Received: from 8.mo561.mail-out.ovh.net (8.mo561.mail-out.ovh.net [87.98.172.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AF2C06173B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:03:05 -0800 (PST)
Received: from player696.ha.ovh.net (unknown [10.110.171.96])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id EF49B22C5C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:25:22 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player696.ha.ovh.net (Postfix) with ESMTPSA id 154781CFCE83A;
        Mon,  7 Feb 2022 20:25:16 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R006f8eb3e46-876a-4ae5-89e1-dc6a7451b8e5,
                    3A825F87F2584202EAD4C0DC0B19FF83D581AB08) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Mon, 7 Feb 2022 21:25:08 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Remove usercopy_warn()
Message-ID: <20220207212508.432a6894@heffalump.sk2.org>
In-Reply-To: <b6e9e005-1269-d591-77b0-7db2edd996f4@huawei.com>
References: <5f26643fc70b05f8455b60b99c30c17d635fa640.1644231910.git.christophe.leroy@csgroup.eu>
        <b6e9e005-1269-d591-77b0-7db2edd996f4@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BTXhOGVfCk=eNZZtoTesO7u";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 9237445785914672774
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddufeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejkeffvdfhjeekffdukeehvddtvdfhieehhedvheekteekudefjeffueeuvedvvdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrheileeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BTXhOGVfCk=eNZZtoTesO7u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Feb 2022 20:25:19 +0800, Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2022/2/7 19:05, Christophe Leroy wrote:
> > Users of usercopy_warn() were removed by
> > commit 53944f171a89 ("mm: remove HARDENED_USERCOPY_FALLBACK")
> >=20
> > Remote it. =20
>=20
> s/Remote/Remove/
>=20
> Except the above nit, this patch looks good to me. Thanks.
>=20
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Likewise,

Reviewed-by: Stephen Kitt <steve@sk2.org>


> >=20
> > Cc: Stephen Kitt <steve@sk2.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---
> >  include/linux/uaccess.h |  2 --
> >  mm/usercopy.c           | 11 -----------
> >  2 files changed, 13 deletions(-)
> >=20
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index ac0394087f7d..bca27b4e5eb2 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -401,8 +401,6 @@ static inline void user_access_restore(unsigned long
> > flags) { } #endif
> > =20
> >  #ifdef CONFIG_HARDENED_USERCOPY
> > -void usercopy_warn(const char *name, const char *detail, bool to_user,
> > -		   unsigned long offset, unsigned long len);
> >  void __noreturn usercopy_abort(const char *name, const char *detail,
> >  			       bool to_user, unsigned long offset,
> >  			       unsigned long len);
> > diff --git a/mm/usercopy.c b/mm/usercopy.c
> > index d0d268135d96..e7b0cb49daa1 100644
> > --- a/mm/usercopy.c
> > +++ b/mm/usercopy.c
> > @@ -70,17 +70,6 @@ static noinline int check_stack_object(const void
> > *obj, unsigned long len)
> >   * kmem_cache_create_usercopy() function to create the cache (and
> >   * carefully audit the whitelist range).
> >   */
> > -void usercopy_warn(const char *name, const char *detail, bool to_user,
> > -		   unsigned long offset, unsigned long len)
> > -{
> > -	WARN_ONCE(1, "Bad or missing usercopy whitelist? Kernel memory
> > %s attempt detected %s %s%s%s%s (offset %lu, size %lu)!\n",
> > -		 to_user ? "exposure" : "overwrite",
> > -		 to_user ? "from" : "to",
> > -		 name ? : "unknown?!",
> > -		 detail ? " '" : "", detail ? : "", detail ? "'" : "",
> > -		 offset, len);
> > -}
> > -
> >  void __noreturn usercopy_abort(const char *name, const char *detail,
> >  			       bool to_user, unsigned long offset,
> >  			       unsigned long len)
> >  =20
>=20

--Sig_/BTXhOGVfCk=eNZZtoTesO7u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmIBgCQACgkQgNMC9Yht
g5yLtg//ZTIlI9ZMBzHv0WwyUdxM+A7Zt9ud+2LrYM4Y45YUnO2ZVhuYEYMfyvN5
7W7I+SbijmY6NlwDFlFV5tqomeJYC1u4eNqJL1owcpGT6wz6XkOPo2O28VYv2/Z5
Kq5CUP9HLxxhLICwC61rcCDz+uezwe+6OzfGl6SphlDCLng+XHiKky7gPJeL6o31
zmE1O1jFovodFjjP0hKw0Zla3aQnxBWEUPZxSH4bij/5yBKc9JG2EpiUm3YsDb5q
aBU6ZOi3LuDhXvxrqak70jG72jpITSyzLcC8Ob0aWDcA6uA5OFckE7mIYm26FpBN
ke1wDkBB02UYsr6qJ7LFFkdxFRAFY6En2eEHyksDp8R27BGLk7q9ca3yO4noO+4Y
xq46iAZo8Sl2SFSPXc2PjaOc0wt41dJFnduK6OoYukQRBXQ8OENcOijcO598tGwt
Rq4p1Ltu82N7U9+WnrANydDgU1D4oC8ldqqVmC1JIfCaGuSti+97S9iiQRH5hwXF
LUH5IdSi2Acax2w5gMHF0NRInJMx0C7yHAdcgNpCsSMCP8NBTbmKChKR2UMZlsq9
2lBtYjbdTNCds/HfbtD1NGAWk5PYtOgrOsTR9GhsTxXTaxROylxW/KslF7F4Y6IV
nX0xXW914tejTbOH9sm28U+PxDhQz6boGjf0bz3fwMhvhtWnEWM=
=c9dy
-----END PGP SIGNATURE-----

--Sig_/BTXhOGVfCk=eNZZtoTesO7u--
