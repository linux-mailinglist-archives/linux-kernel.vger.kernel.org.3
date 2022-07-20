Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5657C075
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiGTXFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiGTXFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:05:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF383BEB;
        Wed, 20 Jul 2022 16:05:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LpB9n0g8pz4xCy;
        Thu, 21 Jul 2022 09:05:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658358301;
        bh=Pad65OonXhfHGXFjpCFpnwi3rdmoLZjXrU7Mm65EMcY=;
        h=Date:From:To:Cc:Subject:From;
        b=ItjMBJrm2vi3Jhp3rW2aYtQn5Qy4HYMJijwSoOoWd2ZrM3pZ6ZYGzvuhLaHw4/go1
         JlLsTlx5hRwx/UMosP0Qs3nmLCltG/+V2ofsREsXUH3OXU+YhjLnNiCVi4TFl2h55O
         VVYBmRs7sZYF+O9Zz8SQc4F12yBjNMJEk+naCxY22t4vpaYdQ++N7Vkyu6aad2Kb+J
         CGt97ixtqlRw21tk6vBhDVRPtMZVe+hC40fXcifMgD3muDRvKGLlxOaY1jGuNc2TsY
         tZfLJB6O7MFsCGHC/4WYYeaB2OWzC8dh5zJRK0vxJAoHeTTsnv2lzDi/QsXTM8Vt7i
         LVE4nNBarZlxQ==
Date:   Thu, 21 Jul 2022 09:05:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Ian Rogers <rogers.email@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the perf tree
Message-ID: <20220721090500.35774b43@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RlCDqEavVPgpxDi0rLi/j3c";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RlCDqEavVPgpxDi0rLi/j3c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the perf tree, today's linux-next build (native perf)
failed like this:

Traceback (most recent call last):
  File "util/setup.py", line 31, in <module>
    from setuptools import setup, Extension
ImportError: No module named setuptools

Caused by commit

  ee87a0841aa5 ("perf python: Avoid deprecation warning on distutils")

I installed python3-setuptools.

--=20
Cheers,
Stephen Rothwell

--Sig_/RlCDqEavVPgpxDi0rLi/j3c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLYihwACgkQAVBC80lX
0Gwl4Qf/V4b0eJpVOxcDE0+k98Lk8ulPlNb/UZ9GTNvXuO/9RYWZ6z2d0hdcbvNh
H1IB5cxCFDeXIXKlwG+pJpJ2hWwwop1LjtYK4YlvnFSpfxaXjVWT8+XQKK0Co10w
sAj3BAy7FlKEQb6Bk/Z9yGftZgfBXnHFo9rc8pcesemxM0mnY74zWAdaOgVHuqVJ
cnzac0dlhiCxRUPZU28lsEmQWb2ja/T57hUw4yfFAN6x2+wOARZ9uGDQfPedcSbM
FGOgj0PfRJ+3DJWr0ZLkXCkDzdE3wpTcHYDhZlRaNDvPv3O6vNgBjn4p7D6U1kAb
d50OUbdNwK84yEtt4P7BuDOx+YCq7g==
=E7O0
-----END PGP SIGNATURE-----

--Sig_/RlCDqEavVPgpxDi0rLi/j3c--
