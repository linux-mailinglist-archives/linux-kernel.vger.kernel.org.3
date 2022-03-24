Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BC54E693B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352917AbiCXTWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244003AbiCXTWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:22:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB87FB82EF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:21:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u22so4705449pfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hCdN7j/E0Rbp0JoQeqtUx61RDuGAMFdads/ZyG7JtMg=;
        b=LKGfUYciftDqwAhSC+a6t1WzBBlu3hQlOcjFm7lPZXy6Fm4vL9wnmmnOCtUlkqsP+i
         7XDstWeC29wOTTa0uVJvGjx6qGaDbEj2xFOLkX3gaTl/7g7qlVGVB8ug0UCUGoyWZf3x
         /Hr+Ju0vhJdSqubL/dmyGUh0qHPae+3UGE5/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hCdN7j/E0Rbp0JoQeqtUx61RDuGAMFdads/ZyG7JtMg=;
        b=NfScSeqV1BXs4jbrnQAjViFDMJCpSLJTlJKXxWhhPIXdm3PxJN5i/dqsb3KTx19rLv
         knw1HTc1Uq+iIpAZ+DaX7RrX8wqXF9cEcwcYLRn5mgsiOYgG3SU0nnrndqBep2YVrYIk
         9J52WpVvt92MSwhfa4x1cEnULbYpSiwkRmDJUIb2oTomK8WXRcLaQHxXzghgThL9xH8n
         DRKZot5juOodsAuVaNFRy3K8JnC/GSjGWqcTg+xjjs9wIimUTDmH7Ja8HSCFt9HBQmRd
         ZZ39k/sexuUd7Jh09IKNlqBw56xYSB3FmG+RmI+GRAlYXMMynv0La/i3ybJO/3jDZRDx
         aIMw==
X-Gm-Message-State: AOAM530BNHMW1Tz1LccVSmY5Bpf7lA8Og9UMBJ4Wtj9ZV1qdmZoXTa8P
        4eWJp2r0efOqCsLZx6QbBU2OdQ==
X-Google-Smtp-Source: ABdhPJwW+r9IMlIFvJh7a1lw+TfPeEt8fCWqBqcwetjMPcSN7Frtyr/omNTa7epfL/a076QJyCY9Jw==
X-Received: by 2002:a63:1b42:0:b0:381:6ff8:76a0 with SMTP id b2-20020a631b42000000b003816ff876a0mr5190186pgm.220.1648149668229;
        Thu, 24 Mar 2022 12:21:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:690f:642:3ebe:c89d])
        by smtp.gmail.com with UTF8SMTPSA id s15-20020a17090a880f00b001c6b0114038sm3642131pjn.4.2022.03.24.12.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 12:21:07 -0700 (PDT)
Date:   Thu, 24 Mar 2022 12:21:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/panel-edp: Add AUO B133UAN01
Message-ID: <YjzEoqfHebYuiuKl@google.com>
References: <20220324111335.1.I1131d63cbefbfa9ff107a284e2e51f880c5bf7c8@changeid>
 <20220324111335.2.I816014b6c62da5a33af5021f3cc35cea66552c00@changeid>
 <CAD=FV=X_a9aU0ZvXg1AkGS5j1oKDJmPdZt0Hs22eEcWWczTe_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=X_a9aU0ZvXg1AkGS5j1oKDJmPdZt0Hs22eEcWWczTe_A@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Thu, Mar 24, 2022 at 11:27:46AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Mar 24, 2022 at 11:14 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Add support for the AUO B133UAN01 13.3" WUXGA panel.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > output of edid-decode:
> >
> >   Block 0, Base EDID:
> >     EDID Structure Version & Revision: 1.4
> >     Vendor & Product Identification:
> >       Manufacturer: AUO
> >       Model: 34196
> >       Made in: 2020
> >     Basic Display Parameters & Features:
> >       Digital display
> >       Bits per primary color channel: 8
> >       DisplayPort interface
> >       Maximum image size: 29 cm x 18 cm
> >       Gamma: 2.20
> >       Supported color formats: RGB 4:4:4
> >       First detailed timing includes the native pixel format and preferred refresh rate
> >     Color Characteristics:
> >       Red  : 0.6513, 0.3271
> >       Green: 0.2900, 0.6279
> >       Blue : 0.1503, 0.0517
> >       White: 0.3134, 0.3291
> >     Established Timings I & II: none
> >     Standard Timings: none
> >     Detailed Timing Descriptors:
> >       DTD 1:  1920x1200   60.026 Hz   8:5    74.192 kHz 156.100 MHz (286 mm x 178 mm)
> >                    Hfront   16 Hsync  16 Hback 152 Hpol N
> >                    Vfront    3 Vsync  14 Vback  19 Vpol N
> >       Manufacturer-Specified Display Descriptor (0x0f): 00 0f 00 00 00 00 00 00 00 00 00 00 00 00 00 20 '............... '
> >       Alphanumeric Data String: 'AUO'
> >       Alphanumeric Data String: 'B133UAN01.0 '
> >
> >  drivers/gpu/drm/panel/panel-edp.c | 32 +++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> 
> I can review this patch and it can be landed if you really need it,
> but I'd prefer not to. Instead I'd rather see the panel added to
> _just_ the "edp_panels" structure. That maps the panel ID to the
> delays. If we do it that way:
> 
> 1. We don't need the binding.
> 
> 2. We don't need to hardcode the mode in this file.
> 
> 3. We support second sourcing the panel.
> 
> 4. We simplify our device tree files.
> 
> 
> Let me know if we can just go that way. If we really have a reason to
> support the old hardcoded mode we can land something like this but I'd
> rather avoid it if possible.
> 
> Also: note that even if we land this, adding the entry to the
> "edp_panels" structure would help future-proof us a bit.

Thanks for your suggestion, it seems it should be possible to support the
panel as you described, which I agree is preferable. I'll send a new
version without the binding and the hardcoded mode.
