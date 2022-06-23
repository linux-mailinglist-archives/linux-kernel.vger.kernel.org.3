Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D845588A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiFWTZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiFWTZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:25:11 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A2549692
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:37:20 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id l11so471745ybu.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+06H+RDgwvHqnW/mu3jxtp3uKGDdYaMeztRhDlRy+2Y=;
        b=M2d16jISsGOMxbNgUi6CrTcuiHAo8b4VfVws/IvmWXbja3y8S3/EyTmrk2MgkxQb58
         D8/UBc0Y2FUWCcofnX3ffMY/En+VFhCoVFWi4pUYKiISYOQr5gW818W1LIdjbVOEQO2F
         6fxHdW0MNcHURmuzQzoO4ksxV1gUf3uUQJ7C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+06H+RDgwvHqnW/mu3jxtp3uKGDdYaMeztRhDlRy+2Y=;
        b=XnTOFtCPx6FEcPzr8zbvSGFbwqPBysstxlR1JQb66+T1G0EYC6RGH+9omvgmHrV+b1
         80ep3pWbwCxFGnoE83VXPXcnfXu+Km+oeHtWN1CfTb2e0FDSwnrhh9ksiR/6GKnMEseN
         /Lo6vTczAg7ADoNP5SJ8yfsqyXgdPb4dyr8UbPnpvc94rx4Jbeollh53+797qY1ehXHz
         js9+pEYedidJNQU1llSTFZ41yyOcgfTkUDYNxgYwFH6yfS9IqfqjImm8yDEQmvx4zErm
         Ra3sH1GFAF9+gGwkrTjDv805Zyr523DofaMhoQ8PL+hMKVvagHosIFCyHTQdE9mvBp08
         GruQ==
X-Gm-Message-State: AJIora8B3BP1JyG9oLxhSpRF0dxeBmLmVfCywQEyDzPsuywMx8e9MpHD
        GdHsvpDvqMIffTz2FM6iCOGSYA1L13wT2UX89r5QFQ==
X-Google-Smtp-Source: AGRyM1tJ0GnhcxV8bocJAnR76WzFGYTbHrhGTY+yB5tG8hUuyoQw0mZK9As6rHzHY1b4q130MyyvmWi36ZZuF6FRnyI=
X-Received: by 2002:a25:9d89:0:b0:669:31d4:7cd9 with SMTP id
 v9-20020a259d89000000b0066931d47cd9mr10937558ybp.294.1656009439543; Thu, 23
 Jun 2022 11:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-7-pmalani@chromium.org> <CAE-0n51d4S3T+_f+YXsu3es7AMxuyFORSXFQe2LTSkZB4C56Ng@mail.gmail.com>
In-Reply-To: <CAE-0n51d4S3T+_f+YXsu3es7AMxuyFORSXFQe2LTSkZB4C56Ng@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 23 Jun 2022 11:37:08 -0700
Message-ID: <CACeCKaduttgNfxyzE2_7eD1N4NLNp_8J1EaWTnn+eqp+_P-i1A@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] dt/bindings: drm/bridge: it6505: Add mode-switch support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Pin-Yen Lin <treapking@chromium.org>,
        Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
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
        <nfraprado@collabora.com>, Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
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

On Thu, Jun 23, 2022 at 11:24 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Prashant Malani (2022-06-22 10:34:35)
> > From: Pin-Yen Lin <treapking@chromium.org>
> >
> > ITE IT6505 can be used in systems to switch USB Type-C DisplayPort
> > alternate mode lane traffic between 2 Type-C ports.
>
> How does it work? From what I can tell from the information I find when
> googling this part[1] and looking at the existing binding doc is that
> this device is a DPI to DP bridge, and it outputs DP (probably 4 lanes
> of it?). Does the 2 type-c port design work by transmitting DP on two
> lanes of DP for one type-c port and another two lanes of DP for the
> other type-c port?
>
> DP could be one lane, so if this device is able to output one lane on
> any output differential pair then I suspect it could support 4 type-c
> ports if the hardware engineer connected it that way. Can you confirm my
> suspicion?

I will let Pin-Yen comment re: this hardware, but 1-lane DP is not a
supported Type-C Pin assignment
(as per VESA DP Alternate Mode Spec version 2.0 [2]), so the H/W
configuration you are suggesting shouldn't be possible.

>
> [1] https://www.ite.com.tw/en/product/view?mid=45
