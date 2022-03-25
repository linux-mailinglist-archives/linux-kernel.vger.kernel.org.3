Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F234E7C0D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiCYTdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiCYTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:33:23 -0400
X-Greylist: delayed 7499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Mar 2022 12:08:19 PDT
Received: from 7.mo575.mail-out.ovh.net (7.mo575.mail-out.ovh.net [46.105.63.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F30E165A82
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:08:19 -0700 (PDT)
Received: from player774.ha.ovh.net (unknown [10.111.208.218])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id BF25424DD5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:51:46 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player774.ha.ovh.net (Postfix) with ESMTPSA id 6169E28B1E2F9;
        Fri, 25 Mar 2022 17:51:41 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G00340880d83-d935-4bde-a67c-27e18a733d59,
                    1702D5D0C6B5DF16716081994498F990499A02DA) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Fri, 25 Mar 2022 18:51:34 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm*: use simple i2c probe function
Message-ID: <20220325185134.1096bcc6@heffalump.sk2.org>
In-Reply-To: <Yj3+ILE03nOxbpsT@sirena.org.uk>
References: <20220325162439.1203870-1-steve@sk2.org>
        <Yj34gLRxhmXD1Y5B@sirena.org.uk>
        <20220325182616.6fb6e13e@heffalump.sk2.org>
        <Yj3+ILE03nOxbpsT@sirena.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EVIM78FD/YHiqgFyoMhIYaW";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 86131344199747206
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudehuddguddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepveelvdeufedvieevffdtueegkeevteehffdtffetleehjeekjeejudffieduteeknecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EVIM78FD/YHiqgFyoMhIYaW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Mar 2022 17:38:40 +0000, Mark Brown <broonie@kernel.org> wrote:

> On Fri, Mar 25, 2022 at 06:26:16PM +0100, Stephen Kitt wrote:
>=20
> > Which tree should I check for conflicts? I=E2=80=99ve got similar patch=
es across
> > all the i2c-using sound/soc/codecs files, I wouldn=E2=80=99t want to wa=
ste
> > anyone=E2=80=99s time if I can check beforehand... =20
>=20
> Since we're in the merge window non-fixes patches just aren't getting
> applied at the minute, you need to follow what's going on on the list at
> the minute.

Apologies, please ignore all my patches then, I=E2=80=99ll re-submit them a=
t a more
convenient time.

Regards,

Stephen

--Sig_/EVIM78FD/YHiqgFyoMhIYaW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmI+ASYACgkQgNMC9Yht
g5wGWRAAlqQsOLE3vqJsuhfVQzmlktxRpi9LEC/7k33VgDHtQYAE/D89x2LZuEee
oH6PcmxsExmaFQ5KxhYuvAxjjuaSwzaT3XGkTEQ2B8kXffqf7U1Ox5TmNDIDEoJw
2bUAFwBrcSpPdpHrzK2Calu7PJr2bpxix8DwBmCVoLvZ0btJGt65luLsOiaLblcR
yhqZKA8ZL4G55c0SxU5xSj7z+CzJBR0WRAroWrFlTjq8NWVy5FZmPF2w7DrviJ2O
FuktTYiUz6ZyJU2oodWyPWx2NcGp7apX5vQQ6jOnr3Rxo0cQpPT31QHLx15OqXXV
8h8N8cxVMquC/StLIwIHt9G5jwLIGRtiWYmEZnTguS99ci9RePLu7vbnoi6XjWLg
XTbLUPj1XxM7JAQc3yTU73vx87Iqz+8wwStu7pGlkVyOinQpplQHazq1xZEctdqf
uuFCSrtHZGMqO2oCDLO8PNhCEmKlK5oUUk/owaRmnV/3WZCeP5q7cW04ek3a//pa
qHXQEOdpK3DTzT+Q46ItfNjFo30an5nJLJnrCoCQbOkR38pfWEvzmxL/cBHRlEUq
72/LGrXXS/w8tQtXyLgvLXDwsGpgUI/gXAPjhMAxbiBJ5g8w/6cODWlrJABSvAdW
yIH4ztC4wPr9AtkNwDpt9JeeP86F/8GBs9AL/WKuWTBxfoUyrtY=
=XGZZ
-----END PGP SIGNATURE-----

--Sig_/EVIM78FD/YHiqgFyoMhIYaW--
