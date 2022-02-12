Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61994B35FD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 16:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiBLPvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 10:51:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiBLPvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 10:51:04 -0500
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7E2212;
        Sat, 12 Feb 2022 07:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1644681047;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Kikg1n0GjNW55lJXdn/Gh/3mpzDarcpb8bfYkSiBQ+E=;
    b=taoy6ReN8rZfESOTY1+ddA3GC50ZJ5jrLicBV4du/McZON+8WtjNe6W60bwV5qe5QP
    bMH7k409H0uLbwYe9Clcby+Tx5R3i7qsp7WeRoPvZ5SEUfQ/5yWh+rjONAJDIFpC3WxO
    0Ytf5IyRj6mJolyxA93sJ8xoSM/DDtoEDXA8xIR1yKjDMcbU9Cqe601jldLG+zBeRMCV
    alNImiSPi8IiwXSlQdphXbLwKigEP1PSjZh4KLaZWN9Vtm91rdAIZi1S3bZJAbndXF0+
    Z88inUe1XrjRPeaBVl5eZ3VsDfm7p9oRsv1ZsFPF8/LX5KQrba3R8LbauA7BxiA5ZWyH
    VDpQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDaqyA=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id L29417y1CFokswm
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 12 Feb 2022 16:50:46 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v14 8/9] [already applied to mips-fixes] MIPS: DTS: CI20:
 fix how ddc power is enabled
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <0L577R.CVAM5NCZN3F72@crapouillou.net>
Date:   Sat, 12 Feb 2022 16:50:46 +0100
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
        Paul Boddie <paul@boddie.org.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B8B0942-1FC8-435A-B1AA-D06702D0718D@goldelico.com>
References: <cover.1644675566.git.hns@goldelico.com>
 <6722afd4a89d2bf0d95e49e6738ff50bf9f26245.1644675567.git.hns@goldelico.com>
 <0L577R.CVAM5NCZN3F72@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 12.02.2022 um 15:58 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi,
>=20
> Le sam., f=C3=A9vr. 12 2022 at 15:19:26 +0100, H. Nikolaus Schaller =
<hns@goldelico.com> a =C3=A9crit :
>> Originally we proposed a new hdmi-5v-supply regulator reference
>> for CI20 device tree but that was superseded by a better idea to use
>> the already defined "ddc-en-gpios" property of the "hdmi-connector".
>> Since "MIPS: DTS: CI20: Add DT nodes for HDMI setup" has already
>> been applied to v5.17-rc1, we add this on top.
>> Fixes: ae1b8d2c2de9 ("MIPS: DTS: CI20: Add DT nodes for HDMI setup")
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
>=20
> Since it's already applied you don't have to send this patch anymore.

I see, it has arrived in linux-next but not yet in drm-misc-next...
So if someone wants to test the series directly on top of drm-misc-next =
(as I am doing), it would be incomplete without.

IMHO these side-branches and partial merges here and there sometimes =
make more problems than they seem to solve...

But I leave already applied out commits for v15.

>=20
> Cheers,
> -Paul
>=20
>> ---
>> arch/mips/boot/dts/ingenic/ci20.dts | 15 ++-------------
>> 1 file changed, 2 insertions(+), 13 deletions(-)
>> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts =
b/arch/mips/boot/dts/ingenic/ci20.dts
>> index 3e336b3dbb109..ab6e3dc0bc1d0 100644
>> --- a/arch/mips/boot/dts/ingenic/ci20.dts
>> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
>> @@ -83,6 +83,8 @@ hdmi_out: connector {
>> 		label =3D "HDMI OUT";
>> 		type =3D "a";
>> +		ddc-en-gpios =3D <&gpa 25 GPIO_ACTIVE_HIGH>;
>> +
>> 		port {
>> 			hdmi_con: endpoint {
>> 				remote-endpoint =3D <&dw_hdmi_out>;
>> @@ -114,17 +116,6 @@ otg_power: fixedregulator@2 {
>> 		gpio =3D <&gpf 14 GPIO_ACTIVE_LOW>;
>> 		enable-active-high;
>> 	};
>> -
>> -	hdmi_power: fixedregulator@3 {
>> -		compatible =3D "regulator-fixed";
>> -
>> -		regulator-name =3D "hdmi_power";
>> -		regulator-min-microvolt =3D <5000000>;
>> -		regulator-max-microvolt =3D <5000000>;
>> -
>> -		gpio =3D <&gpa 25 0>;
>> -		enable-active-high;
>> -	};
>> };
>> &ext {
>> @@ -576,8 +567,6 @@ &hdmi {
>> 	pinctrl-names =3D "default";
>> 	pinctrl-0 =3D <&pins_hdmi_ddc>;
>> -	hdmi-5v-supply =3D <&hdmi_power>;
>> -
>> 	ports {
>> 		#address-cells =3D <1>;
>> 		#size-cells =3D <0>;
>> --
>> 2.33.0
>=20
>=20

