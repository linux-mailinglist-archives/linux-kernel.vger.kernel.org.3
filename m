Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53B4B3AEA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 11:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbiBMKjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 05:39:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiBMKjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 05:39:47 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340FC5D640;
        Sun, 13 Feb 2022 02:39:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JxP482hFgz4xcY;
        Sun, 13 Feb 2022 21:39:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644748776;
        bh=vzfNiDIGFc1DKK/k7hfUXazl1OqJYrls97yWyHhv6yA=;
        h=Date:From:To:Cc:Subject:From;
        b=g3Qmr2S51VXucFmOkHN6HyZNFpHKBNmbAAAhk+xBN/viBS2gxClkCsp8hkIMokLni
         KiJP11cn5ygnLdFUNIN6I2jmZyAu/LvTxhxMfD+H6MlnwRjPu4QqJpUGEAobhY1+N+
         JoG5MwJp3iMrJ1zAnN7Pz4RFvLJe0r1BWKILtjLElNDW9vWZARHRoYSmWfX34snNMQ
         MyvakSeG/ExE3OCie7NFMjtEwLLGOKmLxC2F/x0TxTjsTOapM0B+hT0B4ALrjeTkPI
         rG8/kRi24vWn3hCUPMPxmxMXkY0qu5ZVQVHt0t2jXzaTHioqj2CH+tSHk/yFhz/T7G
         P3g1Wg8NKWfnA==
Date:   Sun, 13 Feb 2022 21:39:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20220213213935.2c5ef8c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d=tze1_u/PA7dlaKj+YfIf1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d=tze1_u/PA7dlaKj+YfIf1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  bf8f5182b8f5 ("clk: qcom: ipq8074: fix PCI-E clock oops")

Fixes tag

  Fixes: f0cfcf1a ("clk: qcom: ipq8074: Add missing clocks for pcie")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed for the future by setting core.abbrev to 12 (or more)
    or (for git v2.11 or later) just making sure it is not set (or set to
    "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/d=tze1_u/PA7dlaKj+YfIf1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmII3+cACgkQAVBC80lX
0Gy1XwgAiqtXX1oTngR4NbTmbfvmaCc5HkKmhnn20jypFrsKUM1s2bI72bYfYcwM
gJy+IsbiH6T54BRJ65+uqQaA5ZC54Gnph4UoobygYY1vGdAyXoEfnRe2IS6zeGfv
J7rQWgQK7p7M08za4t6lG/6uwHpx1pUX1f6R6zO1iMksmjz5hohY492f70MPUwYD
FTJHrEaFJkMeVR3QGk71P1Q1T2tZr/z6mBbOOEDNTCz5JoXARR60JnerN1889mr6
R9YOenH+iNfxT8Q5/r+dxpdX90kfik1lOwm3WlW3fTPsvKXg4JkwuwgQDaLDTrc6
6WgsVWPoa3TE8Wc9Km5Vxi7jgPTaJg==
=vTmk
-----END PGP SIGNATURE-----

--Sig_/d=tze1_u/PA7dlaKj+YfIf1--
