Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A104FB347
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 07:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbiDKFdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 01:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244753AbiDKFdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 01:33:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116AA2983C;
        Sun, 10 Apr 2022 22:30:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KcHWc4kN5z4xQt;
        Mon, 11 Apr 2022 15:30:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649655052;
        bh=R4/qmtP5bq/xNdFcGlWPyW3HWQE7irpJKuvP1F3giM4=;
        h=Date:From:To:Cc:Subject:From;
        b=nk3psxDlQCKG/FaNi6oRBxUKk5VandjvrARLit9fT+YA22NEh+ppPoojZSUeFaRmX
         bjQVIhTfnGUYR75iqLM40nhfj6xIj2erx609X90U/1ovugu1x8xS2E6NibJgsBuiZZ
         hMlLfFe4+TXSdtIbEgkwhPVb1e1xfKxHf92vuH7uBgN5DHyccvP1/O6zHcQRJTSHjp
         w6wrK5slby3QmV4kxZ8Yu+AI8Kdbt660Di+mrWXOS2+V6BTlrpk7pVcyZ4WExS0pvt
         +YOWMdlRnrncVI9hjuyXDtIHAOY69MsRMhq78YezKY8e3/V/hLXlx9WeJx+yeQEi5F
         B8oGRwmj4anJA==
Date:   Mon, 11 Apr 2022 15:30:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20220411153051.6a99348f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BZO/7q6G2vRZtkN9dzNcLNf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BZO/7q6G2vRZtkN9dzNcLNf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  269cfaf60e51 ("ARM: dts: ci4x10: Adapt to changes in imx6qdl.dtsi regardi=
ng fec clocks")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/BZO/7q6G2vRZtkN9dzNcLNf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJTvQsACgkQAVBC80lX
0Gwi8QgAmBCPImNvhEVsCBgJmOwC3xAiLIckDqWPAIJrka3UsP4MiS2b/vMspfxt
cbxoqw4TmS7fRvf5eOYMHDXxIBOgQsLLVf4Nly0u+HpSoF7+yZ59r1GQ34a1AAa6
rWbJAKuzDTxEmZsvRMKhsymk1c2MeJsoHEAMjp+kSdA7YxN0MM7zwp6QrxdE9f1S
nr/M2uwpL9VLWK7j90+E6rWsaEtJJMORIG+erwtIXDKnbpv71nBlfsn8Nx1LO9T7
z/p4CM1wbnwyDnHtOG6eXm2mwncE3gne1RsYDnWqw5l7Fd6cfNma+IQhEdKYtDLA
OlKqrdEj43bJoaOONnVp0FgOkeuOeg==
=ziLr
-----END PGP SIGNATURE-----

--Sig_/BZO/7q6G2vRZtkN9dzNcLNf--
