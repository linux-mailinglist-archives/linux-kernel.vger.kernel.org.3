Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3661A4B3AF7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 11:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbiBMKwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 05:52:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiBMKwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 05:52:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929765DE68;
        Sun, 13 Feb 2022 02:52:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JxPLw0bLjz4xcY;
        Sun, 13 Feb 2022 21:52:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644749544;
        bh=q1PiSzy9fPtrrGlyILZI15Ey5v0iP5l6DYvReg+qPbY=;
        h=Date:From:To:Cc:Subject:From;
        b=brnyHL0Aq7MiGDh1N2ew5vNbBDnGfEPjzW9EpJlUWj3WmBzsl1mmSOpvcwhxoRPSX
         sM70jvD71BhcsSGELqlnrxUxZquCXldLlB9+iIPrcTd3m2lOTdomEgseY0bIApfXQB
         C8kFpNnRaQTtWQ7M2a8FOPKb9S6pgpsDzbNnOM/P3hJiBe0yc1V3vJQohQs9zE1vao
         hY+ymlIlKBU5m2ZltYrxvvX/yyhLQ3M1LjLsLxyySt5QTpJYBv/jgih76tpzxykoxt
         hW2xDtsJvXKKxAY4yAo//ARcCrZMfvFI8mJvDi0gEOctck2qqepWcsniqXR03142oT
         uaqliYTP0geVA==
Date:   Sun, 13 Feb 2022 21:52:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20220213215223.04cc2755@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aL7VeTQ=NAdC=Dki1Lsr0_A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aL7VeTQ=NAdC=Dki1Lsr0_A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  700e82af02f2 ("gfs2: assign rgrp glock before compute_bitstructs")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/aL7VeTQ=NAdC=Dki1Lsr0_A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmII4ucACgkQAVBC80lX
0GzKdQgAgWiCmn2eVbfUPetwaHqvfIgQWqMyo+nPnrT9aVdyVUq2pwHgvzN9Y0zj
Rbx4DeOhQNKNPGira2IxVvUwD3crIcCUWMoFRrG7iU3JOUdflFZ4XIGn0QBu2DF1
kV5tXkzDJoJe6NFUceZWS4mr524rISMkv0vyLypwNByfG5Yih1VkyeJDm0Q8Lulx
2P2SDmRJAG/hC3XPOZixOnAQtWKz+I0U+e428z6lOvKIyqF9xKo95vFQB5UODN2r
BXqcJCOtFpWMNsrNOIIsJMEab73KodDgTm0SMKcDXyut0qt5MDPMZ3nLZqfmo8/E
rhsJWtaKzHJaWA4AIEPUP4E7kY4wjQ==
=ZzP2
-----END PGP SIGNATURE-----

--Sig_/aL7VeTQ=NAdC=Dki1Lsr0_A--
