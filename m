Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93C850EC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiDYWc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbiDYWcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:32:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCA8C21;
        Mon, 25 Apr 2022 15:28:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KnKRD5ksPz4xL5;
        Tue, 26 Apr 2022 08:28:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650925705;
        bh=PoAwKcwE9MQNmrzG4V65dtzER/1e/XUchnDW3IGbI4U=;
        h=Date:From:To:Cc:Subject:From;
        b=geqAAuOWYinV3zT8p826NFGh6bt5gjqJ5isiq56yHdSIXrZypzhE4p3NyJuLMQEuH
         4Gmxiyykocn3T62g2EnWyuUoINycmOXl1YY81PWPAc1Z7ANzLLSpUxD3KJqS7KPyjw
         KznbjdbpNM02VQCB5+UP1W0veIae/fmljLhuRrVABSwFcxagA6jyIHrpOGIkHxff/2
         3nQk3VJj6Iz2Stz3Ax34WzzoM5T7HSd3nUgolMTU8Roe8iXRqrEAnqD6Pd8TbJUJEw
         x8N0Kd1Y3LKW1IuRoSJllEEkGIJ75/00bdYoakRaxxN0OD25LnCvuRP08En5//TDZC
         UfT6kWsKqkyeA==
Date:   Tue, 26 Apr 2022 08:28:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Camel Guo <camel.guo@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the hwmon-staging tree
Message-ID: <20220426082824.04f63d08@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uQD0hQhrqaoRsnVoqopBDKR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uQD0hQhrqaoRsnVoqopBDKR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  251a486d3a93 ("hwmon: (tmp401) Fix incorrect return value of tmp401_init_=
client")

Fixes tag

  Fixes: c825ca044988 ("hwmon: (tmp401) Add support of three advanced featu=
res")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: a7e1e934855c ("hwmon: (tmp401) Add support of three advanced feature=
s")

--=20
Cheers,
Stephen Rothwell

--Sig_/uQD0hQhrqaoRsnVoqopBDKR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJnIIgACgkQAVBC80lX
0GwO/Qf7B6qCUY/Tps9S2Ari0Fz5BTIrzf+kheF7nK/HFsI4v1GtR7ZYonK6sH46
zEzTldt7RPmVlJeFi52K5zbAg9/0+rkh79r7//diRcO6ATcLV+ADxmC+1bKt5new
JX4tdM/VuTfvQlWvY9mttSJCiWboYK9hsBU/3a57YYdhMTAhtFDuXsjXkWR15Ab6
yNcbCgjpf4L61rxUZWn6/YggWGuPh4S76K94keAxVYvrGQrnDK2CImCtM2IhriYG
MJC7O0JxfbSncpK38KoapgKQ9fw+vpEpvMn7YBeRKfmcwZo82TrCZG+o5xnkqRFW
YPzWTxl/gBL/D9Ed9OvR047y7735cQ==
=rzjE
-----END PGP SIGNATURE-----

--Sig_/uQD0hQhrqaoRsnVoqopBDKR--
