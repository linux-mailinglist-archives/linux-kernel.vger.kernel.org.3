Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B2D49D972
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiA0Dkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiA0Dk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:40:26 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCB7C061755
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 19:40:21 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id e79so1999567iof.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 19:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7/Kp3F6JWjpBg8AuPne8Hm8StpS8mXuWpdkN/2AU28=;
        b=fIB7aJiW04CE0H1xvznsR47TuEwPDzJp8RmW7I8/i8S3uJLJAhMiNwdn83BxGgnrhD
         cEEMtcdaxxYvkeBylZj4ihG5yHA+CP0L4WNBPaa0xtIuxGHomcmUH5MCSP/spp3lsdu1
         aL8020kO/ekms8qNuzpMx96rFyQDzf9lR1vAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7/Kp3F6JWjpBg8AuPne8Hm8StpS8mXuWpdkN/2AU28=;
        b=VKiqlKNKe301v7XxEwKjkhmDlm4jukxgffFGiCgKXuW4WtQUqDO9NtADHiOG9R4D9l
         dUmdLdosiXNg5BsluicmXAf/LW6uGLUCVirUWhjeF5OeDnf2ng349j71IWRXkH5BdG3g
         +RqGN7YQ/jIkzMrdoc1U4bCmVcOwCCpqqtzxZislc6GEeTB5wO9KuWqJqD7JyFndHSaF
         1ddd2ZWhIktC7nT11Gvia7j6lkWRIl0i2fEm6IivYz480ywcNhVWAebDJMiXQ//10jt5
         CNLmbRdEXBjnMIMkjxSpLpMIyPX8om9tK7B4NbgyX9tNphIDTk+C382mdFKKvN2WQVAy
         CD9g==
X-Gm-Message-State: AOAM532MF8BCFSp7VeGkKgNSV8UOAnYctWY3F1dtpRZ0WEJWuH7anqCB
        kx8sKIw0y5FpBGDenzRf+3i8VVAEYtVxv7xLtN/noQ==
X-Google-Smtp-Source: ABdhPJxf7p8s8pOwk6s2VFdm1yidnImAK0pRyPmSP1y9SUn43IX4YQpe/YpYv1woP96uuTgIFCZig/trFIy74MFsBHs=
X-Received: by 2002:a05:6638:1908:: with SMTP id p8mr182550jal.282.1643254821165;
 Wed, 26 Jan 2022 19:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20220119151751.986185-1-hsinyi@chromium.org> <20220119151751.986185-4-hsinyi@chromium.org>
 <CAG3jFyv--OkEOxHr=61oAw8Q0bMdkftZu47M-N0YTiOB0YyiQA@mail.gmail.com> <CAJMQK-goEdzWT=q-Tabb8hPUDTNwwq6E0HqR3Wxw_JpREK3T0w@mail.gmail.com>
In-Reply-To: <CAJMQK-goEdzWT=q-Tabb8hPUDTNwwq6E0HqR3Wxw_JpREK3T0w@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 27 Jan 2022 11:39:55 +0800
Message-ID: <CAJMQK-jL40QNXjGUF5Z7sjnCNXTFM5cyVrqEPm+h5uvS2hzm6g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] dt-bindings: drm/bridge: anx7625: Add aux-bus node
To:     Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     Xin Ji <xji@analogixsemi.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 2:25 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Wed, Jan 19, 2022 at 11:36 PM Robert Foss <robert.foss@linaro.org> wrote:
> >
> > Hey Hsin-Yi,
> >
> > While I can review this patch, I don't have the authority to merge it
> > since it is outside the scope of my maintainership. Rob Herring,
> > Daniel Vetter or David Airlie would have to Ack this patch.

hi Rob, Daniel, and David,

Can you help ack this patch?

Thanks
> >
> > On Wed, 19 Jan 2022 at 16:18, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >
> > > List panel under aux-bus node if it's connected to anx7625's aux bus.
> > >
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > Reviewed-by: Xin Ji <xji@analogixsemi.com>
> > > ---
> > >  .../display/bridge/analogix,anx7625.yaml        | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > index 1d3e88daca041a..0d38d6fe39830f 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > @@ -83,6 +83,9 @@ properties:
> > >      type: boolean
> > >      description: let the driver enable audio HDMI codec function or not.
> > >
> > > +  aux-bus:
> > > +    $ref: /schemas/display/dp-aux-bus.yaml#
> > > +
> > >    ports:
> > >      $ref: /schemas/graph.yaml#/properties/ports
> > >
> > > @@ -167,5 +170,19 @@ examples:
> > >                      };
> > >                  };
> > >              };
> > > +
> > > +            aux-bus {
> > > +                panel {
> > > +                    compatible = "innolux,n125hce-gn1";
> > > +                    power-supply = <&pp3300_disp_x>;
> > > +                    backlight = <&backlight_lcd0>;
> > > +
> > > +                    port {
> > > +                        panel_in: endpoint {
> > > +                            remote-endpoint = <&anx7625_out>;
> > > +                        };
> > > +                    };
> > > +                };
> > > +            };
> > >          };
> > >      };
> > > --
> > > 2.34.1.703.g22d0c6ccf7-goog
> > >
