Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0CA5ADBEA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 01:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiIEXeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 19:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiIEXek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 19:34:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BA6F45;
        Mon,  5 Sep 2022 16:34:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MM4c74m6xz4xDK;
        Tue,  6 Sep 2022 09:34:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662420872;
        bh=meEHTITl4ujix17gMDMVslaWJU/aabtBTN6YVkKDI9U=;
        h=Date:From:To:Cc:Subject:From;
        b=k2iB1/XabWOl7kGAv0DAx6C5Gqk4rIT6qWsFImpP2NtIBqtbSmOIHxua4V+C5N0a3
         hh+NGidG+jITDNTXKtNtKAekNOU9Z5E222c8lOkN0f9haGCGDtCWuPtCidvSFtlv4r
         T7wJrvNubMRUGG4/xpDCfn8CDQtMbbFqhwMPF9rL7WbM0qdxB8FPHkBRj5j90ZIYkD
         jVbyp8/QvHuII+NcfV5wE0d2yu40fsw0T3hulpfOuMNqnB4J4v9cqkZ4OOzxv3Qbdp
         /00KNdqf/0N6iiBzx/AJYPY0kNy9QwVzVGz2qs++FYcXI2iNeyng2ELiiuF67VVKpb
         +xyNXWX0a4dbg==
Date:   Tue, 6 Sep 2022 09:34:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the clk-imx tree
Message-ID: <20220906093430.09a83716@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TDq7NrvQL/Doc9h7V1UHm_w";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TDq7NrvQL/Doc9h7V1UHm_w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the clk-imx tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/imx/clk-gate-93.o

Caused by commit

  4e9331d4e2e0 ("clk: imx: add i.MX93 clk gate")

I have used the clk-imx tree from next-20220901 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/TDq7NrvQL/Doc9h7V1UHm_w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMWh4YACgkQAVBC80lX
0Gz7CggAiJQ9tjDq13k3uPRJCKxBE4RhWchrR45DaCtqazptW+w+qDnG9lnu9R19
4rBYOCilb/dGsfpQdk/dGyk8R/OonsZsML1k2HR/uH3hdMMNsG7kHh0wTUvQ5+PA
KAeSmcEZO71b/DqnU0f6UWmDrzQ3Ft0b9huCDIjKpLqCWLpq1221Xht4DxHbXVPq
vk+kOWhRmHU91ADs3dQWPEBdylzpFd6D98/9VwrjyPgTvSV+yYc4dhEY+DutXgug
90qJ5iBtCNHePdWQ7wYkdHPt0PBVQhnqePRSTb0myFPHaXIkRUGufGX7UTQfn5RX
BRlB6TsGUOoMHJA+pOstlYOEOlWOXw==
=tlyc
-----END PGP SIGNATURE-----

--Sig_/TDq7NrvQL/Doc9h7V1UHm_w--
