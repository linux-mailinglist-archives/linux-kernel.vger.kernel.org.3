Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4049AD81
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444303AbiAYHUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443743AbiAYHQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:16:48 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E0AC061B39
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 22:26:01 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y84so6090771iof.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 22:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2U6KYB1yIQCjzCwnLoBdcZ/4jIE7qR7aI2a0GGlFPd0=;
        b=HAh7abheMqYTAcBVQo2TAGzKQeui2rCxOSx0l50yhx4nTVqN2AstIUKf9gCw/aXkzv
         tsZ2yumaQFT1WhY8fj4ObQgr7vfrJdGdo1SuWV/+HheBzq3mjOZY1XnBaIYK2ixMdsT3
         2djpmAPyZ37v2dQ1migYZeIwUTm6xBHLJnw3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2U6KYB1yIQCjzCwnLoBdcZ/4jIE7qR7aI2a0GGlFPd0=;
        b=gMq433S3Y8KAL/5rtJN2cLVsfyuWYINydFYzcC3SIHOS4ZO3URXDatDzTsNbb5xXtc
         /1aa3UG5bdH8b6JT5rGQgNK8j8LWrurbvDDYhqvkl8iU1TCuU9VbYDO9WTo9OgKgvOec
         LdbHK0rtLJipVYN1Fza9XMBrG1GNdoo/d0uL7+99T6LuchQxW0T05/HXRA0G6XL8O7Cz
         pbB5EBMWIJvkkeBKTzLSPTeFIrLMj2dCFvbpMlMhK0gAkgxis+A8AvPxtVH2QZ8b/6en
         VyjNpVw0sSoCZgTZLolKAK5tKpkC6hvDo43NhVNdjzucmAfG/orZNj1JS9AE9nQ8V0Wm
         xeew==
X-Gm-Message-State: AOAM5325LXCV9LCzmNJW5Ws8MeJQx81E+EmjOQdVhuyaFcuQtkRyk86Z
        UC2bTuYNqQ7eFIEujzl2wgoDbr9S0Q/lk9FDfta++g==
X-Google-Smtp-Source: ABdhPJxu70h8wl5OczMCGfVK32YiOQthjoUZTQv5YcNKB9G0Rzj180pdM66UAKwXmAmEz90meAioZOoKHPN36d2Pakg=
X-Received: by 2002:a5e:9706:: with SMTP id w6mr9650262ioj.204.1643091961104;
 Mon, 24 Jan 2022 22:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20220119151751.986185-1-hsinyi@chromium.org> <20220119151751.986185-4-hsinyi@chromium.org>
 <CAG3jFyv--OkEOxHr=61oAw8Q0bMdkftZu47M-N0YTiOB0YyiQA@mail.gmail.com>
In-Reply-To: <CAG3jFyv--OkEOxHr=61oAw8Q0bMdkftZu47M-N0YTiOB0YyiQA@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 25 Jan 2022 14:25:35 +0800
Message-ID: <CAJMQK-goEdzWT=q-Tabb8hPUDTNwwq6E0HqR3Wxw_JpREK3T0w@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] dt-bindings: drm/bridge: anx7625: Add aux-bus node
To:     Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Xin Ji <xji@analogixsemi.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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

On Wed, Jan 19, 2022 at 11:36 PM Robert Foss <robert.foss@linaro.org> wrote:
>
> Hey Hsin-Yi,
>
> While I can review this patch, I don't have the authority to merge it
> since it is outside the scope of my maintainership. Rob Herring,
> Daniel Vetter or David Airlie would have to Ack this patch.

hi Rob,

Can you help ack this patch? thanks
>
> On Wed, 19 Jan 2022 at 16:18, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > List panel under aux-bus node if it's connected to anx7625's aux bus.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  .../display/bridge/analogix,anx7625.yaml        | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > index 1d3e88daca041a..0d38d6fe39830f 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > @@ -83,6 +83,9 @@ properties:
> >      type: boolean
> >      description: let the driver enable audio HDMI codec function or not.
> >
> > +  aux-bus:
> > +    $ref: /schemas/display/dp-aux-bus.yaml#
> > +
> >    ports:
> >      $ref: /schemas/graph.yaml#/properties/ports
> >
> > @@ -167,5 +170,19 @@ examples:
> >                      };
> >                  };
> >              };
> > +
> > +            aux-bus {
> > +                panel {
> > +                    compatible = "innolux,n125hce-gn1";
> > +                    power-supply = <&pp3300_disp_x>;
> > +                    backlight = <&backlight_lcd0>;
> > +
> > +                    port {
> > +                        panel_in: endpoint {
> > +                            remote-endpoint = <&anx7625_out>;
> > +                        };
> > +                    };
> > +                };
> > +            };
> >          };
> >      };
> > --
> > 2.34.1.703.g22d0c6ccf7-goog
> >
