Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F615ADB13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 00:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiIEWEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 18:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiIEWET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 18:04:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03FC275C0;
        Mon,  5 Sep 2022 15:04:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MM2c042Z0z4xDK;
        Tue,  6 Sep 2022 08:04:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662415457;
        bh=YUmpcEnQjOWy7dIF+j8oUOejgKKfMcUxeiaVrA1M0vU=;
        h=Date:From:To:Cc:Subject:From;
        b=MikDAkGVRGddNvIqtDfdjBm1b+HS1UwgUjoDTSXVq4FU/O1ZmBvpR3AQU+dbef5lp
         abqimPz1/5O87lrkgO/N5hrCFQ1yrRZYp/f58sFUG/vkH7+LZ4AkJ9BsION1JFubT6
         73phOaSGggyEIjBdau+eDeWL3xpfvepgN2AcIpW/jFwrLFZ8ioEF0V2d9g89tzlnpV
         fbiOgXa0SQL6sHXCAFH5L/2mOtZLOwcnAfITzZ4tgfaWqqiyzr8i3NFTlV5SL1iKtd
         5ycXNY/MkSjMi2cFGzI9eyXdyxbXnyUfNRElPYr+RV5WGcT9B004+0s3/vryzg2P6W
         lz4lWVnN73VDQ==
Date:   Tue, 6 Sep 2022 07:59:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mm tree
Message-ID: <20220906075906.20b5874a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GAwET7Uutxub.l7LEOWQqzl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GAwET7Uutxub.l7LEOWQqzl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  95f35bb5cf4c ("mm: add folio_add_lru_vma()")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/GAwET7Uutxub.l7LEOWQqzl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMWcSoACgkQAVBC80lX
0GzoYgf/ZYSJy6nOvpLPJ7t7w11MAFg5zlIc1ntKGQRxtRRUhBXbBGlGFIayOdcA
B4JdtVRG6cpragaq2eVFPv/H+AVa0ZB80FojA5MQQVqfgUax3RwXBzD6c1PG+6lH
nSxLVXPCGiwe3VurZTLZ5d+70osN47lFdycCtNofvNhQYRX4m7Evrujb7bpEqTPz
Zu+sO6M9DdnANuPMyp9PYHB92WryfLYTSkwpDPIWbYVS0eS68QSEJcvTTmtIABfB
UDZlf54YZ0+0CmaXFR1gqU+AcqcncioQFhqz4JypJyBIviPbISkIkrY8suJ09e+7
f6cQH2UnuFCORstolSoht50kAuNuZQ==
=wgrk
-----END PGP SIGNATURE-----

--Sig_/GAwET7Uutxub.l7LEOWQqzl--
