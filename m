Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF61559410
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiFXHTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFXHTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:19:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA5E67E63;
        Fri, 24 Jun 2022 00:19:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LTpR73Pljz4xR9;
        Fri, 24 Jun 2022 17:19:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656055187;
        bh=GZsDX6Lk/szTTYM2PQO4YfXuXCRgLt4KmsvF3iK4pvA=;
        h=Date:From:To:Cc:Subject:From;
        b=VwhMxKsO4T2/Ekpa2lHosmB65gZSYe6xZGxJa9P3lZD72Wal4f1nOCnfQi9R46otA
         av00UoCgGcL4UOXlVFwFXMzKY81zgyuQ13S+BdkFlcCRqm/x9t2rH1oeYl0/e6Q3f8
         l5RSK9lLgF1HcmLZuRiE++8AEVG8fj71SrnRgmmMSfhYcE7ynzUcMLvz7oFFyqE2Xi
         utVlG6dvwWllgJsIJbbY1LmCuX66w/9o/f79r3vwv9WvA+R+vedsYjN+TxkaKzjvh9
         F+rPJ8aGrPYLDbUKnir+h5F7NYm01rEqOMrbnXJZ2VUS6HJk4Jr0zaqeqZ42UPdrpq
         zI6RHz9y0ZehQ==
Date:   Fri, 24 Jun 2022 17:19:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the pidfd tree
Message-ID: <20220624171946.705f7aed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SI.6mJhU9AxsxZewErfj=9H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SI.6mJhU9AxsxZewErfj=9H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pidfd tree, today's linux-next build (htmldocs)
produced this warning:

fs/attr.c:35: warning: Excess function parameter 'uid' description in 'chow=
n_ok'
fs/attr.c:62: warning: Excess function parameter 'gid' description in 'chgr=
p_ok'

Introduced by commit

  fc643cb39fc6 ("attr: port attribute changes to new types")

--=20
Cheers,
Stephen Rothwell

--Sig_/SI.6mJhU9AxsxZewErfj=9H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK1ZZIACgkQAVBC80lX
0GzRBQf/Tximu5jtosOTXt+9J5t2wUZ+2zZQX65Kd92NwtPK0gRUBxvuIcYsZ3Xo
ubXt7qGzOP8uUaWu/dQ6VkxQD0v97bjRb1VhEh5mOT0Sc5mIG83qDqmcLFC8CVF+
Mbq0Y9vd79q5QySehoOQD+nhha2n77iZ8/bvvfC+4okMHYODnCWrvfHI7hU4WF3z
D2lbZkHCR9WlKSJHLYpLNEz4r6c7uJJ6aVT2H1zk/EQ31FCoj5NETJ1vNBcJf95u
puKmjghY4W7kr8gcIdEtf4stC87puT8cBP4VokQAxwRpZwg5lYo0B1RxZ+JzQucX
2MtdCqnthAXP3fFv1Lc7r0CilUnZpA==
=ZGRr
-----END PGP SIGNATURE-----

--Sig_/SI.6mJhU9AxsxZewErfj=9H--
