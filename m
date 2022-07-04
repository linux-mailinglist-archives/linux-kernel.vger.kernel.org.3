Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF97A565FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 01:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiGDXRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 19:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiGDXRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 19:17:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD01101E4;
        Mon,  4 Jul 2022 16:17:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LcMCP6cQNz4xTt;
        Tue,  5 Jul 2022 09:17:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656976642;
        bh=1vLTo+qnd53//VVI0HxVN4P2k6b4rqQR/tYhThL5JLw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RXEF6WfAwx+fuUXYAjFKUQYacvxtqI4WCSuVEueqd5jmWRuivcxJjnEeP9ivDSUN5
         RbksYaKwIUvT6Ijzdy8vTesXl4ePYUG8qwe7imCkfh3f14890SMujS6301zTH7XcIA
         DlGxH0rBFoW3y/EKxyTqWrMjktyNxdryFHajJw8I1hqGFZjoC2YhSrOj+C7ip7zkt9
         71UZI9Jz4j6/8/UkTxaeXtaUJ21M4Hxx8nleB4QjCBywklRMPrqwKOci4MTFKclf6o
         heiaCNzcpoK0ZPfQOwnrv92kUOYo4oS12R4Slu5rxIEQ9GdzfJOCQ2iuHeZDRjUjog
         rHCZVwfOe5okg==
Date:   Tue, 5 Jul 2022 09:17:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the kunit-next tree
Message-ID: <20220705091720.7b7e327c@canb.auug.org.au>
In-Reply-To: <20220427161901.6522f1cf@canb.auug.org.au>
References: <20220427161901.6522f1cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_xjPfU7g3QFOG_H94can3zI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_xjPfU7g3QFOG_H94can3zI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 27 Apr 2022 16:19:01 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the kunit-next tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> Documentation/dev-tools/kunit/api/test:9: include/kunit/test.h:318: WARNI=
NG: Inline interpreted text or phrase reference start-string without end-st=
ring.
>=20
> Introduced by commit
>=20
>   9bf2eed995f9 ("kunit: add support for kunit_suites that reference init =
code")

I am still getting this warning. (Its on line 324 now)
--=20
Cheers,
Stephen Rothwell

--Sig_/_xjPfU7g3QFOG_H94can3zI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLDdQAACgkQAVBC80lX
0GwNzQf9EyNb+dpXE4IhX59F40w+9xlYDv1ykRnYuQpgPA6mPTrPsLjHDk2jx05F
kUO3HIc41vHWNy3WOhathYu7hqdof/CmWSW1uGWOQyvKVS7GmOx7mMl34MbbNWx+
GPAN8ul90IqJ9QN4knG93ofgyU9TC+pJHU7rDYm0RgZGOjgX74yaxpGwpuRldShU
CU8bh0hVe+TUkumpZuuDv1H9tsrIIhq2FqNzdIScBgPzCXVZD5bYkgKhXp8Sgxt9
CeWYmJbaqipuoICwWhRtIdx2kf7Z2h03CyGykVb1rnpgq5Vi1iVO5gGRO2qgqCuP
ZQsEBF7uOIBKW/QPLfxxJI2ZK+CikA==
=SD9c
-----END PGP SIGNATURE-----

--Sig_/_xjPfU7g3QFOG_H94can3zI--
