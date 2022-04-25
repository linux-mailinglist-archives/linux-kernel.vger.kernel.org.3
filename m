Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1494350D994
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiDYGnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiDYGnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:43:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0885FC9;
        Sun, 24 Apr 2022 23:40:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KmwPQ6wRzz4x7V;
        Mon, 25 Apr 2022 16:40:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650868827;
        bh=J0KzaBi6vTqwiyg2folawIJK4/TDle8h1QEj5kxLEnw=;
        h=Date:From:To:Cc:Subject:From;
        b=E2hu4fQooBTb47zxFjaECW3j73eAaE15GCtqNNB/rZeMW0JWne/YS2ZvH2UfFp3wP
         bxiFX6hWijwLrzSBjiLRswFaDXFnPxjpE7OO04CzkgnPmt4NMM2t5Sxj8ElGPsJZLF
         b+6v3eK4Sc1rw1Q1psivASKi7O8j1pQwgiYayPJNgFRInNzRKVrdWiLlB1ew9m0wOi
         7MeLs86TE6OZTjuT6uJkdB9Qsmt2emYanDl2W5F3ldrCp7DAMF8AQ0HeyqhB3sC3Xa
         MfgFKF/sPmELjNv0cRaFEQFNjy3z43Lqp4QdNZiiZE00OYtyRH0o7IBE/EdfIYDWRN
         5ctsqk+LGl8mA==
Date:   Mon, 25 Apr 2022 16:40:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: no release today
Message-ID: <20220425164025.4a55844b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/27ySs0VuE7wSEaayARmxvyQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/27ySs0VuE7wSEaayARmxvyQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Sorry, I forgot to mention on Frdiay that there will be no release
today (ANZAC day here in OZ).

--=20
Cheers,
Stephen Rothwell

--Sig_/27ySs0VuE7wSEaayARmxvyQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJmQlkACgkQAVBC80lX
0Gy57gf/eVjlGwqAyQSPp4Wr7NRp31Ra+XQGBsw00B9yYFVj6Y5RA6CV/xjMlee7
x4DCjXCRnu1PDCmsSs/+9EMNe0Thgfp4aC/IcjFzeiFU3jt4zHHqlEfI8waYucQH
/qHZG67o31vjpjP2xEkBXYHU4rUEf2H6iCFgu6dhES7NfHatOnzzkWRX81N/M2+W
jf/YSPgxJK7uZJJiDM7r6LzgcFXISPH9Mg7ELNPCQ+2QRkxFZGYLoaL1DB/ZFCBJ
3e15MEjii+T4JGyXb//3PCER1Jsopj58zlfrWYg4IwSTLu3ewuRUd4A6eYNjfz9J
XaS6v4BqIvyYSxKORcfI4jx621nLEg==
=wevx
-----END PGP SIGNATURE-----

--Sig_/27ySs0VuE7wSEaayARmxvyQ--
