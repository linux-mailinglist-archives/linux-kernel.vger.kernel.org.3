Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200484E6AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355371AbiCXW3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355361AbiCXW3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:29:42 -0400
X-Greylist: delayed 16790 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 15:28:08 PDT
Received: from 10.mo584.mail-out.ovh.net (10.mo584.mail-out.ovh.net [188.165.33.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CC21115B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:28:07 -0700 (PDT)
Received: from player694.ha.ovh.net (unknown [10.108.4.192])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id DEE8F24519
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:11:25 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player694.ha.ovh.net (Postfix) with ESMTPSA id 8C18728AC22F6;
        Thu, 24 Mar 2022 22:11:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R006efdb6821-47ff-4e32-8684-c4c0342888ed,
                    78FFD8E4238D9337B8F0C8EEA79873C5FE5514E5) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Thu, 24 Mar 2022 23:11:13 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] auxdisplay: lcd2s: use simple i2c probe function
Message-ID: <20220324231113.057f4585@heffalump.sk2.org>
In-Reply-To: <CANiq72mQXV0sfh6-LKYjc9fMDuJR=t4dMdBD-6y=-Bq3YHDysw@mail.gmail.com>
References: <20220324170929.542348-1-steve@sk2.org>
        <CANiq72mQXV0sfh6-LKYjc9fMDuJR=t4dMdBD-6y=-Bq3YHDysw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/02QoSNGwK.=aPy_zA/gagv2";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 17045280166953649798
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledgudehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepfeehjeevtdefgfdtjeehjeefvedvgeeljeehgeetveffvdehueduhffgtedtteffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrheileegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/02QoSNGwK.=aPy_zA/gagv2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Thu, 24 Mar 2022 22:18:39 +0100, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Thu, Mar 24, 2022 at 6:10 PM Stephen Kitt <steve@sk2.org> wrote:
> > The i2c probe functions here don't use the id information provided in
> > their second argument, so the single-parameter i2c probe function
> > ("probe_new") can be used instead.
> >
> > This avoids scanning the identifier tables during probes. =20
>=20
> Thanks for the patch -- Andy submitted an equivalent one which I
> queued for -next some days ago.

Ah yes,
https://lkml.kernel.org/lkml/20220308151119.48412-3-andriy.shevchenko@linux=
.intel.com/

Thanks,

Stephen

--Sig_/02QoSNGwK.=aPy_zA/gagv2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmI87IEACgkQgNMC9Yht
g5wCIQ//TN3LdmVV2eqVAinqmtssnvhJi8xjzeXgsimoC9auT2zB0vpN2Wl4bsMR
tKLld3B34/s4hYwHjmLfwE8+Qy2n7aNga8oI4leBLSvW2KG+Gh3LOWmYiZc5dKaK
noLb+f4HUUD7nhUsAK9ObfqhgQxWsqViImdjfhkuduhFusessplwUkfF6VKtbmky
4JG+SlmdJfiwRKgm7OEseEgUR+L1I27YoOp+/MazkkdDYfDVccx6Zk/Qrz3eefj/
9Aq2eeV4wilq5Jn57+/A62t8VJthvW2MA3EFsVM+A/7It1L+SWyQFbbV3qk7iAG4
81LiUzS3V+I984CI7z6hR4YxkEBCD8e+SmJfZxBtlQdbyr7+Ojab7j3OaLpQdPB9
UbRxqT5c1/gcVx2QGKLUm8pdD74nWWQ+Go5+lqHqDl04G29pZwDYmILymCspJfIZ
m8SkbFPBxfX7lCD7Kqjp/88m/lKqmAiOmW+sX3QfIsTrAjnGagtD0Tfi++uk/7wj
h4GHeOLNOEQIIUJdx28x9xj76r+VaAjpuLAnNmezIF/wVTXdcsJ834KGzLgQe67l
b4104dQ4iKTiaI8F2leUPZ+97DB6u1heNYH9jb29QYGiJKJwHgk1zZsHOkqN/YO1
aht53Zmkif2cQi2170ZtIxrKZFsgfl7oc6olPDMe6LGqpvptWS0=
=wtHT
-----END PGP SIGNATURE-----

--Sig_/02QoSNGwK.=aPy_zA/gagv2--
