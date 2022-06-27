Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D9455DE27
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbiF0WCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242227AbiF0V7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:59:39 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B411CB2E;
        Mon, 27 Jun 2022 14:57:23 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id k15so11056093iok.5;
        Mon, 27 Jun 2022 14:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GByTRovhreeBVcySF/6td5WnIoeUKJH8EVN0W2QYucY=;
        b=gKrkD2reMY/KvDMNmxPtPyaMIMGlcP6HoJqXkBmqHnn04hPHz2i/8r1TDiliJO/sbr
         0dz7kye4gnFG/XdWBTxshmvciOpz7YwE3JP8Is/CqQ3CyqgGsDjCoRC7/ZwAlLKwv2mc
         WtOL+AgSnzAgrkOCrJ2iGDj9k+FYRQvt7B/78WKbbVxmWirNvoalQBdYRQ5ZBdJp6nll
         tksE+q1YLZJHe8Rt9hV2RQOcCGCz0i+6vdWE2GuOvhbvzVAgX/78MZh8mpZj6XOxQSHF
         b5S+IRvb65Hi0tbtbcjSeOEEKr3Uq2F4IGlEueK3JiXPPvIEvRn7Y21xpF+7eZHzOXRM
         bkTg==
X-Gm-Message-State: AJIora+KgyI+qr/WxduJ+t/AmOf4fJHsIdq42z9VHgIzHWuCEQ+vbTV5
        44rac9ISt2UGdSDKbqw5aKQckFNjyQ==
X-Google-Smtp-Source: AGRyM1uMna/0ZhSmeNlsBB7VjCYVusraceaPQMcCVlLmwH+8k6NuzZefhWbziP1Ag2HjwKDfsksPdg==
X-Received: by 2002:a02:c619:0:b0:339:bc5a:205e with SMTP id i25-20020a02c619000000b00339bc5a205emr9510427jan.184.1656367042314;
        Mon, 27 Jun 2022 14:57:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h8-20020a92d848000000b002da9f82c703sm956479ilq.5.2022.06.27.14.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:57:21 -0700 (PDT)
Received: (nullmailer pid 3036027 invoked by uid 1000);
        Mon, 27 Jun 2022 21:57:20 -0000
Date:   Mon, 27 Jun 2022 15:57:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: cros-ec: Add ChromeOS fingerprint
 binding
Message-ID: <20220627215720.GA3004792-robh@kernel.org>
References: <20220614195144.2794796-1-swboyd@chromium.org>
 <20220614195144.2794796-3-swboyd@chromium.org>
 <CAD=FV=UU-AENyChCvVAKH709E4hFtgo4Txa8zFDY=JM1UifA0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UU-AENyChCvVAKH709E4hFtgo4Txa8zFDY=JM1UifA0g@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 03:41:25PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jun 14, 2022 at 12:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Add a binding to describe the fingerprint processor found on Chromebooks
> > with a fingerprint sensor. Previously we've been describing this with
> > the google,cros-ec-spi binding but it lacks gpio and regulator control
> > used during firmware flashing.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: <devicetree@vger.kernel.org>
> > Cc: <chrome-platform@lists.linux.dev>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Craig Hesling <hesling@chromium.org>
> > Cc: Tom Hughes <tomhughes@chromium.org>
> > Cc: Alexandru M Stan <amstan@chromium.org>
> > Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> > Cc: Matthias Kaehlcke <mka@chromium.org>
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  .../bindings/chrome/google,cros-ec-fp.yaml    | 97 +++++++++++++++++++
> >  .../bindings/mfd/google,cros-ec.yaml          |  9 ++
> >  2 files changed, 106 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml
> > new file mode 100644
> > index 000000000000..48c02bd4585c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/chrome/google,cros-ec-fp.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ChromeOS Embedded Fingerprint Controller
> > +
> > +description:
> > +  Google's ChromeOS embedded fingerprint controller is a device which
> > +  implements fingerprint functionality such as unlocking a Chromebook
> > +  without typing a password.
> > +
> > +maintainers:
> > +  - Tom Hughes <tomhughes@chromium.org>
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: google,cros-ec-spi
> > +  required:
> > +    - compatible
> > +    - boot0-gpios
> 
> I've never personally used "select" before and I'm not sure where it's
> documented. 

Documentation/devicetree/bindings/writing-schema.rst

> Without knowing anything, it seems weird to me that in
> this file we're matching against a compatible that's not
> google,cros-ec-fp. Randomly grabbing some other example that's similar
> (panel-lvds.yaml) looks more like what I would have expected. AKA in
> this file:
> 
> select:
>   properties:
>     compatible:
>       contains:
>         const: google,cros-ec-fp
>   required:
>     - compatible
> 
> ...and then in the other file:
> 
> select:
>   properties:
>     compatible:
>       contains:
>         const: google,cros-ec-spi

What about i2c and rpmsg variants?

>   not:
>     properties:
>       compatible:
>         contains:
>           const: google,cros-ec-fp
>   required:
>     - compatible

That is what is needed assuming the binding stands as-is. Otherwise, 
boot0-gpios erroneously present or missing will give unexpected results.

If we were starting from scratch, I would say you should just drop 
'google,cros-ec-spi' from this binding. But I guess you want to preserve 
compatibility here. In that case, I think all this should be added to 
the existing doc with an if/then schema for conditional parts. That also 
avoids defining the common properties twice or moving them to a common, 
shared schema.

Rob
