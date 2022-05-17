Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1290529EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245487AbiEQKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245426AbiEQKAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:00:30 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95693C71B;
        Tue, 17 May 2022 03:00:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L2Wp15S1Mz4xY4;
        Tue, 17 May 2022 20:00:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652781627;
        bh=ACzjneqDXRTFSb31q0UAPmXWo5ic5ZuLKSemylhPJjk=;
        h=Date:From:To:Cc:Subject:From;
        b=BhcTrHEsF+igXDnkrdFg745RQpjTleUFXXiLwZbglwW3SfcncFuLK5lQwSBh7IEdO
         AXmbV650JkEH894TqAOtUdWrQ8K5laKvMxdTNf825rCUy8fu5BR6P0ARMaEU3B7eDi
         gdx7tUKs5Y6pRDEwzSP3C1p7Xvrqd0OgX2udR3Ij+IHMvzqOf1ADfRoo5+5oWBiso2
         H0Lty5G+VqU8sZNx1JdwRvNzg4jOvGeZkN6/rUqQRCAc72slMeWufB005zS35bbPcS
         jZX8s+VIWQUf8aQsNKq+ah9XdsIbowpwbMzQPGQ7xXF5MKzxRONuAlUR8oHTu24I0c
         5cLl+iT3y9m7g==
Date:   Tue, 17 May 2022 20:00:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the wireless-next tree
Message-ID: <20220517200024.3bc972ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vh5HJxTto_A7tISj4ndI+2F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vh5HJxTto_A7tISj4ndI+2F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-next tree, today's linux-next build (htmldocs)
produced this warning:

include/net/cfg80211.h:1188: warning: bad line:         attribute is presen=
t in beacon data or not.

Introduced by commit

  3d48cb74816d ("nl80211: Parse NL80211_ATTR_HE_BSS_COLOR as a part of nl80=
211_parse_beacon")

--=20
Cheers,
Stephen Rothwell

--Sig_/Vh5HJxTto_A7tISj4ndI+2F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKDcjgACgkQAVBC80lX
0GxCuAf7BopOsVfrp3A6v/pMXmeaHb/fLGl+J5r1mtNFolUtGq0H8k58NpBX69ch
64W9XJBeDx4fBfWgeFjHPl9b4XrsKg/q7JheNQBRgrdRri6dINfUXFjZb7Ps5H4K
8EAOCaT8zFR+7jS3jBgCCM+frX1Ea/QHrBGA5aBz5U6CCkvWunHxHjGfYDuz33ds
FC3wMqtWhQ8bix7CH9xF0jkpxCfcl0PvV2k1G/YZwZ46ob/hYpFu9CopELjNi0Fo
dpHry2ENOBGfb9eP97jLT8j3+8Fj3bL1iU4tM20aJUyckt5hf8tW6D7VJHa7juIc
KB+/lIQw4kr5bDs5+dWzctt3x8JPWQ==
=gHGq
-----END PGP SIGNATURE-----

--Sig_/Vh5HJxTto_A7tISj4ndI+2F--
