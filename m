Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E50354ED60
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378585AbiFPWe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiFPWeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:34:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3E261624;
        Thu, 16 Jun 2022 15:34:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LPH610fMwz4xXj;
        Fri, 17 Jun 2022 08:34:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655418857;
        bh=VnzoU4CtXwZG4jAYHFjl9qplotknKe8u7bZFzWmU7FY=;
        h=Date:From:To:Cc:Subject:From;
        b=puQzfvEnAKcF/36vvbrTnpd37c8N5HsXHfFyXcR1iys8JNVZGFeSleznfoWMz84cC
         pcovt0s4u5IppwuL5ni+ExigMHQ0BoSFiy46qbTzwg3Pj7gEFvroWFwxZEz8c14NNk
         OMv7eC5TZq+YFKZM/pmkEoWC3j71qs80zgXZ/5SVdRheOFolTILQ0AK4pnagvZJNa3
         996GurJ+gOPlUiCDSHMqkbFNFIcEvusDkVbyqzsJ3Idj29TLUbnqkmd7XeqpZ3NWbI
         yXxKIbw63C2DsNCyRoq6VJJ+2av6bmWEke8qjc5zsyOC4BElU2YKTwk3w2cE65ClbO
         +EE0amUMjkEcA==
Date:   Fri, 17 Jun 2022 08:34:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20220617083415.58099b8c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3iRvmYN=N_W5F20WxXzirvI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3iRvmYN=N_W5F20WxXzirvI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  a284f0491590 ("cifs: periodically query network interfaces from server")
  d6758ffc0dbb ("cifs: during reconnect, update interface if necessary")
  dacfaed48632 ("cifs: change iface_list from array to sorted linked list")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/3iRvmYN=N_W5F20WxXzirvI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKrr+cACgkQAVBC80lX
0GwMlwf+MSVcsmOeLpHw5yPGJK3bYz/OGmPfuiiLbpmYAcK9KANH5+fihPWcaV4Y
hb9ZTJ2HbjbPovmbgFGd8GQbD5rRCMpfCSmJb7SI9apU8iR1/TJxeQtxPqh9Vjsi
F/FQn8PNp10YklVB7KVKI6OlnPcbG41BL/pdqdmqMAT5Am02EwQcdZnSBOJBkWeZ
J9KJEAalYbKXTpaY1L1xXiskBFiJua6jo0CpnOLx0Sf9nAdVXnfkNMTMCbuOfbil
Wi0767giiV4DLQoUNG5vhGQNCegfm+0zd3u7ycvQ06LgkW2tWVhToQi9kkYYLoR5
i+7+oeuBoCXUMb8rToYw96Ln9tqH/Q==
=KQiq
-----END PGP SIGNATURE-----

--Sig_/3iRvmYN=N_W5F20WxXzirvI--
