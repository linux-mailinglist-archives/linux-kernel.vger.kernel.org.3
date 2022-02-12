Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9E44B355E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 14:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiBLNun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 08:50:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiBLNum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 08:50:42 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5CCB0B;
        Sat, 12 Feb 2022 05:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1644673813;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=kkf3f5UeVkL//K4QzMvabJJMd5RoVnu3V9J2z+HY2/M=;
    b=bnMGBdCTw+mw9xmD8gwPKSS774LQfFj6EtUAvqIekLvHzNuoU5qMhaY8gJZXv2zpW4
    lBLz1NWJaFTJz6thln58NfGQ6ohW5NuobIQk6C8OhA00vWHV460Kh9R1ILm39iYZSEH6
    Vr4MKloC7JxSx4mbG73PU65gL1WN9/2D91rfAmAvhQdmEXgYGLPzLqcCAUy/T4njXoN0
    SHjvStuF6BQl3T8wctsRWQhQM6vuIEOYnTk0Fd3+8nG61tPbK1961bphi+zKW82fhAap
    fW+jlbAQi/wc1r7HVYVdztHTH+JElP8JaKh8grPrXrjR6fAYe8xSFG97X3JHqGlQ13CX
    EOqw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDaqyA=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id L29417y1CDoCsoM
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 12 Feb 2022 14:50:12 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v13 0/9] MIPS: JZ4780 and CI20 HDMI
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <F0J17R.I8VTR1ZGV2Z2@crapouillou.net>
Date:   Sat, 12 Feb 2022 14:50:11 +0100
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
Message-Id: <5B3FD0D2-28B3-4D35-BD6D-9747A0E35C07@goldelico.com>
References: <cover.1643819482.git.hns@goldelico.com>
 <9ZC17R.T1L0TBAW7MJA3@crapouillou.net>
 <4294A500-52EB-4319-9B89-F9DAC48EBF03@goldelico.com>
 <F0J17R.I8VTR1ZGV2Z2@crapouillou.net>
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

Hi,

> Am 09.02.2022 um 15:02 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi,
>=20
> Le mer., f=C3=A9vr. 9 2022 at 14:51:12 +0100, H. Nikolaus Schaller =
<hns@goldelico.com> a =C3=A9crit :
>> Paul,
>>> Am 09.02.2022 um 12:52 schrieb Paul Cercueil <paul@crapouillou.net>:
>>> Hi Nikolaus,
>>> I tried applying patches 1-2, but they don't apply cleanly on top of =
drm-misc/drm-misc-next.
>> Ok I had rebased to linux-next some days ago and it appears that =
patch 1/9 has now arrived in drm-misc/drm-misc-next.
>> So we can drop 1/9.
>=20
> Yes, some weeks ago I did apply patch 1/9 from one of your previous =
patchsets. Patch 2 was applied as well (commit b807fd2c43fe =
("drm/ingenic: Add support for JZ4780 and HDMI output")), but you then =
said that it didn't work and needed a fix.
>=20
> For this patchset you should always base on top of =
drm-misc/drm-misc-next, and not on linux-next; they have different =
schedules. You can drop patch #1, and rework patch #2 so that it only =
fixes the previously incorrect behaviour.
>=20
>>> Could you rebase on top of that tree?
>> Sure.
>> Unfortunatley my v14 breaks the display again. It is not much fun to =
develop on top of such a moving target...
>=20
> I can imagine...

Have found it. Was a typo in a rebase conflict resolution...

So, v14 can come now.

BR and thanks,
Nikolaus

