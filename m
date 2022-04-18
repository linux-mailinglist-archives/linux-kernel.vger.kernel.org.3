Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB938505F19
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347898AbiDRVER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347856AbiDRVEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:04:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4174329CB5;
        Mon, 18 Apr 2022 14:01:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Khzqx1T40z4xR9;
        Tue, 19 Apr 2022 07:01:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650315680;
        bh=J+ThAFs1lwgbJGvGifYpWhoLEGe9lkumqw+eteyhro4=;
        h=Date:From:To:Cc:Subject:From;
        b=tAvF/ogKoUmDknKLvd4uc+14DtKaIgRejWw9+SLHfC5Xxz4x7sjq2USPe29238guh
         it4AzTcB/WWn16uLOCu5lT91jUhxhl4VHQ+SfLpmcOj2X9H5RRNh8TwAd3L6pDf60b
         7GhnZFRoWMYdOkfSZXO5KMwu9noQOGGlc0eJtCC35uUX8QC0dqefi56/Uyco9+uBJh
         xjIWIEc2fZk+4Fgo+pY2RrNcXG3rQxoMOKZ75JUXGVcv+4AEtPH0URq0gvNCZIpjnd
         waOHg/deSqQXGDnAA0POjvtEYend3EqjrPAs2Hct8r0Q25voz/qmd5gk6YtgH3bKIX
         sPWPSYa9PaBLQ==
Date:   Tue, 19 Apr 2022 07:01:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Lawrence Hileman <larry.hileman@xconn-tech.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: linux-next: Signed-off-by missing for commits in the pm tree
Message-ID: <20220419070116.2974bddb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2C6+iNBGJWD6WElNTn+wcKR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2C6+iNBGJWD6WElNTn+wcKR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  6eaf08770ee8 ("ACPICA: executer/exsystem: Warn about sleeps greater than =
10 ms")
  ace8f1c54a02 ("ACPICA: executer/exsystem: Inform users about ACPI spec vi=
olation")
  1838ffe7001b ("ACPICA: executer/exsystem: Add units to time variable name=
s")
  8bd24835db17 ("ACPICA: iASL: NHLT: Rename linux specific strucures to dev=
ice_info")
  ab1ba87bd71a ("ACPICA: iASL: NHLT: Fix parsing undocumented bytes at the =
end of Endpoint Descriptor")
  90037551c68d ("ACPICA: iASL: NHLT: Treat Terminator as specific_config")
  a95d2fb08538 ("ACPICA: Add the subtable CFMWS to the CEDT table")
  62b32fd961cf ("ACPICA: Add support for the Windows 11 _OSI string")

are missing a Signed-off-by from their authors.

--=20
Cheers,
Stephen Rothwell

--Sig_/2C6+iNBGJWD6WElNTn+wcKR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJd0ZwACgkQAVBC80lX
0GxYIwgAm7rJ6fR5Zbs6fcwIZOu3QdHvX9PRfn6keG93eeLJz9eM7P8f0ytnnGCm
OzUqb20aSCh73N8PtyfzN+6Uw0JZNOg6cuzKYOrPa6nsiOOCGJ2m/GksB8xdH6Gc
bIjcLa1tDzJRSidN7lFM+//oWeQbVw1EZlhT4+swh8SBcW8CZkw/PzvJy/Zeq/+N
R79mmPCE2yfqTIawkBvqzTPv+P9pUraeXcYn1vZifZw1iXRX0LvrXfD90UIqeMbV
U0Z7Qvy2hcupPx79pZ24P8aS9z9nE8rbu0DTVmy+r9QI54yy3sUBCp+XAGTEFpen
nn9wyIVG0cJDKEJyCjjiwsbv+Ev6GA==
=4oPa
-----END PGP SIGNATURE-----

--Sig_/2C6+iNBGJWD6WElNTn+wcKR--
