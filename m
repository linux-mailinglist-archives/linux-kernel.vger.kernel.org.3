Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E603D5ADAE6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiIEViE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiIEViC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:38:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B440E45993;
        Mon,  5 Sep 2022 14:37:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MM21d6q4lz4xG3;
        Tue,  6 Sep 2022 07:37:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662413878;
        bh=vDNiX+BpvfYT2D33EpbXur3PHESzRNwtOPIB4VLff4U=;
        h=Date:From:To:Cc:Subject:From;
        b=oxFX1EDLgFfR12rYZQAHnVyPi5NSjAvyYAf096pTJg4XFcJgDnqTq/zpxJrNULQkb
         jI5mGaPwjb4kOOiv/wFt16nZNlKfTWjfym7FK/KgspB9GX495DW3pTt+PQcD2EVrx8
         AFLMD+W41e11Oqc9NbzdI6SZlfC1WzTeehv6x8yeSda337GvCVPfDspRsNgS/w0t/Z
         rfJdGYIGMZ/Mz8RclEl2bHu/JnxqMiy6Tg0XKmemZ5aWLCt67rSFNXrGcrDQhWOJLr
         N5MLj2YOCAISMKX2NVkHC7KQnw9zXtjyzLmVoD5Fewtch+g+SRO2dF5hv0q5Fy4GWy
         DeGk4OOzebXQA==
Date:   Tue, 6 Sep 2022 07:37:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20220906073746.1f2713f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ywu2rSJw.=gq2boginXcdaL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ywu2rSJw.=gq2boginXcdaL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  47170487f674 ("arm64: dts: imx8mm-verdin: extend pmic voltages")

Fixes tag

  Fixes: commit 6a57f224f734 ("arm64: dts: freescale: add initial support f=
or verdin imx8m mini")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/ywu2rSJw.=gq2boginXcdaL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMWbCoACgkQAVBC80lX
0Gw+pQf+Piz1IAsM24sF7Bpqx8eykEQYmB+O9g8NlUevh+hKZlto8JCwRoOXjyrb
qeJZsWJDpMR87iPNpKEyfcGpliu79esT5et/UPqnDvQZML9krjO89BkByrZmlazx
2yG52RMFUoO1n9HrmC9Ii4/+gGq+3qmXSimzL/oSVbyd7gAxS2V3htfpCtGh4LFJ
+8y2HX2lkxp9FcSiN7plt/lem/34xounjd09DM1c2kJTKhNxodNwdXKVmm6Wm9yL
50AqAPrUGc4DPrwwbJl/nTDGFBUMcWekVlB59WNn8wkQTSuFXks9FjCoVO1dCI9Z
ajupZhZI8iVAS1hVOHPFSVHc92ua8A==
=AWrC
-----END PGP SIGNATURE-----

--Sig_/ywu2rSJw.=gq2boginXcdaL--
