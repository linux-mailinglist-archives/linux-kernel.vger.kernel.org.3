Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE725589161
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbiHCR1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiHCR13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:27:29 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48101F638
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:27:28 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oJI9P-0005Gg-1o;
        Wed, 03 Aug 2022 13:27:19 -0400
Message-ID: <5fa3beeccef7ab959d266973ab1641f011fdf11f.camel@surriel.com>
Subject: Re: [PATCH] mm: vmscan: fix extreme overreclaim and swap floods
From:   Rik van Riel <riel@surriel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Date:   Wed, 03 Aug 2022 13:27:17 -0400
In-Reply-To: <20220802162811.39216-1-hannes@cmpxchg.org>
References: <20220802162811.39216-1-hannes@cmpxchg.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-c5DYBJ2YMqcrTKaCXMk8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c5DYBJ2YMqcrTKaCXMk8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2022-08-02 at 12:28 -0400, Johannes Weiner wrote:
>=20
> Change the code such that only one SWAP_CLUSTER_MAX-sized nudge
> toward
> the larger LRU lists is made before bailing out on a met reclaim
> goal.
>=20
> This fixes the extreme overreclaim problem.

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-c5DYBJ2YMqcrTKaCXMk8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmLqr/UACgkQznnekoTE
3oOr0wgAgywUN9uwGumzoYXp2P0EZjiAvNMUwlHX7GhhRiywm5I5rJzpy9j8MOJ0
qXoptdJBJVXYfFCGAuqkuirya5wUO6Ig0tqcvXH5hbL6wwUbUPs51zUFdLyibPHW
6JipHhsGcrquVHQFoi1ko73Dq7QWpN+2cuU7eD4jLmFnloINkSr+Uz6xbbMa5/da
IMsCHnZq2gxBB3uBfr0MC+jR3n9XkSobG+p9oLYgJvthIfRne30Jom+wJV1xC3OG
vFU99MNQm9YM8GO0TLEttvuVz7aZMmPJQLmko98lR4vi1Fzw28TBg2ntPVC/J1yf
bg7+OxovM8MPbnVDn8DLgnzQ9khLFw==
=zH2i
-----END PGP SIGNATURE-----

--=-c5DYBJ2YMqcrTKaCXMk8--
