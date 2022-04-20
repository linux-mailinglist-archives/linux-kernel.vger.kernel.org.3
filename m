Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1127950813D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350052AbiDTGfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348640AbiDTGfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:35:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC75393CE;
        Tue, 19 Apr 2022 23:32:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KjrSt260bz4xR9;
        Wed, 20 Apr 2022 16:32:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650436367;
        bh=8EVujM335szcnqXRg1dNPkibcXcGfMWr3NUcJS96XW4=;
        h=Date:From:To:Cc:Subject:From;
        b=gkaJhsrbT6lVPBI+utNaCM3wTnfNGaUXdkKBdVwthty+ay9G02Zb9WmtcuHrOk2Tb
         teAZmPzXZGwM8E65P35lsgOG3MXBw9jmLCnN2yDRJrI9zyGCorMTKy9J2GLjrfvFmQ
         bh+BKUAzMdsi5mCxTPg04WsToqfUNScK1Kt4GedudxVpDpG9zUrrdzyZVq4DAFCpzT
         VqLP0XXHQ94N8OW3Rec2YmI+D3+I/MErCL0gQ2GhR5HffNfWBFHEswTC8NXDcpvDRM
         I4SlEh5TbN2SxPwsRhszP5TL4wd/34d7x9OHnbS8GXFB83SX11BNftVpe/EXfaxW5O
         84araxiUXDLOg==
Date:   Wed, 20 Apr 2022 16:32:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the tty tree
Message-ID: <20220420163245.5a0cbf89@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wXUxSASoQYkWwhQ7AhC70ek";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wXUxSASoQYkWwhQ7AhC70ek
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tty tree, today's linux-next build (htmldocs) produced
this warning:

MAINTAINERS:29709: WARNING: unknown document: ../driver-api/serial/moxa-sma=
rtio

Introduced by commit

  5b437ae9fcbb ("Documentation: tty: move moxa-smartio.rst to tty")

--=20
Cheers,
Stephen Rothwell

--Sig_/wXUxSASoQYkWwhQ7AhC70ek
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJfqQ0ACgkQAVBC80lX
0GyGpgf/X49tTOMaqFmSorwf062pifO64xbpP6YRg1t39AX6Z9+o6lo5frx9ooUR
whfuL21GJyJfEZTzE42nn6W/CSO+tVoQyJueXD4CstYrIo8NH2urtMmvnH0f8QVY
nFD2AuFL6vUW4TTQu8MAhZKl+zcc8MkwwK/lo6/KBrUcmTM8CPd1bN8Pe58i3015
iRfgRJklKlblYwE2t9KDbGZUzKFNR4sJl/QkH9k/ZOdPyVtdb0ITirN9NPpvxwds
BUe47yvO+kNTz/BvshjIy4KRtl04eIqcfrg3KjibUeyuI8W7vTGP/0Otv3VyCwWH
fv73fwcKR3mXJfWyxzQ0cEdIttByEg==
=3nAX
-----END PGP SIGNATURE-----

--Sig_/wXUxSASoQYkWwhQ7AhC70ek--
