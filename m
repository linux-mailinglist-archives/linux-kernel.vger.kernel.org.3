Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF8A589B68
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbiHDMDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiHDMDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:03:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E036C459BB
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 05:03:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kb8so21884898ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jSPm0DHeY8SKZeRpVKL5I803Vfkof5kWJmeBgU5n5aQ=;
        b=HRe87RuKA2aMNt0BUkwVjsmRkP+vcor3jKfM/10zOmoFQ5AYDVEIwVShBVAMqjROdv
         Kqz0BYYQtvJ/MACbb+RA3HFGSEE6+H7kLrA12J3zrRUw+fz8XQMXJMDbjZVCy7eJuGTF
         Sd06MYy4ktBVgror3Ceaes2yFbkRQl/cZHb0wxqG3+E/oYrAyZPqqsppepmYc7fLrafo
         zAIrgCb0nYlGcjIbyS70S40zBcUVw/9MDq2Jn0mhim5Ly8U7BBT/tl+az+i53WrU9a26
         pvRUlrYHwWIcPPIngak6CkEXwte/AktBZrv1MFqvfcsCxAeqRgWzrKvs0g0GItOznj6K
         Oz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jSPm0DHeY8SKZeRpVKL5I803Vfkof5kWJmeBgU5n5aQ=;
        b=LH29qW85c4ZCAPoiNCYLAeAVE8iATGUgeDnL+atiD7lhFbV9FsoRTIcfD1cN0Emyme
         Pb2ixb8E69dV2OYn7AevaMlgsWsA1H6CZMEvtv7/BawjkDOPwACCPV4D2y3oGddwzGq5
         B6P+VgHyx4Kn3uNgL1tvwnS1hYeT/JnRcJmJf7pQKo//NgkENr6I41LshcghhJstfXe8
         Yt9d3cPsrDHPLygsCa7rOGxbGo93xCtFSQZfjMCc/2xjNMigvZWwecvX3Nv87nyNIRAD
         PirOCXLzGtm+Cd4aqkRTnct0sMmLeOuH6zUsWUFLx1xshpyJpDtZQDAB37GPVYdgkqIt
         Qv/Q==
X-Gm-Message-State: ACgBeo1ABf20D1VhiyiR81/8W0HQFkmQG/be+PlL2vio3HY7XSDnxrva
        XRUG5qLIReCtVrbgWnwh935Wq2eUYxnbxeZBZ9LPYw==
X-Google-Smtp-Source: AA6agR7GLiGaCWfqJOO/0niSITItXhWPceMEoVYX48l6R5vAkeNBINt4rqXCIQCBL7f6IjF+RiSPpWukxIzZTPo1ueE=
X-Received: by 2002:a17:907:d92:b0:72e:e94d:b675 with SMTP id
 go18-20020a1709070d9200b0072ee94db675mr1141263ejc.742.1659614608368; Thu, 04
 Aug 2022 05:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJy6X5733m3zwcFMuWM9oGHJEmKrs2KUNhzMzNVggRx0g@mail.gmail.com>
 <20220802080820.jyf3tfpgcj3pvbtp@pengutronix.de> <CAHCN7xL-7wGnEhY9+zDXYjigZfnfsnY_NsRf+enYt_BPsFxgnQ@mail.gmail.com>
 <CAHCN7xLpCbOY+Ma6gKJievw6aUZ5-Qs4S=zxjTgRu=Be7zvhoQ@mail.gmail.com>
 <CAHCN7xKzYcCPL0ddTENGw6xdCMNdYw-m5u4NSBHb96Vb_tByGg@mail.gmail.com>
 <20220803062024.vn7awasmifkp5xow@pengutronix.de> <CAHCN7xL3maPyX8eUiT6mKYei==6pkEvVTwX3vY+1uLTSNDGQ3Q@mail.gmail.com>
 <CAPY8ntBBz56Es=pK+KpqhyYLUET95DT_zE6gorOWx4WkCSxJAg@mail.gmail.com>
 <CAHCN7x+HSPJpYYDgV_F91ZsPHW9Uwze8KRAqWE-XAyp5yzB9Hw@mail.gmail.com>
 <CAPY8ntCeUXRqNVyxU7ey6P99pZ3XAXcVHL65bdb3f0qbcK+rBA@mail.gmail.com> <20220804102757.pc7hljonea43ytwg@pengutronix.de>
