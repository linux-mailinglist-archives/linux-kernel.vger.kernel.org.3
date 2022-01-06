Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9393D4869D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242932AbiAFSZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:25:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:40229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242804AbiAFSZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641493525;
        bh=mC8sD6/rtcD8JtEMZrKMAq28bMVHVi0Aa915QHg3OCE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=B4q2c5Bx81oslkkmHZ5q9K/Wd/pgyZYZWjPvU6uQ7S3zCZkYWrs5eqSMbROjWHIfq
         Ghq/eyAjJTbsTWXACRy00x06uD4hoVLP1aL7Ne3gbeRLcCItYOARB42XaRe+9kYzOm
         IPZfvIQ5jQaxRlPsvGqHQCeG+GsI/Wxw7PuZsshE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [91.65.60.26] ([91.65.60.26]) by web-mail.gmx.net
 (3c-app-gmx-bap38.server.lan [172.19.172.108]) (via HTTP); Thu, 6 Jan 2022
 19:25:25 +0100
MIME-Version: 1.0
Message-ID: <trinity-59d726d3-993c-43c9-9e44-5be5cdfae74d-1641493525223@3c-app-gmx-bap38>
From:   Robert Schlabbach <Robert.Schlabbach@gmx.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Antti Palosaari <crope@iki.fi>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 2/3] media: si2157: add support for 1.7MHz and 6.1 MHz
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 6 Jan 2022 19:25:25 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-b5cc1284-ccc2-477c-ac90-56ee40da91af-1641483579446@3c-app-gmx-bs50>
References: <cover.1639140967.git.mchehab+huawei@kernel.org>
 <76c2ea87882c87bd35066a85cb48292a36a79fce.1639140967.git.mchehab+huawei@kernel.org>
 <trinity-b5cc1284-ccc2-477c-ac90-56ee40da91af-1641483579446@3c-app-gmx-bs50>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:kIiuH7K4RPeU4wYVbB2/6TWJKHpFJwHBqKitCCeSTmdBvilKvklwlFZpYJY6gfJN5w2K+
 UbWN8Kijohb8z5ZV4HAXyObOZjgUKcRkWmc5W38UPFvmyVENcoWUkPqTvtLsCzbk0XddCRQPODiC
 piPVzeyo5DM1OUM23PJlZwh2JIctcVB2lxRKQPcB7+jj/9TRnmii2/OLvuSTmkPQoxq/l6eR811Y
 FHiv/JWtWOSwMEmUdYjbrVf/x06UWBRDdbmcVaJrnElkyF27K3fo1ZjHssDN9OVBLdKMUtyCCN9W
 Rg=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2wmkk7kkf1k=:ecIAMKYQp7bOuIK+ImVpuh
 Z66eOQ9coWpZ9jrkudeek7EgWnniUO+fi1WDLr3UQWwYjGLS0TDmBdFerd00W1lrm2k32QFgK
 29eyj9CebzopuvrDoMoJcZKuZ//GPegSfcS7DQfkD0fficxlYu/DVdcHzmgOaTbgpTAwsFRFH
 a6ArstouscTwUkRAvgZQ7M8ULsvcnaT4dW2zbpO2bprBP3VTIDDLI5/T8OhRUInwHco9jrGDa
 nNL9BzMR+sN9rkIy5qYfs3/WDVlj1y1HNiQzW/EnWJe4jCv6mzcmM4kAPkBxtkmgsH6226SmQ
 YeBVcsE4C7zd/Yxf3lOKQNt6hiK+pYkApFK1u0K0Z6bKovPbtDd4ABgdJOpKjCU7xfKErog9V
 dfY8VFrTVExi6FxKneDEZOaHhIQSIVVyltdbLKzaHLde0exRv4VqPQAi+jKw2YXWFZfrkjCsS
 +hB52dq998NQ16iLH4TrZCwvBpd2V2FDODa/D6c6CN4yxCPHZk4GYUsIaFTCenkKOvmdhDiVU
 LfTM5dyIQeL/xwWMmLm2nVvGS/DBRwmvZqra9QfW4QBBY4LBm1Ji+Tq23JA0lJECsal7A+afP
 /DBgmg2cojwHHAsJEp1ALa+Ia125W509VoYwqlftkomugtCFsUlReUiEsDgFd7jdB4phRwJmH
 DEHiRAu99Y1DzngPhZGvcmOUeCnz3RefnyW9NA7XAf65Bh64dRRE5I1e3lr+0tx3ndfvYe6hw
 Us7gq5upjBGAY6LTPWGAr8sl2g5TJXkOPegVlZWzf7ut++hDxESyR+B7gyiXx2uiJuf8O/Ds3
 8UOG0kW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out there are actually two bugs in there:
=C2=A0
+ if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <=3D 6100000)
+ bandwidth =3D 0x10;

The si2157 code for bandwidth 6=2E1MHz is _decimal_ 10, not
hexadecimal 0x10=2E Removing the "0x" from the above line makes
the tuner work again, even with the other bug that makes it use
the 6=2E1MHz setting when 6MHz is requested=2E

Another issue with the bandwidth setting: The si2157 code is
also stored in dev->bandwidth and returned in the get_bandwidth()
call=2E Now this was not well before, because the call is supposed
to return the bandwidth in Hz, not in MHz, but now it can return
9 and 10, but those do not correspond to 9 and 10MHz=2E

Also, the default case uses si2157 code 0x0f, which also seems
like a bad idea=2E

And another, unrelated issue: The delivery_system switch is
missing case DVBC_ANNEX_C, even though it should operate just as
DVBC_ANNEX_A=2E

