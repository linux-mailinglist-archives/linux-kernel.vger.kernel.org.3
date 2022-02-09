Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF214AE9D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiBIGAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:00:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiBIF6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:58:45 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05290E00FA68;
        Tue,  8 Feb 2022 21:58:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jtq1p0bDGz4xNq;
        Wed,  9 Feb 2022 16:58:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644386318;
        bh=PQrMZ/nl25C90Hv0OCRYFicPXInOb23dgY9cuajsj2w=;
        h=Date:From:To:Cc:Subject:From;
        b=JfMAhXN/NG/6cBZRd6kIn8Kp7QyPvYoZ6QMmkUDQqd5rLWlL/zTgBusDoRoPALIhC
         QDvk228g7kOOMkDbPoIBVVzEfNNFQYGbXlNgKa1eomcMFvvUoejEx5/fTZLRVVz+i3
         3C0/8dftgQiTZo5V+e14CY31M2e3gJl3uhQ2caXhWjSQan4BD3QeL6DUUc/jHgAChE
         aiE4agN0j59nzs7RrRRKHaENhH0iv1m3KGHRCpGz3372vb47OCBPwMLnYKlpZnY97c
         86Zl++EuSv0Tf+tMTnmonCKDstF3H+8Tjq//jQal0fLdlmFoV7JTkgPWzaeuZV0UiV
         K+SUbSDxUwTrg==
Date:   Wed, 9 Feb 2022 16:58:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20220209165837.19f27e9e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.DUVFs/GQR7x4ulu.S3uNrm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.DUVFs/GQR7x4ulu.S3uNrm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/admin-guide/sysctl/kernel.rst:603: WARNING: Inconsistent lite=
ral block quoting.

Maybe introduced or exposed by commit

  68d17e593eb9 ("numa-balancing-optimize-page-placement-for-memory-tiering-=
system-fix-fix")

I am not clear what the warning means.

--=20
Cheers,
Stephen Rothwell

--Sig_/.DUVFs/GQR7x4ulu.S3uNrm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIDWA0ACgkQAVBC80lX
0Gy5uAf9Fl0+lfaSNVz8AYwQvRdDTz8kfIzT/8X4u7++eu3X2kYh4asHJLrf9D0P
RP1frgBOc2bdPVhF3Cx3ASlU6wnWWy2UkZy6hjG5GnZJlhAdyD2Utney+CyXCAlt
5MEjY0jNKgBUnZjREhZtG/S/laKUgnroIytsqsQfCZKClm7NUKJqnrrbaMsIpa9e
F6bPJ+k/IPMi1IzicG2WxulSjilc5c4l1G2kPXADBnGVl4iSPGIy92/cUV8jytEh
+jj6XtC+2euqZaGgKgNiHSMm2uHFx8PbLqud2qf24LJKl6SroPEy+c8vzkfUc6J6
nWZ2UoSS9lH/d5etI1CiZpLB9k482g==
=VSaN
-----END PGP SIGNATURE-----

--Sig_/.DUVFs/GQR7x4ulu.S3uNrm--
