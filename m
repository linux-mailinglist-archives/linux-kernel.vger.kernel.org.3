Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11125679FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiGEWL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiGEWL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:11:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892431AF24;
        Tue,  5 Jul 2022 15:11:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LcxjL54Znz4xRC;
        Wed,  6 Jul 2022 08:11:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657059110;
        bh=P6Hfr2IF7ZpIdzghLv/XtcySNRkvPFbYuccFa2pcaIg=;
        h=Date:From:To:Cc:Subject:From;
        b=AzGLNUkIE9l+J0N0qcywNT6p0fdCZJFzRQPhrgbqOroba1SDlvm06HPBQoM1wE3il
         /MNJhsEbgMByDiJTPHUURdprsMtsz1Lk+PEbbOj9j3QxsrFvWzZTmqipB8/tDWFo9U
         TCXJ/BU3IuWZzwxPCuh75PgR2Fknz81FBY9Ib2H8dHMmPb2CffsiFP501FzuFSCpCr
         512Qb9rZgvVamqJFvjohNZrPeMZO3xNoltXRy0FP3f/pi/Q5oFoPj7jaY9wNijyZME
         1HiRNLlPJYTzMunzi+mga8uUdTLJ61YF9IrRysT/S1ulVbC+Y2In3nZGWalNApJWZM
         Z8dQ3LSv8g1gw==
Date:   Wed, 6 Jul 2022 08:06:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Shyam Prasad N <sprasad@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the cifs tree
Message-ID: <20220706080615.11c5ede3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HSHpA1MQhk015Xv92h96SKS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HSHpA1MQhk015Xv92h96SKS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  37c1ad516f2c ("cifs: fix race condition with delayed threads")

Fixes tag

  Fixes: 37d488b3d38c ("cifs: change iface_list from array to sorted linked=
 list")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: aa45dadd34e4 ("cifs: change iface_list from array to sorted linked l=
ist")

--=20
Cheers,
Stephen Rothwell

--Sig_/HSHpA1MQhk015Xv92h96SKS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLEtdcACgkQAVBC80lX
0GwYyAgApFQFZ/3RgcC4pxZ5ogF6EcunNfozd8O0zkKwe5WKHfxuw1/j3XnMiR9N
2MzEugC6Rnc2H4VSG180Dx2vKIOvVE38vlo6N08P7oPxIiwIqdMW8YOPi05bd7BC
APfknHcjBO/tSSFSg806MErYMc2tyOXGEqO1km1R60VFSqSacPHuT1Yy5+q6Ebh/
OScSLV0TXynLZV7IUfNGDyibmEwbpas/olqa8IKT3UUAbuuMkloOdFw7rZLg0LX9
eKD7W82X1guNOJ/3QJWrSblOHq8qNF/H8a37NlAqwaPpcfFYc8uMqxI4Vzj6KIY2
MD3Ns+SYXvC+JF165qjMLmYsgirsVQ==
=YyQo
-----END PGP SIGNATURE-----

--Sig_/HSHpA1MQhk015Xv92h96SKS--
