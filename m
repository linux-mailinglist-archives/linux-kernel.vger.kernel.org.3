Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7935F57789F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 00:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiGQWhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 18:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiGQWhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 18:37:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0F1F5B8;
        Sun, 17 Jul 2022 15:37:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmKhr1JcDz4xXF;
        Mon, 18 Jul 2022 08:37:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658097420;
        bh=+TCihWo8Ae0uTeCFxF3SGL3K51LUHWsOcjaLBR6IJ0Y=;
        h=Date:From:To:Cc:Subject:From;
        b=VW936BZWPScbWDrUBxYE4i7NzhHqkiNwexjuKZEwGwZSy3qhE1IEjnuIj5KkGXSTz
         7tNbVlKIcAr7BHe60geVxAeupG2lMfEv/HAzTLbtQstIT4uUBKh+iTn1MoiUXp7508
         VcwVIvjZhp3JUkDgtycfIEDaGa79BbB9ltdrsQeB2p99xu4x6TiBsEdHKS+XQdGdIH
         qlyUlWdMmuv4WjZHRs4SlU9sOhPYSFxwLhzmyslCXxtQE3iVtCPA0oWxcvDkRA2X8c
         Yi5OrRyjvImqycN2DTdvCMZpzSKutgjqSBaGJgdW8dYB6RgxLvnjy1dg42tuGoCLm+
         COTI3NBzmdosw==
Date:   Mon, 18 Jul 2022 08:36:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the safesetid tree
Message-ID: <20220718083659.53ec8dd9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pHOhD7JmSdJvJ9QERMR5SBY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pHOhD7JmSdJvJ9QERMR5SBY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  cd5fc01e17e1 ("LSM: SafeSetID: fix bug during GID policy check")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/pHOhD7JmSdJvJ9QERMR5SBY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLUjwsACgkQAVBC80lX
0GzK7QgAojP/cK8SusSFIz8jD+p7B8tKXnHTR+qK/YSFBaElCtHL36GZafxYOx6G
vgdGtZXEQ5SJqUEWtefvYTMajEFA3EZN1dQQCWO6Kjm1NVMeUqXSbptA/d9OOSRZ
aLu+9b0ohVTeDP01NHlD0BpuI5Pk04CORmmsdYWO/GODRsrwOkg1QxeNDO78oEmT
K2gAKP0oAGgzs2gVZx8z3OrWGmBqi5sKLOkj8tZq5A8B7SjmMB37MMI+oPMzqiNR
wVqBQRWtwSC7id8MwpJmchzzqcpKd6hsqYPmFq+GWOLOdpJx35QKrsu3TlohIjUv
WmKSgFgiAn4R4xEn/mJK+EvGDiq/8g==
=jNbH
-----END PGP SIGNATURE-----

--Sig_/pHOhD7JmSdJvJ9QERMR5SBY--
