Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A931354A211
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiFMWYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiFMWYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:24:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E1730F41;
        Mon, 13 Jun 2022 15:24:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMR254LXbz4xXD;
        Tue, 14 Jun 2022 08:24:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655159070;
        bh=aT25+qFi2ASsveLSmhiMwh2DQNJSO4mLealoIl2BhVE=;
        h=Date:From:To:Cc:Subject:From;
        b=IPPjs5hP5YMAjtLiQ+A0u2seIPNRaKGx9S4K74iIAK/w9UTTjtTJGvAfJpn5u8TxR
         yxsxK7oFT856eU7sKOWMevhQI4aNtD/v54pimS7Ogt174gO9n8RW8/4feeScAyUJBz
         ymkJZg5GiEnhCJpnC68pCm6+l4m5xX+MnEpoBwEBcCzL8+i1qmm9JyHivARyGrnsg4
         WD1G5pzV8n8egAcAtIcJAaIUSOK/aEJbGXA3rud9JpjzuebBmrj9+7DbWv50uXZcgO
         iKPNd2qdXZJRtvNQbSgyJKihBCXPlsELL2yJ7p2vOV2CyNQr6BN734CdEV3gtfvuUT
         ZNEDPcdWh4geA==
Date:   Tue, 14 Jun 2022 08:24:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the selinux tree
Message-ID: <20220614082425.415adffc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3Zgp=F4bWVmC3DV9u_ejB9m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3Zgp=F4bWVmC3DV9u_ejB9m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e81ee824e8a1 ("docs: selinux: add '=3D' signs to kernel boot options")

Fixes tag

  Fixes: ^1da177e4c3f4 ("Linux-2.6.12-rc2")

has these problem(s):

  - No SHA1 recognised

Also, I don't think that is a relevent or useful Fixes tag anyway.

--=20
Cheers,
Stephen Rothwell

--Sig_/3Zgp=F4bWVmC3DV9u_ejB9m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKnuRkACgkQAVBC80lX
0GwVcAf/SFo4WbqtCM3a1OJNIDEIQh18GKho0TVPbNHqlUH7GiS2A7DxlBYzSPDN
gtzDOQedB4Et997GICKV/YUjjemV3UcoGwX/JnFxk20C0bY/NlTV3kvkCNcRz9gh
d8Oh+IKHC5HAsh98KNjxZwjoFGhJv7zI7mkMUGKorMVJx+fnFN1hgvMdiIxvfFpU
G/vAlLddpV+mkWt94rPDfjRw8CyXLDmCVQhokHsAbQTYhkv6S3pUtKqmHk5WhIgo
sN8juH6VrLodUyNTg5WYzoiaQInW27NWzkgrSkQDTYUk8B9LyEXb75nAaKXqsBTb
tHugIyhObBQU4YKURvbjVvUXB3aPug==
=/Axo
-----END PGP SIGNATURE-----

--Sig_/3Zgp=F4bWVmC3DV9u_ejB9m--
