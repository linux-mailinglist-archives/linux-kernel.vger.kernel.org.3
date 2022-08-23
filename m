Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EEB59EE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiHWWG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiHWWGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:06:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5E96DAEE;
        Tue, 23 Aug 2022 15:06:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ds12-20020a17090b08cc00b001fae6343d9fso2332271pjb.0;
        Tue, 23 Aug 2022 15:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=dfHw9Au+ywQlgJdIlOozb4wR+/yFGywiWl7xsOUO1XE=;
        b=Q5WL3LFV/P0jkBMfrRt3ikONrj6bCkSlkhJ1YIdFH3Z1g7mCvSTE8fPV8j8GWqGyLM
         tcM1Som5PY6vT2ojWJ/qMZdZ0sfKABf5MOWtL8ctEbqfSWz+AI17lCSJsD8vQ25tEYtk
         +kyZQpP3yfVNbw76dnu9mrOKqFHMw8c3Ux6jpFmcmt5OHQoK35j2+VHos6VlwKzORd3j
         krubR184xtZ2F4Nlqo6khSZFMNQ9qYgrAdfJt2YbBRrIVNCrFUqMNbIg6PVpzlsOO9Vl
         AyMb6aL16Tie+T5sOQpaPVgqTYOufEPG0Lpm3xIak3DJKd8jhtbGoa62OqawuSgVNsBK
         UCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dfHw9Au+ywQlgJdIlOozb4wR+/yFGywiWl7xsOUO1XE=;
        b=S17xpMw+lVyoS9mqP9/obuCoj6yVly4wDcGWPr4kOYtUeUdr/2HAXbwLOanhjbTJ8Y
         GKZOKfaSVI4bGMWC7uxD4v+hFa2WckOLFWgZUuGG+WL2R4ZmtIupd+tXZtSdXxqr3jZ+
         Q5spMsaC0j5y1Z2hlVo+3mDaxW4q4+sXgY8Hv8BZKMXCA0lZ6HQsZ4J8qNsjWkpY+vhs
         3uES1MCcIK/A8abJWA8e4fd40M3MG1vNK1RxpUyePbDiOnEexFspEOWTVH3q7VmV3Ugr
         a2awswoWx7WXlLeBOBKVnOH036Brj+P1Dexx4l8BefHo7dGUuhM4Z6xUERFp9vZo1uNL
         m9Rg==
X-Gm-Message-State: ACgBeo3WiNT1DygzdU1NID1YB7+12sjL/kF4Yt9/TrzF5cSBMg0oNzIr
        +g+nABFMaDRaDnGGKhF2whQ=
X-Google-Smtp-Source: AA6agR5jgv7jQ55A4SxTAhJgsQT44cE3EGWXxOAX0260P+IPbRouD9JrqyOfu/3WbMkB0jdSSYKmFQ==
X-Received: by 2002:a17:902:8498:b0:172:a201:5c12 with SMTP id c24-20020a170902849800b00172a2015c12mr25854815plo.166.1661292381473;
        Tue, 23 Aug 2022 15:06:21 -0700 (PDT)
Received: from [172.30.1.52] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id i38-20020a632226000000b00419b66846fcsm9588221pgi.91.2022.08.23.15.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 15:06:20 -0700 (PDT)
Message-ID: <a888ceb4-363a-1c28-2348-5ba761ffa5e1@gmail.com>
Date:   Wed, 24 Aug 2022 07:06:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: samsung: MAINTAINERS: add Krzysztof Kozlowski
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220823073154.359090-1-krzysztof.kozlowski@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220823073154.359090-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 8. 23. 16:31, Krzysztof Kozlowski wrote:
> Add Krzysztof Kozlowski (already Samsung SoC maintainer) as Samsung SoC
> clock maintainer to handle the patches.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Agreed with Sylwester who is recently busy. Let me handle some patches
> as I already handle rest of Samsung SoC.
> 
> I plan to send pulls the same way Sylwester did - to Stephen.
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5a72b303aed5..13d2b804dfa1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18048,12 +18048,14 @@ Q:	https://patchwork.linuxtv.org/project/linux-media/list/
>  F:	drivers/media/platform/samsung/exynos4-is/
>  
>  SAMSUNG SOC CLOCK DRIVERS
> +M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>  M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
>  M:	Tomasz Figa <tomasz.figa@gmail.com>
>  M:	Chanwoo Choi <cw00.choi@samsung.com>
>  R:	Alim Akhtar <alim.akhtar@samsung.com>
>  L:	linux-samsung-soc@vger.kernel.org
>  S:	Supported
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk.git
>  F:	Documentation/devicetree/bindings/clock/samsung,*.yaml
>  F:	Documentation/devicetree/bindings/clock/samsung,s3c*

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
