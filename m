Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E31B463C74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244564AbhK3RG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:06:29 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:10227 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhK3RGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638291671;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=UIf15iMEtDEvJh887G0IYN5tzrRPMwEaqTyUehQEpsc=;
    b=gcTD6DNbCqRZgz3hRCZCtBRA9Ot4gxTXz9DhxAeHr97rIeO6H8W956dM7G8rkpQQKD
    l4Jww2PBhgDF7Ko6tBTb2NU/SaNsbtuxrAYm0H4hb6u6U7rByUId+2Iq9eCRR1Z1J3KQ
    pKrCfI8N7jQX71gklajTwYLXpP4Ukf5KTeg+YldFYiL/9OOU+MeEidqg5RyRECuP1G5C
    GhM3kKUjMnhSPih6otLPI9Fnddx0fN+RTn+j6ZSy8/fwFCs47GRpBzFDq8UO1m8wKpO/
    ai87qt/r+DTJPVfY9+1e8kpKssTKltSyVxRpURukUsf3pb6Esvd2Xd1oao8SBFJvyc+a
    c3Pg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3iMERYA=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id e05ed8xAUH19Sxv
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 30 Nov 2021 18:01:09 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v9 3/8] dt-bindings: display: Add ingenic,jz4780-dw-hdmi
 DT Schema
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <1637875562.255498.2858308.nullmailer@robh.at.kernel.org>
Date:   Tue, 30 Nov 2021 18:01:08 +0100
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Kees Cook <keescook@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Boddie <paul@boddie.org.uk>,
        David Airlie <airlied@linux.ie>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Foss <robert.foss@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maxime Ripard <maxime@cerno.tech>,
        Mark Brown <broonie@kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Karlman <jonas@kwiboo.se>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A72D034E-EDBC-44F5-82DF-9EEBC5EC7E0B@goldelico.com>
References: <cover.1637789354.git.hns@goldelico.com>
 <d678e785d95487202ac0660eb66796e9fb5beb50.1637789354.git.hns@goldelico.com>
 <1637875562.255498.2858308.nullmailer@robh.at.kernel.org>
To:     Rob Herring <robh@kernel.org>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Am 25.11.2021 um 22:26 schrieb Rob Herring <robh@kernel.org>:
>=20
> On Wed, 24 Nov 2021 22:29:09 +0100, H. Nikolaus Schaller wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>>=20
>> Add DT bindings for the hdmi driver for the Ingenic JZ4780 SoC.
>> Based on .txt binding from Zubair Lutfullah Kakakhel
>>=20
>> We also add generic ddc-i2c-bus to synopsys,dw-hdmi.yaml
>>=20
>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> ---
>> .../display/bridge/ingenic,jz4780-hdmi.yaml   | 76 =
+++++++++++++++++++
>> .../display/bridge/synopsys,dw-hdmi.yaml      |  3 +
>> 2 files changed, 79 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
>>=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m =
dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Unknown file referenced: [Errno 2] No such file or directory: =
'/usr/local/lib/python3.8/dist-packages/dtschema/schemas/bridge/bridge/syn=
opsys,dw-hdmi.yaml'

I wasn't able to fix that.

If I change

 allOf:
-  - $ref: bridge/synopsys,dw-hdmi.yaml#
+  - $ref: synopsys,dw-hdmi.yaml#

then make dt_binding_check still reports:

Unknown file referenced: [Errno 2] No such file or directory: =
'/Users/hns/Library/Python/3.7/lib/python/site-packages/dtschema/schemas/b=
ridge/synopsys,dw-hdmi.yaml'

BR and thanks,
Nikolaus Schaller

> xargs: dt-doc-validate: exited with status 255; aborting
> make[1]: *** Deleting file =
'Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.exam=
ple.dt.yaml'
> Unknown file referenced: [Errno 2] No such file or directory: =
'/usr/local/lib/python3.8/dist-packages/dtschema/schemas/bridge/bridge/syn=
opsys,dw-hdmi.yaml'
> make[1]: *** [scripts/Makefile.lib:373: =
Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.examp=
le.dt.yaml] Error 255
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1413: dt_binding_check] Error 2
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.ozlabs.org/patch/1559375
>=20
> This check can fail if there are any dependencies. The base for a =
patch
> series is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up =
to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.
>=20

