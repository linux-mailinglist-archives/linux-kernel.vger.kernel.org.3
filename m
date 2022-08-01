Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587FC5871FA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiHAUHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiHAUH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:07:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A3275F6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:07:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y13so8366307ejp.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dM75XEwFU5CbiGRXcEpaIYQB6b03v9H4wzpeMmKaTgk=;
        b=LYlztePAEJ2AR3JYWDBFtZ3dDQRZSbMAj+XFcthBsl3pBXZqprQFMOHZwwbFTGLOKx
         Kcc5sHUB2ovvR1uPTOKjlEKx4fAHAfeDxvzpuG1rxkxvLqeODXbWDMxaO8kT6TXyGXKp
         nelGiqXplCHeWya10cSQlxq30U76m08sgRAaXBd+mSp97UcJxSQEQ+YAuDAYXkPMcQZJ
         QWofxAa7sdyEA4SoI9RKrfTc6287QDZGBAmDinTsSHGhp7lIIVEHwGPok8xr7p9JNqse
         dinisRZYsfERxKgNA1olrNs9Ds8FbKWw2pvKlAzoW/yXKMSYqy/lt61xttNLi4ytim2p
         9J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dM75XEwFU5CbiGRXcEpaIYQB6b03v9H4wzpeMmKaTgk=;
        b=aDWnZ4FW9Ctu6qzF2OEhHAuXjPsSs82eyyeOkmETk6bjOpb4zq9c2HDW1UdZpByOip
         QD5amzbEjmjp+Dk1wFyQ80zVq56WCLktmmHFLKKiCAhKiSOtaXMr9tL37EipfHp3r7Mb
         ZtMFEjd2S2hDqcyDxrbEy5eRlrLu4vPUzXOjErsbihHIBMKHgGNlheI1069N1rCQrDUD
         aBwxzj8K5/a2gEigDeGwGNK7fJwEBeOJy/G5bAwKswxQKtpgs5w3YAAhafX+ZUhoQU6m
         zl2C4paCxVyv5OUXBAW2jpibBXejXyFRSwzIQIv4yyD4pmEVZ69Xk+WlRZKtJeEHXdq5
         t73g==
X-Gm-Message-State: AJIora+/TxLyRuFlO6/pt1WkGUHJl0TA1yhKnbd+DF9qfgLCQ5Wza7pF
        Nlk+lw7OBckMV/4dixthZh8C/ryUJJEXMApM1iE=
X-Google-Smtp-Source: AGRyM1uexHlNzjAEWlTkuhlfGVVKV9MRLa+HenftvIKqi3rwguQ7/nrBYx0l41AbyHlSKpZlsYS3aD9ELhcedZFNS2k=
X-Received: by 2002:a17:907:2724:b0:72b:496c:568a with SMTP id
 d4-20020a170907272400b0072b496c568amr13821421ejl.305.1659384446832; Mon, 01
 Aug 2022 13:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
 <CAOMZO5BAheG4r1Umnd7bLhOqezsxJgE0x1c-858EcabbpPm6Pg@mail.gmail.com>
In-Reply-To: <CAOMZO5BAheG4r1Umnd7bLhOqezsxJgE0x1c-858EcabbpPm6Pg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 1 Aug 2022 15:07:15 -0500
Message-ID: <CAHCN7xLDPvQ__WJPeCptvq7mFtF3v3TGAG_vyDBxSdoqWwoO8A@mail.gmail.com>
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

On Mon, Aug 1, 2022 at 2:33 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Adam,
>
> On Sat, Jul 30, 2022 at 12:16 PM Adam Ford <aford173@gmail.com> wrote:
> >
> > Hey all,
> >
> > I am trying to test Jagan's patch series [1] to add support for the
> > samsung dsim bridge which is used on the imx8mm to output DSI video.
> > The DSIM gets the video from the mxsfb, and in my case, the DSI is
> > sent to the adv7535 for connecting to HDMI.
>
> I had to add some extra patches on top of Jagan's imx8mm-dsi-v3 to get
> HDMI output functional on a imx8mm-evk via ADV7535:
>
> https://github.com/fabioestevam/kernel/commits/imx8mm-dsi-v3
>
> Does it work on your board?

I'll give them a try tonight.  I managed to get a hold of an adv7535
user manual, and there are some items that it appears NXP did in their
downstream kernel that never got pushed upstream. Based on my review
of some of the changes, some of the NXP changes seem reasonable to me.
If/when I can get it working, I'll try to report back some of my
findings and push driver changes to the adv7535 as I find them.

adam
