Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BB0534EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiEZLys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiEZLyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:54:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2143D0286
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:54:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cs3-20020a17090af50300b001e0808b5838so1539889pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOlRt/PLq35j8SMajNj0FDTDNh91sVVa3M4KgwiWbqQ=;
        b=zd0au4Lgdoz2aRLN2jvLLKLH9zvMXKC7gGXmcI9icnPAhk34CDEwXC8fLcybWuHboJ
         7rxHeACAiCPZERtaxnmLpdCNfTBxHfRZMzj9To+gvTpMb6NSjOLAmOQV5q6LFzMi01Sl
         IpdLjTrN7CsSEH+4AD+iKLFYyQu/qcJTgFtm6ePYxPAtGWN+sXU+ML1m6voHOI2hhltd
         botwytBAtuuMlPyQoK142BG3F7FnhdtcqUXkXD2MGAIWtrV2nunx+b3TrzoqDse6q40T
         gy03PePXDweEsulO9ouGVDtRizGwyp7uEUKeBpU2dx0PinI4+kvHfjYyjoZL/NSYXykw
         owrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOlRt/PLq35j8SMajNj0FDTDNh91sVVa3M4KgwiWbqQ=;
        b=LgLJc1QHX/N3YcC+dMPkVBztzABA65P5b6zWhCBdhAv0rnm7zRFguLdefEPt3gSa2G
         PoqJu7TCtImGUzVs9DiA9WAJTopjMQLezT1x+3e5swjuOviAn2FBmPRm0zSzZ4H6bRx5
         P5M3AvHAw2yXMv+cJEFNzYX8yGVxMexzMOlmAuZeH5Cpcr/gqPPCH8oLdLSu/aRJtpFz
         Kxz/CvFg0W1rnIkNGaUFCciXjYqNqP0v/fxqOectEv7d8dWg24JEYLl0vtr4jMSqSRFC
         EylrHfoPdz7whjKCaK9blJC4AlgF34gqwEWY5xDVBbfTdiCWLy8uiu4/iX+J2NzIdX5F
         8Wng==
X-Gm-Message-State: AOAM531Uzi4xTR2vjIuiTPQrQdcdb5Uhz+UaXoiVjOhpG7CoZLRPGv3e
        33AQmhtsotBm4rXoUI2uk34S381QbectGmaAZgKMTQ==
X-Google-Smtp-Source: ABdhPJxS0YxvZlwlwDFVDpQC1dH6jaFKCDD2PL5VdUmx6nXiGO6oYQ37GLmA/TgYfkq07HVyNLKHBrlzHP18ryVswg4=
X-Received: by 2002:a17:902:8f81:b0:161:f4a7:f2fc with SMTP id
 z1-20020a1709028f8100b00161f4a7f2fcmr30616697plo.117.1653566085361; Thu, 26
 May 2022 04:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220525205626.2482584-1-robh@kernel.org> <Yo6u6jcVSsTQvRiU@pendragon.ideasonboard.com>
In-Reply-To: <Yo6u6jcVSsTQvRiU@pendragon.ideasonboard.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 26 May 2022 13:54:34 +0200
Message-ID: <CAG3jFyvynnMfkHFcfLUE=g9pswy1OYiAYi4KVy+aZjGd=NmtGg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: ingenic,jz4780-hdmi: Drop
 undocumented 'ddc-i2c-bus'
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Rob Herring <robh@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2022 at 00:34, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> Thank you for the patch.
>
> On Wed, May 25, 2022 at 03:56:26PM -0500, Rob Herring wrote:
> > While 'ddc-i2c-bus' is a common property, it should be in a connector
> > node rather than the HDMI bridge node as the I2C bus goes to a
> > connector and not the HDMI block. Drop it from the example.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > ---
> >  .../devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml  | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> > index b8219eab4475..89490fdffeb0 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> > @@ -55,7 +55,6 @@ examples:
> >          compatible = "ingenic,jz4780-dw-hdmi";
> >          reg = <0x10180000 0x8000>;
> >          reg-io-width = <4>;
> > -        ddc-i2c-bus = <&i2c4>;
> >          interrupt-parent = <&intc>;
> >          interrupts = <3>;
> >          clocks = <&cgu JZ4780_CLK_AHB0>, <&cgu JZ4780_CLK_HDMI>;
>
> --
> Regards,
>
> Laurent Pinchart

Applied to drm-misc-next
