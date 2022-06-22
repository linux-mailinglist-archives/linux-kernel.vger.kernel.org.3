Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4E556E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358833AbiFVWbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358697AbiFVWbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:31:41 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760D23EBBC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:31:40 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3176b6ed923so177017157b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wL3ZTF9h19hCoNLYZHoBwoPWEbOtoBVYiSP/69Bm+zw=;
        b=K1SZedqvlRkOQ0Emk1zeynRXzpyN8VKjUYl8ks44eTWSZ6YOhfu9M0UsZBjkST6TEx
         mvbCToZCxYoSpPEli2GKYb3KS6C9V4MI1nYGK1t7p/4R7m7zPnPF68zEIx/T8P34inaI
         5uwgFwz8hNO3S3d6T8R6w+qxw/x2p/0nLyK7rmHwAJQea4bxVIgng1Li9UDY00NiRWOe
         Cn9h30jP+EfR2kv+UrM0pCH6WkXPdJRYhUuopIMu4Azap7pC7Kx0hFNEicqKya7ePDep
         3AGtI9IHUc/t7di1WhkmgxZ3B7WX3SAjUHQ1xwLMpMXexUzWJntgoq0HN4s0ypPgJlcs
         b54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wL3ZTF9h19hCoNLYZHoBwoPWEbOtoBVYiSP/69Bm+zw=;
        b=6t5wok4XBLhF2cdvu4UlFmsJT7Zn0yqswy7zhMd70CDekgbdhk7bw3eYP3cuxafor5
         21oprMUNUjamGj7nzpl2y77zpyBFVZxZlth0ZUFIiF9wxW2nPdL25QAHq+JbKPVyGnx7
         XO20XyLtzHqs2VVlOx/d4a4I7+wQSlZa0mxgCakf2aH3WalACc6yKm6fjIz/8XVzowJt
         dRRSWcQLnw956TFtgTAcWUvD0X1Npiu58DDCdok7bYhWXN7kdm3vF1hxW7ZZqhI7TUpd
         uNnbcTIBaH20hKt861m9QP2g0zzGCWjfmsZH2HmzdWWIVSdFiStamyije3Nr351h4g30
         LMng==
X-Gm-Message-State: AJIora+X8fXQmwPjYvqkkrd6R6VmNGJrTHejWfuIH+JIsEblv0sPXcJp
        /Ya9XZltxE0AryzuyDCqVp3FO8rgwq21OJpYh6UJug==
X-Google-Smtp-Source: AGRyM1sZdTjrDeXBBaamGWp9llWEK0UeVY3VyF0Mm8KGbyrlio2K1CT4ypglFVpOpHUdV0azLrhswWhJk5V07MXI370=
X-Received: by 2002:a81:7557:0:b0:317:6536:d404 with SMTP id
 q84-20020a817557000000b003176536d404mr6626035ywc.459.1655937099503; Wed, 22
 Jun 2022 15:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220622062027.994614-1-peng.fan@oss.nxp.com> <20220622072435.GT1615@pengutronix.de>
In-Reply-To: <20220622072435.GT1615@pengutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 22 Jun 2022 15:31:03 -0700
Message-ID: <CAGETcx9JpTbYtGFoKttWLeiBB73QzzBM1o-OL0o-XuFouLcEog@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        festevam@gmail.com, linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:24 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> +Cc Saravana Kannan <saravanak@google.com>, the author of 71066545b48e4
>
> On Wed, Jun 22, 2022 at 02:20:27PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Commit 71066545b48e4("driver core: Set fw_devlink.strict=1 by default")
> > default set fw_devlink to true. This has a side effect to i.MX uart
> > console. The sdma will make the i.MX8MP uart driver defer probe for some
> > time (~10s with i.MX8MP-EVK board) until sdma ready, because sdma is a
> > supplier with property dmas set in device tree node.
>
> I just tested this on an i.MX6 board and observed the same behaviour.
> The same will happen on any other i.MX board as well. This will also
> likely happen on any other SoC on which the UART driver uses dmaengine.
>
> >
> > Since this uart is for console, we need log printed out as soon as
> > possible, so remove the dmas property for the uart console node.
>
> Fixing this at board level is not really an option because that means
> fixing each and every, at least i.MX board in the tree. Furthermore
> this would mean to bring the deleted property back in and to remove
> another dmas property should a user want to switch to another console
> port.
>
> For what it's worth: NACK for 71066545b48e4.

Peng, I sent a fix. Can you give it a shot please?

https://lore.kernel.org/lkml/20220622215912.550419-1-saravanak@google.com/

-Saravana

>
> Sascha
>
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V1:
> >  The upper set fw_devlink.strict=1 patch is in linux-next tree.
> >
> >  arch/arm64/boot/dts/freescale/imx8mp-evk.dts                  | 2 ++
> >  arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts | 2 ++
> >  arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts  | 2 ++
> >  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts        | 2 ++
> >  4 files changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > index fb11c03bc8b1..3fdb38bc0069 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > @@ -359,6 +359,8 @@ &uart2 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&pinctrl_uart2>;
> >       status = "okay";
> > +     /delete-property/ dmas;
> > +     /delete-property/ dma-names;
> >  };
> >
> >  &usb3_phy1 {
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> > index dd703b6a5e17..fb2b44e94482 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> > @@ -69,6 +69,8 @@ &uart2 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&pinctrl_uart2>;
> >       status = "okay";
> > +     /delete-property/ dmas;
> > +     /delete-property/ dma-names;
> >  };
> >
> >  &usb3_phy0 {
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> > index 6aa720bafe28..68a478151292 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> > @@ -99,6 +99,8 @@ &uart1 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&pinctrl_uart1>;
> >       status = "okay";
> > +     /delete-property/ dmas;
> > +     /delete-property/ dma-names;
> >  };
> >
> >  /* SD-Card */
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > index 521215520a0f..f90c1ac2791c 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > @@ -554,6 +554,8 @@ &uart2 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&pinctrl_uart2>;
> >       status = "okay";
> > +     /delete-property/ dmas;
> > +     /delete-property/ dma-names;
> >  };
> >
> >  &uart4 {
> > --
> > 2.25.1
> >
> >
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
