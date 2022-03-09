Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57654D3BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbiCIVHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiCIVHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:07:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF89A10C50F;
        Wed,  9 Mar 2022 13:06:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78CDF61AB8;
        Wed,  9 Mar 2022 21:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D548EC36AE7;
        Wed,  9 Mar 2022 21:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646859966;
        bh=FeLtBU7QMp6iEJHccU5vuRdG5htlOJfIhhIpS6r7AhM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z9Ot8vd0SD9n+maWBFR9fCvdLyFrzkzJZ0clgv0hHJ1OYP0+Ol+cZju3OiiDm/yiL
         Ma5epBS1vFTVXJvScrqEz3sqDgwZZRa9WZQ/N50WIqeqLnS5haqiPMeYb5BejHUGL9
         gkkFjOLgV8TSt50cYWcDK+LaTTuSxuz8GymRKPkPuDG5hmOZ8p0Ht1ZGHkyCkNTPL/
         DDCV4RKt0kOAYVylpiJXblzinr/DN5/tGcfvawWu0Ai9ypNTelwyoytBHwt5kDezU1
         NN0DAiyCI1mY5mAYJwmq6IsD3tUrRYgfz9cKL6IvIqRry19yENUBPAomSN5yUxxWGJ
         ZzyIfvzhlIOvQ==
Received: by mail-ej1-f48.google.com with SMTP id qa43so7725407ejc.12;
        Wed, 09 Mar 2022 13:06:06 -0800 (PST)
X-Gm-Message-State: AOAM531dwVIA9D83R8yyQox/mSMMg5ZP+c0MrBiTv6zw9XmG325M6DGK
        pIMvmI6f9QMs22fSrv/UcGC0aNjhdUf6TJT+JA==
X-Google-Smtp-Source: ABdhPJxP4r5jkW2XGKLwSeYb+P3R9mLVmIuw9bFE1hEmABTru6Z5W8ocg6Km8rnC2ammFaLr1fc9kholLHA72ed6cTo=
X-Received: by 2002:a17:906:a38e:b0:6da:a1f9:f9ee with SMTP id
 k14-20020a170906a38e00b006daa1f9f9eemr1449135ejz.27.1646859965060; Wed, 09
 Mar 2022 13:06:05 -0800 (PST)
MIME-Version: 1.0
References: <20220308155735.54146-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20220308155735.54146-1-alexandre.belloni@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 9 Mar 2022 15:05:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJXz01F_+-xg8VfAOQ=-C96NVa1KO+nRbXf9mq289kmYQ@mail.gmail.com>
Message-ID: <CAL_JsqJXz01F_+-xg8VfAOQ=-C96NVa1KO+nRbXf9mq289kmYQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: rtc: at91: rename rtt bindings file
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 9:57 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> atmel,at91sam9-rtc is a confuing name for this file as it is documenting
> the RTT used as an RTC and not the other regular RTC (atmel,at91rm9200-rtc
> and atmel,at91sam9x5-rtc)
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../rtc/{atmel,at91sam9-rtc.yaml => atmel,at91sam9260-rtt.yaml}   | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/rtc/{atmel,at91sam9-rtc.yaml => atmel,at91sam9260-rtt.yaml} (100%)
>
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> similarity index 100%
> rename from Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> rename to Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml

Now failing in -next:

./Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml:
$id: relative path/filename doesn't match actual path or filename
  expected: http://devicetree.org/schemas/rtc/atmel,at91sam9260-rtt.yaml#
