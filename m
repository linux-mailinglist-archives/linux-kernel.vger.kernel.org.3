Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF25525E53
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378372AbiEMIkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378362AbiEMIkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:40:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EB7268221
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:40:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i27so14814426ejd.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p/Zao6rc7Ug/D0K5Bk7hpf3ji+A1xvbtLiVbyeRffeE=;
        b=KxbmUHMMzCKtIHI9JgJ7xt2hRE2AzDnbDN51JiOKTGaS/z8k/0nwD5Neiil3w10ZUI
         /oaoFX9cia/FZd3oJ01o70/jEuscy5m+kK3vtWsmCmj0r+BoXTjxoHqo9ukRuCJW287q
         wwML0PITRXXMW9qwtDxlkmcFnHdqDKD9egoDUGvH3I1twIPotFN/2wHDr5iatcfvmiJT
         Fx5AFgbejxzG1Gtv7Jd6bPEUzUHDMA2NizEhCvAXAxwjQMxB2Wsc9ynga5LaIxN8uult
         yYkwz9iKPSn9bYp+TWPOTkik36asJYThIhYPYr2e2TikeMJr9A9hl9S0d2YXJ9PUdVOc
         ytpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p/Zao6rc7Ug/D0K5Bk7hpf3ji+A1xvbtLiVbyeRffeE=;
        b=pmP6QEkY7ciPy+swSogwOhEtSSorl11pZcP79m71w+tGbqhefXZ3IkCjQKyYcf0pvf
         6gjSwMqw1Qnh+7iiCCawl/RbFNpKLSB749q0Wh/sljIRUMi3KgPRvtQ7N/C5igTDETN6
         vjOIpl3h6wTvveUeiKP+0bYYj8SPwCUikWup/Edbhq48McvvE8QMMB6YTw9rmNhjK32j
         4nNoEzOJkOuEr6DrGOZYdmj1Of4YGgynR+Mlco18ELwFJerYbrLzCoQCZlHZ06ZrKAGe
         0G1D8ocGKsQlzqX12HdA91FnbUuglVQuZTIX48MJrgyhTyr56NAUdZy1UHpZR/4L4RPA
         sxKQ==
X-Gm-Message-State: AOAM5316tCqYzlueZ/T2U4FtY4+3fNEqSpOdguXQWjDcqrNyYAtkeUXD
        bK4O5fZydPkb6aJmFIm+32ziLQ==
X-Google-Smtp-Source: ABdhPJzMeQB9inIJNFaQxmFpNwKNj8u+DcKIX4UYgxC//r5KM1m9TKDb9OcOkgEUQu62L6z+7qtAbg==
X-Received: by 2002:a17:907:9482:b0:6f5:171d:f7f5 with SMTP id dm2-20020a170907948200b006f5171df7f5mr3309800ejc.68.1652431204937;
        Fri, 13 May 2022 01:40:04 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z16-20020aa7d410000000b0042617ba63d1sm657973edq.91.2022.05.13.01.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:40:04 -0700 (PDT)
Message-ID: <059ce16a-0e0e-a6c6-8e19-0fbcdf55e989@linaro.org>
Date:   Fri, 13 May 2022 10:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/2] dt-bindings: gpio: gpio-mvebu: document offset and
 marvell,pwm-offset
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        andrew@lunn.ch
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20220512094125.3748197-1-chris.packham@alliedtelesis.co.nz>
 <20220512094125.3748197-2-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512094125.3748197-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 11:41, Chris Packham wrote:
> The offset and marvell,pwm-offset properties weren't in the old binding.
> Add them based on the existing usage when the marvell,armada-8k-gpio
> compatible is used.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v3:
>     - Split off from 1:1 conversion patch

To clarify - this documents properties already used in driver and DTS so:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
