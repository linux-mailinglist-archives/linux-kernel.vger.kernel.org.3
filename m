Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD76D511109
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358057AbiD0GWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358019AbiD0GWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:22:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864F2888F2;
        Tue, 26 Apr 2022 23:19:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kp7qp6yPDz4xLb;
        Wed, 27 Apr 2022 16:19:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651040343;
        bh=ip44o4s69uf3eabHI7PEx7JO19lALyAXC0+aTGAnL3Q=;
        h=Date:From:To:Cc:Subject:From;
        b=HE13h2PkLkjsAY+B5rgdRw1VViCs035NcQ+LeMQROb9l8vpr1EB0hP/66DQrcquUl
         pv6Wk7PBnDkr4B9RHlFkr6098CRHTU1+T4KcmJbHuZooyU3NhzYWfUu+/rxiDG3jNh
         xQFl0m002SSO4U/YWci62CEERhAfhEv05dFCGF1S8F5WNvMPWOrDPs2ep9ISB+RD1o
         P9t53+pMDvYJQh9soLcmH+lbN1pUNXpaQ2Tj8/5bHtaYt938jdILEPgVUTUyPBozxU
         7l1MKnmgYyJ28kIzGlm6R44nqr0seUCPovdZTcUILjX0yXfaQUr9IK61PjHF9eUcQ7
         DeW3Qeq85hYwA==
Date:   Wed, 27 Apr 2022 16:19:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the kunit-next tree
Message-ID: <20220427161901.6522f1cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+wHFzbXbkot0Cv7C+=bFy37";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+wHFzbXbkot0Cv7C+=bFy37
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kunit-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/dev-tools/kunit/api/test:9: include/kunit/test.h:318: WARNING=
: Inline interpreted text or phrase reference start-string without end-stri=
ng.

Introduced by commit

  9bf2eed995f9 ("kunit: add support for kunit_suites that reference init co=
de")

--=20
Cheers,
Stephen Rothwell

--Sig_/+wHFzbXbkot0Cv7C+=bFy37
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJo4FYACgkQAVBC80lX
0GwpQgf/ZOU7slmhIkUtHwuh/vYEh8GDWi+6Jah6RKxAmC3JffWxM/ur5ntUkEQP
Fzkpt0OUAIhZudnGCKRE8qHXvHDrU6rYhQIACbhTF4ba3DEOqNRV0exv5pQDFLrB
ppJUAoiYwSn5X5o8Bz6O5K4HPqjGo0O0rLyGP0DRsmTCKhXlJ7d3wdClGz92Mt33
wfQ481b7AYzfegl75N06BRFNggXpOS83k0i5QU0vhP6hXlLqZNAeXU0qKDdh9BKZ
ZkSflEp3TGRVNn9FaK3zWYLQYjsUlheInZtFqY8G+mbHPi/i9U6924SkQCPPwf5Q
cgQk1R0uFhlnnGYgTMy/MW85OavbYQ==
=o+WM
-----END PGP SIGNATURE-----

--Sig_/+wHFzbXbkot0Cv7C+=bFy37--
