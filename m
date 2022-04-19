Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEEC506491
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348877AbiDSGgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbiDSGgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:36:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A51B2AE06;
        Mon, 18 Apr 2022 23:33:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KjDWz2Qmvz4xXS;
        Tue, 19 Apr 2022 16:33:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650349999;
        bh=4FwEif2YPiKAZKoA68FV0y4+Spendma+CKRcCjHFzu0=;
        h=Date:From:To:Cc:Subject:From;
        b=LlyUlVr11bwWnIUUE2dTsynX+zMYJYIDY8KYcmOWOwt60N01UtxeYyvZkuZR16MWm
         oAbIbW4mVwdqzyaW95XJ/yDrbLyttniZPgSkvjCjIf0qqyjxPuniVH782A0LYqRIoO
         7OXlkenWaxRXbdxDdEmvZKNgCTstb5zw3KxhoILy+NJGr9HtbfAy6R+apTy5ZHr/j2
         lhG3dTN2Ux4MdTk+EghUM6dpSo45MfgPu8k+U6zVE2K7KDNd5jaN5OHd7Y1Jnqc3v1
         JO1prsFjYA7yKv2YFsC3QQ1nUFmBD5ATUMwijYWx0MGz49m+fsdHNqdNMQ/zx0ykCA
         Favkdih34/aMg==
Date:   Tue, 19 Apr 2022 16:33:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Jiri Slaby <jslaby@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the tty tree
Message-ID: <20220419163318.0682ffb8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9YjLyh_6G07rkaRMZSCgp3D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9YjLyh_6G07rkaRMZSCgp3D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tty tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/driver-api/index.rst:14: WARNING: toctree contains reference =
to nonexisting document 'driver-api/tty'

Introduced by commit

  b96cd8b05ead ("Documentation: move tty to driver-api")

--=20
Cheers,
Stephen Rothwell

--Sig_/9YjLyh_6G07rkaRMZSCgp3D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJeV64ACgkQAVBC80lX
0GyfFQf9FzecDnFNZL4rho4NTT0Yp+c0p5rhx1V8MAa6pFebBJA0KkFwN1v985Nu
T/92V9Qq3xavn4lQJ1XSqfq+kI8AnKHFaW2I5Lzu2dkHBtCHpTiom9RbmKYOLhfu
0EmgBw417JECbp1UOorNYbLPVDL+jvguFt9V5K4BvfBdM4PPUtWq5UWCeM0jP7vA
ISmqxGj9gqkRBWgk8wFtMyDMaDWllLKo8EctbjM25dnywZySpWcaHUmhiDJ31Fe6
gMsyz4QwNcGNfQdyIoyBJqbk+PgYwh2CBqtOgnXTlkMOHTkx6VxiTPXeUhAl2SpM
IV7oQ3TjoX6cH0c4ehoYYdABao/nxg==
=R+DT
-----END PGP SIGNATURE-----

--Sig_/9YjLyh_6G07rkaRMZSCgp3D--