I'll see if I can come up with a patch which addresses all of the
above=2E

Best Regards,
-Robert Schlabbach=C2=A0


Gesendet:=C2=A0Donnerstag, 06=2E Januar 2022 um 16:39 Uhr
Von:=C2=A0"Robert Schlabbach" <Robert=2ESchlabbach@gmx=2Enet>
An:=C2=A0"Mauro Carvalho Chehab" <mchehab+huawei@kernel=2Eorg>
Cc:=C2=A0mauro=2Echehab@huawei=2Ecom, "Antti Palosaari" <crope@iki=2Efi>, =
linux-kernel@vger=2Ekernel=2Eorg, linux-media@vger=2Ekernel=2Eorg
Betreff:=C2=A0Re: [PATCH 2/3] media: si2157: add support for 1=2E7MHz and =
6=2E1 MHz

Sorry for the late test and response, but there is a BAD BUG in this patch=
:
=C2=A0
+ if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <=3D 1700000)
+ bandwidth =3D 0x09;
if (c->bandwidth_hz <=3D 6000000)
bandwidth =3D 0x06;
+ if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <=3D 6100000)
+ bandwidth =3D 0x10;
else if (c->bandwidth_hz <=3D 7000000)
bandwidth =3D 0x07;
else if (c->bandwidth_hz <=3D 8000000)

The additions omitted the "else", which resulted in the bandwidth setting =
for
6MHz being overwritten with the one for 6=2E1MHz - and that completely bre=
aks
6MHz channels, as the tuner then refuses to accept the tune command!

As a result, e=2Eg=2E MCNS aka ClearQAM aka DVB-C Annex B no longer works =
after
this patch=2E

I don't know if the 1=2E7Mhz and 6=2E1MHz settings are even usable, if the=
 tuner
(in my case, the Si2157-A30) then no longer accepts the tune command=2E Ma=
ybe
they're not suited for frequency-based tuning, but only for channel-based
tuning? That would not fit the DVB-API, I think=2E

And the 1=2E7MHz bandwidth setting currently can't do any harm, as it is a=
lways
overwritten by the 6MHz bandwidth setting, also due to an "else" missing=
=2E

Best Regards,
-Robert Schlabbach
=C2=A0
=C2=A0

Gesendet:=C2=A0Freitag, 10=2E Dezember 2021 um 13:59 Uhr
Von:=C2=A0"Mauro Carvalho Chehab" <mchehab+huawei@kernel=2Eorg>
An:=C2=A0unlisted-recipients:;
Cc:=C2=A0linuxarm@huawei=2Ecom, mauro=2Echehab@huawei=2Ecom, "Mauro Carval=
ho Chehab" <mchehab+huawei@kernel=2Eorg>, "Antti Palosaari" <crope@iki=2Efi=
>, "Mauro Carvalho Chehab" <mchehab@kernel=2Eorg>, linux-kernel@vger=2Ekern=
el=2Eorg, linux-media@vger=2Ekernel=2Eorg
Betreff:=C2=A0[PATCH 2/3] media: si2157: add support for 1=2E7MHz and 6=2E=
1 MHz
Some tuners allow setting the bandwidth filter to 1=2E7MHz and
6=2E1 MHz=2E Add support for it upstream, as the narrower is the
bandwidth filter, the better=2E

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel=2Eorg>
---

To avoid mailbombing on a large number of people, only mailing lists were =
C/C on the cover=2E
See [PATCH 0/3] at: https://lore=2Ekernel=2Eorg/all/cover=2E1639140967=2Eg=
it=2Emchehab+huawei@kernel=2Eorg/

drivers/media/tuners/si2157=2Ec | 4 ++++
drivers/media/tuners/si2157_priv=2Eh | 5 +++++
2 files changed, 9 insertions(+)

diff --git a/drivers/media/tuners/si2157=2Ec b/drivers/media/tuners/si2157=
=2Ec
index aeecb38b147f=2E=2E2d3937af4f5f 100644
--- a/drivers/media/tuners/si2157=2Ec
+++ b/drivers/media/tuners/si2157=2Ec
@@ -458,8 +458,12 @@ static int si2157_set_params(struct dvb_frontend *fe)
goto err;
}

+ if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <=3D 1700000)
+ bandwidth =3D 0x09;
if (c->bandwidth_hz <=3D 6000000)
bandwidth =3D 0x06;
+ if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <=3D 6100000)
+ bandwidth =3D 0x10;
else if (c->bandwidth_hz <=3D 7000000)
bandwidth =3D 0x07;
else if (c->bandwidth_hz <=3D 8000000)
diff --git a/drivers/media/tuners/si2157_priv=2Eh b/drivers/media/tuners/s=
i2157_priv=2Eh
index df17a5f03561=2E=2E24849c8ed398 100644
--- a/drivers/media/tuners/si2157_priv=2Eh
+++ b/drivers/media/tuners/si2157_priv=2Eh
@@ -66,6 +66,11 @@ struct si2157_cmd {
unsigned rlen;
};

+#define SUPPORTS_1700KHz(dev) (((dev)->part_id =3D=3D SI2141) || \
+ ((dev)->part_id =3D=3D SI2147) || \
+ ((dev)->part_id =3D=3D SI2157) || \
+ ((dev)->part_id =3D=3D SI2177))
+
/* Old firmware namespace */
#define SI2158_A20_FIRMWARE "dvb-tuner-si2158-a20-01=2Efw"
#define SI2141_A10_FIRMWARE "dvb-tuner-si2141-a10-01=2Efw"
--
2=2E33=2E1
=C2=A0
