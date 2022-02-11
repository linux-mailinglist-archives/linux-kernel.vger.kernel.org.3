Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4524F4B278B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350705AbiBKOLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:11:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350715AbiBKOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:11:15 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572A8DE1;
        Fri, 11 Feb 2022 06:11:14 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso10427133ooi.1;
        Fri, 11 Feb 2022 06:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=becK90zSagIE/vmdgZ2NZa5JnCyjlMT3936wKWpj1L8=;
        b=QNXCUXAgLY1lQHMw3Jk1BEe5iYD8+zGsxOciIXK1Hz7/L2B0MEoJ24Fgy4cyASyfDU
         pzyNnnVl6WEkR+dJw81UVGnu8U0+XSND4zCf8WhYe0ZeeVox7WiyZqHmFzPxOA3jQhWm
         Jr17bjmbd/RIEnquOtpTDKxm3qrwxJcCePDMy7M6PQNkijHIy8fs9nSfo0yBzss3Z7Ol
         HX3g0ltsR48TVC2RAYLojpAXjH5E2rvfnNgMFK2QbwDmVSjgCKZt3PrRf43huJxdaSxp
         +8iDEvsRrrPE2u6pvGtRcZb3xT6Kz1/7iLqilOpQrtgsLxEibB0Ji6CBUD60HG8h8u0p
         NMmA==
X-Gm-Message-State: AOAM532oi1Ol8oagjrGtfVcNYXWO/v458kgIuBlUJx5dVExPSvz/l2uK
        s0NHVCaLjDuhpMSz7l1yMf36ECx/Tg==
X-Google-Smtp-Source: ABdhPJySlAkAErddhsD8rVETpoEppcfPmvHPSOTOjNwsQ8abxTVr0RtEPRSrskH9JfAcJ68wUgzMxA==
X-Received: by 2002:a05:6870:5303:: with SMTP id j3mr190932oan.51.1644588673591;
        Fri, 11 Feb 2022 06:11:13 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d7:a802:e6b0:6d9c:32f7:4bd9])
        by smtp.gmail.com with ESMTPSA id eh38sm5106803oab.36.2022.02.11.06.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:11:12 -0800 (PST)
Received: (nullmailer pid 288855 invoked by uid 1000);
        Fri, 11 Feb 2022 14:11:11 -0000
Date:   Fri, 11 Feb 2022 08:11:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] dt-bindings: clock: ti: Add clock-output-names for
 TI composite clocks
Message-ID: <YgZufwm5VekH7EB0@robh.at.kernel.org>
References: <20220203112337.19821-1-tony@atomide.com>
 <20220203112337.19821-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203112337.19821-3-tony@atomide.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2022 13:23:37 +0200, Tony Lindgren wrote:
> For the TI composite clocks, we currently have only the divider clock
> list clock-output-names as an optional devicetree property. Let's add
> clock-output-names for all the TI composite clock bindings.
> 
> This allows us to use clock-output-names for the clockctrl instance name
> instead of relying on a custom compatible or non-standard node names.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Tero Kristo <kristo@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/clock/ti/clockdomain.txt     | 3 +++
>  Documentation/devicetree/bindings/clock/ti/composite.txt       | 3 +++
>  .../devicetree/bindings/clock/ti/fixed-factor-clock.txt        | 1 +
>  Documentation/devicetree/bindings/clock/ti/gate.txt            | 1 +
>  Documentation/devicetree/bindings/clock/ti/interface.txt       | 1 +
>  Documentation/devicetree/bindings/clock/ti/mux.txt             | 1 +
>  6 files changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
