Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760A8546F37
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350907AbiFJVZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348721AbiFJVZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:25:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263DD1F89B1;
        Fri, 10 Jun 2022 14:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB12CB837C6;
        Fri, 10 Jun 2022 21:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBEBC341C4;
        Fri, 10 Jun 2022 21:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654896317;
        bh=+yOYQf/molwfJfp3mc62IB7uUe79xlOHDuVNNoHLbxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PWDDxD/MTpJXCcqo8cDBRdQPlRHGDZEVW2HsxMG6PD/E53sbqsEaK+/jfvyqUHr/3
         d95HuTziadxlfer9hgoZqy8qNANzuuoh525MaZVb5XwHabSscUQGsSp/4SDTl4KBQ4
         Me8KJ/vVhuT1g2hiSW3cxrCYndp09x0BoR+MrGr+//GqYr4CT02mIazMC0E8bMZG16
         EhW5gIAFqKUoIuRFqzaGHREtqlFDpyFQLMyZXT71GUDfzH+Jx1wEWSD0ILinNbwOsM
         Vg93mTsRJGCs9qrMTbuaqR9L2FSsK5nFbY5XX3NSPCnamLaVHxYzLc9daW48g7B4we
         iiP9TIje/5R4A==
Received: by mail-vk1-f173.google.com with SMTP id q186so85641vkh.8;
        Fri, 10 Jun 2022 14:25:17 -0700 (PDT)
X-Gm-Message-State: AOAM5332pw3IdjpmCTEOMmtF30mst/oB2Ko+ZgE8vNdinodXqwDdGXws
        Izu64YLwPLn7gm0FIXS9yGPGWvm8Bw1/fD2oew==
X-Google-Smtp-Source: ABdhPJznf30KHWe8+z+YOq+izPos96vlalgcSMg0OYweCf6ENJfJTZBrfLeqOWSlufxTTtn0BIGqeF6S2vYhe3jMi2M=
X-Received: by 2002:a1f:aac7:0:b0:35e:1c45:def with SMTP id
 t190-20020a1faac7000000b0035e1c450defmr11545955vke.35.1654896316529; Fri, 10
 Jun 2022 14:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220610203818.2193593-1-robh@kernel.org> <YqOvmrDGgS0AubU4@ravnborg.org>
In-Reply-To: <YqOvmrDGgS0AubU4@ravnborg.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 10 Jun 2022 15:25:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJmkp=LUa+TmFo=3dZAKPhPNMGFWj5jyHq_Q9RxZqz4qw@mail.gmail.com>
Message-ID: <CAL_JsqJmkp=LUa+TmFo=3dZAKPhPNMGFWj5jyHq_Q9RxZqz4qw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: panel-simple: Add Arm virtual
 platforms display
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 2:55 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Rob,
>
> On Fri, Jun 10, 2022 at 02:38:18PM -0600, Rob Herring wrote:
> > 'arm,rtsm-display' is a panel for Arm, Ltd. virtual platforms (e.g. FVP).
> > The binding has been in use for a long time, but was never documented.
> >
> > Some users and an example have a 'panel-dpi' compatible, but that's not
> > needed without a 'panel-timing' node which none of the users have since
> > commit 928faf5e3e8d ("arm64: dts: fvp: Remove panel timings"). The
> > example does have a 'panel-timing' node, but it should not for the
> > same reasons the node was removed in the dts files. So update the
> > example in arm,pl11x.yaml to match the schema.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Andre Przywara <andre.przywara@arm.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/display/arm,pl11x.yaml           | 15 +-------------
> >  .../bindings/display/panel/panel-simple.yaml  | 20 +++++++++++++------
> >  2 files changed, 15 insertions(+), 20 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/arm,pl11x.yaml b/Documentation/devicetree/bindings/display/arm,pl11x.yaml
> > index b545c6d20325..6cc9045e5c68 100644
> > --- a/Documentation/devicetree/bindings/display/arm,pl11x.yaml
> > +++ b/Documentation/devicetree/bindings/display/arm,pl11x.yaml
> > @@ -159,25 +159,12 @@ examples:
> >      };
> >
> >      panel {
> > -        compatible = "arm,rtsm-display", "panel-dpi";
> > -        power-supply = <&vcc_supply>;
> > +        compatible = "arm,rtsm-display";
> >
> >          port {
> >              clcd_panel: endpoint {
> >                  remote-endpoint = <&clcd_pads>;
> >              };
> >          };
> > -
> > -        panel-timing {
> > -            clock-frequency = <25175000>;
> > -            hactive = <640>;
> > -            hback-porch = <40>;
> > -            hfront-porch = <24>;
> > -            hsync-len = <96>;
> > -            vactive = <480>;
> > -            vback-porch = <32>;
> > -            vfront-porch = <11>;
> > -            vsync-len = <2>;
> > -        };
> >      };
> >  ...
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > index 21ba90c9fe33..97afd276c54a 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > @@ -19,9 +19,6 @@ description: |
> >
> >    If the panel is more advanced a dedicated binding file is required.
> >
> > -allOf:
> > -  - $ref: panel-common.yaml#
> > -
> >  properties:
> >
> >    compatible:
> > @@ -35,6 +32,8 @@ properties:
> >        - ampire,am-480272h3tmqw-t01h
> >          # Ampire AM-800480R3TMQW-A1H 7.0" WVGA TFT LCD panel
> >        - ampire,am800480r3tmqwa1h
> > +        # Arm, Ltd. Virtual Platforms Display
> > +      - arm,rtsm-display
> >          # AU Optronics Corporation 10.1" WSVGA TFT LCD panel
> >        - auo,b101aw03
> >          # AU Optronics Corporation 10.1" WSVGA TFT LCD panel
> > @@ -340,9 +339,18 @@ properties:
> >
> >  additionalProperties: false
> >
> > -required:
> > -  - compatible
> > -  - power-supply
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +  - if:
> > +      # Most 'simple' panels must have a single supply, but a virtual display does not
> > +      not:
> > +        properties:
> > +          compatible:
> > +            contains:
> > +              const: arm,rtsm-display
> > +    then:
> > +      required:
> > +        - power-supply
>
> Sorry, but I do not like this change. The beauty of panel-simple is that
> this is a collection of simple display with identical bindings because
> the HW is more or less the same (in general - not in details like size
> etc).
>
> Any panels that requires more are pushed out to their own binding and
> for arm,rtsm-display that would be better.

But I require less...

> It is not this single exceptions that bothers me, it is the many
> exceptions we will have in a few years from now.

Fair enough, I'll make it a separate file.

Rob
