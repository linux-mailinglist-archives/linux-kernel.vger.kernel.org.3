Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6994D8E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbiCNUxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiCNUxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:53:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E830C3C49D;
        Mon, 14 Mar 2022 13:52:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHTHv6cqNz4xLS;
        Tue, 15 Mar 2022 07:52:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647291148;
        bh=NISpoazxsKwRguXZIjrnG0lamu2pUld0Zkdo0rjoqYk=;
        h=Date:From:To:Cc:Subject:From;
        b=LyDsUBqwKYV6b49+tZU6iqzcgZE80bmQDpjgBghwvptrLLiJvPJYBnS2zkdcwfNfC
         Ut4txEI6TQsAbwYkPFYk+5Zs5VGiQ1USynUiIqwX86iRlNLXUHjVoScAZG7tAOb6ai
         b9ZXsZHEHhuJSqYIzy8dfGjwl1FDgH3L5edeTn0Z1tu/FrTHd32rztZpurTRuNXQAI
         CuiGZigrATDEPKdVYn50OC3um5Ey3WnJuIR8iExVnvqLj7Xi1Iz/zaLI9GcO6pB4Z9
         y1+GuHxmXLTlvImH1nhNaPx4RxFKspKGSOT23FTyx0OmFOV/0ZRONdeTV/DxWyTni7
         oq9+SCJ56fSyQ==
Date:   Tue, 15 Mar 2022 07:52:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-next
 tree
Message-ID: <20220315075224.73b6dbeb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LoiWDiCizKSAQLTb.QkGf7Z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LoiWDiCizKSAQLTb.QkGf7Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  ab9466f3294b ("media: platform: re-structure TI drivers")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/LoiWDiCizKSAQLTb.QkGf7Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIvqwgACgkQAVBC80lX
0GzYZwf/RcdnLcksJvqozKJNwEpz6gaCMa5zSptahbkXOfmfKf9iign2mEdy+dRa
5krvZZjnGhjT3wkcYSnw7j7anSAIbgTp6OuazY3ltp1sFksh59Aq+oc9bAwxvY9j
7ZBB2Bco+/Qh9UkJjY+fprHlD+iQGTeIFuvbB5hfXfM14gwjjFE9Bt9qQqv8SpYA
rTy17gOR6bX0ERJd8ROLng8wC56oqWR/t+Uav2hxhkI3R0wYwLQoYbqYl8K4kkqF
8ei/AA6dt1ORx1pAiqinr892L00IMTT/yOrFIq9st2mZTspQNYmIbHUjmtaVG5NP
nPWW0Lon9JvqovaduWgRWPOGKakQJA==
=pdg9
-----END PGP SIGNATURE-----

--Sig_/LoiWDiCizKSAQLTb.QkGf7Z--
