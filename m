Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69B6587D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiHBNwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiHBNwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:52:10 -0400
X-Greylist: delayed 2039 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Aug 2022 06:52:06 PDT
Received: from mx01.ayax.eu (mx01.ayax.eu [188.137.98.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D060D252AE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 06:52:06 -0700 (PDT)
Received: from [192.168.192.146] (port=45372 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1oIrmZ-0001SJ-Dy; Tue, 02 Aug 2022 15:17:59 +0200
Date:   Tue, 2 Aug 2022 15:17:58 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: The r8188eu kernel module does not depend on the
 rtlwifi/rtl8188eufw.bin firmware file
Message-ID: <YukkBu3TNODO3or9@nx64de-df6d00>
Mail-Followup-To: Grzegorz Szymaszek <gszymaszek@short.pl>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iqpQVhHimMfcUGvS"
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iqpQVhHimMfcUGvS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear r8188eu Maintainers,

The old rtl8188eu kernel module, removed in v5.15[1][2], indicated that
it requires the rtlwifi/rtl8188eufw.bin firmware file[3]. The new
r8188eu driver no longer does so.

I don=E2=80=99t know if it should be considered a regression or just a diff=
erent
behaviour of the two drivers. I=E2=80=99ve noticed it[4] when I tried to us=
e an
RTL8188EU=E2=80=90based card in the initramfs of two different Ubuntu kerne=
ls:
v5.4 and v5.15. In v5.4, the firmware would be automatically included
when the (old) driver was included, whereas in v5.15 I would have to add
it manually so that the card actually worked. (One can verify the active
driver=E2=80=99s requirements using =E2=80=9Cmodinfo -F firmware r8188eu=E2=
=80=9D.)

If there are cards the new driver supports that do not need that
firmware file, it makes sense to not automatically include it. In
general, I don=E2=80=99t know the kernel policy on such dependencies.

[1]: commit 55dfa29b43d23bab37d98f087615ff46d38241df
[2]: https://lore.kernel.org/all/20210731133809.196681-1-phil@philpotter.co=
=2Euk/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/staging/rtl8188eu/os_dep/os_intfs.c?id=3D06889446a78fb9655332954a=
2288ecbacc7f0ff8#n22
[4]: https://answers.launchpad.net/ubuntu/+source/linux-meta-hwe-5.15/+ques=
tion/702611

Best regards

--=20
Grzegorz Szymaszek

--iqpQVhHimMfcUGvS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZT55kPBhnB69hD4ZeE9lGUIcpz4FAmLpJAUACgkQeE9lGUIc
pz6bAw/+Lgr16PtH7UpW6XYVGCUSGmtE9iquxHi+fAAPn61RpdkcbF7LJN1rqgQC
MVt5hYDZrOEE6DcXXTKdb2BMNJfPJq7O66UGH71myyZx3xNbsKkW07BjikxDmZ69
/My+HKCxXllVBMSZDlkdt4mHn1df+3E9jhY2Uu5Qu8TnQ1yY1zAfeXz+MTnI81lM
RzpeNCs0LBUR6Hr4AqYsIKLqAhmx3hBCyhK5y4pZa/rTymwefM/CSvHiC+CGr89s
6iucyx2wh4Cyv9ZLh4HSnGgkBhSS5AtzY7H+vE5318TqjJBUadvnhSGH8ponLQpO
u+LC1BMaE5BabkJRPtQ49q+fvrPUs7tVB2hg3osrS/dEcwRs4h8mDvFkv2suC2rE
rasrrZOL+RH8MfjeSNrS/B1cvPQiv8L8SWMvSErx9Z3Vlqr3oOVpgiVkogXg43Lo
D6CRfQSzkQ+kfsQXFuJZ57cq5iAGTC/1VYU1NTmlSmlRg2RjBxL8EpY+3rDY2u+C
qEp4j1Ly+Vc8Mr5i5tVHlpWjw8+59EJiZuuVz5kG1cslqgfVTwZ/fm2ZMW3uGJiT
8AyPuZaCgzEpdO5bn2SfJNeCuKfEGJmfkuMgiILj+Oh7xjv+qkvrdpbjp7bVGXHl
DeVeiSutlkqLXaSVUdZYJwaWEeafYDJqEcZnRXZ1H8WtnBkAbpY=
=sx65
-----END PGP SIGNATURE-----

--iqpQVhHimMfcUGvS--
