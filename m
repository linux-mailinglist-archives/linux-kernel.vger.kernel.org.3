Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D79587424
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiHAW5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiHAW5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:57:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE26329822
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:57:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m8so15530369edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3RtPyRzfB+HpbeEhTpVLyjlCEZhvDS/xfu2vrY2Ps+0=;
        b=BSJs3K6wmAEgOokteewdwhwrlGG6ViaQg8zXXgab7Z2kxWGLL0sgk+pFCtcw0JYS5w
         rWIMf8TSZQ93mdKn1UojbZ73I7kiq7PSD/+A+WrQBIElm2OYhHUk75wGYmTMrMcLN4dn
         ohBtLNk5Boz19RaAlAj3sEL7HVrosc7dDhUf3e8PEbKToq7X0LX+X5LUg9X8NvT2QVHc
         yvIbd/9Fp/7mIGUkmvRgwoZHAq17B8ofXwafQuL4u9iQ0JDIyCyw+R4F8Ngtn4qVDAL5
         8LBjIQkRKInarwtfe+0ks8vE8wGdyr43O/9NrH12+7q2cZ2TDZUuA/3PQeSHJNAi4qb9
         6FCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3RtPyRzfB+HpbeEhTpVLyjlCEZhvDS/xfu2vrY2Ps+0=;
        b=ph33f9EhUgWLSDPEzBhE5eymx2Y9JUWBT9Y7eeTffhzF+tkzyf9UayfFG9x/DRXNDz
         4F/0dU8iEXwSa2FROtu7WqETNeVbUKOF40NLqj6Gfw7oSzeHHz9ArEilJxdPZWD50S1W
         cxj+1Q9s7+LfdRIdPxSg1YBB8iMmo2AenjXighWcqaWTa6ZDh15gOnno+65pQN5aMquW
         FDvTny0fkFs6t9+Jhmfl68uWVsLaIF5rPuvP/sKjekPnvOCGrNIoHV23Oe8Zt76u/r99
         +ptEdcNP6EyGeccqO5iuP8T1+lpqBh0Kr6u/ceahzGJ1TFMqiYIkLLlJm6bwfKrFDS+h
         AQHg==
X-Gm-Message-State: ACgBeo3YEDoYGqZmgkSWAOrkiqDeRHHM4znDrtBDxQUGMS/PxjhLJbKZ
        xHGrjJYVMQwaTFD6OBvqdn3ltUW2atikm25MZjQ=
X-Google-Smtp-Source: AA6agR6KXe7sXk/8IbFRkqOSPia+ub7FMqBjrXdEXQw2hy+FXvDfCZHeUz7nyVRMBZQOniflLDJz2S4z6+xC61LLPXs=
X-Received: by 2002:a05:6402:1e8c:b0:43d:db52:78a8 with SMTP id
 f12-20020a0564021e8c00b0043ddb5278a8mr2755420edf.324.1659394665341; Mon, 01
 Aug 2022 15:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
 <CAOMZO5BAheG4r1Umnd7bLhOqezsxJgE0x1c-858EcabbpPm6Pg@mail.gmail.com> <CAHCN7xLDPvQ__WJPeCptvq7mFtF3v3TGAG_vyDBxSdoqWwoO8A@mail.gmail.com>
In-Reply-To: <CAHCN7xLDPvQ__WJPeCptvq7mFtF3v3TGAG_vyDBxSdoqWwoO8A@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 1 Aug 2022 17:57:34 -0500
Message-ID: <CAHCN7xJ44L01tyCNyWZsvG-+=OuT93KrG8YLm8rCrzd=L6PkeA@mail.gmail.com>
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
To:     Fabio Estevam <festevam@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 3:07 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Mon, Aug 1, 2022 at 2:33 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Adam,
> >
> > On Sat, Jul 30, 2022 at 12:16 PM Adam Ford <aford173@gmail.com> wrote:
> > >
> > > Hey all,
> > >
> > > I am trying to test Jagan's patch series [1] to add support for the
> > > samsung dsim bridge which is used on the imx8mm to output DSI video.
> > > The DSIM gets the video from the mxsfb, and in my case, the DSI is
> > > sent to the adv7535 for connecting to HDMI.
> >
> > I had to add some extra patches on top of Jagan's imx8mm-dsi-v3 to get
> > HDMI output functional on a imx8mm-evk via ADV7535:
> >
> > https://github.com/fabioestevam/kernel/commits/imx8mm-dsi-v3
> >
> > Does it work on your board?

Fabio,

I tried your branch, but I still get no video on the output of HDMI.
I do get a response to the modetest.  I won't post the whole thing
here, but here is a snippet

CRTCs:
id fb pos size
33 37 (0,0) (1920x1080)
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500
flags: nhsync, nvsync; type: driver
  props:
24 VRR_ENABLED:
flags: range
values: 0 1
value: 0

Planes:
id crtc fb CRTC x,y x,y gamma size possible crtcs
31 33 37 0,0 0,0 0        0x00000001
  formats: RG16 XR24
  props:
8 type:
flags: immutable enum
enums: Overlay=0 Primary=1 Cursor=2
value: 1
30 IN_FORMATS:
flags: immutable blob
blobs:

value:
01000000000000000200000018000000
01000000200000005247313658523234
03000000000000000000000000000000
0000000000000000
in_formats blob decoded:
RG16:  LINEAR
XR24:  LINEAR

Frame buffers:
id size pitch

When I compare this with NXP's downstream kernel that works with this
monitor, I get some different info:

CRTCs:
id fb pos size
33 41 (0,0) (1920x1080)
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500
flags: nhsync, nvsync; type: driver
  props:
24 VRR_ENABLED:
flags: range
values: 0 1
value: 0

Planes:
id crtc fb CRTC x,y x,y gamma size possible crtcs
31 33 41 0,0 0,0 0        0x00000001
  formats: XR24 AR24 RG16 XB24 AB24 RX24 RA24 AR15 XR15 AB15 XB15 BG16
  props:
8 type:
flags: immutable enum
enums: Overlay=0 Primary=1 Cursor=2
value: 1
32 zpos:
flags: immutable range
values: 0 0
value: 0

Frame buffers:
id size pitch

Notably, the  formats for the downstream list significantly more
formats.  I don't know how that translates to working video, but it
was something to note.

>
> I'll give them a try tonight.  I managed to get a hold of an adv7535
> user manual, and there are some items that it appears NXP did in their
> downstream kernel that never got pushed upstream. Based on my review
> of some of the changes, some of the NXP changes seem reasonable to me.
> If/when I can get it working, I'll try to report back some of my
> findings and push driver changes to the adv7535 as I find them.
>
> adam
