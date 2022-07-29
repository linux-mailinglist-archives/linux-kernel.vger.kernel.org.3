Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE9F58574D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 01:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbiG2XYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 19:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiG2XYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 19:24:02 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A6F5723A;
        Fri, 29 Jul 2022 16:24:01 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id j20so1662251ila.6;
        Fri, 29 Jul 2022 16:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9jNnx8bueEMXz2uTDzsjEDA4cddHIYz0DNfyg6eHaNU=;
        b=XIT2oPLkCegAPoZCMxMghBQ0zKn0/jiBbm+gdYM6guQN+awYri5DcsT3XPlHFzE47p
         zceGwQIlD3HDEifmKTy1L3nmFKIizDKTLcDzRZp4tR9XvVIe7yTSkv9SP/qQPUiHHgzR
         gq0oHGeTqKDd5gMNtYUQSi97/2QYb6GhJqeJMOd9zlTj58MZocy4foS5hr6sZTEVQ/oH
         AvvTsUddlPCYCAF6auCkpwUyAV64ehRtsy6tsSDSBHUV4S+M1fvxop6KuUsmXwHiovk4
         xdGXmZbwJ864WMKVh3wsfwU+NR4phsPCtfq0VhkG80dWrDB7gdl6vAyiXJ0N4QijsHEg
         T07Q==
X-Gm-Message-State: AJIora9qAi/6Z4cWSsn4GPzlUOcPrwCd9oeTV2/T5fp99N3zaPJjEVff
        Bwy8tuCTUFRJhk3odcTNIQ==
X-Google-Smtp-Source: AGRyM1vKy8UNsx2PoSk/hxVZtyDogWhfvNAaG0Ia0vcjVuHpWRvHBWQNxFO9OVOtbXG36xa0W+lDMg==
X-Received: by 2002:a05:6e02:1181:b0:2dd:bd7a:26c5 with SMTP id y1-20020a056e02118100b002ddbd7a26c5mr2192516ili.8.1659137040947;
        Fri, 29 Jul 2022 16:24:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g67-20020a028549000000b00339ee336be1sm2202734jai.81.2022.07.29.16.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 16:24:00 -0700 (PDT)
Received: (nullmailer pid 132847 invoked by uid 1000);
        Fri, 29 Jul 2022 23:23:58 -0000
Date:   Fri, 29 Jul 2022 17:23:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>
Subject: Re: [PATCH 2/2] dt-bindings: eeprom: microchip,93lc46b: move to
 eeprom directory
Message-ID: <20220729232358.GA132804-robh@kernel.org>
References: <20220727164424.386499-1-krzysztof.kozlowski@linaro.org>
 <20220727164424.386499-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727164424.386499-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 18:44:24 +0200, Krzysztof Kozlowski wrote:
> Move the Atmel/Microchip 93xx46 SPI compatible EEPROM family bindings
> from misc to eeprom directory to properly match subsystem.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../{misc/eeprom-93xx46.yaml => eeprom/microchip,93lc46b.yaml}  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/{misc/eeprom-93xx46.yaml => eeprom/microchip,93lc46b.yaml} (95%)
> 

Applied, thanks!
