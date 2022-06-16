Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8226854E5CB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377610AbiFPPPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiFPPPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:15:01 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25FF1FCC5;
        Thu, 16 Jun 2022 08:15:00 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id h7so1122442ila.10;
        Thu, 16 Jun 2022 08:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=biXCDQT90ObJ6hyRTS7k12rAG7yzeSvs6GnS6eorWy4=;
        b=4KFni0JUHy/RXePEgug3lRYdrB/T3gWGyRUi1151sGPri6b+rvBu7RKG5zvX4vpsmi
         9sSVxq4Hvty5mYp86O74xKyaDYf4MGlc/eGkxDKU8fYsbMlw7SkBHI5M19ky3VmTRlwy
         sC/oUJN5LHxjuhM7fSODk8XO2v+jE4bl9nsDLhuKF/P0svMZ24NxMKCYOm4mzgTWtrtL
         rvZzNyiYvHXEptWdmrQNYRe6MYGdb66IuMDSE4EstVUA+z0+xLxFP8UQHFQGoC3pt5ta
         wvN0a89/DVWXp/IaA7v/ID8edocSguDB6RI/DvNrtPQMb6bp3zR9XJrO8cjmIOD+zjS6
         znYg==
X-Gm-Message-State: AJIora8tIyfcBdLh+7YDVFFnYGXKqYwqqcbqMOFSHuhoeyMSCYyv7d2Z
        tI9RnXJ8U177ZX4qaBgu5A==
X-Google-Smtp-Source: AGRyM1vyI6gtpeykTILPZnbma0073Cvcndgl+qd/LTGfH3eUbekQPxJg89MwT/qdbvfooBY3nSXjMQ==
X-Received: by 2002:a92:cdac:0:b0:2d3:bf8e:8389 with SMTP id g12-20020a92cdac000000b002d3bf8e8389mr3153113ild.56.1655392500209;
        Thu, 16 Jun 2022 08:15:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z4-20020a926504000000b002d11c598e12sm1103936ilb.61.2022.06.16.08.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:14:59 -0700 (PDT)
Received: (nullmailer pid 3488523 invoked by uid 1000);
        Thu, 16 Jun 2022 15:14:58 -0000
Date:   Thu, 16 Jun 2022 09:14:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        kernel-janitors@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        patches@opensource.cirrus.com, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] dt-bindings: clock: Move versaclock.h to
 dt-bindings/clock
Message-ID: <20220616151458.GA3488452-robh@kernel.org>
References: <20220613081632.2159-1-lukas.bulwahn@gmail.com>
 <20220613081632.2159-3-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613081632.2159-3-lukas.bulwahn@gmail.com>
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

On Mon, 13 Jun 2022 10:16:32 +0200, Lukas Bulwahn wrote:
> Most of the clock related dt-binding header files are located in
> dt-bindings/clock folder. It would be good to keep all the similar
> header files at a single location.
> 
> This was discovered while investigating the state of ownership of the
> files in include/dt-bindings/ according to the MAINTAINERS file.
> 
> This change here is similar to commit 8e28918a85a0 ("dt-bindings: clock:
> Move ti-dra7-atl.h to dt-bindings/clock") and commit 35d35aae8177
> ("dt-bindings: clock: Move at91.h to dt-bindigs/clock").
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/idt,versaclock5.yaml | 4 ++--
>  arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi    | 2 +-
>  arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi          | 2 +-
>  drivers/clk/clk-versaclock5.c                                | 2 +-
>  include/dt-bindings/{clk => clock}/versaclock.h              | 0
>  5 files changed, 5 insertions(+), 5 deletions(-)
>  rename include/dt-bindings/{clk => clock}/versaclock.h (100%)
> 

Acked-by: Rob Herring <robh@kernel.org>
