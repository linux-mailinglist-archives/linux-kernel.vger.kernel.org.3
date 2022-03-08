Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911554D2325
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350385AbiCHVS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344101AbiCHVS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:18:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502BB21;
        Tue,  8 Mar 2022 13:17:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCp7P5dmDz4xYy;
        Wed,  9 Mar 2022 08:17:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646774242;
        bh=8n7HbzxjLGWascFK+nPCboMUEfFVJlNA3NE5yCP9Bp0=;
        h=Date:From:To:Cc:Subject:From;
        b=nRj2ClsyYjA+87irrWqJ0iOFe8iw1rqKY5oKIiA7exMPPW0p3DYwtAacfuCwV0qG2
         QcVS5GSGhDPo28FTI0nJMt7QkaOHhGCzkfsp7hqHrmmGrby3AI2OBalePl+ZoHo4Sq
         ulaaDzfzetfTNLcjthF5C7p2h3IorY9BIJ+br1RVSgis7zFhHuJLHmDQ8uKZxG5WDX
         NTIZyTv9MGQmuBNorQ7Fz3c8DqYkXiI5e/Lhbz4hIrL8NegdyNLB/dGU8A9TYbxwMl
         26rdARYzXpgUI6bnPF9jKkZ3LFyCbYWysJYXxuChtrkmU1qnWzCOILTESAIaeC3cDU
         0N38GhKP9xj6A==
Date:   Wed, 9 Mar 2022 08:17:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the arm64 tree
Message-ID: <20220309081719.54964469@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nR==vPqzq0g0g_YRg+SlPkk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nR==vPqzq0g0g_YRg+SlPkk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  1a7b2121ebd3 ("kasan: fix a missing header include of static_keys.h")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/nR==vPqzq0g0g_YRg+SlPkk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmInx98ACgkQAVBC80lX
0Gzgswf/WZof2tZ4trtmcmaCgzlwZFqVbaBUSdVKTIhTurbBnlwV/wjsdgbhIzLW
uHrHNZsjNtnrfiXnbCDVdFB+uuLTyJkWwkk6ctugF0wTD5yQcY/E8cQNAIVa/GWt
l01bdLjvCVbRNaTV5/XDBww2KomU4WpjozE1W7ES+/viEPVnn9sOzsqGbo8qwQw+
I4CANXT9UyM5KjVzgCsKopTca5lMoMdf73gnYPud0wv5h4RMh9q3fu2SR05sYRN5
4BRlGkecoEtSoAYoUrLlB803kkoZsll9SEJ2JeLWvW0nz3ft/rcfziKqSiUu7+DX
N1Yhs+vUsxDYoUBHX3M3oYJzvFA2cQ==
=WXMG
-----END PGP SIGNATURE-----

--Sig_/nR==vPqzq0g0g_YRg+SlPkk--
