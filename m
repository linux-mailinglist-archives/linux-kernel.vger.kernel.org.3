Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD1A58F5B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiHKCFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiHKCFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:05:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804A661B29;
        Wed, 10 Aug 2022 19:05:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M399q0lS5z4x1G;
        Thu, 11 Aug 2022 12:05:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660183503;
        bh=gqVcAZmDGzFyOMBMJp7BozjV/+rTEc3sG8ZnD4QXDrQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Co1E7iqFNXsHrypdsunj7n2fehBgcQ+W414jK+QzRxPkU47xTP12rGdpDdSxRJwUv
         d+L91s2+1PO48dscct+XD4f9wGFLqKWA9g3gxaB6dJmWc+AbpmMkg8U2FbLbnt4rJd
         yWf6sEVRQLA1FSSb2zSYF3ePmNeBg/77uJiAOBjLm+5DLrDVEciWkineH3/h0ctQkY
         kqBLds49BSyFLOiF/MRCILzsJVQKm7xJoqQS2DVdWm3kMnDedc4SOWYQMdgI1WON3y
         NI0naUFKfiTDcaMbEsqyqTcVbvvBlM8B33+foa+DuPOsQga64qPVhYpxNoaJ0wJ0Jt
         jHkk+fIfwtEpg==
Date:   Thu, 11 Aug 2022 12:05:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20220811120501.15f84a79@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hN0.wEXDBlDWoS79zeBBh.q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hN0.wEXDBlDWoS79zeBBh.q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldoc)
produced this warning:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:9951: warning: Excess fun=
ction parameter 'aconnector' description in 'amdgpu_dm_update_freesync_caps'

Introduced by commit

  8889a13f99e5 ("drm/amd/display: Add some extra kernel doc to amdgpu_dm")

--=20
Cheers,
Stephen Rothwell

--Sig_/hN0.wEXDBlDWoS79zeBBh.q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL0Y84ACgkQAVBC80lX
0Gx9tggApT9HWJfLrmj8L7g33/wgvJsB2UKzAQXkY5rBbl5VYa4eGt3vEQpgFyzZ
5UDcmgxTdz09R3HwiuT7JdppeN3zcUuzf8p93WY0xsYhdfv/0Dh5KOewETjrlTJw
6RLYBYQnhk1cPnaWfNrRm0g0H4DjrUv+H6AUUcFnU1rkD70HzmB4145oZcnfSw4X
t9z13jqfj9HMbSeMJhXycZKORNavntSNiWPjWfiiw73ZqSeHIVjVuLseuruCOxPJ
hNCm6K0guR5WRxbMri1eVLk2D94Wgcs+IR5ZlNbXOtp6ifMazBptY5cYv/ov/hGX
AxpTBApBkGtQZnZUC1xR1lm7O6ybJg==
=8OOs
-----END PGP SIGNATURE-----

--Sig_/hN0.wEXDBlDWoS79zeBBh.q--
