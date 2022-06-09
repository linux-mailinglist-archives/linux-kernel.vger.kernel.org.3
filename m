Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBBB5448ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiFIKbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiFIKbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:31:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7877220ED75
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 03:31:46 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v25so30603281eda.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 03:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ufnscmxQX0AEbzv5PDtE4okgkONgzlvCJEgtYxQypeY=;
        b=PvTB125tZx08/hSvZa0syMVCHbKXmlH9QhWjjk13m1U4RJs0l+5sC2JJ3fHV+Nb1/u
         ep/DvZG+xBu13nOf1ivLWhHz8VBNxtgqz/kf/AQdhwfxjiQQ5wRBIWfNyI5qhHtm8/YN
         a5pbig0h3m4TSnO4UgWGOHYITPP7Ye9e2st1LR8xlyuBjbzWObAXC6FE0A33sPe13JGW
         uGu5S5TVz1Z8TtvQu9FkHT0EUsxkpHx5/c9mZvZJkPPE2RCcy3/lJxsBVT2LdUcRpy80
         PF1ArDfyrRwbGp1zKwVwTbv0kpmI9vo+/YeU+llZcojlFMT7uinD924FB2KFN2yeD0J6
         Kn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ufnscmxQX0AEbzv5PDtE4okgkONgzlvCJEgtYxQypeY=;
        b=4h8ADRf0BRXDmpdGVVs6RDy4Be6Rk30edIolbQfksr5eHup3047j1zjp6CCJqISN5G
         Khc+7Kl/NLb3q2Aqwama7aUCeetTONK6RTps/fx9jXFlDFw0NIJnfz3jjc2gJOHvz55X
         SycNJWIHnq24lUk7/qXPVXG12JKJn2O3WifU7WoErwr8CPcncCqyLkomWcmwavmUnRlD
         6vGHd87T675UIkTmRHvUCQFA76ebKmjzKW++L36M5hz4lqWEfyXm9n9wmZ46stjm75e7
         vT7x2bwIAQiL5USAXyO+zKy0BbsZqXfbkImHwO4Fd2eic5vYgr4oM0emGpSegFjuEzaJ
         mXIg==
X-Gm-Message-State: AOAM5325WHtWoHhMie7kv8Lp2Y+OGiDyccQXIOWSopTDtUFLNT/enIUl
        ZMpTzRPqKrcLB79SF5mCVeUq5A==
X-Google-Smtp-Source: ABdhPJw5ncZiCRvmHdPWyeUur4wU6OHfZmwNQw3+Rny6dLpgU8K5SbVI4FBkZ6nYipWKlORRD78xpg==
X-Received: by 2002:a05:6402:270a:b0:431:43f6:1e02 with SMTP id y10-20020a056402270a00b0043143f61e02mr27435767edd.317.1654770705027;
        Thu, 09 Jun 2022 03:31:45 -0700 (PDT)
Received: from [192.168.0.196] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p23-20020a170906499700b0070f36b8cb39sm8066737eju.103.2022.06.09.03.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 03:31:44 -0700 (PDT)
Message-ID: <7b8653c1-355d-b390-042d-e02085a3910a@linaro.org>
Date:   Thu, 9 Jun 2022 12:31:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: rt4831: Add the new ocp
 level property
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1654741339-12756-1-git-send-email-u0084500@gmail.com>
 <1654741339-12756-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1654741339-12756-2-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 04:22, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add 'richtek,bled-ocp-microamp' property to make it chooseable.
> 
> The wrong backlight ocp level may affect the backlight channel output
> current smaller than configured.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v3:
> - Refine the description for backlight ocp property.
> - Use the enum to list the supported value.
> 
> Since v2:
> - Change the property name from 'richtek,bled-ocp-sel' to 'richtek,bled-ocp-microamp'.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
