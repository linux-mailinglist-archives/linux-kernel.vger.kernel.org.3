Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1807534F17
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbiEZM1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344382AbiEZM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:27:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4B63B3EB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:27:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q21so2760093ejm.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RmdgQ6QrbjFADLKwDXStotKVNTKmg/T5i9TT9aV1tgQ=;
        b=FyeaF3HmgoG5Nrq0ozfTGve7pY+D0upLBRF61A6nYGuSlnsBzLHvpL1KKXDHT/UgOC
         /55k838A/parSyTgm4qnKMetHZEJSlsm0xWQ21WRBVlVfmG5yMAKKtRJoS0zyome3TUw
         JCb8216AjiNOhclkoUk3mRlH+hR+S2PlDBgOLizR736xnx683gjuMwPPBwDGixsPV5Fz
         2EMfSJFzWPeOBA2lLEdI8OFj7/a8C/wO1XB3SnGN+2wrqbXdDnpAKpNj4aXoPUucf9GP
         YnGqsdyq2F++gqa5f3lkTP84BPz2C0oK81bImMDzx3H52g7gBfvEJhK7vDf4mWg/Q61d
         X2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RmdgQ6QrbjFADLKwDXStotKVNTKmg/T5i9TT9aV1tgQ=;
        b=g9z9lyTcWydWXTGoal5BR3LHaBi9BBxzuWdxhfQPoLjr2v1eMFwsI4ypehdH9507E2
         IK1NNvazdOaWaMTJLcYad7Rzn9k+rZAtUktNh5Sf3qI1WgM4i6SYRd7rIK9SWLIgX2J3
         Ylk8B59XrHqJmuYeZhiHxwmgZJOx48zbrp9umFCd1kgJ+AjswqvtGLy6f+oAvZRfddjp
         ZnrWrr+T+/SM28/Vu5g/H39digjQnCVmxqsyhGPaZdNM//AekI9R+LPYNSAoq5i7sO29
         PlieIMB/lX54Gmmmvhlm1u5BAKKIQ+LZE46heKkR2UtVhkdICQE6dAhEdJSQ/OOHRbPH
         Ld/A==
X-Gm-Message-State: AOAM531RTtPttqC9LE1zd4SFUkQyOFAeTQsvDXXnC5CITIzu1VtAC3wF
        6MDjHj5AdPmQNThPWgijBhFypQ==
X-Google-Smtp-Source: ABdhPJyVSLyzUDQr+8q3fimY/nfSl+e/VRZgdIN+MYgyjcKSCOX7TUDoTzskr7rRUO9haGK0uSv8JA==
X-Received: by 2002:a17:906:5d16:b0:6fe:b420:5e9d with SMTP id g22-20020a1709065d1600b006feb4205e9dmr26350422ejt.254.1653568048115;
        Thu, 26 May 2022 05:27:28 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p19-20020a50cd93000000b0042617ba63besm746565edi.72.2022.05.26.05.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 05:27:27 -0700 (PDT)
Message-ID: <19be5e00-80cd-4e2e-7cda-841c61f980c9@linaro.org>
Date:   Thu, 26 May 2022 14:27:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/3] dt-bindings: gpio: gpio-mvebu: deprecate
 armadaxp-gpio
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        andrew@lunn.ch, thomas.petazzoni@free-electrons.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20220526012946.3862776-1-chris.packham@alliedtelesis.co.nz>
 <20220526012946.3862776-3-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526012946.3862776-3-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 03:29, Chris Packham wrote:
> Commit 5f79c651e81e ("arm: mvebu: use global interrupts for GPIOs on
> Armada XP") the marvell,armadaxp-gpio compatible obsolete.
> 
> The driver code still exists to handle the armadaxp behaviour but all
> the in-tree boards use the marvell,armada-370-gpio.  Document the
> marvell,armadaxp-gpio compatible as deprecated.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
