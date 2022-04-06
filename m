Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099E24F5764
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiDFIMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 04:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347385AbiDFII1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:08:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CBB3ED26;
        Tue,  5 Apr 2022 22:50:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KYDBb4LKqz4xNp;
        Wed,  6 Apr 2022 15:50:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649224231;
        bh=7PZ3FsoJ+2ptme2gu7mqW7PuHp/a2hhqRzA7YZz7414=;
        h=Date:From:To:Cc:Subject:From;
        b=oz6dV031CxuborbAjuX5RgW5wpiMVyWp13vQU28ZuylsCpGvHzkq/K22YfGYFAWlX
         vgMtTkI+kKY+Dv3+ceQ9G+t9IZladrQB5DVsw1futYdvDwJnhJuCa3DdcgefQfIZI6
         JGH4QjbAdqKQiAWeEH+RrhP/irBjNgKyAXdoVVO6bQ6rMDU5zv6MoPZ6QIiLWGDGWP
         uJTamH7gjribW1S6IHa1Enr+t/P7JeAgCBUrxPMKWBvLKLulnZ45aQL1KFD8S+/r5D
         PgqPh3OGbgZpoV0GUGEFN7Ii8Qdy9UzjmLKLG/TIMwvk7qhX35hUEfbh09dRh4MAAV
         kzhzX7+3Y2X7A==
Date:   Wed, 6 Apr 2022 15:50:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20220406155030.0dacf051@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rUlpEF7g.GhbEZ/hrKpYp5t";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rUlpEF7g.GhbEZ/hrKpYp5t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (htmldocs)
produced this warning:

include/drm/ttm/ttm_resource.h:226: warning: Function parameter or member '=
pos' not described in 'ttm_lru_bulk_move'

Introduced by commit

  b0e2c9ea5afc ("drm/ttm: allow bulk moves for all domains")

--=20
Cheers,
Stephen Rothwell

--Sig_/rUlpEF7g.GhbEZ/hrKpYp5t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJNKiYACgkQAVBC80lX
0GxvGgf/e0A2pF/iLTLUGePDXq6bOz3pHSt0OiJIXgF9wfnHIG1H+eCufkblYrxn
jYDshdWhGpzf3QJtp8MxzgqbH6j019ekBzvp4DL+1tY5KXs39c5oAXXuEyG1UMYU
bUT8HvCnvapzCKCcloVYNRR4nqaXvHGJe3LbUUR1nRLJ6xleQO8KdbbaGTCaTV/M
VBSKJ/0tkw3W1oW7yW5/qcQuzuMDJPWXUIK9RB/1omEGDJ4tlvLB2AIh3Oaeb45B
zaDYZIOvMhYME5exTu3oyetIAvslyTHYTZXLCV3lO6ZOIvl35IhWlqO+2M+GrI3n
pC9r7owGL6YmQIq0DfUwJ7lQ+KJJsw==
=Kh+P
-----END PGP SIGNATURE-----

--Sig_/rUlpEF7g.GhbEZ/hrKpYp5t--
