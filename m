Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE3B4E3076
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352415AbiCUTHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243715AbiCUTHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:07:31 -0400
Received: from smtprelay07.ispgateway.de (smtprelay07.ispgateway.de [134.119.228.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB90A3CA72
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:06:02 -0700 (PDT)
Received: from [92.206.166.137] (helo=note-book.lan)
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1nWNLr-0003ty-0w; Mon, 21 Mar 2022 20:05:59 +0100
Message-ID: <62c44a98ba6d45a087ccf20c5a857366639f2025.camel@apitzsch.eu>
Subject: Re: [PATCH v3 2/3] dt-bindings: leds: sgm3140: Document ocp8110
 compatible
From:   =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-leds@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Date:   Mon, 21 Mar 2022 20:05:57 +0100
In-Reply-To: <YhVN9MoUyme53OeK@robh.at.kernel.org>
References: <20211117091405.7412-1-git@apitzsch.eu>
         <20220212180942.8241-2-git@apitzsch.eu>
         <YhVN9MoUyme53OeK@robh.at.kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-C3CkBKU7TmV9uTkARBvl"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-C3CkBKU7TmV9uTkARBvl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Dienstag, dem 22.02.2022 um 14:56 -0600 schrieb Rob Herring:
> On Sat, 12 Feb 2022 19:09:41 +0100, Andr=C3=A9 Apitzsch wrote:
> > Add devicetree binding for Orient Chip OCP8110 charge pump used for
> > camera flash LEDs.
> >=20
> > Signed-off-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu>
> > ---
> > V2 -> V3: Add commit message, h/w info
> >=20
> >  Documentation/devicetree/bindings/leds/leds-sgm3140.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>


Hello Pavel,

kind reminder that patch 2/3 hasn't been applied to [1], yet.

Is there anything that needs to be done from my side?

Best regards,
Andr=C3=A9

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/log/?h=
=3Dfor-next

--=-C3CkBKU7TmV9uTkARBvl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEazlg6L1sjNt+krNCgnfiFzZ+STsFAmI4zJUACgkQgnfiFzZ+
STu8ew//cmFJGYUF1ifeQEKE/wMqYVEDypIhDbvlZIgak6v4Yjb2QA+nQV23VuiR
ZpjRXORxMbM6T5FdsJtDZDnfaHWNEAZ1dz5AUiFS2BtSMtBHbY1riMqgPRsc6AtD
TP7FXlqMJwz9RDd+o/SPahyjwCZSzPeuAQQ0PDI1bnzpG6DD2pQ5OLp+zbbpYH97
ShdcX66UY/yBzFdrXWoFjc8d8/HtuObrbx0vHc1Kx8nkv/R4P6MAY7getAfOw7tG
lT1yRInQKlhQh6cThCvVWS1KdukrpiVNVytfTYmOid4mXr56INZXVPeKwJ2Hj1o1
SlNNHNbFoE5xVA49Fein4cs8RKQDG8whV04PyR6yRmjpcVRXz4n8PgGY8k14df7u
eCfI0QcLEKW3545wKtJdTQEojFYlOLc2QACxvGzZWlg7edpZmugRLjdyNKV+wiYU
0A3Sumxtif28WHol2M2fwHSahOvxoIVZFceDxmwJ1CQ/oJ4CJ1F2TXOcoArhXvDj
wHrYu6Ml8zVQcDpuZ7vTz3XGU3Iadp8M6RFCYqUTwHn/Oipk67K89nje1AdU/3FZ
YFujZ7MAmELhes5rWpe/Oh9qQZAEoYnGLrA0BljSFPtUOm0EFm8/Wz7mrvt+BDYD
YjKKoLl/zK+QxoMznNL8JPSMn8Y9tauJUV0OH8aj1WUvuKAj8c8=
=yezE
-----END PGP SIGNATURE-----

--=-C3CkBKU7TmV9uTkARBvl--
