Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B157A464EAE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245024AbhLANVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:21:36 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:12496 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbhLANVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638364685;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=4c3epF2ScffUjNFE7pqyVEAU/QWj/7JeeA6yeKVR/Xw=;
    b=ed5XJ6A0DHDOixvsBEnMCR/tZI4nrM6770k+bAgJ/0JHUnyN+x7zhyk/nrEGbiiBE4
    +00amMPfU8SLs0KhySY3C6FHXQLohYA51L3nFcggRaxRoQ2FB7FUZzEWXaH8wn+cmH0x
    PI4l4kQ2BBVPKL30u7py2gHXByEAyDlhFRpdcQbyShx+Jop3mq7nHsG/WFULSxnNck0W
    rojwHKwQdYNG2wSegzNxoep9lnttsWGoJircnP7KFGKRgQnwlk9/ksXXLDwxaMlsOass
    8MAkSsL6jm8JyJ5NMhSqLoBXCjc596a7MMhRZm4L6JCdIm8lvYaOLl94w4DOiW1EuKgM
    PotA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw43u22M="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.34.10 SBL|AUTH)
    with ESMTPSA id e05ed8xB1DI4XDF
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 1 Dec 2021 14:18:04 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v10 4/8] drm/ingenic: Add dw-hdmi driver for jz4780
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <LKTF3R.YREPOCHOSMQN2@crapouillou.net>
Date:   Wed, 1 Dec 2021 14:18:02 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F852C647-7368-4BC1-A3C6-CE40F5A757F9@goldelico.com>
References: <cover.1638307601.git.hns@goldelico.com>
 <4daf0c5dbed2c47c97003ab8de0a7dbd2a335dc3.1638307601.git.hns@goldelico.com>
 <LKTF3R.YREPOCHOSMQN2@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,


> Am 01.12.2021 um 14:02 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
> Le mar., nov. 30 2021 at 22:26:37 +0100, H. Nikolaus Schaller =
<hns@goldelico.com> a =C3=A9crit :
>> From: Paul Boddie <paul@boddie.org.uk>
>> A specialisation of the generic Synopsys HDMI driver is employed for
>> JZ4780 HDMI support. This requires a new driver, plus device tree and
>> configuration modifications.
>> Here we add Kconfig DRM_INGENIC_DW_HDMI, Makefile and driver code.
>> Signed-off-by: Paul Boddie <paul@boddie.org.uk>
>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/gpu/drm/ingenic/Kconfig           |   9 ++
>> drivers/gpu/drm/ingenic/Makefile          |   1 +
>> drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c | 138 =
++++++++++++++++++++++
>> 3 files changed, 148 insertions(+)
>> create mode 100644 drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
>> diff --git a/drivers/gpu/drm/ingenic/Kconfig =
b/drivers/gpu/drm/ingenic/Kconfig
>> index 3b57f8be007c4..4efc709d77b0a 100644
>> --- a/drivers/gpu/drm/ingenic/Kconfig
>> +++ b/drivers/gpu/drm/ingenic/Kconfig
>>=20


>> +	}
>> +
>> +	if (!regulator)
>> +		return 0;
>=20
> Blank line here.

It is one of these cases where checkpatch doesn't complain although it =
should be improved...

>=20
> But I can add it myself when applying.

Yes, please. So that we are not wasting mailing list bandwidth...

> I'll just wait for Rob's ack first.

Indeed. Fortunately he had the right hint how to fix 3/8 quickly.

BR and thanks,
NIkolaus

