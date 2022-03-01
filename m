Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2654C87A3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiCAJRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiCAJRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:17:43 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3988A6C5;
        Tue,  1 Mar 2022 01:17:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7BTR6vSyz4xZq;
        Tue,  1 Mar 2022 20:16:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646126220;
        bh=EoQZCiAkih9VjhuL3sbOdqquGbMt5Ul1d3vvn92kyxs=;
        h=Date:From:To:Cc:Subject:From;
        b=OJ6Jpjr9LSQIu35lVex/s058KrX0BgPSu6Ay4H6Iolj4J7tEKcb16g+0usEu0y80l
         yzehK2kEXQZbm8E4YNi9d96n6qRzgFF8eGlwVPTAUvUabIQppqXQb0T12bZGnL6O4L
         ybf9HmxWHcWWnndrYtN7BcdAaG0ruF8RNVV4FGUzCXGS12jZmfFAdrhOYMFCKtPcio
         M6dfTz0Xn6QrNObtPn/rlhTSJd2DRdgn2+oVmubktXNDgWNQ9/y9U3v2Gdx2SPKrIw
         pESkMxqOHtQIv9LlwoA9DlQe4fzCrEFr4onnjq2TXk983dkJlmbxrMkthttmJgC8dT
         iRUsmtGm8V1Dw==
Date:   Tue, 1 Mar 2022 20:16:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the drivers-x86 tree
Message-ID: <20220301201659.45ac94cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uX.C.ETc_jEyVxerbsBr2jd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uX.C.ETc_jEyVxerbsBr2jd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drivers-x86 tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Unexpected in=
dentation.
Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Block quote e=
nds without a blank line; unexpected unindent.
Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Definition li=
st ends without a blank line; unexpected unindent.

Introduced by commit

  2546c6000430 ("platform/x86: Add Intel Software Defined Silicon driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/uX.C.ETc_jEyVxerbsBr2jd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmId5IsACgkQAVBC80lX
0Gzy4wf/SXimqZmPOOFcg7scv0+HAfAqCqVFNX8iVCsvWbeBgJh4wzb3L6m2dE3O
pQP6CQF7xot904pv3/nSm7MfGneZu6aPvSJ2wyaLFh0Yh6jBFoodPCJI40pbwgPq
eQ8MlO40TZBcdkJqsikBjzbIZs177i9Qi8oZDyBPxvUj7uZHGhxjEpZbtqW6Uxpq
jNrQsrHktg5g34Et1jgEoo43aIt5z7gLMY5/aUHpEZDrnDrcuZYjGkza6S2kGjSJ
kRSLa7r4aC3XQpxcNXq4PrYVJea8mIRKP9jXYn0bpjIwipjZrwuxIkvm/DJEbddW
9T/Vw2PQzpmcorapwJFchWg+lzOgbQ==
=0USc
-----END PGP SIGNATURE-----

--Sig_/uX.C.ETc_jEyVxerbsBr2jd--
