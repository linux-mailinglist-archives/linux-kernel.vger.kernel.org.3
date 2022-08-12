Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6E3590DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiHLIrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiHLIrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:47:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E879F779
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:46:59 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a9so424507lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=f3JKjv//LxKB5+mzdQGHJih1IuquG0rT5vJK16EtzN0=;
        b=i5VSMG47Ah0V1K1Iuqp1Gf0y4LldoyH1+p6zB/LHb2a6IGIyPi01kfOLOQa+h02/oV
         jP7Dx4jZG7DLWgTbDk723PZ+E4oZvBgDPW0oKpt/9OFq5L7HI1UeElMuIflIpZQ3x/I/
         6m7G0e2058QmJ9tPMhuuol5nSGnVeW+9GQ9rE9Ca5iiymlvYRrb76EIS6NsL+C/R1OxR
         mhcoxEyCTvVRPf1up+4dbzANRbatDrfYWeYAR7G5L+YyJ1DcWRngbRzEo8ybx42sMcjk
         1olPvnDSw2cCJgeMvf0bFammshX4FZSqpU1GBwsspoWLx0lXSvqyg+6+/YgWXj3JBbGJ
         vg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=f3JKjv//LxKB5+mzdQGHJih1IuquG0rT5vJK16EtzN0=;
        b=MXO7nbP0eomYMRUCiCHFQWY1r1jW0qaW1RXOr4BAzzl3UnWWWTJn9zUyX9v/epQrOP
         oIOh7pTefQd9bBocVE+7ViDdVldD5/FsK/C7n0vdLu+KB8CkBEBXYZAhkP6T4bCTpv5p
         mi03jAuD9rJpdDKhh0rV779xR85qXjV8tD2KlEbk4vaAQqWM5FFJaLaeh67ilEkfpnaR
         iMh/g0vKycgyU8IsHFuuCIC/roCJ6xZoMNMavF9gcgysRfFYnvL5Fb5WWp8mpjzQbFPd
         JRNB99jrRUrXOkoqn7nbMw3DL+vtLDeLLWUm11zDAZ6lNdNjad6KK64//bWUywnn4d9Z
         z11A==
X-Gm-Message-State: ACgBeo3G45sTej/R6lvEmp3y52SM7m49Rolyz5tVPXleH7ZNaPZWmKYa
        y1bn1/ViArqFx5COHZBbueYQHQ==
X-Google-Smtp-Source: AA6agR7D+3HXmSlpB+0CeSYLis3QxIqroHYiRty6hNmfJ6O/3i9rARi5pP/pDUc8uZFVkTZFLHzUwQ==
X-Received: by 2002:ac2:5c02:0:b0:48b:29ed:6e1e with SMTP id r2-20020ac25c02000000b0048b29ed6e1emr917307lfp.560.1660294018040;
        Fri, 12 Aug 2022 01:46:58 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id f16-20020ac25090000000b0048b99e4a26dsm136876lfm.145.2022.08.12.01.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 01:46:57 -0700 (PDT)
Message-ID: <eaba9c5b-792d-5fa1-7d71-d225e789d29f@linaro.org>
Date:   Fri, 12 Aug 2022 11:46:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/9] dt-bindings: clock: Add bindings for Exynos850
 CMU_AUD
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20220809113323.29965-1-semen.protsenko@linaro.org>
 <20220809113323.29965-2-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220809113323.29965-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2022 14:33, Sam Protsenko wrote:
> CMU_AUD generates Cortex-A32 clock, bus clock and audio clocks for
> BLK_AUD. Add clock indices and binding documentation for CMU_AUD.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - (none)
> 
>  .../clock/samsung,exynos850-clock.yaml        | 19 ++++++
>  include/dt-bindings/clock/exynos850.h         | 68 ++++++++++++++++++-


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Sylwester,
The DTS depends on these, so I can apply headers and provide you a tag
with them. We could try also the other way, but Arnd is picky about it.

Best regards,
Krzysztof
