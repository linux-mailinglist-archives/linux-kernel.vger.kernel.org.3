Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD954A0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352033AbiFMVLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351783AbiFMVKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:10:42 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B73536E19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:48:25 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-30ce6492a60so10347837b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3mzLXc3omMOdnceGi72bYvaWi09FowsdxsPXVOOLWCo=;
        b=UkGQCIGmy2VA2qNV54XgHFut1lruS44Ok6ioCXsNzw6LyRpNqBzZClI6cA1S7OvMcY
         Kp8PTojzzJD65eMqBbZ/0ziJq0NYOS6jETD9dqdsU4UjPK+Z84UhGwH6M7KldwNl2q3N
         5tACt6+cbeMJpcLCaQEI4AOkuRxogFnBtnqG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3mzLXc3omMOdnceGi72bYvaWi09FowsdxsPXVOOLWCo=;
        b=Fuzq/jmBQHVJ48g2mNMhJACdl9KOVhnaIunUJptnk72mELyu4dKgJL5MVgpvI0zKu/
         siCgThpsS+qqbENMj5Rm8NdpklhV3SPiRZ51YbDkQ7GYyux98x9MFC7CizSNH75L8l3C
         h458mgR+PyrlxFOCC8yOZ/lCfVq5EkpezimnzYiylLBEiGUeTxdJa8dSQdJU+Xcx3ke7
         EtMw7gcdK13Zjq0uESxpgbZnNEODWoeW0jHSy/nlpa0PhrWKXJLOxJMo87ZDZBap36Cb
         F6dFAygj2pVrMGkTo/ZRJHr329RCZEjz7gLeF4lqTgT/MmyNGGO6witgcsJmSbhyyroT
         98wg==
X-Gm-Message-State: AJIora8BCGvJYBjLTDYbaQDI3gSuxAknRYCfE9kugaEho5yPomFaCtbd
        jsvNnhF9sU8jz7sAJVb5JUvW16aZs96wcLBPI0sBfg==
X-Google-Smtp-Source: AGRyM1v0IBXwwJvQ6ThVo9NueSieU7nIxKk5N1jB0CBM2omKJsAvjrCZ6AcsceMJ9k7lsbfvB7coyKa/u+Rb5K9KkgU=
X-Received: by 2002:a0d:f882:0:b0:2f4:d830:6fd with SMTP id
 i124-20020a0df882000000b002f4d83006fdmr1775978ywf.387.1655153304756; Mon, 13
 Jun 2022 13:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220609181106.3695103-1-pmalani@chromium.org>
 <20220609181106.3695103-6-pmalani@chromium.org> <20220613204544.onfazkv4ciphddm3@notapiano>
In-Reply-To: <20220613204544.onfazkv4ciphddm3@notapiano>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 13 Jun 2022 13:48:13 -0700
Message-ID: <CACeCKacaq_6zc9daL38VycCxWaNvVHFETBfytrDXTBCa3Y3jRw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drm/bridge: anx7625: Register number of Type C switches
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi N=C3=ADcolas,

On Mon, Jun 13, 2022 at 1:45 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Hi Prashant,
>
> On Thu, Jun 09, 2022 at 06:09:44PM +0000, Prashant Malani wrote:
> > Parse the "switches" node, if available, and count and store the number
> > of Type-C switches within it. Since we currently don't do anything with
> > this info, no functional changes are expected from this change.
> >
> > This patch sets a foundation for the actual registering of Type-C
> > switches with the Type-C connector class framework.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >
> > Changes since v1:
> > - No changes.
> >
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 20 ++++++++++++++++++++
> >  drivers/gpu/drm/bridge/analogix/anx7625.h |  1 +
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/dr=
m/bridge/analogix/anx7625.c
> > index 53a5da6c49dd..07ed44c6b839 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -2581,6 +2581,22 @@ static void anx7625_runtime_disable(void *data)
> >       pm_runtime_disable(data);
> >  }
> >
> > +static int anx7625_register_typec_switches(struct device *device, stru=
ct anx7625_data *ctx)
> > +{
> > +     struct device_node *of =3D NULL;
> > +     int ret =3D 0;
> > +
> > +     of =3D of_get_child_by_name(device->of_node, "switches");
> > +     if (!of)
> > +             return -ENODEV;
> > +
> > +     ctx->num_typec_switches =3D of_get_child_count(of);
> > +     if (ctx->num_typec_switches <=3D 0)
> > +             return -ENODEV;
>
> Since the hardware only allows at most 2 switches (based on the dt-bindin=
gs),
> you should have a define for that limit and check that it isn't exceeded =
here.

This is already enforced by the DT binding (see the
"patternProperties" in patch 4/7, suggested by Krzysztof in the
previous version)

>
> Thanks,
> N=C3=ADcolas
>
> > +
> > +     return ret;
> > +}
> > +
> >  static int anx7625_i2c_probe(struct i2c_client *client,
> >                            const struct i2c_device_id *id)
> >  {
> > @@ -2686,6 +2702,10 @@ static int anx7625_i2c_probe(struct i2c_client *=
client,
> >       if (platform->pdata.intp_irq)
> >               queue_work(platform->workqueue, &platform->work);
> >
> > +     ret =3D anx7625_register_typec_switches(dev, platform);
> > +     if (ret)
> > +             dev_info(dev, "Didn't register Type C switches, err: %d\n=
", ret);
> > +
> >       platform->bridge.funcs =3D &anx7625_bridge_funcs;
> >       platform->bridge.of_node =3D client->dev.of_node;
> >       if (!anx7625_of_panel_on_aux_bus(&client->dev))
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/dr=
m/bridge/analogix/anx7625.h
> > index e257a84db962..d5cbca708842 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> > @@ -473,6 +473,7 @@ struct anx7625_data {
> >       struct drm_connector *connector;
> >       struct mipi_dsi_device *dsi;
> >       struct drm_dp_aux aux;
> > +     int num_typec_switches;
> >  };
> >
> >  #endif  /* __ANX7625_H__ */
> > --
> > 2.36.1.476.g0c4daa206d-goog
> >
