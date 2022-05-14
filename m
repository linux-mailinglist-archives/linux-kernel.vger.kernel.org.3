Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5DE527098
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 12:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiENKLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 06:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiENKLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 06:11:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69F4F5C;
        Sat, 14 May 2022 03:11:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L0hBK240xz4xYD;
        Sat, 14 May 2022 20:11:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652523097;
        bh=XBYloNUWpqX8XDCbghXfajfbb2etABKA+WNqERyxi6k=;
        h=Date:From:To:Cc:Subject:From;
        b=hDG5HdI6k8kd3i7Ko9E4jvFutGawMbMPxHHcFGe7OuNlae5repCoPpVyVqG9QBhoZ
         NaZZ//UR5EZuDGZmHY9wI1ZAhinKVBTDGxViXYyk9pecxLd2XIuTsJyvxz5hlfwMJg
         DOMbv8iEMrMNfYtMKKlobvLsYXjAiN696E1GVeT6oXbadKZ/+CVZzsj16jcj7nTdV3
         Zzwdk1Z0ck/8z/YNYDDmY+V79Fa6Uya0oMzz+YklN5yGUHqfxWE+d53KD7AWhPZ8Du
         VakvRlguxsDqGmHPJZ1ExC45h85NNi8JpVjYQiCfhDJB2CCLo06Id8nzHwGptnkkgq
         1H+ur4aD5qiEA==
Date:   Sat, 14 May 2022 20:11:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the amdgpu tree
Message-ID: <20220514201135.3844f8d4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/32Fm/U+lQXLswfMcc1K_VJQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/32Fm/U+lQXLswfMcc1K_VJQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  7d8896a222b6 ("drm/amd/pm: add smu pp_feature_mask callback for smu_v13_0=
_7")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/32Fm/U+lQXLswfMcc1K_VJQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ/gFcACgkQAVBC80lX
0Gz54QgAnpQX6FmqQW4SIg4b68OLDFLVxltSzLIW/E0/4W9flPnd4TYdrf8IoSWa
8lSIvya5aYGLVLpK0qEiIg5lvLtD9sCCS9gbfacI4ZLep1ZqOrH68JsN3NiOKqFR
AyQXPJeAHAxRywRtrPAGSNN3e7KIuKK5qiYGS+vcg3mfSnC//gbtyLK4pE01kWJ0
LmHfmSpdIAmll67diCOmlKD4XiRyi7QHtQObpV1kI3c2YbO5St9W+zXHmXspqn0I
+meiM43IB7oJbCBthh7GKPy+gk7Jtm/vWD5i8ALMj+eoxoFvnM2Df640sFZ6ekVv
/wh/gsNo1W7uJ8PhYwpyz81pEahIPQ==
=nD3n
-----END PGP SIGNATURE-----

--Sig_/32Fm/U+lQXLswfMcc1K_VJQ--
