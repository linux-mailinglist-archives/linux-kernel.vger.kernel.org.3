Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1725F4866D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbiAFPkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:40:01 -0500
Received: from mout.gmx.net ([212.227.15.18]:35575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240507AbiAFPkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641483579;
        bh=vIrJWvg04ZaFIVyjjc5fJS3aJR7MuLf8gGPQLxNZun0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hA613tt0yMEnkLqhskIv+EFijhS6slo3ysvAOnSkip4cTTRvZeTMvxP0deiiVNGMD
         OewXmKCTZufbL406zaC7NMgN0MKjgzQE+a/H9TbsOmxQbqx+I2UQEScxvmNO3EbWv5
         ZRHa6DNZsL4iOETM9fEl0g9OtI+llUvJmZ0y7g5I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [91.65.60.26] ([91.65.60.26]) by web-mail.gmx.net
 (3c-app-gmx-bs50.server.lan [172.19.170.103]) (via HTTP); Thu, 6 Jan 2022
 16:39:39 +0100
MIME-Version: 1.0
Message-ID: <trinity-b5cc1284-ccc2-477c-ac90-56ee40da91af-1641483579446@3c-app-gmx-bs50>
From:   Robert Schlabbach <Robert.Schlabbach@gmx.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     mauro.chehab@huawei.com, Antti Palosaari <crope@iki.fi>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 2/3] media: si2157: add support for 1.7MHz and 6.1 MHz
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 6 Jan 2022 16:39:39 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <76c2ea87882c87bd35066a85cb48292a36a79fce.1639140967.git.mchehab+huawei@kernel.org>
References: <cover.1639140967.git.mchehab+huawei@kernel.org>
 <76c2ea87882c87bd35066a85cb48292a36a79fce.1639140967.git.mchehab+huawei@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:kldg5sfH0lV7+OmAzzqHh7Fc/OmVasLESqyiyvqWj5bm2mYaY/6veO5+h93IbIu37QZp8
 ypnvoaMfT9+dRWcPxlOnlL6sKsqs4pAqoYdgx/M+alOiJhM+kHcKGTtVh/mf6hsMWR7LZ+WO0iLY
 QE8F7q/qhKNetVw2usxYHCEQAW2D15d5PPr0OdLyY70EEY0mmmp13YfL0FU/R7J2RahGzQc/WfWN
 mUXABJSI9miE2c1qBu6XpNnMVVn4NERNPbsfl85os579ho2ep7xgMqeAOtQDJaKScM/Rv7YK2nsG
 Ww=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8z48HhBFc3k=:oCq2ZPzR0F1BBdFEgwbG8F
 pzosLK3kqzFB+jfWKh9t6cEqH8NATdYZZY/yzayzZTaYPGeoqiqNVBK451MIuXGqborfUpy6A
 sIqd4EFCNH6Atl8rYpKtk7YzsPchiQPR1kg3wcu3QY8h1/J+l/D8+L0pu5OclkDkEVlCPmvEr
 imS487EhFYAahFWHhnguby1XzNzkV8wjPlGqaxJVUP84DO3psEhqVhnbcGpk1bXYkUSXtrRxg
 4/e4LoRhW3mZTRtq6C3u5l43aTcQpnNhRUtfbwWPfUUeEIWMyNk1Wiu8u34cIZK0bmngf09wx
 ZHAP0mNY1rIaZOzX4BUsUxchE4BcT9eXj5dojYXah+ZnVkJBlv6924jkLvI0adK1eJm/bJ1tv
 kWYh6EleVFKVu1TccAnGXU0isIjDgmG8uCIIzHji/OD0aP/z4CHcDINTzoadi40CyRjGMvnaX
 FP2GtNGFmOWIMWGk4EzasceoPoUsiq+1c3KxkKdQeLt+TWeiB3irNegtynLZusoHgqwGaH0z2
 zDabRn2lg9OXZ7HAb+YUHKeY2Yl13XqF8C5LevC9c98cbdG2sL8kdHt9zk5TDTarFlYSdfIvy
 cQr2u5QpBV1fe9EuwW7ELD75CeXV06mjTAqmvt2GXQYqvHgUjX4aW39cDF5c4ToaJwURhtlTM
 sk/O77QQ6El7/d2z53ZF2r6K3MEve3DvckGqQ2n0Lp6iyeWvgtZUmLcJVIv3O4N4qyok+rPal
 s2+j4mCybDmh6YbfthCi/vJk8Y4iVHPTVJxYfcioptaqMzeppjsdI4e+r5/9ojFmY9lku78Zc
 rvk+bmQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late test and response, but there is a BAD BUG in this patch:
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
