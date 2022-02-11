Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A954D4B1F79
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244444AbiBKHmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:42:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiBKHml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:42:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05281A2;
        Thu, 10 Feb 2022 23:42:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jw5Dq1fb5z4xNn;
        Fri, 11 Feb 2022 18:42:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644565355;
        bh=kJgcvdOQYR22pgOelIt3jO+KPGAiG/PLiaN0JDZGXPA=;
        h=Date:From:To:Cc:Subject:From;
        b=oNEaDk6PiV8aS+VtY54zO+Scwxo44Lt/s7e9XtyZsRs53wtlEwyViINih0eM8CE4C
         rof3T/wNlXENapfS0eU4m3zdsvIIGm8aGLRoerbUHiQP1sNkp+AGhbQkWmG3KzAXNf
         tEgGSpprTUslfDogr2pEO8Sekwk+4Je485ejszoqkqPZGYvqbDlf80M4TZg+k0H5jJ
         5jONUBUuzhwHoJ+HxZ+vZpPp5eXnEczk0ZNhiKU8vjZVVOVBzqoJkHY/rADC7SE56c
         VO/P/6Unza5YtK9yj4G0JHA2o0D42EXFqoooix/CjpmJ2nBr3XrQQoEExYH16RcJJY
         Lr/9k1Xb90RUg==
Date:   Fri, 11 Feb 2022 18:42:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the iio tree
Message-ID: <20220211184232.7e22c214@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//_f98+_bcAWJyPmD.WuqIiH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//_f98+_bcAWJyPmD.WuqIiH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the iio tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: WARNING: Unexpected inden=
tation.

Introduced by commit

  4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")

--=20
Cheers,
Stephen Rothwell

--Sig_//_f98+_bcAWJyPmD.WuqIiH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIGE2gACgkQAVBC80lX
0GyNqggAnbWioY5jhlnhr+n/htemm+3wCjcFjeF7G8R0M50ISuN/iiulztoH5bVE
oBTVMBG9xHDeiA84+j5/arynKlY/ZGN5y7sbTiHceHRLYToD4G4WhImhzslsw0RC
Ij0CaqojopzSZkwPcd0yiW85x3zncYBckQ0UhJVbZ3IKkc5dLnvpnu4gBcdfKsyw
xcfPtse7U+bNbqocykp0rQ2Cwh8MsiXtFjBXNWLERCVIKAJDUT2SQ1o1TkPY28xL
MOceBN1AjNWrtPzaPZEM/mKECI7ZLYaJwUSmZupv0BGrs17jrerd/zwUdqqufdPz
28+yaDzgpvkRjg/rQuTYhXuN7R8Xqg==
=q0nS
-----END PGP SIGNATURE-----

--Sig_//_f98+_bcAWJyPmD.WuqIiH--
