Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B27512D27
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245575AbiD1HlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiD1HlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:41:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE6A9AE40;
        Thu, 28 Apr 2022 00:38:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KpnXR4JKlz4ySd;
        Thu, 28 Apr 2022 17:37:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651131479;
        bh=GtVgEMNzYXFitX4K7tRFEYy1V7GBnIDa+hRD9HEBRFw=;
        h=Date:From:To:Cc:Subject:From;
        b=ud5kZN5ERg+nPN0sorjQG7dsS8WJXMiQmhWqwkxpApkebAGs7qGkcq0uOryXKlJT0
         QFJ9wqCQ6TaeaiprptPwe8r0MmZfYv0guuXmuXJnOEhRiV0wcBXmzAzB0Quu4A61Ir
         EgNr4u1IoFulLbvK9kegayOhfs3amRRajvSqDNH7nKeB8Ix8z5RED4UMWRWuYCe3Gg
         Y8kULMAsnZcHf5SoUyX/yhX/EhK4ni6dqA7ZQ8KK9v4YVeAalG7CFN6z3PxRxEO/fC
         aWERVotgSO6nOlSGpxGb0zvPS/MYf2Iz7/kLYKDQPxCHJRP3p9z+248lvAuK5i21mU
         u6apdUlLVLa+A==
Date:   Thu, 28 Apr 2022 17:37:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the iio tree
Message-ID: <20220428173758.2e642f54@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UfM71HFKtnp02yQG/os.HlS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UfM71HFKtnp02yQG/os.HlS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the iio tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/iio/iio.h:319: warning: This comment starts with '/**', but i=
sn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Device operating modes

Introduced by commit

  831d87089ca8 ("iio: core: Clarify the modes")

--=20
Cheers,
Stephen Rothwell

--Sig_/UfM71HFKtnp02yQG/os.HlS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJqRFYACgkQAVBC80lX
0GxhDAf/e8tiIt9JnFdA2OL5SI3f36VBmoGfXUQZJJpkGkDFhtlno7D0qe3M1Sz/
cQOXc04Ll9GeOvosWAy0K+58wkpTv+B0+k1JtP3LMDl/acnl+iNrpPvI9LWLD6Lt
GS76IpCIaElSa6sZgdztLqUPIRVdd34/opuRJHyF+PHqSwXRxjJTygUGG/i1TGss
E8CyQEzuVK9aTvA6iv2dshJ81xLfO0uW44eg+e+OQOlknOqqHd/Kv1ro6BorLBk4
QIPHFnS2rRGshRXOLOlin2nD1RxcPX7fzUQekhyf+EEjmyFZRMvmM9FJthJ2MY+6
xXHogbIYSbqdtrOpbLgkenlbe8cVNQ==
=Ohg9
-----END PGP SIGNATURE-----

--Sig_/UfM71HFKtnp02yQG/os.HlS--
