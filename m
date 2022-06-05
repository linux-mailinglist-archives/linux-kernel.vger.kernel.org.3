Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C91A53DEDE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 01:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351787AbiFEXBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 19:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiFEXBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 19:01:31 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210384D9C6;
        Sun,  5 Jun 2022 16:01:30 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id o73so4876751qke.7;
        Sun, 05 Jun 2022 16:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nleMcvZk4Jih85JWgwJUKr1i+EvF2q+f7GJQzET+W1k=;
        b=F8xUyrIKUPT3V+jS4LwlRA4oLWAdERUJGg527pOTUFyhFYsivS0V26dS6s7q/XJC+0
         2PZw8s0Uo4h1ouexjwyrdXskB/b931nM557pIHlrpPw0yKwI3YrtdnIf/dEBh+cuXMPC
         vxwlbTxJrXHBG1sl9o7KX3F0mk3mhTsuy59e74aXRNDdMxSqs9mNqzt7Pz2yisRcvdWy
         L2E4ceaWIBWL2dqd/Etb7ILGDdSgQOYnjhXG5pHcRD/VLI72B6Y9RASiEtunR1JAWo/V
         4ZTdwatD5hQHJ2YL6tIgzvZl0KxxwjDRGWfQfizZIJH4zA9tr0CaxfXA9Sw5WPmKUE4P
         aN1Q==
X-Gm-Message-State: AOAM532Y334P5MTbVyGb5GCPiz0tBM2p5xvqe7X3dns5C56x0mwoSgG7
        9xdGcoviEjcHkkj8hS+IYA==
X-Google-Smtp-Source: ABdhPJyacYFtoLAtY41rU4TddnbyNMQJ2gAdcLcoOQncgirbHwAMY3kAtSPCGlPwbV4bi6/l7dAcKg==
X-Received: by 2002:a05:620a:683:b0:6a6:93aa:8559 with SMTP id f3-20020a05620a068300b006a693aa8559mr10987977qkh.94.1654470088985;
        Sun, 05 Jun 2022 16:01:28 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bdb:2e61:f12:452:5315:9c7e])
        by smtp.gmail.com with ESMTPSA id fb11-20020a05622a480b00b002fbf0114477sm9356624qtb.3.2022.06.05.16.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 16:01:28 -0700 (PDT)
Received: (nullmailer pid 3690548 invoked by uid 1000);
        Sun, 05 Jun 2022 23:01:25 -0000
Date:   Sun, 5 Jun 2022 18:01:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-media@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-watchdog@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, Leon Luo <leonl@leopardimaging.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/6] dt-bindings: update Luca Ceresoli's e-mail address
Message-ID: <20220605230125.GA3690493-robh@kernel.org>
References: <20220603155727.1232061-1-luca@lucaceresoli.net>
 <20220603155727.1232061-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603155727.1232061-2-luca@lucaceresoli.net>
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

On Fri, 03 Jun 2022 17:57:23 +0200, Luca Ceresoli wrote:
> My Bootlin address is preferred from now on.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  Documentation/devicetree/bindings/clock/idt,versaclock5.yaml    | 2 +-
>  Documentation/devicetree/bindings/mfd/maxim,max77714.yaml       | 2 +-
>  .../devicetree/bindings/power/supply/maxim,max77976.yaml        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
