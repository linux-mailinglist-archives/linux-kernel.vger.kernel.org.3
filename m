Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507AE4AF391
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiBIODD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Feb 2022 09:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbiBIOC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:02:58 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA50C050CC2;
        Wed,  9 Feb 2022 06:02:59 -0800 (PST)
Date:   Wed, 09 Feb 2022 14:02:39 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v13 0/9] MIPS: JZ4780 and CI20 HDMI
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
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
Message-Id: <F0J17R.I8VTR1ZGV2Z2@crapouillou.net>
In-Reply-To: <4294A500-52EB-4319-9B89-F9DAC48EBF03@goldelico.com>
References: <cover.1643819482.git.hns@goldelico.com>
        <9ZC17R.T1L0TBAW7MJA3@crapouillou.net>
        <4294A500-52EB-4319-9B89-F9DAC48EBF03@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mer., févr. 9 2022 at 14:51:12 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> Paul,
> 
>>  Am 09.02.2022 um 12:52 schrieb Paul Cercueil <paul@crapouillou.net>:
>> 
>>  Hi Nikolaus,
>> 
>>  I tried applying patches 1-2, but they don't apply cleanly on top 
>> of drm-misc/drm-misc-next.
> 
> Ok I had rebased to linux-next some days ago and it appears that 
> patch 1/9 has now arrived in drm-misc/drm-misc-next.
> So we can drop 1/9.

Yes, some weeks ago I did apply patch 1/9 from one of your previous 
patchsets. Patch 2 was applied as well (commit b807fd2c43fe 
("drm/ingenic: Add support for JZ4780 and HDMI output")), but you then 
said that it didn't work and needed a fix.

For this patchset you should always base on top of 
drm-misc/drm-misc-next, and not on linux-next; they have different 
schedules. You can drop patch #1, and rework patch #2 so that it only 
fixes the previously incorrect behaviour.

> 
>> 
>>  Could you rebase on top of that tree?
> 
> Sure.
> 
> Unfortunatley my v14 breaks the display again. It is not much fun to 
> develop on top of such a moving target...

I can imagine...

Cheers,
-Paul

> So I have to find out first what was broken this time before I can 
> send out a new version.
> 
> BR,
> Nikolaus


