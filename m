Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA1A518D49
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbiECToI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbiECToB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:44:01 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9647717051
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:40:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p12so32070206lfs.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=PpcOEiHsSXEXVeVpcZFgM2SND6CCz4/z5LeJtfm4WzU=;
        b=JdhHrL0tSQx+VnBMXyJMkfaRUySUx/ACO57L/wJDoQ6hulsCVqtglcHHgih4Q3kmWB
         3CWzf46Zy1MeOKLYeZzswIF+wEnjJBRPpE3pmZ2QhPHij539PYuP5KlSOKO4sB25qGnI
         Nb9EjW+AFVgg4jiksSHD0Uox8x4081Yibnv+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=PpcOEiHsSXEXVeVpcZFgM2SND6CCz4/z5LeJtfm4WzU=;
        b=qLQ/FvHA8Zv6rjFPYZUNzAS9r/sulFjo2P7sEGF9H7Quo8Zwoo7KjvgTwbOrrvHbEC
         4Cux5d7jg/WDS/GEQKggWSKYWwi6ivdXgBCesMAFhLd2BbMQ15NCksKEndmiOCmK+sKm
         SkxT5lwdyOe3gg/uyMcx1Sx/aBOInWPh2ICLDNIS70XrO1gP1OloLZgGgZezW3fhQc1X
         GudRaqIgRtleRHgbmVz7Z+bahz4MjeuAJWXLnNVW2Pv1hom6sKPX2wsptRD5X1svAGdv
         ooYaaKEiwWLwGnRphJ/O5froNdb5oCSs2dQEzFmThHOBGVgSzRsVQNjXW84GdjVMDKQD
         KeJQ==
X-Gm-Message-State: AOAM5306nKQUAwTcGBJRXORHfpZl55XjBb17dIIID+G4bxTHmzOSKkXg
        bjoZeC+zeKut1+ALK+i52EwybmVKnawtmm8IPLoS4A==
X-Google-Smtp-Source: ABdhPJwZ7rKvRJvg+003hnWPuIibNwH4Vp3fTUxcsMHvkAcJNe7sssEHH+Dttxg/YTKAx2walPqk4DPnLgN+bztMLrU=
X-Received: by 2002:a19:ac42:0:b0:448:1f15:4b18 with SMTP id
 r2-20020a19ac42000000b004481f154b18mr12222327lfc.32.1651606825945; Tue, 03
 May 2022 12:40:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 May 2022 12:40:23 -0700
MIME-Version: 1.0
In-Reply-To: <CAD=FV=V8kfRYidvQRmx_XmGm8X3XHR_GxTkKvxkqUHdqJ5CMNg@mail.gmail.com>
References: <20220503042242.3597561-1-swboyd@chromium.org> <20220503042242.3597561-2-swboyd@chromium.org>
 <CAD=FV=V8kfRYidvQRmx_XmGm8X3XHR_GxTkKvxkqUHdqJ5CMNg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 3 May 2022 12:40:23 -0700
Message-ID: <CAE-0n53540_=76amOxOQ0YhutOUke+ZxSaTHCuyAHUGfAVkKKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
To:     Doug Anderson <dianders@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
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

Quoting Doug Anderson (2022-05-03 08:09:04)
> Hi,
>
> On Mon, May 2, 2022 at 9:22 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > @@ -113,3 +135,56 @@ examples:
> >              /* UP      LEFT    */
> >              0x070b0067 0x070c0069>;
> >      };
> > +
> > +  - |
> > +    keyboard-controller {
> > +        compatible = "google,cros-ec-keyb-switches", "google,cros-ec-keyb";
> > +        /* Matrix keymap properties are allowed but ignored */
>
> nit: s/allowed/required/

Ok. I will roll it in and resend.

>
> This now looks reasonable and well explained to me.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks.
