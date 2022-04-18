Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E6F505F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346362AbiDRVUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiDRVUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:20:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476822CE16;
        Mon, 18 Apr 2022 14:17:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kj0BW4nx9z4x7V;
        Tue, 19 Apr 2022 07:17:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650316644;
        bh=/tNqYXoNy1mjldE8pgn14x6sLKNc9koqdiS4bX8mZ0w=;
        h=Date:From:To:Cc:Subject:From;
        b=rBwaCCTcawxEtB9B4kWOKnOtkbQUmv8sgckJ7cHewUIFF6BtaBLWkEh85KXsgJqCq
         q47dW2MojZBoQ1YQzatEQWRo7gNL/qnG9kdsgpmDfkKolm3M2b0Ddr6NpjWxpaA0hl
         7UryH4NuhyQie2lOikRdwL7oJx7ZIyHXhYrYyOql+FBaUxniP+B21kD7Qo9KwjARx5
         V8QfAyLsgt6OGgtSSTwnXpvWypntJW85Yb6ewJkCRm7GeWs3CSwA0pQm6k3JE4lZBA
         uM2djouPIFgOZOpNa9KQoc5YAg2aihDyjJQ/KOCvEK/RKtHVpmJknCHjXzzWu2Xu9X
         WGEQ0VRfZ5CCA==
Date:   Tue, 19 Apr 2022 07:17:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Marco Chiappero <marco.chiappero@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the crypto tree
Message-ID: <20220419071722.6e47c542@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_///p1V/r8TiyK/y4q9yfw9Ct";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_///p1V/r8TiyK/y4q9yfw9Ct
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c690c7f6312c ("crypto: qat - rework the VF2PF interrupt handling logic")

Fixes tag

  Fixes: 993161d ("crypto: qat - fix handling of VF to PF interrupts")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_///p1V/r8TiyK/y4q9yfw9Ct
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJd1WMACgkQAVBC80lX
0Gwi+Qf/ZYiwAXVKRIff6Jx2ftmH2rUTqCfE21zeiManMQR8S0ue/GMAeJotK7eE
RAg/QaQhYTEZHtYN8uMH7GSaNbaA+Ckn9wX5MkzREwPs8TXaWhTwlpMdhJUociSM
c5HW7yefb9/MeC2v5IIiDDD/2D8GrXiSML7HRakyvpxFecbOJUPxU/9/UWs5LDZg
zUxAy/AZOjei/lNsHWBtbhveZJW+jpXwWMWN0oQXf7TM5FvLtB9Pqy8iCjtFlYSA
d2OzYJ7p4bV+r8QYYxZFmVfbNfAoX29Q7bKTZhUfc5VMB0kBiXo53w4P0hXZKosx
v+oX0nQcVEe8nyTwhdGpo1zAlfJ6ZA==
=VJsk
-----END PGP SIGNATURE-----

--Sig_///p1V/r8TiyK/y4q9yfw9Ct--
