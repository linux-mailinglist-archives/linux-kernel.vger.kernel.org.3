Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3887753C416
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbiFCFQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbiFCFQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:16:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF451EAC6;
        Thu,  2 Jun 2022 22:16:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LDrh16CqRz4xXF;
        Fri,  3 Jun 2022 15:16:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654233363;
        bh=NSQid8teN+eZbKRxsWrg9fDVrnzjEoyHi9+1au8iE4g=;
        h=Date:From:To:Cc:Subject:From;
        b=VXT9+JPxaInI3CCbjc2gISw7NrmcXX0pGh7zA5Vj6JT3rNZ72Yyz6ek+XOkmDCCNR
         HE71zFs1Dv50pTMpYZ54QYPQOgMlvaEYkLYFUalQ+G0iPvikqJQrfce8FfgcGQlViG
         fUL+t4W8w6E3Tw7mWO62UWEFV7s5dx3HQV+32QFdSc21bawaRmZYgv2ZBTRspt06jX
         k7Y5/PQKEjHKaABi3KBrXV0aaYbF0ej2Z1Bbve3m3YXlPWQ0qlSrJJiFmAxZXF4iAx
         5z3t6DbV8VOPvOPIjK6+yfOTMM0iZZXZqc3E6SMGjdRfGsPXg4AlfzC5WRjl4peBF8
         J9EJph2oPcofA==
Date:   Fri, 3 Jun 2022 15:16:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drm tree
Message-ID: <20220603151600.19cfa617@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XYe_7K6S+lJq=Ado.xALumu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XYe_7K6S+lJq=Ado.xALumu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8caad14e7224 ("drm/msm/dpu: Fix pointer dereferenced before checking")

Fixes tag

  Fixes: d7d0e73f7de33 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Fixes tags should not be truncated or split across more than 1 line.   So:

Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for wri=
teback")

--=20
Cheers,
Stephen Rothwell

--Sig_/XYe_7K6S+lJq=Ado.xALumu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKZmRAACgkQAVBC80lX
0GyZSgf/c/ld/msFN7fHC9sFgqct+pha/eQEcQ/lQ9wFkyf1UmrFZYZ9L0kwmT5f
H7u8so9FfC42eJ0UZgQYL7cD/oXyxL7JYyZODrPRfSWFHrq2JXaftFICorNMMcru
7V/YxfqCvEm1w8I7y6V4SdLjqPu/LGk0Z+tTEgdflUhNDRoRep40WaX2hI/5i7AJ
AbtwL4FYWh9q6fbqnD4X6e0+ZsGbS4L+INjl3HHSPuav12obVgLAcmbxj5qeVwy6
3qBtShXPKHJ6fqG5S1n9Rbab+mvn7nlN0pStwYvIhJFN8v4CoGxD5oUybKA03E1T
Sjm1g4hxHxv/wirXh42iQrcjyWdVRQ==
=mDYP
-----END PGP SIGNATURE-----

--Sig_/XYe_7K6S+lJq=Ado.xALumu--
