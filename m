Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7373456D33A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 05:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiGKDKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 23:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKDKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:10:04 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD68917A99
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 20:10:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i128-20020a1c3b86000000b003a2ce31b4f8so4245485wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 20:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFEMZxCK/djolvQUSJ9ZgoX+sTLVZ0cVLpJ/rtD11j8=;
        b=Eq6JEWFVZdbf2pHCpJ1ou4cgn1NeNrhvTPJ0Fg+W3dP9EAAXrEZguNEEEiprKM0km9
         ah3kPdL4JKEevIv9eeNPm0vVO9ZYW6r0VDm1C5xLvcNhUD53qZHPPq+acillaN+K14xC
         EEMjs4IpDIKobVLM4isnWpFIlSDNwECPe2kZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFEMZxCK/djolvQUSJ9ZgoX+sTLVZ0cVLpJ/rtD11j8=;
        b=Wz3dkIGFhPCmI4uLGCSPI8i2MAEW7uRHn98SFjYZ3qiJnfrbrHDWueDnJg1yjv6C7O
         ANpe1mImlLeAi8f1FhRmDy0ZDnzgIAf7hQTZaBanmRAgdq8AN9fVIkLPbDo+c4jx+rOz
         vr2qZIzNmi0ufrBnboBqRWBYG0wNPtzY2cc8tOCWHtEfgu/8F8Fu3g12YT24Dp6eF5FO
         6rHcJM9snXdVvL2z6yDXm4wrL58AcYXIir5oNd3520K6ZlvGSxtEBOpKHZjiwxDHa134
         6TXiK2liwL4boR/ue90E9MDK3Yr8+xpYwr3FlcAeeDpyoNn6BNayaiO+veYVYiIFEC9j
         wcBw==
X-Gm-Message-State: AJIora+pj4OBwSlBTfvAl9EdfsMCVvKDziKqyVvfSwomMem20/2sxukl
        4XV2U87fBKWY8i1NHFzUfVgGzBaw9soPo8W+rxMywg==
X-Google-Smtp-Source: AGRyM1sBjrTuZpzK4XuwdVW/i96VfIBsSENgJ1XKIaFYOjZSkgDs8pG/TSMT1eQCfInpje1o8o9KcnScfs/lAo9nh1c=
X-Received: by 2002:a05:600c:2e53:b0:3a2:e51c:a6a with SMTP id
 q19-20020a05600c2e5300b003a2e51c0a6amr6258057wmf.168.1657509001388; Sun, 10
 Jul 2022 20:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220621091854.1904372-1-treapking@chromium.org> <de6412d4-732c-79cf-ac00-e0fccee44270@gmail.com>
In-Reply-To: <de6412d4-732c-79cf-ac00-e0fccee44270@gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Mon, 11 Jul 2022 11:09:50 +0800
Message-ID: <CAEXTbpf=w6qB1X3dYSR=kdJgqNAFW-pRYuiOGuv9WWEtuY47Cw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: mt8173: Fix elm panel DT node
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All we know is that the functions mentioned in the commit message were
working in 4.19 kernel, but not in the latest kernel tree.

Unfortunately, we don't know which patch breaks the driver.

Best regards,
Pin-yen

On Thu, Jul 7, 2022 at 10:50 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 21/06/2022 11:18, Pin-Yen Lin wrote:
> > Move the panel DT node under `aux-bus` node, so it won't use the buggy
> > `ps8640_bridge_get_edid` to get the display modes. Also, change the
> > compatible string from "lg,lp120up1" to "edp-panel", so the panel-edp
> > driver gets the displays modes from the EDID instead of using the
> > predefined display mode (`lg_lp129qe_mode`) in the driver, which is
> > actually not working.
> >
>
> Do we need a fixes tag here? I'm not quite sure if we fix an upstream bug here,
> to be honest.
>
> Regards,
> Matthias
>
> > Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Include more details in the commit message.
> >
> > Changes in v2:
> > - Remove the Fixes tag because this change is not compatible with the
> >    old kernel versions.
> >
> >   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 26 +++++++++++---------
> >   1 file changed, 14 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > index 9c75fbb31f98..1e0802a6f6d2 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > @@ -90,18 +90,6 @@ volume_up {
> >               };
> >       };
> >
> > -     panel: panel {
> > -             compatible = "lg,lp120up1";
> > -             power-supply = <&panel_fixed_3v3>;
> > -             backlight = <&backlight>;
> > -
> > -             port {
> > -                     panel_in: endpoint {
> > -                             remote-endpoint = <&ps8640_out>;
> > -                     };
> > -             };
> > -     };
> > -
> >       panel_fixed_3v3: regulator1 {
> >               compatible = "regulator-fixed";
> >               regulator-name = "PANEL_3V3";
> > @@ -282,6 +270,20 @@ ps8640_out: endpoint {
> >                               };
> >                       };
> >               };
> > +
> > +             aux-bus {
> > +                     panel {
> > +                             compatible = "edp-panel";
> > +                             power-supply = <&panel_fixed_3v3>;
> > +                             backlight = <&backlight>;
> > +
> > +                             port {
> > +                                     panel_in: endpoint {
> > +                                             remote-endpoint = <&ps8640_out>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> >       };
> >   };
> >
