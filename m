Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447075816E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiGZP70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiGZP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:59:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1782C12F;
        Tue, 26 Jul 2022 08:59:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y24so13715223plh.7;
        Tue, 26 Jul 2022 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=57o1v3WV4ubipwS3abJpah9hJJPNNRgMDiHh3namw3I=;
        b=WcVN2HanxONRGtLe8KqmdrJozSjLhVzY+wmRxSjqz1fQWrfLaSUfT1Oic9Fz/sJAWD
         8K4kHje+I2el/DpNX1yqJH0zDrf2aqvCsArGN5jMyadNrU1nEYvJb3kcINX4Afll2IMi
         53yIun0jyE9Lqvp0+O6P8vxzMSkCcRIlc8bzFrZoeQV+3qJbcqv9xOxRsi8ByCe9EGSs
         3Z4HOkjU2TJduL2tSpxiFFLku1qLy8Zm9PERgLpCaxkFS//p/dHtR/UP6EOPEmWJUAtV
         38zTl4meS1Woeqrd8NxGvHP96rQVfjR+KFKnmJ2kiNFB/l6q2QTHooj1EVAbzqrg66CH
         LK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=57o1v3WV4ubipwS3abJpah9hJJPNNRgMDiHh3namw3I=;
        b=OHKkh7nkp2sGqCgZRwJXhEuzipcJIoaJMez3PkX6w2F2/M7aO1yJTTwhcz1wn+a4Cq
         g9FHn+DZJVtk+6UL0CygrzqPA2ICjLmlyH3oq4LDK3vLkfj5RqUO1PwXioGWnF8jI/wr
         5Or1unTWjm1Cout9wB/lgQBBF59GmRjoYlvjEkKT6JfkmqLaLBaqwv9vcl4fnHxBeZxj
         RzIIYW4KIXTUhpGUN31xCwEAmhzwVTWQgAmd/4Nj1rccHIg9z7LZgX5tSGfZAZyo2psK
         q8p7XUb9zBxoyKS9qlveNTz4Z1AyhFbuY5JTiraeBZ78G8ReFFISS+9xU3b22efoyTDK
         g8qg==
X-Gm-Message-State: AJIora9BNpBBCfZgYYD+EOdDZ7oG2GSuWzdkQB3dHVwGZJarT8fa2EYB
        vfof7gQy4GRP6EVNYE03ECs=
X-Google-Smtp-Source: AGRyM1tbdXRJNvLagf6KQtq7gWhtRWdov/3CcSwRZ96bA4SvoNXcT+j2yMwVGZ8DxvVKa0R7hq9NQA==
X-Received: by 2002:a17:902:cf09:b0:16d:69ad:e496 with SMTP id i9-20020a170902cf0900b0016d69ade496mr12248813plg.6.1658851161643;
        Tue, 26 Jul 2022 08:59:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i29-20020aa796fd000000b0052b94e74e45sm11792118pfq.204.2022.07.26.08.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 08:59:21 -0700 (PDT)
Message-ID: <a70148d3-c87f-969a-b743-11c679d161d3@gmail.com>
Date:   Tue, 26 Jul 2022 08:59:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] dt-bindings: soc: bcm: use absolute path to other
 schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Saenz Julienne <nsaenz@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220726115841.101249-1-krzysztof.kozlowski@linaro.org>
 <20220726115841.101249-2-krzysztof.kozlowski@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220726115841.101249-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 04:58, Krzysztof Kozlowski wrote:
> Absolute path to other DT schema is preferred over relative one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Are you applying those patches or do you want the SoC maintainer to do that?
-- 
Florian
