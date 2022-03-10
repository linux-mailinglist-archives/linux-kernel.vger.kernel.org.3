Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0C4D4396
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbiCJJed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiCJJea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:34:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEC7C7936;
        Thu, 10 Mar 2022 01:33:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KDkQH3sq3z4x7Y;
        Thu, 10 Mar 2022 20:33:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646904807;
        bh=q+xqH7Ft5JQCCBUClzfLKc9UTW8bJal4XkE8zHn8qpI=;
        h=Date:From:To:Cc:Subject:From;
        b=jBdM0qOkmrKhzpOuaH4ye1qlBdRKLs1/q3Cm5bzL8BIm6/oJwOgQhGUj/c78ZvHvw
         3UmAOxMou5TGGc97RMu3Dezygyhq6gWk64IvL+JxW511b6Xto9OoLz+xui/cZG6ltw
         D+duU7mbVFFKMlIgjkjvqp7H5UtusA0YG74Gv42ACnp9x8D15DvISlkokkTYvVt+v5
         wNqxkfv4NBwV7YgoBFi8hYCUNibfm26/gVp683EXcGQXJFbkd0ZeA2B3ukIrkmiN5v
         5jw5nq6xBBPNuXOZkJeG/xzUnHzAZMasLQ+9CKbdxVfhf5RyvIXdirltymKD22o0FH
         RV86rUHLO7XMA==
Date:   Thu, 10 Mar 2022 20:33:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the pci tree
Message-ID: <20220310203326.7c863d4f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e1smVAxomyUjSUf1c/3Juca";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e1smVAxomyUjSUf1c/3Juca
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  548d805b6557 ("PCI: fu740: Drop redundant '-gpios' from DT GPIO lookup")
  e2502d3a7d35 ("PCI: rcar: Finish transition to L1 state in rcar_pcie_conf=
ig_access()")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/e1smVAxomyUjSUf1c/3Juca
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIpxeYACgkQAVBC80lX
0GxI3Qf/cqR48IwzDVv9KMrwlkd405XQ7eIrcWqgxxGNiwuSfq90I75ISqFOu1Ll
SeZInDw0dzmcpVaA3lW+i2ovqJc+Jb4NzbnPlcSskcaULuA/IA3oSEiAbWtNcPuI
j4S6xvken8Glh8xOTku6OWx3BJ1aVGp9d+tCXRFR1jxwU7F6g6qIsQ2Ujuxc0QET
mGq1uD5f9LZU2NDa7SXDTxZXUCyk5eCcX1faM/517X5clxW0dIuSCOc5XFjDWz3/
X9d6Thiu1BbjQmCnYwzFt+JpubhApbY7uPvAaStrGQZO0WGeEXyIESt8lbnEIE0m
q71up05vxupKu8Gs64WXYDlvVa22yg==
=+/WY
-----END PGP SIGNATURE-----

--Sig_/e1smVAxomyUjSUf1c/3Juca--
