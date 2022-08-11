Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2DC58F5F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiHKCp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiHKCp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:45:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966354AD41;
        Wed, 10 Aug 2022 19:45:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M3B4M1FdZz4x1L;
        Thu, 11 Aug 2022 12:45:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660185923;
        bh=jcS3ntECrLZVaPnM43S74l9obgIjD+hTb/7EmJlpQwM=;
        h=Date:From:To:Cc:Subject:From;
        b=onhLgpY8fDm9E4020vxt2Cs/EtseRRkN4zLDZocauDaSnWev5huRdVQGuZYvAamDC
         +2kV4h3LcGcri1UPAk7uyciMpgqZf6w9rCIXShYkwBCFOz9JziIWzYvyJl/twPvLvD
         19tRqCTUbBJA7MTcT2FP2nxTpfg4/joanGgfdaUlPkRTVa0AwGkfwOlU2jO2JWv4Li
         q1G/ynyuEPv6sgqqi/uPtytpsmttSckYjpHOZ05uIQ7T2EReJc7sCaedgRbQx/kSBf
         opTjp1kaUIpG9dTRBL/YwxSe43lWiNnD/FiQx+VaLuLRwkt1+UfIVQazwHNVyaOnXj
         wMqeA9l5sKLjQ==
Date:   Thu, 11 Aug 2022 12:45:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bitmap tree
Message-ID: <20220811124522.68968e81@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BumyX=qS5_jM6pMUzo_euFA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BumyX=qS5_jM6pMUzo_euFA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  3876987b68a6 ("lib/cpumask: drop always-true preprocessor guard")
  878d1d41e207 ("lib/cpumask: add inline cpumask_next_wrap() for UP")
  27d2e18339c2 ("cpumask: align signatures of UP implementations")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/BumyX=qS5_jM6pMUzo_euFA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL0bUIACgkQAVBC80lX
0GwvVwf9EpM9wmaY4fe2oC4PLI6aw8xf49RqJypfWMio/NxX9DtKXZo3j01kqVTH
z3VcTY23+RFyFomXA+vdsOCn+fYQgrfXb9OZS+WT4GnAGohpwmapluq3Qk3NqqeS
xJEHmLiMBcy/SQmJAVZSYNZJpHKyXw66SWmfS1P8S94Q8pljQTBkehIIImMLQd9H
/6ABHrmxwPBQOxzBpPdON/ZD/3z+A0dU/G9f7qWWWyoCEwiT0Ln7VsRtixnUwJ/m
9YNxSwGVVcbvmtoY4fCzN5xibXMlqP+LgiPxsOKMeRzh9oXw9bXHl3I60Ul6LIWR
pY1qtsE+A2BNiBoND0wT9CH/iX/t/w==
=qnnf
-----END PGP SIGNATURE-----

--Sig_/BumyX=qS5_jM6pMUzo_euFA--
