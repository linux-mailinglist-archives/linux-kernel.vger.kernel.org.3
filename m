Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A725468B72
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 15:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhLEOuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbhLEOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:49:58 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FC5C061714;
        Sun,  5 Dec 2021 06:46:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J6TsD1R9Kz4xRB;
        Mon,  6 Dec 2021 01:46:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638715585;
        bh=HUBuhuO3rKQu4ejkXk+5IhrzTVQRmy6vO1dRqRLig8w=;
        h=Date:From:To:Cc:Subject:From;
        b=ZSO8DUgsukQEF1WDoDoC0DY12Rga/ZO/kBw1CDrdLjYiTgX7Y2nRDNIY5AmWvxvUP
         p4RXiNBoKyfcbaMUMKCdD4z4X6qqI6wOZt8ynbFeydqwX0U2vFXFp/SHSoma3V/dB+
         zw3HmYAW5LvO638+RVRodcSiaGZbiHe+oPBNzn60ZhN8SWSud9RoApgGmsSOH6zdyM
         rn1bpS7KrcjNrncmYG33u2yCClsx4F0Bs4NzZ7GMeDdy2LoUFwsBMXj4q/+9prmpyE
         wvJfh+ZyxGqlDVf61LhO3mDt3N2sZWhUMRdcKj+mtizUCFkytScRz/7tbc4xOVSG4L
         0diYQwlcjc+fw==
Date:   Mon, 6 Dec 2021 01:46:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20211206014623.573a93a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TFlVLZl+adFoUnKE47AN=tA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TFlVLZl+adFoUnKE47AN=tA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  e1cd82a33902 ("x86/mm: Add missing <asm/cpufeatures.h> dependency to <asm=
/page_64.h>")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/TFlVLZl+adFoUnKE47AN=tA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGs0L8ACgkQAVBC80lX
0Gz/Hgf9G7QTD4YjqiC9JjS5IdVzXEyiEm8p6Y4StcUaZWX049t4Swo1Xen8LVpA
xQ7NvVgMLFjXa7p1TeVsDCXDUqnhx5PUOvwKJgh7Eo5EFL1ODhVdE8LSb9Ax6sgt
vhk9KAa9Vd4EYoINozkBKgPomEZwg/lQcR9uX1BeFNbgu5NvD17zAF+vZMnlN8Bd
N6/YxgpOcYbn8tSe3JnMkXgeoaV8QCoun0TIpmxsJhJAXhIfd9p8ltf38SgT2TpK
V7+Md6qd4ZbnuZWtp9LJFvD+UqoYxBl7s4vLSQMuSEU7SGE2hALXXsIi/bNUwUWb
uAiMVmYFgX4Wn9RPfrn6/BOVvDNDxw==
=5ex9
-----END PGP SIGNATURE-----

--Sig_/TFlVLZl+adFoUnKE47AN=tA--
