Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39A653DEE5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 01:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351805AbiFEXEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 19:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiFEXEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 19:04:10 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BDE37BCC;
        Sun,  5 Jun 2022 16:04:10 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id s10so6132876qvt.8;
        Sun, 05 Jun 2022 16:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PQ86WMtQWZtiSCCUV0t2mZwhMOZMEYWoxSVQTAw8avI=;
        b=AmRluNomWSrH8h9MrGT3LA4kPVPUGE0frL/6r66BxjjKMiquWjS3IuONJhCcnwUFGF
         tU3n/C5jZ/5tIYZQ1QaWR+3pet2oZUhP+h7ZDxodxvvR+qwh+y83Q1evk1BVRU40IevH
         Iqxn1XRxV84iIUOzeGsk7nMfv2UZqBiGPZ9YFPMcqIwSo1g76PgMBTbJAMN1wYPCiFpx
         jnMS7Ehb0xqphef0W8XBFuGuOe/w8ZZEMh6fvTxwtTvcx5CK9A2lvVSi0ce9EqIZfzXM
         41K2TTVirM/afUE4cGr2l8nCHlO/BMjkT5MS+RpdM40MyM9xWK2woU5Y+JEy/GaiDE0V
         pdPA==
X-Gm-Message-State: AOAM531xbOdoX7UrD/K7LgDvJ51Fqh1WAmcLoJwYe9qEN4Z60WUefwT0
        OPju4peITtq77e6Lk7OV1Wh3xBQFaw==
X-Google-Smtp-Source: ABdhPJw8o4qYBHW4CaM8n7loO8vPejDTZL9r68n+Z50Xa/JCRCy726BVnoeF1wKhs0xUySvy2IwPyw==
X-Received: by 2002:a05:6214:29c6:b0:466:fda7:8279 with SMTP id gh6-20020a05621429c600b00466fda78279mr15387044qvb.32.1654470249321;
        Sun, 05 Jun 2022 16:04:09 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bdb:2e61:f12:452:5315:9c7e])
        by smtp.gmail.com with ESMTPSA id q19-20020a05620a0d9300b006a68fdc2d18sm7459600qkl.130.2022.06.05.16.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 16:04:09 -0700 (PDT)
Received: (nullmailer pid 3694907 invoked by uid 1000);
        Sun, 05 Jun 2022 23:04:04 -0000
Date:   Sun, 5 Jun 2022 18:04:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-pm@vger.kernel.org, Leon Luo <leonl@leopardimaging.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-clk@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/6] dt-bindings: update Luca Ceresoli's e-mail address
Message-ID: <20220605230404.GA3694857-robh@kernel.org>
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

Applied, thanks!
