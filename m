Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C1650E78C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244097AbiDYRzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbiDYRz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:55:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F69107717
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:52:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p4so3763243edx.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F3yL7li5LpaSXdLV4MhSjBlyW+oHrooWjq57e9Um/ro=;
        b=JxiMYT6vE8ZannZ3oVFd7TSLy0pcUqOUX0t43wd2ceuRbvAW6JZiWJGy5jmhP9m7+G
         +jYn4mCkioKNIyA+MV7j5XjiN0WGEJMlONJotdy4ShE1o4KJCM3lOlEDv9TnYxqy3x8y
         QeiekvznqA14wctiICeYtI91Uc4w9ZWNQ5vEtB4h8Tk5QEveOkxqb6Qa7pd4YnHYVgbC
         JmsGaGfqy+BNjK3FNhjdsfiOAtoOwn62FBFhc+cypy9u7GmDUxFzH0g4312KJ6ynILlR
         TyiXL0pckt4NRf94xBxV+9/0vO10lqUQvHqsqZkysJKt7SykV691o6ebjUEQ7JwfIqOT
         FOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F3yL7li5LpaSXdLV4MhSjBlyW+oHrooWjq57e9Um/ro=;
        b=wlrBTv8S1fYWYc3H2vYp7u8gIAAW1qM+q4ZFBuyV2woCxxWu4ZlqFqBk74T4huiW7L
         vpUg6UQSLldaPjb3uYaDJDvZD1lhwbrlQ12BFdp2rJfGc7Ct50A7CP7PiWc4GmWc54y5
         ehmeNNUNzSUsldgagw5IFaKJ3dS/i8WQZOHll+WH+QwYYH3a0Cvd8tQBxGCaXJuv97vV
         Vn5DQrrZ1v0uisM1ezAx+p7qkHmF6AGOVyDik5gf386mqKDaTPhZwOLjpq4ikT2WaOF5
         hxanP1g8kQn1QaqoM3skU6Ebp1tEl6zvNrmdaHO/0mdoezOY2+cnC/uwxQc/71uWuqMO
         Qe8w==
X-Gm-Message-State: AOAM533zIUY944ePzB9c31wMaYQ1vRyFO4/wKZjiA42/gLk9NTcfw1Gp
        tlGc2K+UrvTM0fCtFOh0Om6LHg==
X-Google-Smtp-Source: ABdhPJwgwFhz1B2LGDJ8Ki1N3/M3oLLa3mwFc/841EJQCDHbEo8avaID2VAuG6H8ScmiEKIEj88roQ==
X-Received: by 2002:a05:6402:515:b0:425:bd3f:1ad4 with SMTP id m21-20020a056402051500b00425bd3f1ad4mr18207901edv.381.1650909140793;
        Mon, 25 Apr 2022 10:52:20 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906708700b006da8440d642sm3873214ejk.113.2022.04.25.10.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:52:20 -0700 (PDT)
Message-ID: <a94d1351-f81d-4b36-a772-87d031c0dd71@linaro.org>
Date:   Mon, 25 Apr 2022 19:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/4] dt-bindings: input: Add the PinePhone keyboard
 binding
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <x@xff.cz>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20220424160458.60370-1-samuel@sholland.org>
 <20220424160458.60370-2-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220424160458.60370-2-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 18:04, Samuel Holland wrote:
> Add devicetree support for the PinePhone keyboard case, which provides a
> matrix keyboard interface and a proxied I2C bus.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
