Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E92F5A7D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiHaMkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiHaMk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:40:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB93766133
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:40:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nc14so23170399ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MCBuc3iFnBItgcwahvmF8Fyf/yByT2EhRd1eNSiQSjI=;
        b=ZyGZdtZvlUcVjIqEYoq7QSBtvxtLU54sf8bj9ZWaAW6WJ5+bo/iDixWUKvoWzuj3ah
         2kQSxN6F9EdAOXMasrVeA1rvNKYrJG92yU9BQUwRUSiBQOJZwY28qDThBSdcEPh09pHm
         eaKl5K7VT5xnjIQCn2cquwL/U91c8cfvCkWezWaL11HuJp835rN+qdEJ3IN2kwz+yKk1
         EVz8rhUXBiBGiVq16atOcvL5MJlq1zv1NNfZ5ld2Jt8MSKzFGT55/j1m3kq2GUjY0gVA
         2jh4hutLkDQhnU+QXtX+LDVJrFEeCxa4rJzWIgx7cJX5o6n7NC1WAFTVpN6IBhbqBasa
         aOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MCBuc3iFnBItgcwahvmF8Fyf/yByT2EhRd1eNSiQSjI=;
        b=BAaZvZGbXe3fMENwEQ1eSz6QH0nNholp+JtHLvhLg1I/AOCXb/tyRT9mAewyap9VCz
         SMqD3oH3Ebmu6PyYwsQBAk+Br4xy0nk3QV0XYE2g94oWWUgQ1xrf9WPZKOSW2pLnKe9l
         HTEOy7qRn+DkdVpV0GhBUOU4xRWNlMsRwBtb6jCSk8YsRYChaz24zuLYQm9X33Usv78C
         7wH0FHH1zaT0hBPK+gMXBlT/doe1e0B4VGFIyXhLQYp0485VdgDDqNL52JvoIkm4K2vq
         edU7wmQKI5MSDBB/ylZEogF2sVoHoz+pqUs6/XarmlTfAIJMIat+IRpRLhm74VuplEBI
         a9yg==
X-Gm-Message-State: ACgBeo3+4fts9++w3U86X9Uwb81qZu6vepfIfOAe9rOJ2nSyapjWHpA2
        ZH+tJE8dy17TtjhpK0enOvuJG07RQ6op3EtTKmb04A==
X-Google-Smtp-Source: AA6agR5VjKGidDtLFEn1Gq6NqN0WGj/6ZAB+3gykERCjjCMt8W2xZ7MD4XByi6+Z9ZCivVK/Tp40Ki+UZvj+ZFT5okg=
X-Received: by 2002:a17:907:1c89:b0:741:4453:75be with SMTP id
 nb9-20020a1709071c8900b00741445375bemr14289735ejc.208.1661949625872; Wed, 31
 Aug 2022 05:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220825094132.1268174-1-s.hauer@pengutronix.de>
 <20220825094132.1268174-3-s.hauer@pengutronix.de> <CACRpkdYL24cJgo9F1nWYzP=8+XywdUXhSedJRQFJ16MUAx7-dQ@mail.gmail.com>
 <20220829144032.GC24324@pengutronix.de>
In-Reply-To: <20220829144032.GC24324@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 14:40:13 +0200
Message-ID: <CACRpkdbA3FR_sFrj9FTH3Ui8so-j654wm=5yTMUydZttsU_HMw@mail.gmail.com>
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

On Mon, Aug 29, 2022 at 4:40 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:

> > Hm I wanted to just call these "gpios" but that is maybe confusing.
> > What about "latch-gpios"?
>
> Hm, the clk input is used to latch the current state of the inputs to
> the outputs, so "latch-gpios" might even be confused with the GPIO
> routed to the clk unput of the latch.  Overall, the whole thing is a
> latch, so "latch-gpios" doesn't sound like a good name to distinguish
> the different types of inputs of a latch.  I still like data-gpios best
> as these lines are described as "Data inputs" in my 74273 data sheet.

How about "latched-gpios" (notice the "d")

It makes some semantic sense.

But I will not nitpick, data is fine, just a bit unspecific.

Yours,
Linus Walleij
