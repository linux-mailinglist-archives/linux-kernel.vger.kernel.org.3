Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB07246502A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350587AbhLAOoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:44:07 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:22728 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350163AbhLAOhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638369206;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=gDqNSwOY4krNXyZJKC9cA8DBCihhfe+kQxeeBXbUBDM=;
    b=TfZuFK7agOXamEYkB331yuxjVMDwyGsNTY8R0Li9/tuv7nXqulBYXsJv2tlVUyYlQM
    W94ccGIt4GcPDz3A4IwNOafPlCVGhQ54ZJ6wIda3FkhtRXdVm0H3fnWVg8MGYYwGT9MZ
    dsJj76pnYPTAsaJu8BQkOkWVvOqJxhn78qiRhP654LUjf7b8PpGx+EnCXYQlMOCtspMv
    2xLfEVo5igd9WxRUFZopnEwq3s0bZJ4Xc6VplGnA41Cuc15OCNX+35dtZ9kOzKQmO003
    IPpM5rMjgYvOHLFugSaLRZY0+4mtgMrFhHE8HgwuZ0W6gLG5OcL3JPnrm2fKuIM/59dH
    wwWA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw43u22M="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.34.10 SBL|AUTH)
    with ESMTPSA id e05ed8xB1EXPXiK
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 1 Dec 2021 15:33:25 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v10 4/8] drm/ingenic: Add dw-hdmi driver for jz4780
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <EDWF3R.CMVWMJL42OH9@crapouillou.net>
Date:   Wed, 1 Dec 2021 15:33:24 +0100
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Boddie <paul@boddie.org.uk>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <58C550A4-A21E-47BA-8BAE-00B927DC7A2E@goldelico.com>
References: <cover.1638307601.git.hns@goldelico.com>
 <4daf0c5dbed2c47c97003ab8de0a7dbd2a335dc3.1638307601.git.hns@goldelico.com>
 <LKTF3R.YREPOCHOSMQN2@crapouillou.net> <Yad69aTXcGixXvy3@sirena.org.uk>
 <46070A95-0FA9-43F9-A9A9-52A7B58B88F5@goldelico.com>
 <EDWF3R.CMVWMJL42OH9@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Am 01.12.2021 um 15:03 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus, Mark,
>=20
> Le mer., d=C3=A9c. 1 2021 at 14:51:51 +0100, H. Nikolaus Schaller =
<hns@goldelico.com> a =C3=A9crit :
>> Hi,
>>> Am 01.12.2021 um 14:39 schrieb Mark Brown <broonie@kernel.org>:
>>> On Wed, Dec 01, 2021 at 01:02:45PM +0000, Paul Cercueil wrote:
>>>> Le mar., nov. 30 2021 at 22:26:37 +0100, H. Nikolaus Schaller
>>>>> +	regulator =3D devm_regulator_get_optional(&pdev->dev, =
"hdmi-5v");
>>>>> +	if (IS_ERR(regulator)) {
>>>>> +		ret =3D PTR_ERR(regulator);
>>> Why is this using _optional()?  This should only be done when the =
supply
>>> can be physically absent
>> There can be +5V for HDMI but without a regulator that is visible to =
or controllable
>> by the driver.
>=20
> There is always a power supply though. Either a controllable one =
(through e.g. a GPIO), or it's just connected to the mains +5V; the pin =
is never left floating. In the second case, in DTS the "hdmi-5v" would =
be connected to some 5v regulator, even if it's just a dummy VCC-5V =
regulator. So Mark has a point.
>=20
>> So hdmi-5v can be simply missing in DTS in which case the driver does =
not need to
>> care about. The driver just can't turn it on or off.
>=20
> Please make it mandatory in DTS then, and use devm_regulator_get() in =
the driver.

Well, I just wonder why the elegant devm_regulator_get_optional() exists =
at all
and seems to be used in ca. 80 places.

And if it is not allowed, why some DTS should be forced to add not =
physically existing dummy-regulators.
AFAIR drivers should implement functionality defined by DTS but not the =
other way round: enforce DTS style.
BTW: there is no +5 mains dummy regulator defined in ci20.dts.

What I fear is that if we always have to define the mains +5V (which is =
for example not
defined in ci20.dts), which rules stops us from asking to add a =
dummy-regulator from 110/230V to +5V as well.
In last consequence, it seems as if we have to describe all dummy =
regulators from the power plant to our hdmi-5v :)

Since I always follow the KISS principle I tend to leave out what is not =
relevant...

Of course adding a dummy regulator to the DTS allows to avoid the NULL =
pointer test
in the driver code.

Anyways, you are maintainers :)

So should I spin a v11 for the series or just this patch or how should =
we do it?

BR and thanks,
Nikolaus

>=20
> Cheers,
> -Paul
>=20
>>> (in which case I'd expect to see special
>>> handling).
>> The special case is to not enable/disable the regulator if it does =
not exist
>> and assume that there is hardware providing it otherwise (the driver =
can't know
>> that except by using get_optional). This is done by the code below
>>>>> +	if (IS_ERR(regulator)) {
>> ...
>>> +	if (!regulator)
>>> +		return 0;
>>> +	ret =3D regulator_enable(regulator);
>> ...
>> BR and thanks,
>> Nikolaus
>=20
>=20

