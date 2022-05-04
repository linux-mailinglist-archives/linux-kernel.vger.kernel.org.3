Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAF451AE19
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358467AbiEDTpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355901AbiEDTo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:44:58 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7202C4D628
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=bfQjJp1hnaL5QWRQQRqZLDYnOo/e
        vFULx7ZI4z+9tiY=; b=npvgPHtLbgcACCG85UpI4tywQ9Lt2qD2FYYC/kDuQO0Y
        2qglEl/RYQ1JoVZLgpVtMiyptElvt2RDV59NRztjczsujju+dSk6aM8/1nOzg7Hm
        JlgB1f8QNnLPPV8L07JLVUHSgTjcmEcQDRQJdUXCjokW3LKu9aXVhIYkHl1A7QM=
Received: (qmail 1531107 invoked from network); 4 May 2022 21:41:19 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2022 21:41:19 +0200
X-UD-Smtp-Session: l3s3148p1@onAIzzTeGJwgAwDtxwyXAP9dq+3qRUcy
Date:   Wed, 4 May 2022 21:41:16 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: renesas: R-Car V3U is R-Car Gen4
Message-ID: <YnLW3FO+FOV/FXX9@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <2bbecad7b6c24c0d5c1797b3f7f0733d5ba33842.1651497066.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="psvJW5ppJa1endeB"
Content-Disposition: inline
In-Reply-To: <2bbecad7b6c24c0d5c1797b3f7f0733d5ba33842.1651497066.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--psvJW5ppJa1endeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2022 at 03:35:24PM +0200, Geert Uytterhoeven wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence reflect this in the SoC Family field.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--psvJW5ppJa1endeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJy1twACgkQFA3kzBSg
KbbUsA//WO3/F3T39KYOV3qGgIKnIJEpobWTloFiYpsInxdW29Z7+rNxXNGsR9ez
eJ2BzEnaQNQxqQ01VqaM7HFCBEDB84Ma91MklSThYW9LdHt0YM3UPHH1DmFERsG9
v0BZ36D2Bva/kxraC8GDrDVhnowodT3dlVAPT75P/mXIV/c9WcB2SIp7qowmcPJp
6KADQm4IdqA56tLvvsjRZoxqMFHJTRGb3vpcdgU/n2BHkcWxbElCVJrXfiE3bwdS
+Nb8fZNRebsoMUSdB/zM+8eOJHp1UF51FgPHtPGBROSk9A0s0oXoICkN0hJVSme3
LNZ4k27hZvVFcB3QY3fCuEi1o+gMTUXFDB2iJMuNAeVpQtPi/nMUydQntvVkJjp9
6gx5/rc0750LGX9Ztr3nExyg7rrplG3WkGlEz5ODzyR4+D5iKuZ2z9ewZnXg4l0t
cC7X0kMcTNIrYEFWFsVychVL70nxmeO1rZTJ5f2kBB8iYPWvmzRAhofZKId01XBB
3kRahltzWFmtlVO3amUui2dVkshT9YLY2nSqj99zvK56BjkIIQjL6KnB9H5ZKWZj
mu5VU1Ihfoy7LjHFcee7Y0zf4lRzDcJxkRtujrCCsB3D8vIWHZjls4K3BlEH9GUF
RPZFEY+9NzeMCclgrOrwkpzK6yIB0WoJEyUZ7E8bMMTT8u4kDBc=
=Ekh4
-----END PGP SIGNATURE-----

--psvJW5ppJa1endeB--
