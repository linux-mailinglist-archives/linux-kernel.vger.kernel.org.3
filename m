Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0584F4C975D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiCAU44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiCAU4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:56:54 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925375C32;
        Tue,  1 Mar 2022 12:56:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7V071stlz4xZ5;
        Wed,  2 Mar 2022 07:56:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646168167;
        bh=/CEhfdr5qm01mKvPKLjcMqziR/sZXAAOOd80jfWtPb0=;
        h=Date:From:To:Cc:Subject:From;
        b=LEZU+3WEG1ugkMJgfmtCyIfSIh5Y4uKewlrLViuJFEDxdTB3YQb/HJPO/3RQQI8v7
         CUKRmM04n4LSHfbBkspFHjS+8jxp5FYK6tfuPbhg/WU92q0tlHJ1VMewJ+DlLVQD89
         zIUEtyTsjDKiSrH6kPEkR0X44ILNCiW51CCHQU233AhiKZQkRPDe8VNqCN8iao/9ED
         QXmLjZG7IRMQmFYMmtzmOzdhHGIkMii0IFw5opA4u3I2Q5TbkElCxJm0dHtYgjMsrz
         es6kROhpUmHbLjOuP5dCVcRGBYghuqUacWHD49KQRxczDmlXflEd7o+bzEPS/ptxQT
         +H1O35Rv3wCzg==
Date:   Wed, 2 Mar 2022 07:56:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
Message-ID: <20220302075602.0ea0de3d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OqIpPedt5y+T0Ibjk8AItKu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OqIpPedt5y+T0Ibjk8AItKu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  8fcc54796bdf ("arm64: dts: armada-3720-turris-mox: Add missing ethernet0 =
alias")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/OqIpPedt5y+T0Ibjk8AItKu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIeiGIACgkQAVBC80lX
0GxmNAf+I7h2Qfs0zU2Kx0xyN5d14+IQxmnpvCkZF5txshTb3l8q9YQUxc0UK5SM
KrNZvBwevYZ1XcI004NY8LrR2pHxn7z5G5FGq7+SkeZS/nm4TEtLt8yDJfqKo540
uAGjEZKLL0OoX/xirNImf2uozz+LnZmTFzMet9Q3iLdG+/40VTe2nVoX8UF3NItc
j3mH5827EstsbcQBz8oItcPrVOGw8PSp0o0+T3TIDczoC4g9kfFu09eYaybKEIA/
pqJewdScAiBgzmKB59/dc+uPdEAIsxm9l7nwSIyEg0Defl1MaGKheVKBx9xIRwW1
T/K7lmWBibPBflIktz3CY6uUMJJuKw==
=XUvf
-----END PGP SIGNATURE-----

--Sig_/OqIpPedt5y+T0Ibjk8AItKu--
