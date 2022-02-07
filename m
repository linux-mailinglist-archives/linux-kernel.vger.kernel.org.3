Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840604ACB8C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbiBGVqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbiBGVp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:45:59 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BDBC061A73;
        Mon,  7 Feb 2022 13:45:58 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so4796943ooi.2;
        Mon, 07 Feb 2022 13:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QOxTpsiItYIgn973R83OB/6cA8BtGbALp2vvEgGAMiM=;
        b=CfNhF73zLktFWh0CCodH8HcBg31oeoLszNWSKQiX/HNCN9kNV8IwoA574Cl1Hi+s3S
         fOwhhm2zi17r42KlanyrtqpQKlhtntn3DVSn/HZTiP9q56aN8uRk9nVtErbmOy2K58N6
         E0hgq+J08DnlkprMw+Zj9LURLqcE1qdty6ahASjaj+Ob+xh2SLP8tQcCizVwzcZXSvVg
         3of6loll9gkp7uZcPXhvVOH3ZOqNCz38JNBVlG7Oy5UMy26NmY1qZHf7aHRT+gqIyA+n
         w9ZBDdZJ0MwlG9YUnwZFPVjLJD+9pJLThRtnaYnMFYsjz5Z1QkseXMGYPSH07nwKyDjj
         rrJQ==
X-Gm-Message-State: AOAM532iNLTgYwatw6oldYeweVh8wPY/54udMzi9yM9m6i0cOiEeG6QN
        7qJ7XWEohfrV9bzdRBOSYA==
X-Google-Smtp-Source: ABdhPJxjjb8hTz7JrQNc/dwzSDalOZbNtl/l3u7RMYurH9/W708famAbJ2Dk4CF7ZuFBAkYyOEv59Q==
X-Received: by 2002:a05:6870:3896:: with SMTP id y22mr323481oan.171.1644270357696;
        Mon, 07 Feb 2022 13:45:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i1sm1419831ood.32.2022.02.07.13.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:45:56 -0800 (PST)
Received: (nullmailer pid 978810 invoked by uid 1000);
        Mon, 07 Feb 2022 21:45:55 -0000
Date:   Mon, 7 Feb 2022 15:45:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: rtc: sun6i: Add H616, R329, and D1
 support
Message-ID: <YgGTE/vLUBctPo17@robh.at.kernel.org>
References: <20220203021736.13434-1-samuel@sholland.org>
 <20220203021736.13434-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203021736.13434-3-samuel@sholland.org>
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

On Wed, 02 Feb 2022 20:17:32 -0600, Samuel Holland wrote:
> These new RTC variants all have a single alarm, like the R40 variant.
> 
> For the new SoCs, start requiring a complete list of input clocks. The
> H616 has three required clocks. The R329 also has three required clocks
> (but one is different), plus an optional crystal oscillator input. The
> D1 RTC is identical to the one in the R329.
> 
> And since these new SoCs will have a well-defined output clock order as
> well, they do not need the clock-output-names property.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v3:
>  - Add/fix several maxItems attributes for clocks and clock-items
> 
> Changes in v2:
>  - Properly update the DT binding clocks and clock-names properties.
> 
>  .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml | 76 ++++++++++++++++++-
>  include/dt-bindings/clock/sun6i-rtc.h         | 10 +++
>  2 files changed, 83 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/clock/sun6i-rtc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
