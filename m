Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CDD57FB41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiGYI0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiGYIZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:25:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD713F42
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:25:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso8862373wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ceuq/AzPg/qUxtBubik4O9aoJrDB6xjdeG8Gtrb2V5w=;
        b=koHSa2/e68gxUBwHaKIv/T+VgRXYhm6nTGulLOakkCCOE3DfSjy/jKicIZSwZly4Gl
         wE35M0cF7FAo++9H0jaYmoQgMsVsJbpfBtGzPXR+V8ILT17HJZRMh8TG7RLMy0F6dbSy
         ydTLi3g65CfN762l5ImSuNY9WBmK9GT0028MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ceuq/AzPg/qUxtBubik4O9aoJrDB6xjdeG8Gtrb2V5w=;
        b=hCeLRtIqVLjHQc6Fek/ctMCLAKoThGNxDOIgTXJXb8KXcbzWqfFkeAxUTT01iYcD7E
         za1V9saoUxAmN1nryBY68Fe40v4w5VVKC8zXqun1IJmky1tZkzJz9t6VaTGj09QDVLEI
         Knis/7NwO38P4uhVRBUFdG5HbYIjGBoV4xV8taMzL0XCgW1w1Uvgwiatn8YYxiQ8VXIA
         aYrmqGeJAgMmEIE5mL79A4WSM00lhszyHfTczD8BIxeErIe1SilgKBTMWRO2C89digpy
         k3w0klbIRh00AmubM1BhHL0OzsLkhPGY8EDjBid7s/1NF8Eq7/wgHrRmAiwZ3EyQCUWz
         u/zw==
X-Gm-Message-State: AJIora/ZXqTrGb/lKfmIiG+o7o5KnIOj9sKLiE5y/anh6zxLN61RsWON
        hqcG1DvUJxV27TYPZ7cStkFv1DSUlb/D1lF/KVaUOA==
X-Google-Smtp-Source: AGRyM1ubRVgEsXGa9zbOVrrkfxXmODf9Q0J/xrQzonmleWJncuypb6dFrCLUbX8RhQT5mxmU4ko0X/lK5cO8MAvSCrA=
X-Received: by 2002:a1c:4c0d:0:b0:3a2:fc6e:f8c7 with SMTP id
 z13-20020a1c4c0d000000b003a2fc6ef8c7mr7506641wmf.102.1658737555523; Mon, 25
 Jul 2022 01:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220621091854.1904372-1-treapking@chromium.org>
 <de6412d4-732c-79cf-ac00-e0fccee44270@gmail.com> <CAEXTbpf=w6qB1X3dYSR=kdJgqNAFW-pRYuiOGuv9WWEtuY47Cw@mail.gmail.com>
In-Reply-To: <CAEXTbpf=w6qB1X3dYSR=kdJgqNAFW-pRYuiOGuv9WWEtuY47Cw@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Mon, 25 Jul 2022 16:25:44 +0800
Message-ID: <CAEXTbpdxj3Yd3dbyAd0Yc+8adCtK1bi=UXt+j7Fbtx6q8xd0RQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias.

Gentle ping on this thread. Any feedback or suggestions?

Regards,
Pin-yen

On Mon, Jul 11, 2022 at 11:09 AM Pin-yen Lin <treapking@chromium.org> wrote:
>
> All we know is that the functions mentioned in the commit message were
> working in 4.19 kernel, but not in the latest kernel tree.
>
> Unfortunately, we don't know which patch breaks the driver.
>
> Best regards,
> Pin-yen
>
> On Thu, Jul 7, 2022 at 10:50 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> >
> >
> >
> > On 21/06/2022 11:18, Pin-Yen Lin wrote:
> > > Move the panel DT node under `aux-bus` node, so it won't use the buggy
> > > `ps8640_bridge_get_edid` to get the display modes. Also, change the
> > > compatible string from "lg,lp120up1" to "edp-panel", so the panel-edp
> > > driver gets the displays modes from the EDID instead of using the
> > > predefined display mode (`lg_lp129qe_mode`) in the driver, which is
> > > actually not working.
> > >
> >
> > Do we need a fixes tag here? I'm not quite sure if we fix an upstream bug here,
> > to be honest.
> >
> > Regards,
> > Matthias
> >
> > > Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> > > ---
> > >
> > > Changes in v3:
> > > - Include more details in the commit message.
> > >
> > > Changes in v2:
> > > - Remove the Fixes tag because this change is not compatible with the
> > >    old kernel versions.
> > >
> > >   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 26 +++++++++++---------
> > >   1 file changed, 14 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > > index 9c75fbb31f98..1e0802a6f6d2 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > > @@ -90,18 +90,6 @@ volume_up {
> > >               };
> > >       };
> > >
> > > -     panel: panel {
> > > -             compatible = "lg,lp120up1";
> > > -             power-supply = <&panel_fixed_3v3>;
> > > -             backlight = <&backlight>;
> > > -
> > > -             port {
> > > -                     panel_in: endpoint {
> > > -                             remote-endpoint = <&ps8640_out>;
> > > -                     };
> > > -             };
> > > -     };
> > > -
> > >       panel_fixed_3v3: regulator1 {
> > >               compatible = "regulator-fixed";
> > >               regulator-name = "PANEL_3V3";
> > > @@ -282,6 +270,20 @@ ps8640_out: endpoint {
> > >                               };
> > >                       };
> > >               };
> > > +
> > > +             aux-bus {
> > > +                     panel {
> > > +                             compatible = "edp-panel";
> > > +                             power-supply = <&panel_fixed_3v3>;
> > > +                             backlight = <&backlight>;
> > > +
> > > +                             port {
> > > +                                     panel_in: endpoint {
> > > +                                             remote-endpoint = <&ps8640_out>;
> > > +                                     };
> > > +                             };
> > > +                     };
> > > +             };
> > >       };
> > >   };
> > >
