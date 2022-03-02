Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F34CA5A7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbiCBNNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiCBNNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:13:47 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76709434A4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:13:03 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id w16so3215211ybi.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 05:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iFzdXtEzQ/C71Rve7zBflg7ThV86ZkzCxCmfW7T42tw=;
        b=AMAOABWANU8dJtCSDqHudLvUJKMvPmZCh6uSOOTfcN8gTsmKY4epdjVCB5mzkdZuEL
         A5WgMtmVLqyggWiG/EwmIoPNC9OTB1Vcsf85fLUVIe4wCOeFoMFIJ/Xq9uR4ulyXHNcC
         /v0qIoj/YGhDSC8XUdeo2+Fn14EH+BrxRngjYdxaKr9yxum0WXZ+Jvor6C+TJqJhLUZJ
         UPtZsclHm6UV5HNVbCG4czs+ZYmxws6zuAlCiixIJgEz2nuA3NlpGSzIVnop5ccz7Yqq
         MQQQmR+8XhXI0L+CNN+JOc8XZkTfBMSzG4sLKna+gVByGuSav30sXqbxJyAr/o53o5v2
         z3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iFzdXtEzQ/C71Rve7zBflg7ThV86ZkzCxCmfW7T42tw=;
        b=k3FBOy27YhKsmAezckxRy6pRnzz5XZi06nKHO1zV2HTwFOSuE45J1pWsHdH8YkSXyF
         XZ/tp4NMNM3AnCi6vVbOSAUBNQBuNqYn8A/OT2oMp/56vop5iYIuFDjetoCCvgDaAFL7
         KQ9Xhi1NT2aJtG7M0pXyN75uc7nyslmrnVb0EvLuwSYj5TKKj7Iud3pLkkGpyYY+OJgn
         IChHP/Lc03nKD/W1Mu0E7YE70ZDNHqHc2wRX0xVRSION7Hz/PljnOz3ZTc4rWw0vjuuY
         NGsDXp++aE4Sd7DnzEB6rTVIFkav8Uv04p0SqcTTc51O2xQCYNrt5uTt2HyB2SVD+g5h
         HVCQ==
X-Gm-Message-State: AOAM531QOkyMpJWvDefKXx9+hisd+JPSfA88O/P3zpiVkaaaE5fvR9o4
        V3NUlfBH1bQ3Stx9kIMKOOR0SlOiOS4M2BWxTKPVwA==
X-Google-Smtp-Source: ABdhPJwcMptwYIJ+0vGUlCqUAHmZayhDR+qWANhFtDiip1jgFhh8aMHAyiF0m7wtaCH/vy8kjU9d2FJ8z+vO4S/dFm4=
X-Received: by 2002:a25:296:0:b0:623:a267:ab94 with SMTP id
 144-20020a250296000000b00623a267ab94mr28901467ybc.430.1646226782705; Wed, 02
 Mar 2022 05:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20220216085842.1973868-1-victor.liu@nxp.com> <Yh9WYZ5pA/MUyZFx@qwark.sigxcpu.org>
In-Reply-To: <Yh9WYZ5pA/MUyZFx@qwark.sigxcpu.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 2 Mar 2022 14:12:51 +0100
Message-ID: <CAG3jFyu8mzG07MUg_-0O4Ew=CM6xDX=9e47e2t7dc88K9seycQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: nwl-dsi: Remove superfluous write to
 NWL_DSI_IRQ_MASK register
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 12:35, Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> Hi Liu,
> On Wed, Feb 16, 2022 at 04:58:42PM +0800, Liu Ying wrote:
> > To initialize register NWL_DSI_IRQ_MASK, it's enough to write it
> > only once in function nwl_dsi_init_interrupts().
> >
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> >  drivers/gpu/drm/bridge/nwl-dsi.c | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/=
nwl-dsi.c
> > index af07eeb47ca0..fcc4a2889ad4 100644
> > --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> > +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> > @@ -333,17 +333,13 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi=
)
> >
> >  static int nwl_dsi_init_interrupts(struct nwl_dsi *dsi)
> >  {
> > -     u32 irq_enable;
> > -
> > -     nwl_dsi_write(dsi, NWL_DSI_IRQ_MASK, 0xffffffff);
> > -     nwl_dsi_write(dsi, NWL_DSI_IRQ_MASK2, 0x7);
> > -
> > -     irq_enable =3D ~(u32)(NWL_DSI_TX_PKT_DONE_MASK |
> > -                         NWL_DSI_RX_PKT_HDR_RCVD_MASK |
> > -                         NWL_DSI_TX_FIFO_OVFLW_MASK |
> > -                         NWL_DSI_HS_TX_TIMEOUT_MASK);
> > +     u32 irq_enable =3D ~(u32)(NWL_DSI_TX_PKT_DONE_MASK |
> > +                             NWL_DSI_RX_PKT_HDR_RCVD_MASK |
> > +                             NWL_DSI_TX_FIFO_OVFLW_MASK |
> > +                             NWL_DSI_HS_TX_TIMEOUT_MASK);
> >
> >       nwl_dsi_write(dsi, NWL_DSI_IRQ_MASK, irq_enable);
> > +     nwl_dsi_write(dsi, NWL_DSI_IRQ_MASK2, 0x7);
>
> Works fine here. I thought it was due to some hw quirk but can't find
> any note in it so:
>
> Reviewed-by: Guido G=C3=BCnther <agx@sigxcpu.org>
>
> Thanks,
>  -- Guido

Applied to drm-misc-next
