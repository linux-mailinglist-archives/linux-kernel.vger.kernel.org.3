Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834D254A0DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbiFMVIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351672AbiFMVHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:07:02 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C81DEB6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:45:06 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id u99so11791984ybi.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m5JCegGAYMi5Q9W2JQGuLDIcqo00Awy4QAwQXlwcWcE=;
        b=Y8PgXmY2/nGutxvyX2dVqsPiD/5+ONTAVCrb5dCOijLp6hOh6guiH0qrM/AiFzGG+L
         2zF2AhQ2OrJIp07OjeQZkImtrzevfAiZn6aQPFYk7tefYh8Atc6pUh3dMEF2rocc9zmP
         Dg3xzw03JF6KBjd+jSOcSvmgwkw8LZeAS0/XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m5JCegGAYMi5Q9W2JQGuLDIcqo00Awy4QAwQXlwcWcE=;
        b=1CKtug75wKRsVubdnMDTlNQoQycOb5p6jx3XLXkCTGiSEl0UVM2OgfBsUjZHRVXlzq
         Et85Z2fMS0Hh0gVnKGkghCzbAv6RgykvS6O+UkYFu0tLMoOHXMXLytC8fPTwBklQ0QSq
         mOTaAuWXOZzFS45ANJ/cqT5BVfHQsoD+rjpBsd0eoflbJCXo2HfZdqs/gfqOrifVZS1p
         KHEmB9d5lxHX9chEXtNAVeoOt7MdCjB6G+w1yPtpQtsvHKkcNUnLipjF62oZNydOnzJa
         GHO2iB6kku6uYGyUWH3au3XTJ2BNTk5vgn5EME879M/i7kpCWNDOB73uhYd6oLgf/4Md
         xmRQ==
X-Gm-Message-State: AJIora8NadFrzpw2f+VkXNhBwJTvCn7LkUUbwO/vUPIMUZf/WmI4ejsD
        EQ5Juzwt0zEXnFhs3RyTtoxW/dDGKERkbq1zy1Q52g==
X-Google-Smtp-Source: AGRyM1t6Ihkfl/eHvd+ILi0J6eEA0HkYOgT9briyKqKgLuf0D40FSPRp8M7otpMGiIZHBU56xkDHGbRCug93NReu0Yk=
X-Received: by 2002:a25:ce83:0:b0:664:6360:41ae with SMTP id
 x125-20020a25ce83000000b00664636041aemr1514280ybe.336.1655153105879; Mon, 13
 Jun 2022 13:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220609181106.3695103-1-pmalani@chromium.org>
 <20220609181106.3695103-4-pmalani@chromium.org> <20220613203804.3d23gxidkw657ggq@notapiano>
In-Reply-To: <20220613203804.3d23gxidkw657ggq@notapiano>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 13 Jun 2022 13:44:54 -0700
Message-ID: <CACeCKafwT2HbYqG=u+NwXtvD4R+EK_f7DCWn88WoHriP4iOMdw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] dt-bindings: usb: Add Type-C switch binding
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi N=C3=ADcolas,

On Mon, Jun 13, 2022 at 1:38 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Hi Prashant,
>
> thanks for the patch. Please see sugestions below.
>
> On Thu, Jun 09, 2022 at 06:09:42PM +0000, Prashant Malani wrote:
> > Introduce a binding which represents a component that can control the
> > routing of USB Type-C data lines as well as address data line
> > orientation (based on CC lines' orientation).
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >
> > Changes since v1:
> > - Removed "items" from compatible.
> > - Fixed indentation in example.
> >
> >  .../devicetree/bindings/usb/typec-switch.yaml | 74 +++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/typec-switch.=
yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/typec-switch.yaml b/=
Documentation/devicetree/bindings/usb/typec-switch.yaml
> > new file mode 100644
> > index 000000000000..78b0190c8543
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> > @@ -0,0 +1,74 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/typec-switch.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: USB Type-C Switch
> > +
> > +maintainers:
> > +  - Prashant Malani <pmalani@chromium.org>
> > +
> > +description:
> > +  A USB Type-C switch represents a component which routes USB Type-C d=
ata
> > +  lines to various protocol host controllers (e.g USB, VESA DisplayPor=
t,
> > +  Thunderbolt etc.) depending on which mode the Type-C port, port part=
ner
> > +  and cable are operating in. It can also modify lane routing based on
> > +  the orientation of a connected Type-C peripheral.
> > +
> > +properties:
> > +  compatible:
> > +    const: typec-switch
> > +
> > +  mode-switch:
> > +    type: boolean
> > +    description: Specify that this switch can handle alternate mode sw=
itching.
> > +
> > +  orientation-switch:
> > +    type: boolean
> > +    description: Specify that this switch can handle orientation switc=
hing.
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    description: OF graph binding modelling data lines to the Type-C s=
witch.
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Link between the switch and a Type-C connector.
>
> Since you have a single port, you can omit the ports node.

I've kept "ports", since it should be possible to add additional ports
which connect the switch to some other entity (and kept separate from
port@0), if the individual driver desires this.
port@0 should only contain the end-point from the Type-C connector.

>
> > +
> > +    required:
> > +      - port@0
> > +
> > +required:
> > +  - compatible
> > +  - ports
> > +
> > +anyOf:
> > +  - required:
> > +      - mode-switch
> > +  - required:
> > +      - orientation-switch
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    drm-bridge {
> > +        usb-switch {
> > +            compatible =3D "typec-switch";
> > +            mode-switch;
> > +            orientation-switch;
> > +            ports {
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                port@0 {
> > +                    reg =3D <0>;
> > +                    anx_ep: endpoint {
> > +                        remote-endpoint =3D <&typec_controller>;
> > +                    };
> > +                };
> > +            };
>
> So instead of ports you would have just
>
>                port {
>                    anx_ep: endpoint {
>                        remote-endpoint =3D <&typec_controller>;
>                    };
>                };
>
> And the same simplification on patch 4, for the anx7625 dt-binding.
>
> Thanks,
> N=C3=ADcolas
>
> > +        };
> > +    };
> > --
> > 2.36.1.476.g0c4daa206d-goog
> >
