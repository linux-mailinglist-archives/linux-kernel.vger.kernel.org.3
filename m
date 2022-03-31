Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCF64EE2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbiCaVAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241546AbiCaVAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:00:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1546BE096;
        Thu, 31 Mar 2022 13:58:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KTwd01Kgnz4xYD;
        Fri,  1 Apr 2022 07:58:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648760308;
        bh=cPmvIR3cPhm9g8z9+wcx2gqZ3HNPwqrdhJHNvalSOqE=;
        h=Date:From:To:Cc:Subject:From;
        b=AQeSiOeytkZfNhk28qqssLxCaXsv1ieUV2fdOIt6jyTLcMJiKaAlhLnP0P0h9PVLd
         Y2qFIxMo2jllC0pWaeILNCyvXBy3oJ0vDuaDTY+4DujKjonn9F0vCiWXaX4f6vK5uY
         R/7pDvvkFJGJIvm6DSGqZQ4ZxgPJbc9PRTxtrkWYcdJ28fgbhA+2SL7J+Y8D/P7TB5
         oXywVnU0l1l2rTz43MTHtxW7r9V8J3JG0/zJ4vL0AFKQ7GxWV67N/HuOuVcnWuMd+Z
         3ZpF93i97erYHxCIX7uRZrNaFPyeeTkABpCmGIE57VsXneCC9sT00TsAR20Xjesh+s
         TVUi6oJbOeZhw==
Date:   Fri, 1 Apr 2022 07:58:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the chrome-platform tree
Message-ID: <20220401075827.5a0ca26c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mYWe8bdlyADbTRLLy=ZZCZ.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mYWe8bdlyADbTRLLy=ZZCZ.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4c288c88d016 ("platform: chrome: Split trace include file")

Fixes tag

  Fixes: d453ceb65 ("platform/chrome: sensorhub: Add trace events for sampl=
e")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/mYWe8bdlyADbTRLLy=ZZCZ.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJGFfMACgkQAVBC80lX
0Gy6Ggf/bRif6oEFeoF7459Zk93c5IzGBhOQV/mNkBXq2Sa5cPXkv4JyN3IutiMW
7ZX8ZFgVssWPVsvX5NJ6+wO+4WBr/IhxyUeXBzrQL32VSTk2u9/nq4i+baiKuq3w
Jmieg7f+6J8Uo1YAYQLaO8I1k8FeyotW3Ho5iQb12hj9DuPcf3EJrFi2PkTYetTO
2H0iF4sTQJpYCOj6WuiDy0Uz3/hZkITIvUoXJCtehUeZ0lIciMAd/3jyh974ckol
2L0cptQ2tKu4EAJSkzu4Fppv4SJyOlVN2s1J+dYRbAX0XpIIoxC5aSQ7+DsI3mIT
mxlhglQDeZn26oAuuSOfeUi55lOgrA==
=mvSu
-----END PGP SIGNATURE-----

--Sig_/mYWe8bdlyADbTRLLy=ZZCZ.--
