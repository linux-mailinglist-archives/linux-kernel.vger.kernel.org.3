Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF164F60A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiDFNyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiDFNxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:53:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5201959ED;
        Tue,  5 Apr 2022 18:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78E9160ABF;
        Wed,  6 Apr 2022 01:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CC7C385AE;
        Wed,  6 Apr 2022 01:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649210368;
        bh=pDwgEh6KmeCPgKnTyof6KSyznbNRaJiPPR8oySZr3rc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=capxQEI0O5lXiCZ51wrnI6lHYT0Rwe0rlsse+qJyO3lag9aPOIjkMZJspSuV/naGy
         1Uxm1Z0GsGXU+urhiW6rlMyafUJb6VSxu4BRKPvxuXrBm4fA8V3ukjjo81Ut9/xXOd
         NqEGgjgLUR2xTdDTkMKVuh4Nq5ONoordnW/Xa1YVhQO1xVSpT6MUo60svO97kCkoZs
         DacL3aR+LmTLVHXRN4hOqhjHAz1ty7W8+nPZlJqYT0td+ybhB6RqQNGZO97K334AL+
         uPPVPcYCxJ3aN6qYyuSOxxghrOuFjXEiT0HeaIqepHeEYeJ0ac8egcarB2XiJzC2uv
         yJMy48iqbsXug==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-e2442907a1so1055545fac.8;
        Tue, 05 Apr 2022 18:59:28 -0700 (PDT)
X-Gm-Message-State: AOAM5319how0a6zrVIUYuwQEoae5PzDsEEk8FSGj+tPsSgvTUFbkKikk
        sFcz9BaZxQueTgBze5LBernzGEw7GU70DsqxHq4=
X-Google-Smtp-Source: ABdhPJyWss1xlGBkA+PCf/HgdAp6TEkP4sbTxbCSm6ZcXecPsMrAuDs3F6O7hTv2eW1CSEDxRr7c5QC//7WPFwPAPc4=
X-Received: by 2002:a05:6870:ec90:b0:de:33ac:8100 with SMTP id
 eo16-20020a056870ec9000b000de33ac8100mr3008585oab.192.1649210367798; Tue, 05
 Apr 2022 18:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220221095312.3692669-1-o.rempel@pengutronix.de> <20220406012348.GE129381@dragon>
In-Reply-To: <20220406012348.GE129381@dragon>
From:   Shawn Guo <shawnguo@kernel.org>
Date:   Wed, 6 Apr 2022 09:59:17 +0800
X-Gmail-Original-Message-ID: <CAJBJ56+bmpmDYP+PP3NN+CKkJT8Ls-FLeUBxFxwNLqVbbgHbOQ@mail.gmail.com>
Message-ID: <CAJBJ56+bmpmDYP+PP3NN+CKkJT8Ls-FLeUBxFxwNLqVbbgHbOQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] ARM: dts: imx6qdl-vicut1/vicutgo: Set default
 backlight brightness to maximum
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 9:23 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Feb 21, 2022 at 10:53:05AM +0100, Oleksij Rempel wrote:
> > From: David Jander <david@protonic.nl>
> >
> > Recover default behavior of the device and set maximal brightness
> >
> > Signed-off-by: David Jander <david@protonic.nl>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx6dl-victgo.dts   | 2 +-
> >  arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6dl-victgo.dts b/arch/arm/boot/dts/imx6dl-victgo.dts
> > index 227c952543d4..e6134efbfabd 100644
> > --- a/arch/arm/boot/dts/imx6dl-victgo.dts
> > +++ b/arch/arm/boot/dts/imx6dl-victgo.dts
> > @@ -28,7 +28,7 @@ backlight: backlight {
> >               pwms = <&pwm1 0 5000000 0>;
> >               brightness-levels = <0 16 64 255>;
> >               num-interpolated-steps = <16>;
> > -             default-brightness-level = <1>;
> > +             default-brightness-level = <48>;
>
> Please take a look at the documentation of the property.
>
>   default-brightness-level:
>     description:
>       The default brightness level (index into the array defined by the
>       "brightness-levels" property).

Ah, never mind, I missed 'num-interpolated-steps' there.

Shawn
