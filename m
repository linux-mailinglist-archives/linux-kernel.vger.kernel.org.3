Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8ED54D0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358297AbiFOSNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358229AbiFOSNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:13:46 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD1D32EFC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:13:45 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-30fa61b1a83so70252297b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88rWp51m5t+bsaVtWMHrNKjzep9CN6agHaxeYLzqOSg=;
        b=H8MUMyZkbpsfkUYxJJTUpsb3WM9USwP6+APqKsyACfl9Rvj1vNCBuWn4HVYMWjjkwd
         V7BpgMIUSiYmd/8sLRw/Vc1cJJL8XwBPAZdLidcg/opIXQrJVk1/XvUTzTAZIDhyoa8X
         4xUDtSa72THRkFvfsgrVcZvllNcbogoaLUgVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88rWp51m5t+bsaVtWMHrNKjzep9CN6agHaxeYLzqOSg=;
        b=MEWw01Y97CoUp9Nl3ayGLQrOTBSXAfBLg+Xc6byiXcI4e3LHpBsli8CoqYxiGOslwv
         wBit0tBTWJF2N4br+pG8PpPqR32earknKBvJR311LjyVVUtYkWnz3KZxThR09uOv0qKc
         mS3nz336sk8WQt0dTZAPbR2wU021StjEH3MDUtwC0SF3QSykvERTL2jh2q2Iyzyr+NvM
         qm2L+bDp4bJsoprXhVwUZiAOAvJbXhfTaJswENiVZgkq9Hcf+aPhXAIz7C9FsDcRj6Ql
         KS7+/ftx3prmunsm8HH3CS3TbBeFtOVZaawW4bXWWkm45/2G/PoZcrrU5xXzMYXniIo2
         sErg==
X-Gm-Message-State: AJIora+JYs6pHUlAIcf7NqY0iWY2iOpXHVqUblOprZ7P+TKwj1i4njoJ
        Qw/tWN/fo2w4q69h59q3HUN3+6h+SzkgNa3gVy5KlLsFFChiaw==
X-Google-Smtp-Source: AGRyM1u+RECui2g1rqJWo2sDArYUxX8+ZP/YRCEWMicYm4UeyPBeP4772cKrmnj1CsKqr1gXTmUp8cr2Q3utYCTbhDU=
X-Received: by 2002:a81:fd1:0:b0:30f:f98b:4957 with SMTP id
 200-20020a810fd1000000b0030ff98b4957mr1085245ywp.350.1655316824181; Wed, 15
 Jun 2022 11:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220615172129.1314056-1-pmalani@chromium.org>
In-Reply-To: <20220615172129.1314056-1-pmalani@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 15 Jun 2022 11:13:33 -0700
Message-ID: <CACeCKaetgayTS+yX0cuNiK7j6Yqd4o2ziX6nCoGTt64A3jFT=g@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] usb: typec: Introduce typec-switch binding
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
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
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I should add:

Series submission suggestions (of course, open to better suggestions too):
- Patches 1-3 can go through the USB repo.
- Patches 4-7 can:
   + also go through the USB repo after the maintainer acks have been
received <or>
   + go through the DRM repo (after creating a branch from USB repo's
usb-next branch after Patches 1-3 have been applied).

(I"ll add the above to the cover letter if there is a v5).

Thanks!

On Wed, Jun 15, 2022 at 10:21 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> This series introduces a binding for Type-C data lane switches. These
> control the routing and operating modes of USB Type-C data lanes based
> on the PD messaging from the Type-C port driver regarding connected
> peripherals.
>
> The first patch introduces a change to the Type-C mux class mode-switch
> matching code, while the second adds a config guard to a Type-C header.
> The next couple of patches introduce the new "typec-switch" binding as
> well as one user of it (the ANX7625 drm bridge).
>
> The remaining patches add functionality to the anx7625 driver to
> register the mode-switches, as well as program its crosspoint
> switch depending on which Type-C port has a DisplayPort (DP) peripheral
> connected to it.
>
> v3: https://lore.kernel.org/linux-usb/20220614193558.1163205-1-pmalani@chromium.org/
>
> Changes since v3:
> - Some more modifications to the anx7625 binding patch (4/7).
> - Picked up 1 more Reviewed-by tag.
>
> Pin-Yen Lin (1):
>   drm/bridge: anx7625: Add typec_mux_set callback function
>
> Prashant Malani (6):
>   usb: typec: mux: Allow muxes to specify mode-switch
>   usb: typec: mux: Add CONFIG guards for functions
>   dt-bindings: usb: Add Type-C switch binding
>   dt-bindings: drm/bridge: anx7625: Add mode-switch support
>   drm/bridge: anx7625: Register number of Type C switches
>   drm/bridge: anx7625: Register Type-C mode switches
>
>  .../display/bridge/analogix,anx7625.yaml      |  64 ++++++++
>  .../devicetree/bindings/usb/typec-switch.yaml |  74 +++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.c     | 148 ++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h     |  20 +++
>  drivers/usb/typec/mux.c                       |   8 +-
>  include/linux/usb/typec_mux.h                 |  44 +++++-
>  6 files changed, 350 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/typec-switch.yaml
>
> --
> 2.36.1.476.g0c4daa206d-goog
>
