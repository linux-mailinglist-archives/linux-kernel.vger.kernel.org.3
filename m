Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA1582602
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiG0MA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiG0MA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:00:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064DE13CF6;
        Wed, 27 Jul 2022 05:00:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LtC6C5kF3z4x1V;
        Wed, 27 Jul 2022 22:00:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658923252;
        bh=22jeZx+EVHGac2JcBwvKlgVHJYKPVNQxebwTZeaFzUs=;
        h=Date:From:To:Cc:Subject:From;
        b=Fqh1dDSoZi8cU4OabBNSemQYrWqxOBkHCwW63ygbWnzpPxO7iY4f811rYdqhnDmw4
         PmoNt3LCOU1EE7QCcyBZjZGJCuiXz74/hYr3d8C21D3JokPEJZF5kXq2adgSYUAOjY
         UQQEOfEPS/4AklSIDfBv8QGAS6zRuSPSJbzjYK7fuwoADkF60Iw4VlEUwMXCM8kGfv
         qdxjrBWNDXK2buAJzqByI1jwbEot7T+7b0PtYgkRlfr5GgWbshKGPHjIlKW/IKuuel
         lLZ5818RaZzHUeIcrXuhoLT6iC4ug1DYiumutGSTiYWWbDAWU/Kf8TJ1ZD/9FWvpJf
         k2vrzXeEP6xkQ==
Date:   Wed, 27 Jul 2022 22:00:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the powerpc tree
Message-ID: <20220727220050.549db613@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//DrwmQVWtZ5uWe5YwoEux_E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//DrwmQVWtZ5uWe5YwoEux_E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the powerpc tree, today's linux-next build (htmldocs)
produces these warnings:

Documentation/powerpc/elf_hwcaps.rst:82: WARNING: Unexpected indentation.
Documentation/powerpc/elf_hwcaps.rst:100: WARNING: Unexpected indentation.
Documentation/powerpc/elf_hwcaps.rst:117: WARNING: Unexpected indentation.
Documentation/powerpc/elf_hwcaps.rst:122: WARNING: Unexpected indentation.
Documentation/powerpc/elf_hwcaps.rst:144: WARNING: Unexpected indentation.
Documentation/powerpc/elf_hwcaps.rst:5: WARNING: duplicate label elf_hwcaps=
_index, other instance in Documentation/arm64/elf_hwcaps.rst
Documentation/powerpc/elf_hwcaps.rst: WARNING: document isn't included in a=
ny toctree

Introduced by commit

  3df1ff42e69e ("powerpc: add documentation for HWCAPs")

--=20
Cheers,
Stephen Rothwell

--Sig_//DrwmQVWtZ5uWe5YwoEux_E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLhKPIACgkQAVBC80lX
0Gylqgf/VhEW/3p/YXhdwtMCrAVqT7nkj47Yeq1oLvycZndbTg4n0+nYdYgw32uI
B6Kg+3ZSyBzZa0PQcDWHqvqbkuvI7ouOAu5gsuA7r+S5NxToPxfRo5qSYe1/Jj8e
05U79pFxm5kE0o6sas9B7SURMNsLEj/sm/5/KOblu77Z1we3+mthYn5RadnKFl/g
ye0DmX1+CH0/3/VshQAXgwmjSsDGPS7BMgxpIMK6Y8C37T05K3/nBPeNqMGjbp4H
BPhrn00zLCO8dvlSxhxf143sExHKrSDvYulQFI7KWVm+2HJk6BjzYvylnyaxgeXC
kA9nPb91VByJKWtQ0sbWm/RGvSWtDA==
=7Q5q
-----END PGP SIGNATURE-----

--Sig_//DrwmQVWtZ5uWe5YwoEux_E--
