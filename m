Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F73C5AACAF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbiIBKmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiIBKmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:42:06 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7DBC8891;
        Fri,  2 Sep 2022 03:42:03 -0700 (PDT)
Date:   Fri, 2 Sep 2022 18:41:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662115321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/xxuhxcM6QfkTylQcvhMIIqWokz6VUXQjhsUn1n4Pd8=;
        b=aMn6cAlb11q4RMMVIdJPsmR9U9jN9LCVN7BpsTYey3XHwseSB40ft8d2dIs2tgGkDPYFzC
        Kyl+SY+BssuuZszpxfOLx92DCAnwWhkTGiJIZEwOJvmY8nXHLJC0VN/HSkIAtY9TctsVdw
        5XvdFob1yUgw6lDH79GYQudWm8iaVBw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Zhao Liu <zhao1.liu@linux.intel.com>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <bobwxc@email.cn>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] Documentation/zh_CN: add latest kmap_local_page
 translation
Message-ID: <YxHd4tjI+OxhALWC@bobwxc.mipc>
References: <20220902081304.2259706-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d9cWTGeOJTPHR27D"
Content-Disposition: inline
In-Reply-To: <20220902081304.2259706-1-zhao1.liu@linux.intel.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d9cWTGeOJTPHR27D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Liu,

1. It is better to give this patch a more meaningful name, like:
	update something to 6.0-rc2
   "latest" is too ambiguous.

2022-09-02 (=E4=BA=94) 16:13:04 +0800 Zhao Liu =E6=9B=B0=EF=BC=9A
> From: Zhao Liu <zhao1.liu@intel.com>
>=20
> Translate the lastest description of kmap_local_page into Chinese.
>=20
> The translation is based on these commits:
>=20
> commit 516ea046ec555 ("Documentation/mm: don't kmap*() pages which
> can't come from HIGHMEM")
>=20
> commit 6b3afe2eeec27 ("Documentation/mm: avoid invalid use of
> addresses from kmap_local_page()")
>=20
> commit 84b86f6054c42 ("Documentation/mm: rrefer kmap_local_page()
> and avoid kmap()")
>=20
> commit a9e9c93966afd ("Documentation/mm: add details about
> kmap_local_page() and preemption")
>=20

2. Just list the latest commit, that's enough.

> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Please remember above two next time ;)

Anyway,

Reviewed-by: Wu XiangCheng <bobwxc@email.cn>

> ---
> Suggested by credits.
>         Ira: Referred to his task document.
>         Fabio: Referred to his work on the original English document.
>=20
> ---
>  .../translations/zh_CN/mm/highmem.rst         | 20 ++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20

Thanks,

--=20
Wu XiangCheng	0x32684A40BCA7AEA7


--d9cWTGeOJTPHR27D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmMR3d4ACgkQtlsoEiKC
sIVhBAv/QeyFp7DE867xPC3T+tLUZhxe+hm6kFkeM7dwn3LPYG1flH/EU4M2AU+F
M6CfFdtHklv4eNfvm8puCqjsg/NroFq37fb54xmKdIp+8CW2tcCdxub39ehceRMz
3af3W5bkjPje9FzAujHs3c9l1FqwaJHM7+oNm7dEFYSVqsA1fHFptSeogSz2YREp
DTxoBQlOWsvqOYOb0MXE7ul91uZVoG9DOV5wfvXNMZlx316AJa5rvN+gE9IDn6wq
cUIMwKia66ges1LkYqgYEJYy9VvxZ55kSz507uuCQ2epcTNlodjWeS7kSG7nZaKN
KMlFpXTZP1hfGlI6+C9y7VsnCh5Txm9EczIf2QS0lCuY9kFYW9iuQHwldAsFfsJe
1bW3nmxOgxef5R0aJ5NRpciChoWmseiVzT5WmMYgFhTveyrFqcNqoT8tttIj2yML
Cx9jHaanWvatLLdO8Q9aBTwbdVQ6GTCn4oTv79stx4BMxqJ5/MbrjXwlMezzoGij
9Lnwhmqk
=CoVp
-----END PGP SIGNATURE-----

--d9cWTGeOJTPHR27D--
