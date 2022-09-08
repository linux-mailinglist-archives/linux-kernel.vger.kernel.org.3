Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF88C5B2575
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiIHSQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIHSQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:16:17 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC869C6FF6;
        Thu,  8 Sep 2022 11:16:13 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so12861790otq.11;
        Thu, 08 Sep 2022 11:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=eDGoGCLlcgFGg9hAmkw1n8adhCvK7wFgfBY6+eUsHWg=;
        b=Xkf5CDZWww8/QzRwvhqL4ZMe/qWDxIOisy5xIwiBrIjkejdM+eOHqD+LYP5jnx/eF8
         MyRhNg5xRk9g+kkVidQXDyPDg5v2K6NEbh8+BjFpja1BuVYMjGaO8u/QcdTL2axci4XJ
         JnL7TPohF+fnuzhRBbNP5Yqa47mLURA0NyH6RZOB1WSu0/h5s0o/ajh3L7wwHsEytRPx
         bjKWzht6azrH/i9BTWXVC6rZLRFQQl5IWg+u2SvsGzi1aD/Qku637C7FtDGIPnkkMJLX
         bVojisxDU0PlBvYygaQVSLvZBW5+E4FtkuN3ctNE5PxgOU5rYP3azms2ssqJb6cBXD2N
         LnAA==
X-Gm-Message-State: ACgBeo0R/7E6QFfdfI7Qx1dH7GkSloqxi7fkkUI43KJV9ngj5Zpq0sS8
        v87qwx2nj1TV+XsIxbQwDg==
X-Google-Smtp-Source: AA6agR42S8+FgwPtXh3ZFOSPxpzL1Jh449dSw+4HdwAQ39gFsTEn0b/1gn71yDHQSy3W8UBgeYRQyw==
X-Received: by 2002:a05:6830:3482:b0:638:92b7:f09b with SMTP id c2-20020a056830348200b0063892b7f09bmr3854213otu.140.1662660973077;
        Thu, 08 Sep 2022 11:16:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n26-20020a4ac71a000000b0044528e04cdasm6514800ooq.23.2022.09.08.11.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:16:12 -0700 (PDT)
Received: (nullmailer pid 3001911 invoked by uid 1000);
        Thu, 08 Sep 2022 18:16:11 -0000
Date:   Thu, 8 Sep 2022 13:16:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Olliver Schinagl <oliver+list@schinagl.nl>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Daniel Mack <daniel@zonque.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: leds: Expand LED_COLOR_ID definitions
Message-ID: <20220908181611.GA3001858-robh@kernel.org>
References: <20220830134613.1564059-1-oliver@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830134613.1564059-1-oliver@schinagl.nl>
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

On Tue, 30 Aug 2022 15:46:13 +0200, Olliver Schinagl wrote:
> In commit 853a78a7d6c7 (dt-bindings: leds: Add LED_COLOR_ID definitions,
> Sun Jun 9 20:19:04 2019 +0200) the most basic color definitions where
> added. However, there's a little more very common LED colors.
> 
> While the documentation states 'add what is missing', engineers tend to
> be lazy and will just use what currently exists. So this patch will take
> (a) list from online retailers [0], [1], [2] and use the common LED colors from
> there, this being reasonable as this is what is currently available to purchase.
> 
> Note, that LIME seems to be the modern take to 'Yellow-green' or
> 'Yellowish-green' from some older datasheets.
> 
> [0]: https://www.digikey.com/en/products/filter/led-lighting-color/125
> [1]: https://eu.mouser.com/c/optoelectronics/led-lighting/led-emitters/standard-leds-smd
> [2]: https://nl.farnell.com/en-NL/c/optoelectronics-displays/led-products/standard-single-colour-leds-under-75ma
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes since v3: Fix typo in purple; Fix whitespacing
> No changes since v2: Re-send with the proper e-mails.
> Changes since v1: Unbreak existing definitions.
>  include/dt-bindings/leds/common.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Applied, thanks!
