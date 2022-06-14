Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C873654A5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354131AbiFNCSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354393AbiFNCOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:14:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B324A3B55C;
        Mon, 13 Jun 2022 19:08:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMX0f6VzSz4xZK;
        Tue, 14 Jun 2022 12:08:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655172515;
        bh=XF4j9j8vj63p9k9kxUS7826ICnBo920lHxlbbGtHHSI=;
        h=Date:From:To:Cc:Subject:From;
        b=CIA/H9RdPG3f88QdmMMI2wfDoBN4xAkefC1zzn/tM4fGFJ8JIEoVCGePhsBOiCkkS
         x2WnjJHxjR57m/vzSxVTihH9Ql7Rd1PvmDRsUWI0OYbRtzEIt+E07DC/EWgi15KB94
         yCTWpy428rqCMngVoQgl0/00jlzDbaXnZfDqIMhRyq5QBZIbtkwJm/6IJVgYK00fkD
         Qb/xYJ7PhAUKN1U3jwv950HEbmEFvSlroTTxu5JddB4/oxggctJiFUhD5QFMhg5OCu
         X4fGkUv+xW5R1QsfAuLYUJHjUg7QY91R+1XPmBeSZD7MPy6pRlAWrR63BwxBb0yl0S
         X7mkXz5obyCQg==
Date:   Tue, 14 Jun 2022 12:08:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Neal Liu <neal_liu@aspeedtech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the usb tree
Message-ID: <20220614120833.06cec8e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MzH=SMk3139Y8vMKMwdtN5C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MzH=SMk3139Y8vMKMwdtN5C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:


Caused by commit

  2cee50bf4590 ("ARM: dts: aspeed: Add USB2.0 device controller node")

I have used the usb tree from next-20220610 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/MzH=SMk3139Y8vMKMwdtN5C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKn7aEACgkQAVBC80lX
0GzT0gf/UssKtshy5NEnxzkSIiix1xrbVEbU+FM2xjAcmsRzzmxinnQK2LH/8r6v
SEf51c9w3FAjURj5L3PFk5XnKiPDHEsKZp1mKsR0cQPdpKVN8aDuWUo2jagBOoJA
IA9qP7omqauyWdVLmY+Swb/XKou5IavURbBWHe45Hn3XkocsWNSqR95lPt2Xrmc3
73kTPupzVvvvlyZubcHlFjcpxLgdbZN+paYFNIHyWQ52rxa61NllhZNVnwvDwsSn
pEL2g2kIK2DhL5XFMdWzeYpzu9i1Hpr7Zp0CCmwxwFGJI8z1tJkbdZTatB3FKGmE
Kkdzh55dvNUpWv50DIUGqQA0oQRJzQ==
=cB0k
-----END PGP SIGNATURE-----

--Sig_/MzH=SMk3139Y8vMKMwdtN5C--
