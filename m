Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE358B002
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbiHESqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241416AbiHESqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:46:51 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BBC1EC5C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:46:50 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oK2LR-0007nN-Bx;
        Fri, 05 Aug 2022 14:46:49 -0400
Message-ID: <002c12c92bf17fab467c28660abf933e12709183.camel@surriel.com>
Subject: Re: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
From:   Rik van Riel <riel@surriel.com>
To:     ira.weiny@intel.com, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kernel-team@fb.com
Date:   Fri, 05 Aug 2022 14:46:48 -0400
In-Reply-To: <20220805173009.3128098-6-ira.weiny@intel.com>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
         <20220805173009.3128098-6-ira.weiny@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ky+2NogySQXq+2iwZg1g"
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


--=-ky+2NogySQXq+2iwZg1g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-08-05 at 10:30 -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>=20
> The CPU information of an exception is useful in determining where
> bad
> CPUs are in a large data center.
>=20
> Define arch_{save|restore}_auxiliary_pt_regs() and set
> ARCH_HAS_PTREGS_AUXILIARY default to yes.
>=20
> Store the CPU on exception entry and use it later.
>=20
> Cc: Rik van Riel <riel@surriel.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-ky+2NogySQXq+2iwZg1g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmLtZZkACgkQznnekoTE
3oMPfwf/SzHHY5MJ9SXgHddmkMiQqg5au3t7boXsCeXuiSBrqw8wb1anemZvfAlG
hAqzfzx0HADaxXpGcoLnhIgv0QqXWMmpwlp+JkTyUnuZQiNU6OWKiWLhqC+mQduD
z1C0uZhIOZc7nadcRXIv6ZN3y26SclRQWqz54GRvuOSB/XvefCYwfhlt+OKnzQn1
lp/GQOffG5IzF4KeyiiXOQBJqhUfWwYTC8kDNdjfjdj2Dt+bbGYyyq+3XDp44Ziq
YvzP790hb1nPdCCvNYJxVLTqaNUb1yIPpwCF9zQNCEOLNM3gsMn0oZJJFsk1VqPY
nzvdZmntoZdznMjbZ3MdfF6XDbQVpQ==
=oo38
-----END PGP SIGNATURE-----

--=-ky+2NogySQXq+2iwZg1g--
