Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36E54A9B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352292AbiFNGrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiFNGrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:47:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5A42B199;
        Mon, 13 Jun 2022 23:47:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMfBp1YSkz4xXg;
        Tue, 14 Jun 2022 16:47:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655189266;
        bh=kl6e33z+z2C3uV4sjs4rjBGHqWaNl3gfF13vHXhmPhk=;
        h=Date:From:To:Cc:Subject:From;
        b=N+CuOi56FKVIN880LcBgh2t6bCRVCQlorfKp2zBpJgg17+P4WZvjvNWesMTKCz3U8
         3FncxOCZvn5GDNT8z9Zv2IhLPrJdDLczauNOSOK+58g1OeG5QAy9n6crTFI7ZnHVaM
         aoqcwpQeAe0vG4/Dp8IUEPDrbX8HX1V8M3GDllfm0o1Q3Rb3hGAmYVlznUg5sUgEfy
         JLtUwAuAoo+r5e74fk9jQAJRGSYL1KN5rY0NIfRoRs8KGFqIEZ3TYBxlcKnku2kWZL
         29o+ozIrOvRXN+KnjaUNsGqxidv0dGrqIwdOxVT6Kkuc2rHw4kectlI1/ZHk15AVXb
         Tp+Cb5Jk/sM5Q==
Date:   Tue, 14 Jun 2022 16:47:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the tty tree
Message-ID: <20220614164745.7b746354@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M52EJeb8BVhq0iQZcFFqiyP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M52EJeb8BVhq0iQZcFFqiyP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tty tree, today's linux-next build (htmldocs) produced
these warnings:

Documentation/driver-api/tty/tty_ldisc:46: include/linux/tty_ldisc.h:190: W=
ARNING: Inline literal start-string without end-string.
Documentation/driver-api/tty/tty_ldisc:46: include/linux/tty_ldisc.h:190: W=
ARNING: Inline emphasis start-string without end-string.
Documentation/driver-api/tty/tty_ldisc:46: include/linux/tty_ldisc.h:190: W=
ARNING: Inline emphasis start-string without end-string.
Documentation/driver-api/tty/tty_ldisc:46: include/linux/tty_ldisc.h:190: W=
ARNING: Inline emphasis start-string without end-string.

Introduced by commit

  6bb6fa6908eb ("tty: Implement lookahead to process XON/XOFF timely")

--=20
Cheers,
Stephen Rothwell

--Sig_/M52EJeb8BVhq0iQZcFFqiyP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKoLxEACgkQAVBC80lX
0Gy8hAgAmVEaQEgW16BD6cZwAHyROAvE2OWRVK59FiE0yoTP/9flG+r4UK0PNUlo
Dvyjzijub/mB3GM9eKReRs/ocLamo44DsZbCYlbmhs4z6R8kBkGBJZrkUw+wQ3eZ
6DWwi0J3CroUDc+p8StkJbOwI/8OHD/gkuBV3UH4LCrOCdG1/v0c2FONjBQwzKeM
z5viW/lK8wuZld/24HMiQm6vnvCqXLR0U/oORjQdm98T5HpUW1T6/l5l/v2TqBpW
BoJlsU6/1lNgdxpSLfWzD1N3i/yaK+mjPASK9WR2TWkDw9czyvuI7lp58vY+ShDc
ysGrrqhJtyO4mIAMH5ibWQddzM9Irg==
=7SiC
-----END PGP SIGNATURE-----

--Sig_/M52EJeb8BVhq0iQZcFFqiyP--