In-Reply-To: <20220804102757.pc7hljonea43ytwg@pengutronix.de>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 4 Aug 2022 13:03:12 +0100
Message-ID: <CAPY8ntBqdv=yPZy3g8Pw=wYA39y88esT4dVH9Fkq-=V2cS56Nw@mail.gmail.com>
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Adam Ford <aford173@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>, robert.chiras@nxp.com,
        laurentiu.palcu@nxp.com, NXP Linux Team <linux-imx@nxp.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco

On Thu, 4 Aug 2022 at 11:28, Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> On 22-08-03, Dave Stevenson wrote:
> > On Wed, 3 Aug 2022 at 13:31, Adam Ford <aford173@gmail.com> wrote:
>
> ...
>
> > > Mine also states the DSI source needs to provide correct video timing
> > > with start and stop sync packets.
> > >
> > > If I remember correctly, it seemed like Marek V wanted the hard coded
> > > samsung,burst-clock-frequency to go away so the clock frequency could
> > > be set dynamically.
> >
> > I've never worked with Exynos or imx8, but my view would be that
> > samsung,burst-clock-frequency should only be used if
> > MIPI_DSI_MODE_VIDEO_BURST is set in the mode_flags (it isn't for
> > adv7533/5).
>
> Some notes on that. The samsung,burst-clock-frequency is the
> hs-bit-clock-rate which is twice the dsi-clock-rate. This has nothing to
> do with the MIPI_DSI_MODE_VIDEO_BURST.
>
> > Without that flag the DSI link frequency should be running at the rate
> > defined by the mode clock, number of lanes, bpp, etc.
>
> IMHO the DSI link have only to guarantee the bandwidth is sufficient for
> the mode.

DSI spec 8.11.3 Non-Burst Mode with Sync Events
"This mode is a simplification of the format described in Section
8.11.2 (Non-Burst Mode with Sync Pulses)
...
Pixels are transmitted at the same rate as they would in a
corresponding parallel display interface such as DPI-2."

If you are running the DSI clock at anything other than that rate,
then AIUI you are in a burst mode (although you may choose not to drop
into LP mode).

(One of my pet peeves that there is no documentation as to exactly
what MIPI_DSI_MODE_VIDEO_BURST is meant to mean. Seeing as in the DSI
spec all modes of 8.11 say that the host can drop to LP during
blanking if time allows, it surely has to be the time compression
element of 8.11.4 Burst Mode).

> > From the DSI spec (v 1.1 section 8.11.1):
> > "Non-Burst Mode with Sync Pulses =E2=80=93 enables the peripheral to
> > accurately reconstruct original video timing, including sync pulse
> > widths."
> > "RGB pixel packets are time-compressed, leaving more time during a
> > scan line for LP mode (saving power) or for multiplexing other
> > transmissions onto the DSI link."
> > How can the peripheral reconstruct the video timing off a quirky link f=
requency?
>
> If the ADV couldn't reconstruct the sync signals, then we should not get
> any mode working but we get the 1080P mode working.
>
> > Unless the Exynos DSIM_CONFIG_REG register bit DSIM_BURST_MODE [1]
> > reconfigures the clock setup of the DSI block, then I don't see how
> > the Exynos driver can follow the DSI spec in that regard.
>
> Why do you think that the Exynos driver isn't following the spec? We
> configure the host into video mode with sync signals which is working
> for the 1080P mode.

1080p is working with samsung,burst-clock-frequency setting?
As I say, I've not worked with this IP, I'm only looking at it from
the outside having spent far too much time recently on the Pi DSI
interface.
exynos_drm_dsi.c seems to be doing a lot of PLL computation around
burst-clock-frequency, and nothing with the pixel clock rate. Without
knowledge of what that DSIM_BURST_MODE bit in DSIM_CONFIG_REG actually
does in the hardware, I can only make guesses. Perhaps it does ditch
the burst clock and switch the bit clock to be derived from the pixel
clock of the upstream block, but that seems unlikely.

  Dave
