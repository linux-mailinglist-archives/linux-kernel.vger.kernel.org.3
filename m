Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE06C581C70
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 01:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbiGZXe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 19:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGZXe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 19:34:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C437199;
        Tue, 26 Jul 2022 16:34:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LstXv6CYhz4x1b;
        Wed, 27 Jul 2022 09:34:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658878464;
        bh=3ftdO6M8zn0EKg12EZzHz9s0Ryl+xR9HzLM4f5CJJ90=;
        h=Date:From:To:Cc:Subject:From;
        b=XuvAFQjYIXxn8Ib0ABy9HEUOG+OwU8S+KsbGJdkZd/ssQM3L/lhzwsynf4qhIlt08
         KMcJZwMkJ0bGBrdxcMS5wrqKcsyUlm/Kpy1K7BAefdRUBHlb/Iag3E3z/qtRw8/z0a
         B2MXcypIgXDdzOze3AAhQahRJX/+zXLfjrfdEZNGMcviZSb+BEYDMohfny5PXgyISa
         gS4a6W+LXDJf+NpuW6752INDcWZVecWEKpHoRkeYCEg5t+tGjN2+0fxkXgZWyvdUIP
         tzcrZAmv144rpoMpvgXGMWOsOQ/bHvfb3suvqLGHPcB+oFEQC3yj7InENn3mvApUM7
         IfGYs/YagNCnQ==
Date:   Wed, 27 Jul 2022 09:34:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: linux-next: taking a break
Message-ID: <20220727093422.78d6142b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U/dJ48i2d0jpfS_ciOKuAWB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U/dJ48i2d0jpfS_ciOKuAWB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

There will be no linux-next releases this Friday or next week.  It was
supposed to be the second week of the merge window, but the best laid
plans ... :-)

Presumably everyone is already prepared for the merge window anyway
(since we have an extra week).  ;-)

--=20
Cheers,
Stephen Rothwell

--Sig_/U/dJ48i2d0jpfS_ciOKuAWB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLgef4ACgkQAVBC80lX
0Gydswf+KrYkz4APO3NZXDpuWNK0GiuswTJf98CBMN7Sk/d96izXAOLiSa5VRCMm
q2/HUYL/1L9podb3LtRQR2C3CSQxFT73B2RXHA5ygGlg7RoYpfA7HOek1wl/WDSe
F44N1sGMA4SN1lbcyaBLAjFEmknGSls5b13KAqxj8aFtZibWOvYK8pkYy+kTfM//
JA7JNsuv1cChFxjGCsE27Og1q18xEJsqLUmqfUs44/QlsBbys3M9PkzyfSOY/K+3
d/ExLFrCj3ACNei9Dr0DvymP115UWHN1CAM6wUfOH3vfUhNjSGVQ8bsMR5J0GOGx
6rW/wneX5O+0+bim6+Kd94WaCoUlCw==
=vDT0
-----END PGP SIGNATURE-----

--Sig_/U/dJ48i2d0jpfS_ciOKuAWB--
