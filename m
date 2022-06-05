Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C577C53DECA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351753AbiFEWwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348554AbiFEWwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:52:50 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64A431DEF;
        Sun,  5 Jun 2022 15:52:49 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f2cbceefb8so17236302fac.11;
        Sun, 05 Jun 2022 15:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5PuEYy4kb2UhfUYggdOyvBx1jx2H1KFhJiPSEvKIeFs=;
        b=lpGYNlwlxNsnCtKnfVsM0Ivps1Hc7s7cuvdZutdHh0NXPyQoT2bIvNsr2ItTsqj64H
         wpY2D4EIDQXZqEowLU31ZjWrvQ/t51iQXBXMrZf+agnarSX4IsLTUrMfrScGtS55cq3K
         vA2i7P9gtc+tdGV/38ccW0yldpFrsWjCetSZ2JhC4vCEsRi5bkJJ/6/w5zzdVGMvRM6H
         F8pBm/9j1v/des9qlkUf+DCjcerg5WZMzJ3lPhv8R/IYoSLe+T78OKkHx+LrTphDdyjJ
         Touigx19Jys/pV0YEp35f1nm6V4nDa6YSr6Xz4mdD/0Kr7qnP+5IzDyayQ+jFllW56W4
         0nqg==
X-Gm-Message-State: AOAM533YlbHC/vLqpx29doaBhbrln09tRz3XoSDIdv6LdCE97Fe7As2i
        XGc+Wgi53FKAXMHk8FbIJA==
X-Google-Smtp-Source: ABdhPJy8SpvKnrwzpnyeWEflQchEZgnIF0V7sEn4UgOSMvWXRkdK4sNBtJnziMse/ttDT3L05DIg4g==
X-Received: by 2002:a05:6870:3454:b0:f2:1d65:1319 with SMTP id i20-20020a056870345400b000f21d651319mr29049594oah.120.1654469569177;
        Sun, 05 Jun 2022 15:52:49 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bdb:2e61:f12:452:5315:9c7e])
        by smtp.gmail.com with ESMTPSA id z18-20020a9d62d2000000b0060bf670dd35sm1440855otk.49.2022.06.05.15.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 15:52:48 -0700 (PDT)
Received: (nullmailer pid 3676160 invoked by uid 1000);
        Sun, 05 Jun 2022 22:50:46 -0000
Date:   Sun, 5 Jun 2022 17:50:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linux-pm@vger.kernel.org, wens@csie.org, brgl@bgdev.pl,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        linux-gpio@vger.kernel.org, sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        lars@metafoo.de, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, lee.jones@linaro.org
Subject: Re: [PATCH 04/10] dt-bindings: power: supply: axp20x: Add AXP192
 compatible
Message-ID: <20220605225046.GA3676080-robh@kernel.org>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-5-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603135714.12007-5-aidanmacdonald.0x0@gmail.com>
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

On Fri, 03 Jun 2022 14:57:08 +0100, Aidan MacDonald wrote:
> The AXP192's USB power supply is similar to the AXP202 but it has
> different USB current limits.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  .../bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml  | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
