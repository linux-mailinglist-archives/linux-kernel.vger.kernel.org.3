Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BDD4C9761
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbiCAU54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238475AbiCAU5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:57:53 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1037876E18;
        Tue,  1 Mar 2022 12:57:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7V1J65SHz4xZ5;
        Wed,  2 Mar 2022 07:57:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646168229;
        bh=zwKdTFyMOhfcMMera5SvympTUYlkkCbI+u65zfLEmxs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YWeGCN+tm2BNWc8sNs8ISGN73ryugaXYa7VefjMslFOZTCk3Xnxl408wFRtDUju+P
         K6c6/YbMjPe+CX4T5+AME6V+JkuBglpusN9rfStgtkp+11cPfOPrCS4i77QZJJ33HB
         uwElW7v+Cr/LhKdlIy64Dtpt40tfbZTa6e7M2PRCcjJrqjGdPCqWebzWZS/81hqTxn
         o3usI0X49DHzG/6joav4dOgxB7zehcaN1Fon6wMp/XGc79hSn4J/5d1Ty6MS7K9Dep
         6RwD0JuaFzkn0WdNDwd41AbHdlGrNEaU5KTr2DikSK4UKkyeHfBdho7lZI6Cql5GSW
         b0dnqLeb5aFaQ==
Date:   Wed, 2 Mar 2022 07:57:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc
 tree
Message-ID: <20220302075708.73e2d8b2@canb.auug.org.au>
In-Reply-To: <20220302075602.0ea0de3d@canb.auug.org.au>
References: <20220302075602.0ea0de3d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aiLkjA7QwzysQrCk2FJUw=Z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aiLkjA7QwzysQrCk2FJUw=Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 2 Mar 2022 07:56:02 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Commit
>=20
>   8fcc54796bdf ("arm64: dts: armada-3720-turris-mox: Add missing ethernet=
0 alias")
>=20
> is missing a Signed-off-by from its committer.

That is actually in the arm-soc-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/aiLkjA7QwzysQrCk2FJUw=Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIeiKQACgkQAVBC80lX
0GwmBggApZ9aK2kbRFW8RJWZkGgR7AyMjHGsdArszRW/wmJuhV1cB77/89okqZTw
l1i8B2MWuwaNrIypDdC8wzKlChdIjCmP/N+BkXHT5MbanZIDrYBQjTh7T2SZFHP/
L/KKVENrZzZcvpC0BuLj0CvtbJMCCzG1fPKYTjGwHrCqadVI+sbJOcttKAYYMDqT
rrg9ZAeJcGrn0pyfT7DfKa/xIXU8scd44oXIJwp/MY1JjAgnTfesBUUE5TFAJwDo
OcErAGs0WGFqyYmcND6LI+pGRbLxla3jMBgrsXk9mluGfMaONUDeIVHaVSuNgh3t
Hwc2nGpz0AIGB7zmAxmCodKofKmWZg==
=p7M8
-----END PGP SIGNATURE-----

--Sig_/aiLkjA7QwzysQrCk2FJUw=Z--
