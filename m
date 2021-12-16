Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B59477BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbhLPSuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:50:07 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:56889 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240821AbhLPStv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:49:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFLkz18tqz4xj8;
        Fri, 17 Dec 2021 05:49:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639680589;
        bh=ri32OcPWxF/ph9vWE05JKMD+Xqy5EcsRkLKNmhTvVSg=;
        h=Date:From:To:Cc:Subject:From;
        b=HYObuM+/23I1NOe+vmePN2aXpdla5bYsGdlLv9dh9yn3DoWIyjdC9WDTQAlOpiTSF
         64ypA4QNAtNc1OE1nrLGC0AbZdKCxc/BNWTdAc23dLYjVwFzqmnJolIz5qjQvKhTxu
         HWtgtpu46cXVNKwpdZ/2wdbeOFxx0fZFcW8zFphcHZA3uBQj9gcNZBu6nAL0W7kuBA
         ctp6Dl2zmHQPXVAgFgJw2e1uc9LZx/BQh6yc3iYOApmYaQVfJUrF1hJeWLFPvfSQGY
         gF7VzeWBraEG8KhRGcZCCA6rkw8WMosXMCUfSnOTlPMTCKRj+cjirUKIPdydbVnKN0
         yJ4NDBHXfFQfA==
Date:   Fri, 17 Dec 2021 05:49:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Stefan Roese <sr@denx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20211217054946.4b58f7d2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n5j6P=/7fZJHpiu_lN4y54b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n5j6P=/7fZJHpiu_lN4y54b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  83dbf898a2d4 ("PCI/MSI: Mask MSI-X vectors only on success")

Fixes tag

  Fixes: aa8092c1d1f1 ("PCI/MSI: Mask all unused MSI-X entries")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")

--=20
Cheers,
Stephen Rothwell

--Sig_/n5j6P=/7fZJHpiu_lN4y54b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG7ikoACgkQAVBC80lX
0GwGpwf+NHx8F16lIfUdCy97PTqKuyLALdX0HKo8zAMFuUvRWCrpqlJeUPg0G418
P3Uef6hqv2D0auQ5P3s09ulynspPUqAv6cYoaKB5XV+z0hA0Av2f9f/Dw2NOIal7
rX+XoCbNNJrmnMM4slBhHAzE3pkdXJ/R4DlPvkuWyEt2zw8FebaAlH3sdJ6IW1yT
a5IhtC2AeX6NnUFC+HQIge29nt9NDel+Xnmub/iXnpCRig5ue3fhMpInr7BQk8dF
sKiv1ci53AvNJ2saT6VQxFltYmsmHSHTWsPWSd1qsTVPeM038P5wFcagw5CR+djj
t/6YICQQvckJB7vk6wOih+Ap/iscEg==
=3Bru
-----END PGP SIGNATURE-----

--Sig_/n5j6P=/7fZJHpiu_lN4y54b--
