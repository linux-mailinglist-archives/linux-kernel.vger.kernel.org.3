Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8C258F5AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 03:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiHKB7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 21:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHKB7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 21:59:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EE183BFD;
        Wed, 10 Aug 2022 18:59:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M393K35QHz4x1V;
        Thu, 11 Aug 2022 11:59:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660183165;
        bh=hlshCIu8xFu0o9Wv+W/0DQv6zxL5tJ/JYNyinzmBvI4=;
        h=Date:From:To:Cc:Subject:From;
        b=j+a+X4NaXj+2vxCwyZ8RohVhqxPe4N1smB7vFW6Uj6sjhj0nzBVcvwJrJ528ift49
         NxAJKOxGHspW16tZvx5Cedb0//JANNh45gT9v6RuySL+fh+nxssNqSOTNmun3pxBLp
         VrJvRpN8QuJxX/n+TckHWcbHoeSGbrj12cy64jUIXAaBSJn1o1EBJzjHYlsozLwz+q
         ZkUCYFebaykQi70wAz+XsY5tthvj2kJCXcxIsZMKQ+rkab3MThhMNWAEOD4cC9as1y
         2xCM1gDE57GBmBZEh0+j+OZ0HaBrhCzuhb07sIVjPt7n3VFYOwhfMpRdPh4oanwqjh
         gMFAmxucFTDDA==
Date:   Thu, 11 Aug 2022 11:59:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Ricardo =?UTF-8?B?Q2HDsXVlbG8=?= <ricardo.canuelo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vhost tree
Message-ID: <20220811115917.1b5c9a57@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2unuc7KNLXnpuFYPOESdxKX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2unuc7KNLXnpuFYPOESdxKX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vhost tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/driver-api/index.rst:14: WARNING: toctree contains reference =
to nonexisting document 'driver-api/virtio/index'

Introduced by commit

  6355eeb59129 ("docs: driver-api: virtio: virtio on Linux")

--=20
Cheers,
Stephen Rothwell

--Sig_/2unuc7KNLXnpuFYPOESdxKX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL0YnUACgkQAVBC80lX
0GwHRgf/cnHYtmhQX9HksjfNg6uGq+OHelcsqaZqa+LnQXuVwJMF1JVvP/zIwkqu
jk1e9ycWc+LzIm60AdegRtCrfp42ibLKq8gGKCrmW3bp7RR7DB0gbaveUIN5pM/n
nzHV+VxbXJxzUdyLkQTTpYFPvgJsx+Be7Ncrt4ynJ6cVjqQxMALIg3im1EH+Ei+h
eKA7ivn5NyYse/SyCxdUGA78vhjc/+MpizZ8jj0OQPvb6lCYUoI6an1x6Rl6B9rK
OEH9tDkrX4gcos5P0UyBwJ/igVBJLxlYRp74I+8nhJbDHDUP4dBU18jaZ6sHVgEx
PWRu5Ic3Ke3xC/0BShl0n/Gw5kKlRg==
=Ozea
-----END PGP SIGNATURE-----

--Sig_/2unuc7KNLXnpuFYPOESdxKX--
