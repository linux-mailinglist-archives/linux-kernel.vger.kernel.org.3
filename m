Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1102056135B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiF3HiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiF3HiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:38:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F023BE0E;
        Thu, 30 Jun 2022 00:38:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LYVYT75bLz4xXD;
        Thu, 30 Jun 2022 17:38:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656574686;
        bh=vfArvR1hUdxJ6IBhHtEiWMEREkUOQN0pPAM222geFbI=;
        h=Date:From:To:Cc:Subject:From;
        b=r1w57T6JgM9cMEDYw5TYFupmJsEuze4kQygxgLI0JFWK2qWKDio6BqukUQX6MepcY
         d6aawoRFzPFH+ZQRKR7Jn8z0f/YHi5P1Dt+K1pjfBUxOY2ghRVwbOmjNWteC4GbKeN
         QgO9b0Z++4R9QpQt426x+luiK1AmwdFYYTm5kKa5oOfI2TMaqpa7ZU0FTlkII4BofM
         1OTdCBKSi1RHR3d67LvGN2aU//PCybuVTMU+Tkc1Hylin2uvhgDKZmb/qJSuiBeIbu
         Tkb6SbUNBmfOgxRXyNEOK3wzovnxQf3MkOef7b91012DqKj7PeQ/qzoGZiZBDxXJHt
         QzDL1xnwpRASQ==
Date:   Thu, 30 Jun 2022 17:38:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the coresight tree
Message-ID: <20220630173801.41bf22a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F.QFVGX5StrnikScNUKl_UU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F.QFVGX5StrnikScNUKl_UU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the coresight tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/trace/coresight/coresight.rst:133: WARNING: Inline emphasis s=
tart-string without end-string.

Introduced by commit

  3c15fddf3121 ("dt-bindings: arm: Convert CoreSight bindings to DT schema")

--=20
Cheers,
Stephen Rothwell

--Sig_/F.QFVGX5StrnikScNUKl_UU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK9UtkACgkQAVBC80lX
0GyquQf/Q/Dsp0s7wyFM9zYlEk4uAofPawmrNlg2k/ksDPvyNpw509Gn5v9aMTLV
W5mRCZhXTtah5jQqo/60h7VFs/jeLEcXYVgQ6IV8Wx7QoMzWlB/5kjy3qYmBVUNQ
BlA1I1rJtLC6sm5O7tJ0G1QyP89fOLaTG0HI3QmOOF3BeMdMdjc42x/J4A/lZveI
L/1rYegiDXkCXU9QjMcaZRXnl7b+5+YDwWa2AmHqnmrunvYupUFS2PZPt5WgqgTn
wgusFjSAMtMRopHC04+y2MBvWbi1HWZA7dYXr/oyeeOYgDDTDSYoz+INxcCqohJD
iLDm/unJ41D3Z4uv6htat5F1IZ6GTQ==
=k5Go
-----END PGP SIGNATURE-----

--Sig_/F.QFVGX5StrnikScNUKl_UU--
