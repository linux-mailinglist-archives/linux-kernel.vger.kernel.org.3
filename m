Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8DC4F5269
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850300AbiDFCsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1586405AbiDFAB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 20:01:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B61AF1CB;
        Tue,  5 Apr 2022 15:27:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KY2Md1gVBz4xXK;
        Wed,  6 Apr 2022 08:27:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649197661;
        bh=AQcMZSaixpjjDWAOAjd+xNhd+Jit/u2PyC6G40SxWxE=;
        h=Date:From:To:Cc:Subject:From;
        b=porv704JoScAOo2hhZU1/44TiX9tKj+ZFzFZ4w1NXw3aSsZ8TuDLDlX94nhjp8aoe
         whMNCsRM+69TonL7zlvdnq4Qnte7nFwxUjkhai0M/l9hqaqPMrvOmxunKyze5q4GBI
         MCIuPT9zKuScu7NJv9odJghvOg/XqcnK9TOtGzItlZQ69ZgzVauFWf1BvRMBmiMigd
         dXZiZZJskp1T06oP1BY6ZK7jMoV15v/6FFyBvClpRFKBSfB1bZOD+PcNI0kqUIhiR+
         RCmHMOK0iiFn3iqQskFUalI2svfXTWbqWumPeWE71ON+Q0mvVgo1zF9+jHSSI00zyM
         mFhgyuYoQQV7w==
Date:   Wed, 6 Apr 2022 08:27:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-fixes
 tree
Message-ID: <20220406082740.13959150@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/godLMf+gOkJV7W.q0IjgIIT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/godLMf+gOkJV7W.q0IjgIIT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  397c08e66130 ("media: platform: imx-mipi-csis: Add dependency on VIDEO_DE=
V")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/godLMf+gOkJV7W.q0IjgIIT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJMwlwACgkQAVBC80lX
0GyPMggAhltqNPb5urHdU6NZRzIbuaK9cgfukopB49yELQfSYz0I3WFCjowTgftZ
QEGdBehqkhYqp+cFUpqdzPudI0uUEO5qC/EddCONalcp9aFK1AFUy2+vkFjObMFl
0R9j7a1k4TTMu/5DJaWSUOpoVAGSCa5j/EwDp3W7pFcM9BQgSCppuLTFtHn1G2NH
m2f//PZdj0Ln4PjKkotGi+Or66Y51BFYBVpOnD42sQuNtp7R8Ph7kfAY0vXkJPk+
Sj4O2WOeDvAO1hiXTrPoslSmiNwAriqxgemPPOw6FZo9rjfMpMSUMdpz6NQKdtVh
lrAh+yyIlC87tfG3U8CtcdPFlrmz8g==
=WuYs
-----END PGP SIGNATURE-----

--Sig_/godLMf+gOkJV7W.q0IjgIIT--
