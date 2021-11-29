Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC88E46233B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhK2V3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:29:09 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:46802 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhK2V1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:27:08 -0500
Received: by mail-ot1-f53.google.com with SMTP id 98-20020a9d086b000000b0057a403bbd4eso2762973oty.13;
        Mon, 29 Nov 2021 13:23:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dmREQEVCQ41yGFn0gHzS27UhG+OxJeV/G0e6YBc3FUI=;
        b=1NEi8KsdJNNjbfQXCnrcvk934ZVbZzHee/jEJfz9KPMzobXFtgccQLmNrUobWUOqhc
         dlN0RxzZmYKT6LBhZz0rM+OvmxpJhEdtF5WianyGRqYmdjuLjGRAWECWuGOzBnPmkCPE
         nHZplgMZtVXT6s3OGyH+370qrnTSvF4Vd2vz4bhJZOV9+hjaWQjLwkZkdGVk4lwbGaA4
         AXjmp4EI8Hm+mUxu6vSL3Qc1DoNx8ZssFa4FCrf9L2lDp3EfDWt2mMF1K1Cl8NG035iT
         7YqtGTyh9iNmZTFucLnGH/ahpKU2ooVzEKJqB5DBhJS8o1MeOXheBSVvSDlkNnR8XNJ2
         jxaA==
X-Gm-Message-State: AOAM533Vvy4GvFlh0QNb4Erbc88R9cNeAhvfqzGZts9uMLVP6l6lnEVH
        bjpMATKtvFWoSBZzznSKp/OIt+e3kA==
X-Google-Smtp-Source: ABdhPJzhJ81ob8F3Ax4aT7ILoDVlOxASMklkW3tRSMVHdzBd6nW5UiTymt1TntIJM64Ho3oULKmUGQ==
X-Received: by 2002:a05:6830:19c5:: with SMTP id p5mr45778794otp.195.1638221029526;
        Mon, 29 Nov 2021 13:23:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r3sm2811284oti.51.2021.11.29.13.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 13:23:48 -0800 (PST)
Received: (nullmailer pid 634142 invoked by uid 1000);
        Mon, 29 Nov 2021 21:23:48 -0000
Date:   Mon, 29 Nov 2021 15:23:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net, marcan@marcan.st,
        alyssa@rosenzweig.io, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Add Apple Watchdog
Message-ID: <YaVE5IL7oO3Q4u5h@robh.at.kernel.org>
References: <20211113094732.73889-1-sven@svenpeter.dev>
 <d3cad37524f7debf@bloch.sibelius.xs4all.nl>
 <fc541162-928c-4318-bc2a-06da0cbdf5e8@www.fastmail.com>
 <d3cad4a2f2f05eef@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3cad4a2f2f05eef@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 12:58:20PM +0100, Mark Kettenis wrote:
> > Date: Sun, 14 Nov 2021 12:40:48 +0100
> > From: "Sven Peter" <sven@svenpeter.dev>
> > 
> > On Sat, Nov 13, 2021, at 22:07, Mark Kettenis wrote:
> > >> From: Sven Peter <sven@svenpeter.dev>
> > >> Date: Sat, 13 Nov 2021 10:47:31 +0100
> > >> 
> > >> Apple SoCs come with a simple embedded watchdog. This watchdog is also
> > >> required in order to reset the SoC.
> > >> 
> > >> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > >> ---
> > >>  .../bindings/watchdog/apple,wdt.yaml          | 52 +++++++++++++++++++
> > >>  MAINTAINERS                                   |  1 +
> > >>  2 files changed, 53 insertions(+)
> > >>  create mode 100644 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> > >> 
> > >> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> > >> new file mode 100644
> > >> index 000000000000..e58c56a6fdf6
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> > >> @@ -0,0 +1,52 @@
> > >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >> +%YAML 1.2
> > >> +---
> > >> +$id: http://devicetree.org/schemas/watchdog/apple,wdt.yaml#
> > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >> +
> > >> +title: Apple SoC Watchdog
> > >> +
> > >> +allOf:
> > >> +  - $ref: "watchdog.yaml#"
> > >
> > > I believew this should be:
> > >
> > >   - $ref: /schemas/watchdog/watchdog.yaml#
> > >
> > > with that fixed:
> > >
> > > Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> > >
> > 
> > Thanks for the review!
> > Almost all the other YAML watchdog bindings just use '$ref: "watchdog.yaml#"'.
> > Only arm,sp805.yaml uses '$ref: /schemas/watchdog/watchdog.yaml#'.
> 
> Hmm, maybe it is ok since the file can be found in the same directory.
> Guess it is up to robh then.  Feel free to keep my Reviewed-by
> regardless.

Either way is fine. It's just ../ paths I want to avoid.

Rob
