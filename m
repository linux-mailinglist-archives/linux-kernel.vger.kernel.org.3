Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F74B4691FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbhLFJKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbhLFJKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:10:11 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E17C061746;
        Mon,  6 Dec 2021 01:06:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J6yGm2Klrz4xgY;
        Mon,  6 Dec 2021 20:06:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638781600;
        bh=DSG3WHGlme46/2anWUJk11SuLZgMvUNlNTmV1FgLAG8=;
        h=Date:From:To:Cc:Subject:From;
        b=XbscnS1Qln7RMLVWxXDRYuZ0B0bA4CvX7+b/BWnAPvfcEI/I/TNGWG+qPPaMU+Ib1
         XH9l527WFmkm3LNBYmAK2xO0xYY++PrCrOBgs0eM2t4YCm3Esvz7tWh7xXdbWuxli9
         uKzLRw9qUNIdEkKwdFevTFRBjTsGh5vgl13QC1VnHt1S5hK0SHVPSPFoL1isI1Y3Gv
         RmQqCmWjwWEhMdhOOlqOCcn024/itNaQwubAs6MUa3LwAPTbUzp6tvaqwDG+9IhuR/
         yp5ych5KTNMUjIMEKBw+WUK/x6pRU5GaOFlLDfw9MgPTczBYCbfB86ClFOthbmvTVD
         nCxIv9tZtxUTA==
Date:   Mon, 6 Dec 2021 20:06:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb-next tree
Message-ID: <20211206200639.203bcea3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g+xSEyRVeVZt6OtVne+I5e1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g+xSEyRVeVZt6OtVne+I5e1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c1c95d709941 ("media: uvcvideo: Increase UVC_CTRL_CONTROL_TIMEOUT to 5 se=
conds.")

Fixes tag

  Fixes:

has these problem(s):

  - No SHA1 recognised

--=20
Cheers,
Stephen Rothwell

--Sig_/g+xSEyRVeVZt6OtVne+I5e1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGt0p8ACgkQAVBC80lX
0GyDnAf/Zxb+tYtBmmyJ5uwgQ3QxzUwzHBY83SwNRHG2+JFzdnadI6HkTgP7kVI5
sesTzWL71NakYmVjGEqNtqxHjNnHzkOtZU9N8Qg/FLtIMWk2L/jK/+39ti3n9Jgu
PLDlP3kgg2lqtTXcycwXJMM+MJqdv1YMmIE5SePFNrNhfFTYJuSYstQmF3KWOSS3
4DyLdkPWS+X2kb7K0aiPz6Vj1F+s2xGWjPgYr+DpH1h5QSYMlCjva/HsvHTHOnFI
8+Y+OveOv8tiPJQoXgBCxHc/xiqIvb8w4WGxTiTeDboE7UBq/FqKiEtqzmy1ibG8
b9tpmgJJcLNraX52MHWh/tgf4nVe1Q==
=2BDJ
-----END PGP SIGNATURE-----

--Sig_/g+xSEyRVeVZt6OtVne+I5e1--
