Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A5A539983
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348433AbiEaWaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348425AbiEaWaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:30:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCEB9E9F2;
        Tue, 31 May 2022 15:30:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LCRmc70qQz4xYS;
        Wed,  1 Jun 2022 08:30:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654036209;
        bh=4CtpH3pfTm+ukxe/CQ8SQlHG8AEr4B/+uC8VGTEwO90=;
        h=Date:From:To:Cc:Subject:From;
        b=nzeb4QRa9F1zrpI1ZDlog7eVPZL+5qVkJh5sUBRfct1pPcBeWhNMaKNJoahZvBtr6
         6a7dmTXJyMpyJ7a3ESACbNkHgG2MHipHix/P9nr4Drjsp2uurlftN9dRTp9eo8JCBT
         znY8aE8FtncVGy6kQaltL/95kEfrZNDlE3HbA3XFF/gAsXOgOQ0VyMuHtxzE+j4z8S
         R3TxjXz+EktE/xei6KmFNFAMMqiHlkL3Gzg8LC6NdZTnvvhsIjf0700PXSgZznRg4K
         AxHpxIMixlqVW0KWQKkWJfzxt9qkdrL0G/elRT5vKtKS1WmIwtkC6F4PbNRTkPLRLF
         S7jHDPBQoakog==
Date:   Wed, 1 Jun 2022 08:29:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the devicetree-fixes tree
Message-ID: <20220601082959.2fefa1e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jGV.0hRXVMxWsm3k0vH__Yn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jGV.0hRXVMxWsm3k0vH__Yn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  adb97f9f8442 ("dt-bindings: soc: imx8mp-media-blk-ctrl: Fix DT example")

Fixes tag

  Fixes: 584d6dd668e2 ("dt-bindings: soc: Add i.MX8MP media block control D=
T bindings")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 8b3dd27bfe47 ("dt-bindings: soc: Add i.MX8MP media block control DT =
bindings")

--=20
Cheers,
Stephen Rothwell

--Sig_/jGV.0hRXVMxWsm3k0vH__Yn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKWlucACgkQAVBC80lX
0GxQPQf+I77xIErI6GJk7eIYX9czLqwXRLpFcxQawkZrUEU2BAk+TpxAfxu931Eg
P92gw8Hmgnw9V1UFT4nR1uBz1bi7QydcazqGCsuo3xl3EBwgTprRruXIXbrHGG8F
V2H8NPfeah19qc3hYwV5siGb8GKFOqDvrJ/O0c3ZYJMk8qIh4kvveC+NzClcHGO/
rYcXTU03Ot6AQtbq0j9XCbP5v7ys8DxbU31A8NApaxCg7Clfz2Oo5d8dw2OxYd6a
sWRCgvdyO6Dl2VHvMXAf6xY7iI52dvD82SETwyy5R6Anz7dZvpqUmUk9DC71UnWj
EHRDAb3WUQkb3FUNoMgOp+bnYz77XA==
=6yOI
-----END PGP SIGNATURE-----

--Sig_/jGV.0hRXVMxWsm3k0vH__Yn--
