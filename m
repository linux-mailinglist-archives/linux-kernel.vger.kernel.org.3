Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D4E47761F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbhLPPjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:39:33 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:17557 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhLPPjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1639669158;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=MHu1HtjYmw4nq41J5OgWRHpWBkTI68HMrnU4IC1AtA0=;
    b=onlP5l5ytXGnJJ63PvK9x46J7sm6dURpQbUvN4SRBm6d2GS8X6JFsySWjJB4WO/9iE
    9oj/e3gstuZp91ymTat8rucIGnW+X6yv+mnE1gQXEaPXGHBvppi4dmF6He0QL29e+/oU
    oBEGwGW4frb7pQK5CokP0bXmG2U0nQy0NhkZ3gUPDToLWwTeEisKnIYehdlAnwVtpgW8
    vbW6ppmu+VLEda7cQEKZ6HJ/wiCNZ3UBXj3jLolrFLmexeRfU5ecWvT/TVB3016KeGE7
    KaRFcVPW27/8IGReJE8n66tlff0Bq5ZW2Forifwbpm2qgDqa3z6QMiyaz2GG5hDywOUP
    4UPg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3iMMUrw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.35.3 DYNA|AUTH)
    with ESMTPSA id 404833xBGFdHF8Z
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 16 Dec 2021 16:39:17 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v11 0/8] MIPS: JZ4780 and CI20 HDMI
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <H5S74R.5BG9EDZORI63@crapouillou.net>
Date:   Thu, 16 Dec 2021 16:39:16 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Jonas Karlman <jonas@kwiboo.se>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <638E4C90-BF5A-4DE8-A8E3-BE81B454CF63@goldelico.com>
References: <cover.1638470392.git.hns@goldelico.com>
 <H5S74R.5BG9EDZORI63@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul and Thomas,
thanks for already applying some of the patches of this series!

> Am 16.12.2021 um 16:24 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi,
>=20
> Patches 1 and 2 added to drm-misc-next.
>=20
> I'll pick the rest when the regulator situation is sorted out.
>=20

I had started working on the regulator and while testing and trying to =
read the EDID
something has damaged my monitor so that it does no longer report proper =
EDID information
(for the second time, so that I can't pledge for another warrany =
repair). Maybe controlling
+5V for this specific monitor must be done very carefully and in a =
specific sequence...

So I will need some more days for building a more robust test setup and =
doing verification
of the driver. Well I have other monitors, but this was the cheapest one =
and available
for such experiments :)

Generally the idea is to replace the regulator with a ddc-en-gpios =
property of the connector.

Unfortunately it does not work to control it by atomic enable/disable in =
the connector driver
(it is not called at all). So I have been working on an approach =
following the concept how
drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c does it.

Sorry for the delay, but a V12 will come.

BR and thanks,
Nikolaus

