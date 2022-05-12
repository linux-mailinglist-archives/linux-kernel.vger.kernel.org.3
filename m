Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D899525002
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355289AbiELOb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353993AbiELOb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:31:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F95F53700;
        Thu, 12 May 2022 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VZJ1WsTQ5SKJzbWkNRYklpcb3FUCcmNSggyJUBGGeA0=; b=MZv7v/GFSJnPmNpsbPmVj2qtKZ
        ighxhqGSTRN5amZEfnpXh2R278E6Bp7m5zrq0W4h9yMty38gu5V0h2jGgRWuDye7CsxA0t+vI/BiR
        WvH0jHGwYIZ4QGMTUIpcHuGebLcj3o4YFneU8+BFV53rRSnuo+FNr9YWK21ijDkXVxO6P7bPeSKO6
        fSXlP0i9V33l5vAvB5qhWMUZOYwlI1OmvuKAxGIuTb4kbyVDs5nej2FXajlBsTE5eexE3fdGaZWrC
        oEX+Y4rGZ2Zc+mXk9bXi5ItL04TqyCy92euCoePFaiFfdRKlRTLD6HmrfrW9VS5l2Y6BUucezs7If
        EStQN2bQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1np9qT-00DWhp-4i; Thu, 12 May 2022 14:31:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A321E3001DD;
        Thu, 12 May 2022 16:31:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CE18201E11D2; Thu, 12 May 2022 16:31:12 +0200 (CEST)
Date:   Thu, 12 May 2022 16:31:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Zucheng Zheng <zhengzucheng@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <Yn0aMFQ0pBm2F2BX@hirez.programming.kicks-ass.net>
References: <20220512204444.29f3c634@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qwCJ+XPpmHXKzL6/"
Content-Disposition: inline
In-Reply-To: <20220512204444.29f3c634@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qwCJ+XPpmHXKzL6/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 12, 2022 at 08:44:44PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Commit
>=20
>   2cc6edea3673 ("perf/x86/amd: Remove unused variable 'hwc'")
>=20
> is missing a Signed-off-by from its author.

Urgh, my script got thrown off by all the '---------' in the original
post. Fixed now.

Thanks!

--qwCJ+XPpmHXKzL6/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAmJ9GikACgkQdkfhpEvA
5LqDPg//eeXzwf1lkh1UmOH9z4GlAS8yEmmg6y8+3grJAhbUivbUgIyxeJxhEWWa
3CWuouGNSa32yD4HiN6Ypiq7wXyHUv4rlAD4YqF5a1jJAxY28b1ZlazocL2JxP+/
0XVN0UPTlw2LNL+y4TVFpjVeUmcKJRBqQInNhj+jdL1xmtmGYur2h3sI/8mAUTbj
nGgFTGsQXvLjrxiXax5NXqyaCgdkFJUxKSWA97OavYp0464VpVwMVE7PEQbu+Dru
+yfbZJChKZdqoWlOR07zLQGAnYcY34PS5DYVxneoz30bFkdaTGIolCVl+Yc20lym
a708b6alhX6/vwbBm3WEDhFfAowhzd7R+aF+OX0KH8alWDobk3IkzsM1tDwo2xVP
LDoRyNwqElPvgThmr8o7diUi/BK2td2YOSkL8mfOSznNtpyQ/b1ur0P6pcDT2Xv9
SAiFIsbOkgxI6BhMjaFkwlay/F4JWrZK+zEr0MW+w/9cSwgPxRZ2zQMhVyRb7T23
xhGf47J2djCIVsMpMndnmpYjuE739FexJOl/yxHeklyQ97qf0++wEOrTQKNJRCTc
5kFGUHBzk4+el9azw6eSn+i9XdF250flT03/EAfZ23LAlvVR9kUhJW8de8iYKVZw
T8KurAOQsITrO5cjoST0pvqp4vhN9KNa5Cuizi0lRhKSLX3sST0=
=UnyS
-----END PGP SIGNATURE-----

--qwCJ+XPpmHXKzL6/--
