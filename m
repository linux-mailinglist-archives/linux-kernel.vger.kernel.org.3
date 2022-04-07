Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1F4F7A06
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243240AbiDGIpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243230AbiDGIpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:45:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6003DD0AA0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:43:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bg10so9373586ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AzvrnUgBhvYNXPbA1hicIptk9K8vlP/oQGWNXIHZ2/E=;
        b=DzKHTBQFvU0DQ7nQ5GMZNNg86m//8Ob7ATXrFW3bnVNADYLyiBNImx5JbU9YMO9jNS
         8gsvODTMjJLaHX4Wg15mTVXldih2wJTi4C/PyB5YQ68tBVXxahRdvWveRqHrYsV5l0HU
         fUj+JUaXU9nJ4nFvB5guGJIsG8Ftb435ZMIiZ7DEdApl/FemeiOL7BgSkL2eUPhNdAtW
         FiuC3FGnjZ/sKUeWuWbFWNRHbkJ8KrcpG9A3zW1c1R/n1KA/oWLQ0Tunu8g10EXExWd8
         kSBJD/V555YJtHKEb50r/lFInzMn10kDtNTjmejOK9yPWhCVaeO2LWeh/B9iC3w5wmO3
         LpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AzvrnUgBhvYNXPbA1hicIptk9K8vlP/oQGWNXIHZ2/E=;
        b=v8f9gaapWvRJHFHX88zMXnpi3mEdN4cPcLeAjao7r+luybRUOdp0WSXdGxtZ6dAZ0r
         7xOLoVBj0B2S4bk8g3CYZoIaZgsntS5s+rnNs8f+/avFKkJPwsIeusuRUWPi/bsrRfPR
         PadoAFW/O9uBP0YhTDOhtLOpPITfk4tRJsGweVxWyABLfbwwOyYayTXhZoLkEYZBZW3z
         6aaaYwLKX91i2YJoGjln9jCOBej6EQvGO5yMU+lPuGB+6iT5IN0y9saXLlL1UJAKekBG
         ix9HkA+xs2Ors6uNIG9feWE7/5aC4kAR0Y2eSjns3iGtJZZmsFQC8y2Gy6Lrwi0LjBOZ
         TmRw==
X-Gm-Message-State: AOAM5322tjHJqXKJZlFzAvdRMMhHV6BVqS8oLgTvqE01AcGNbW8/Uzmt
        7TqfsUhucP3poJcNcq44kzkyzg==
X-Google-Smtp-Source: ABdhPJy92V03/Z7dPcOPlQNI0l13ephK1a9zSR8fU5WUx1PP3AAPuZL2c+Hk5gc8z8t0YbIagEvzww==
X-Received: by 2002:a17:907:6e04:b0:6e0:95c0:47b8 with SMTP id sd4-20020a1709076e0400b006e095c047b8mr12215661ejc.483.1649321030880;
        Thu, 07 Apr 2022 01:43:50 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709066d8700b006d4b4d137fbsm7482790ejt.50.2022.04.07.01.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 01:43:50 -0700 (PDT)
Message-ID: <d1e40224-9537-1fbc-cf5e-2432fd001a8d@linaro.org>
Date:   Thu, 7 Apr 2022 10:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] ARM: s3c: mark as deprecated and schedule removal
Content-Language: en-US
To:     Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomasz Figa <tomasz.figa@gmail.com>
References: <20220407072319.75614-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407072319.75614-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 09:23, Krzysztof Kozlowski wrote:
> The Samsung S3C24xx and S3C64xx platforms are very old designs. S3C2416
> was introduced in 2008 and S3C6410 in 2009/2010.  They are not widely
> available anymore - out-of-stock on FriendlyArm (one of manufacturers of
> boards) and only few specialist stores still offer them for quite a high
> price.
> 
> The community around these platforms was not very active, so I suspect
> no one really uses them anymore. Maintenance takes precious time so
> there is little sense in keeping them alive if there are no real users.
> 
> Let's mark all S3C24xx and S3C64xx platforms as deprecated and mention
> possible removal in after 2022 for the first and 2024 for the lattere.
> The deprecation message will be as text in Kconfig, build message (not a
> warning though) and runtime print error.
> 
> If there are any users, they might respond and postpone the removal.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> 
> ---
> 
> Changes since v1:
> 1. Language: in->for removal.
> 2. Don't show pragma with COMPILE_TEST.
> 3. Add Acks.
> 

I forgot to add important part in changelog - I moved the s3c64xx
removal to 2024. There was an interest from Mark to keep the platform
running and it is a newer SoC than s3c64xx.


Best regards,
Krzysztof
