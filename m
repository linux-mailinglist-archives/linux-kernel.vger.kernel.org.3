Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6785A28B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbiHZNhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343588AbiHZNhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:37:53 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D69DC5FE
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:37:53 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-33da3a391d8so36803637b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=q8PbLhE/XrUOR16T195SOwGCO0An7Rg3CZvVaNouLwo=;
        b=d7ViihS3RT1OfEGoo4oYHrv/V+/uKTZOrj7Ic20JETLODS3iKrurldpGQaH4tfavaA
         FVHyDxD2J51d1DnGPLI9jwdqxisNsz+BWtwTTsPqUzsJ082z21MPnlXhytd9Ry3F406w
         9kO1KJL94YGxSBbM/PbcuWwJDJ5GOs2/IrkhW78w8S4hEbpXYDzvcDLseAuYC+2WXUiV
         fwj5A34xMY/DZeEhqBpL7mcPDtagwr+3Ghs3tkSS1ESZToDUObC+HLiICL5oNQ3lawAY
         id8NwkHayucOVMBtccc2Z7o2G/z6k3Ho874T+Em9iuydZDhZNKnSRm3y1O8ORrpw5Xxp
         /plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=q8PbLhE/XrUOR16T195SOwGCO0An7Rg3CZvVaNouLwo=;
        b=jrDDekUJrZ6bMqsVwRT+wdxhVTsO/dwdvgPAKnGOQs08of212EmtgBaeXv2rtjGiAi
         0LNlf5O3vWLO0p4J4JHITo+cMSnNEnSsa+JJ3XZ3cKrH+X97DzSiy85Jy7pTPRb9QDiO
         4cH1BYWn1AEu/Y95h188T+SunnKNIt5BwWuMyBMF9cCQHAH0UceHwy/wzlHnDVe2WG45
         kH7NH9u+wXv+uiU0lz0B+XiMBzeNFiNROK7lyz41kuZDQtS7dbx61xYiMVIUhY46d3zB
         c2z1oeSSdhDR2mwio096a3UGYvU7hf8Bv0wc6SJJRlET19dIOsu/5/kv1H7U3Kr4KcXH
         EwGg==
X-Gm-Message-State: ACgBeo17co2Eyzv0mkU/wTfHJR44WWReGvhTWPKhwv8F8YnkCkkOw81J
        9kiw/DEA7lDfQcD08BTtC8mB3Q3EA56qzOn8xUm7w5Nw9zw=
X-Google-Smtp-Source: AA6agR7UhUd0nkWAMhrNEtB1CEuCm4ENhrbVT9L37v2x3KrKvfk3k4bculRKirggTHNvpy4rDZyudPKhDPNU0VuCpCo=
X-Received: by 2002:a05:6902:3c6:b0:694:1088:5448 with SMTP id
 g6-20020a05690203c600b0069410885448mr7683130ybs.410.1661521072408; Fri, 26
 Aug 2022 06:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220825094132.1268174-1-s.hauer@pengutronix.de> <20220825094132.1268174-3-s.hauer@pengutronix.de>
In-Reply-To: <20220825094132.1268174-3-s.hauer@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 15:37:40 +0200
Message-ID: <CACRpkdYL24cJgo9F1nWYzP=8+XywdUXhSedJRQFJ16MUAx7-dQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: gpio: Add gpio-latch binding document
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
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

On Thu, Aug 25, 2022 at 11:41 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:

> This adds a binding for a GPIO multiplexer driver based on latches
> connected to other GPIOs.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Nice overall!

> +++ b/Documentation/devicetree/bindings/gpio/gpio-latch.yaml
> @@ -0,0 +1,83 @@
> +%YAML 1.2

No license?

> +  data-gpios:
> +    description: Array of GPIOs to be used as data GPIOs

Hm I wanted to just call these "gpios" but that is maybe confusing.
What about "latch-gpios"?

Yours,
Linus Walleij
