Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B9657789B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 00:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiGQW0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 18:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGQW0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 18:26:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D48712756;
        Sun, 17 Jul 2022 15:26:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmKS50vBkz4xXF;
        Mon, 18 Jul 2022 08:25:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658096757;
        bh=4iZSHga6dTB4ern6xoT5t0BQkfA7Rd684PlnMhg8LOA=;
        h=Date:From:To:Cc:Subject:From;
        b=j0vaB6+EjpBBqyGVkact+kgBFzNbC4KHRYFIO1e7aGkzK2FdZzDuP+s/Md1WsD63a
         FUe28Ienhr/iHDLYtmJ1tCBXHJXhaiyyvQQMhETE6+XX3YXSxH0tVP/44uMuKg4NJK
         E8dvUG/JEYBgetg7U0bG8cYlsNvKEyX5K6KF6cq9+iX0oeZbbcTpb+75N5WrSKsTVh
         jqw7nQRa++93E7hq2uOlmmLNUIQuCFMT4/Q9ZlfZHcUuyc5v7cFqIbLdgfXGkFHvyX
         uwudA807rVclyibH0yQJ1RKms7bxHLrwQhq0KOcoQYLa6OdCF2FQyQW4S1w773CnZQ
         8pgrb721fhIHQ==
Date:   Mon, 18 Jul 2022 08:25:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb tree
Message-ID: <20220718082527.18bfe5d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=4M20.dNStm_40DeA60QedU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=4M20.dNStm_40DeA60QedU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  106be65a4119 ("media: mediatek: vcodec: decoder: Const-ify stepwise_fhd")

Fixes tag

  Fixes: ("76250b48de79 media: mediatek: vcodec: Getting supported decoder =
format types")

has these problem(s):

  - No SHA1 recognised

Please just use

  git log -1 --format=3D'Fixes: %h ("%s")' <commit>

--=20
Cheers,
Stephen Rothwell

--Sig_/=4M20.dNStm_40DeA60QedU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLUjFcACgkQAVBC80lX
0GxWWwf+LbRgXhDfWR5KT/+/j78z1GE4J0S8QEJFi+nGDXDQexHGQlHNpY/Bu95T
6l/Pvc6dmwzIwl1bfWIqbqT9f5NU8mlCewdJL24TkZjEPBL7osTzahu6M7RecvTF
FR02vMC9JsQrDpAPa8XI7KxTYEur8IYyf+VpXr6xav+AbuUqGARKufHKKjXBFIHz
eRarnnc9B7L+oCNPgFmZoSSFBeNUVMv9WDphBwQV2X1yxgNaFgeLo/hOEfvKdQrr
U3w/2/nUAKyxh0jpIdx/wU3kzwNeo/ojrSIPDv/7di6k9ydEKliCLyb3/UEa6stm
dJi8mOSUt4i70jImFSA72O7HeMmVbw==
=j+T9
-----END PGP SIGNATURE-----

--Sig_/=4M20.dNStm_40DeA60QedU--
