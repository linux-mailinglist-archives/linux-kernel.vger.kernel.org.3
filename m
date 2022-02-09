Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304A84AF35F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiBINyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiBINyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:54:12 -0500
X-Greylist: delayed 154 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 05:54:14 PST
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94840C05CB88;
        Wed,  9 Feb 2022 05:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1644414674;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=jA//raiEAQNJt49nn2RrsPVb29dWMlgBK10K+Ak3DxA=;
    b=d6KPdwgPmdMsAhpKpVRJBy9e3u6cVVqGChNYv8v37GPaAuHoW0wuePBR6cxqAFQtss
    Hpfeh+ldKDl3hY0b/kv8GvRNxH1/qtc43nMm5wPj3UjMlOhsy0C5B6fKM6acZ/trBjp3
    dSapsDtabozCAsXYnzxXoiQ5ZNNA2xBamzAYiqQ1KS4ApYZ4SGikXKYhpaS5Wj+F/vDX
    owxbDn2SbWxIECVdvKaYCYkbXKxz9cOf++A8DMOK7i5v2PA0m1pnyjtEV0LphhjOmJYZ
    iVZGOTa/v19A6oYrJygxt2qlOIeAkrkzmV59thD6IgmgNOJIQYHnfida6KmKn3o7LOgm
    jKvQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3iMYawg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id L29417y19DpCguK
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 9 Feb 2022 14:51:12 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v13 0/9] MIPS: JZ4780 and CI20 HDMI
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <9ZC17R.T1L0TBAW7MJA3@crapouillou.net>
Date:   Wed, 9 Feb 2022 14:51:12 +0100
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
Message-Id: <4294A500-52EB-4319-9B89-F9DAC48EBF03@goldelico.com>
References: <cover.1643819482.git.hns@goldelico.com>
 <9ZC17R.T1L0TBAW7MJA3@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

> Am 09.02.2022 um 12:52 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
> I tried applying patches 1-2, but they don't apply cleanly on top of =
drm-misc/drm-misc-next.

Ok I had rebased to linux-next some days ago and it appears that patch =
1/9 has now arrived in drm-misc/drm-misc-next.
So we can drop 1/9.

>=20
> Could you rebase on top of that tree?

Sure.

Unfortunatley my v14 breaks the display again. It is not much fun to =
develop on top of such a moving target...
So I have to find out first what was broken this time before I can send =
out a new version.

BR,
Nikolaus=
