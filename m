Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D872D57AA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiGSX0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbiGSX0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:26:18 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A115C368;
        Tue, 19 Jul 2022 16:26:17 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id h14so1314512ilq.12;
        Tue, 19 Jul 2022 16:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RGSh/9OhsQv+i2rDwOllkM0fVDxN+/XdQcXayxg7Uj4=;
        b=V5yt05xmPLTrzdwvu2vIC63VcDI8Kgc64m/ADBbzqYjupPICdX21vQnKD9ngTi6JN6
         N6HLAZSLc92hbGuBVDWJb+7Vbz/UzXLB3POKlXsaAiKQ7Up0bebNvW8VaQ12RlUZWR+L
         h+PaTiYWnblThzYoHImh9fm+jXvKui/loHv4CPyRdxcua6iX8V5lm9qP3JVH+z+kkC0A
         P7ZIyaccHznHXQc+4Tr1CDBtqT3P61j/OHO1jiBX82cyQ5CUWz3LFNVhYeNviW4+awpW
         /GrOlO+kp0EzOeS4vZtpY9n/+0R5Izz95xmNAbwxcs1ZRAdnZPgzmdlFTLZsXkGrXBom
         b5GQ==
X-Gm-Message-State: AJIora/VRe6mv9qV2xYBfib5wdRY16FZ/rEIlUkcGWOuPBZMa2VDksix
        MGbplqxQxe9Tkih+YE3iYg==
X-Google-Smtp-Source: AGRyM1ugiylAPQWVwDJT3vLFR6RTW4iA9+JSTtz+wXFBWc1Mq59kklgCGdkegcLHtj3uPR0l0x/yDg==
X-Received: by 2002:a92:cbc5:0:b0:2da:d35b:c06b with SMTP id s5-20020a92cbc5000000b002dad35bc06bmr17719653ilq.37.1658273176429;
        Tue, 19 Jul 2022 16:26:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e10-20020a921e0a000000b002d79f619517sm6273223ile.26.2022.07.19.16.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 16:26:15 -0700 (PDT)
Received: (nullmailer pid 2034613 invoked by uid 1000);
        Tue, 19 Jul 2022 23:26:14 -0000
Date:   Tue, 19 Jul 2022 17:26:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: pwm-multicolor: document
 max-brigthness
Message-ID: <20220719232614.GA2034561-robh@kernel.org>
References: <20220719074542.24581-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719074542.24581-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 09:45:42 +0200, Krzysztof Kozlowski wrote:
> The Multicolor PWM LED uses max-brigthness property (in the example and
> in the driver), so document it to fixi dt_binding_check warning like:
> 
>   leds/leds-pwm-multicolor.example.dtb:
>     led-controller: multi-led: Unevaluated properties are not allowed ('max-brightness' was unexpected)
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/leds/leds-pwm-multicolor.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
