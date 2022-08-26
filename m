Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E365A2271
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245740AbiHZH45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245554AbiHZH4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:56:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AB2D4182;
        Fri, 26 Aug 2022 00:56:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MDXGl1R1mz4xD1;
        Fri, 26 Aug 2022 17:56:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661500608;
        bh=0PtRSPSI3FdpeLeDi8zlNlfYXLY3SQCY0hLwkYka4DE=;
        h=Date:From:To:Cc:Subject:From;
        b=Vebr0+jBUilJWfK8CqbAhmFbYm6TlMZ5bfy6tK3/iIJnfVU3gUjDRr8DsnjW8iri0
         ekekQloN9nYZ4kU0LE2GJ2GMfjsSkxN7Uw7ngSlS72x8ByM44QPa/qB6ntIT8BYAJH
         liRn74/SoXXMIpN7V+msHt7E5+Qhbhjkob1juI4RRzyDNL75qwotOxRoabRxHP7nEm
         mH6hDmX7h0oYOBQ6tBMdiEgJudbGVHV+zZrzS2E/Go3yUax/BCtyZXohY3nv3lYrsz
         gbq+xcKQUSj+E3BB1UGu4F3IvcmoELOVeizmBqKJpRyl8RYJxq2lD/U6PFRAZZQ5Jm
         2y0pV7oCiWGgw==
Date:   Fri, 26 Aug 2022 17:56:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the risc-v-fixes
 tree
Message-ID: <20220826175646.77554fff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TL.IjyQn36rp3=Jb4Xs3rTi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TL.IjyQn36rp3=Jb4Xs3rTi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  5024d917e5f6 ("MAINTAINERS: add the Polarfire SoC's i2c driver")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/TL.IjyQn36rp3=Jb4Xs3rTi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMIfL4ACgkQAVBC80lX
0GyzqQf9EPKo1dFYEwetRlbb79RiNMd420WA6fkjQTXZinwx+qUP3wg3TnJEYXLF
hR5pnD3+tuZo+6It/7zEByysxywMpcXNpnPFCSRHnuGkzrEDXxaV6eBUeISuMpth
zm+4ytfAdLAisJlYM7evp5NulZBWxbURVCPofiUFTdDW9Gc6ofWVLsWwAXk+A+PV
xg6z4hQU1xMyEZxP6lU/vUzvsv3IiU6hTZXoynwuP/eiK4ypWLwE6OOkAUXcmEyz
AZQqmKGoOOhxhoJpVdGTbXJCjkb/y4jPjXKSc2/dA3xeyJYB8A73VIZ4eYb1CD3M
wjGS28bUoDXR5pvzCGA49LsMAPmZkg==
=HtIw
-----END PGP SIGNATURE-----

--Sig_/TL.IjyQn36rp3=Jb4Xs3rTi--
