Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFC754A1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348466AbiFMVlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiFMVlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:41:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C2F26DF;
        Mon, 13 Jun 2022 14:41:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMQ4R0RN2z4xDK;
        Tue, 14 Jun 2022 07:41:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655156487;
        bh=sBmhxazqNPZYSHbLJzJtf8KNPrV2knO0bIhsJfautr0=;
        h=Date:From:To:Cc:Subject:From;
        b=fethFYYhce8fUuZRoSzAxcQjdO06SRue2yqjCT/bAF+3nfyqXs0ydu/XxKswAXiEb
         gHUa317sOXCpJ87i9fEOQmd/KnY++G0stCmx5/sUT2wpHwhA8wc4Q2c44D5pnHMa/o
         134uuD7BSC539AjabRaywNHA2l/sSdPa3TnZbHmUtoo5csdtX1EPPgaIjlXT1WsEDA
         NocBmQMMM5mMKVIm6MiGe6P50brd+WScoWG92hwUXAVBFG4I7CO8/9Df2/iktNY3NN
         nzeGdalWE85DAj/UlzS9QnTOhLPnRYWiHnZNrVZg5N5ePwpvkZztGLqDKMyLDEo62S
         +52gqOV/F1u8w==
Date:   Tue, 14 Jun 2022 07:41:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20220614074125.55b94094@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_L0g0=ZGL9upv30fdZxwsI7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_L0g0=ZGL9upv30fdZxwsI7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

n commit

  4e69ed8427ef ("ARM: dts: imx6qdl: correct PU regulator ramp delay")

Fixes tag

  Fixes: 40130d327f72 ("ARM: dts: imx6qdl: Allow disabling the PU regulator,

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/_L0g0=ZGL9upv30fdZxwsI7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKnrwUACgkQAVBC80lX
0Gybuwf/YkXe1wJsLsEAUrcCXfkfLwJrbJEB+FtJMIcbPp9fLpUDLVNLv0TWQ0cV
rNzkoNdlT+N3PL0CU2KWxxbnKGxqueLB8cdCpeD3bpJvpSd4AVsb8RWkKa6PwSIG
L6cZjgg0WmVMAVC/sd3027wDgmDwKIoj3XSUmN+6BbjbRb3bSCSd0BseDfZxUzfR
qghz7gyeuttaMN/FSeNKFLkSpwIbZXrGbNkrpwZiuHrQ6qEdHt0VZXd96v9o0Bc9
jRYUIg92DD80wtxSacs922adsVmZz7l/C1b3Q+0LB3ILWVUkamL0JaT5jg1BBwgm
57MyOzESxh6rbJo+q9vWWoY0D0CzQA==
=+E+6
-----END PGP SIGNATURE-----

--Sig_/_L0g0=ZGL9upv30fdZxwsI7--
