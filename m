Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61B1525E45
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378593AbiEMItt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378581AbiEMItp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:49:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439952B0327;
        Fri, 13 May 2022 01:49:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L02QF6Y0fz4xXS;
        Fri, 13 May 2022 18:49:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652431782;
        bh=7vQCyjKCbqzpIcTmFM2G6yNt/XS4nNkQs/JghES7AEo=;
        h=Date:From:To:Cc:Subject:From;
        b=o/FY5ZlyHQfJdRRA+yLOQvTHoWn5t0bIfdwFwggI9nDP36BytYG2tDw7y4w2SL6WC
         W2S91vOd3+6kfTVB9+SLPb26WqztLjz6TyTreNJxWyIYE81p2f+4SH3Aeih7QgyIfk
         +ISaje4uB+uwGpepA7RjKec8ABNpA0DeGFycu9cKkKe/l6CNE1HSWak/R9ESisX14r
         3HCk40jS/++JcSviS+h+5TWjbGMUR2rnwRtAtv3Py48DJ0jFlSJv5KvHVJiJXgdjdc
         jEqJwSEN79QCyu5n86vzkDCaLkF9gz+FaFmXQFvX0yz36vLam+0Zw6bPNl97j4tw5T
         TRQvEVVbxTZXw==
Date:   Fri, 13 May 2022 18:49:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb-next tree
Message-ID: <20220513184941.37b08b2a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nDcRZLJBkrvo6iVl/Rd1FMj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nDcRZLJBkrvo6iVl/Rd1FMj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e62cc3ab0fc7 ("media: atmel: atmel-isc: Fix PM disable depth imbalance in=
 atmel_isc_probe")

Fixes tag

  Fixes: 0a0e265 ("media: atmel: atmel-isc: split driver into driver base a=
nd isc")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  3d18e7e0aa2d ("media: st-delta: Fix PM disable depth imbalance in delta_p=
robe")

Fixes tag

  Fixes: f386509 ("[media] st-delta: STiH4xx multi-format video decoder v4l=
2 driver")

has these problem(s):

  - SHA1 should be at least 12 digits long

This can be fixed for the future by setting core.abbrev to 12 (or
more) or (for git v2.11 or later) just making sure it is not set
(or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/nDcRZLJBkrvo6iVl/Rd1FMj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ+G6UACgkQAVBC80lX
0Gwqmwf4gpCf/Szo/hIdSdFPke3TomcGIZ1bUM0USULgumOB+BcYHTIp/mqQnUiJ
9dYXQeVYpv2ChN8eBoLM2+5Aw/AEwPzh9nXIgHiQcpNOiiA/ZTK/9d0zsLdEYYXB
rZPstVsV9oT/8xIr/hZ0Nh7s0KToEKxnAuaHj0Z25X6XwBvM7DBWKkK6dFGanmXu
U1cr/7uJAYvSA0q0bkRwH6tJe52dCqK6Cr1JBbpMCwyPVzawqea7qB2unDU6oNd1
c61tkdy2PoxAVymF6/hMhv5g5g4LmPCQsrwhwILq7d5pNlveU4EuMFCaXUu8BtvF
q0u0SkNOb4e5JXtyu8kJuADVaiHY
=+hR/
-----END PGP SIGNATURE-----

--Sig_/nDcRZLJBkrvo6iVl/Rd1FMj--
