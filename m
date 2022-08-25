Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD605A0B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbiHYIWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbiHYIWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:22:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A171A2A99
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:22:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id l1so26701749lfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=FyQKxEzJPLBTQnte3dv1CLlOWzBU0+b5BmjFLEtuJsA=;
        b=UULiU0EFuK3+E2dvoW+xc5zr4vyow0oTphJLZxlMK+pOfWQ0pg4bx3BEGuEqKZO+JC
         tiPakBxSr8iX86/9KWfwXHztHmr48INFEWsKx+f3g3ERMLNMTKXLWhZi6D5SJ0gXKpTg
         gGgZknWrZ0Z4CGQ0HArogrl3juntWE7nJ5JcgNrA+AQXLdPxxVh6rwq7Bw4uzbbf6/hR
         egaUbqD0gqXS9mvHgh/bxX6cM7sLCotB0BGD1KHjjYLNkkD9I8Nq9zhA5nscn3N7ehtd
         rS+NUQG9ap6/qzaw4QqZjHvbMQfmj4r95xauxFA4rUwj9460LEBc+Ku2/tbtI8WK3dDi
         q99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=FyQKxEzJPLBTQnte3dv1CLlOWzBU0+b5BmjFLEtuJsA=;
        b=kPm/wP72kgDN5cV2A2gysSP8dMGrW8jwaHFREpK/5+RVIuL0ZXG6DYYPs8GLUVbW3j
         gA7w8JUIv2uvPBiiTfcUSSaAzYjryGzQCJYTG7h4tMQRT+2hcYwEtC2+HYK2w8Gj9tuW
         GOHplSuWr2o/mILzq1Gz6uWJTpDAn971Cu9zZppNipwj6ORQEEIcdXPNUIEfDxMQUI1S
         hcVn1tYkG3w5vXmJaAyB+ROPWXDve6/LG++ciy+AVkHIhTDQALe4/6l7YJjjZemtqLPK
         2sxY5zxvanTWVQGRN4P90uquq+aP+GYVBDjqR1ex3b7jZp8ri/vzBm0qoJbyeJO/akXu
         Bkqw==
X-Gm-Message-State: ACgBeo3KE6hpXC5L5ae+MvjE7jl2xHXTCzYW+di39gw7Z4LW0wFQboJo
        kjhdAinxVPBl5Luf0jT6peyV4w==
X-Google-Smtp-Source: AA6agR6rCHKklWzPVJqc5DPkHhh0ceITvsb+iGIHVzK0U5kb1ieRgRzkVG9VWI41ICO7nCFdZcIrAg==
X-Received: by 2002:a19:e00d:0:b0:492:e5a5:588b with SMTP id x13-20020a19e00d000000b00492e5a5588bmr757025lfg.243.1661415736811;
        Thu, 25 Aug 2022 01:22:16 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id r2-20020ac25c02000000b0048a9e899693sm381394lfp.16.2022.08.25.01.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 01:22:16 -0700 (PDT)
Message-ID: <d142dc97-4842-eaa8-482f-4b2f08c20931@linaro.org>
Date:   Thu, 25 Aug 2022 11:22:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: display: adi,adv75xx: Add missing graph
 schema references
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220823145649.3118479-12-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823145649.3118479-12-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2022 17:56, Rob Herring wrote:
> DT bindings using the graph binding must have references to the graph
> binding schema. These are missing from the adi,adv7511 and adi,adv7533
> bindings, so add them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
