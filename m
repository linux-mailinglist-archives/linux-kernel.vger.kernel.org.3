Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E454F1F1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbiDDW2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbiDDW1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:27:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376043204F;
        Mon,  4 Apr 2022 14:50:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KXPbQ5Yyvz4xsx;
        Tue,  5 Apr 2022 07:50:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649109042;
        bh=0hodjE1FtJ3AN9fnIJnBwuUUot8ym1q+Qm61r4T9AyA=;
        h=Date:From:To:Cc:Subject:From;
        b=TumCdOh/A2DRqOSmxQMYAD5RAX8/jlbSmWvZhmdksg6NpKSBk947kOrhT/+LVRzQU
         9l3Y3PFJ7sqHaNveyouZRUyBXxqG5NVJ63am2Pebx5ZRbJDoh+zb83/8MDBtxAxs6E
         OyjMi5ZrC/2Ga3hP4yxpM03k8gK96RD1AMHY0YQ7DDA5HQ2hazzXNy4peTdfb553F1
         HEyHIcFrVKY4FNzj6GWTCYGro53fgBDykm23AeMTNB44Msl0EdGTtQNJ/0nRxf6v13
         uAEr7I7KCLEEhdi6U/f3MyJ7gpkzueRM0wn3zA97z8Vio7KsK8aETg7lErlNoLuPGO
         wIwrxFHbHbz2A==
Date:   Tue, 5 Apr 2022 07:50:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drivers-x86-fixes tree
Message-ID: <20220405075041.7a73e2a3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HY9efuTy=7n2B2lBHp88UcZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HY9efuTy=7n2B2lBHp88UcZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  753ee989f7cf ("platform/x86: amd-pmc: Fix compilation without CONFIG_SUSP=
END")

Fixes tag

  Fixes: commit b1f66033cd4e ("platform/x86: amd-pmc: Move to later in the =
suspend process")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/HY9efuTy=7n2B2lBHp88UcZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJLaDEACgkQAVBC80lX
0Gyq9Af9HzmqtGoPZGRyG/G0S4rY2d1WuJ9J79W3seBRXOBHnF2Hh2MHPMECmhSM
EqO9b96teliW/z1E9apPkC1grisluZNxdEX/oseiSWOBPr0vQmMThav5y8OBz0Gz
2JtNoc1OXNwABBigz0YY+tq7RUdKE8ThOZIXqhdEqEOGrcgg8pBP4nqPIBUIpN/b
3F0vmTXOCNTMwmxwtMJ66lymGllIILohD1dTonkePTQRFvPIsVKAOHUOuQvTjkRh
zTWCmakG/9Xx07znFasgu1KQyRvhClYAsx7Tv45667Bb8hk4bK8N8WiaDo5QRd1S
wy7M8AtoOq/lI8Lfejh+EIagntWX9w==
=I5EF
-----END PGP SIGNATURE-----

--Sig_/HY9efuTy=7n2B2lBHp88UcZ--
