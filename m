Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08209554CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbiFVOYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358517AbiFVOX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:23:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6B55580
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:23:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z11so17993601edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ASFP5IP9NFXmeexPLRW7qWJpEpGv0lKpIUxpCQWgUGg=;
        b=XdOLqhNxL7lmkLKULp9Ztpbq+zF0iuuPKXJVOBPylr6Blak5hUecuSf5XJBQVWuSnv
         RVs0AQSC+RepxEmPKVkauvYKAH/mqWMBcDW33/NJ8uMCbKLnbCbbzwvHSqWaZoTbBL8W
         bzRxiDHY3fz0B0rTVUfZ92iwn4bfCZehABZI7kyUnm3yEgPGrVwt+zwMvg66IegAnlln
         SjKXLjNMEjBU0WQC2KQwB/t/nrKm40Pa7WgUjDQSaJfLKR3fy/LCIerQ2aEGkNo21q5/
         wGI4MW+Hotjd3W4iOAp2DNe6+7KDtiLFTRnks10ZzTlloBt2anznfpv9512OEIR71G0z
         pXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ASFP5IP9NFXmeexPLRW7qWJpEpGv0lKpIUxpCQWgUGg=;
        b=CKOWmcoyE51yqcZs1vUG1391s9EZF/3ULCJBg76782wMyDDuOleJ5olZ2FV47nAK4k
         yUHxrlce1lKI4f/XZqtcmBUkrHS3grjeQGTw830S4OvSZq37LyIhm/9iqpgxc1BvpXgK
         O7DTOvTJLLd7LDLVYfB5USwvfwjm20g9KQC/PDIpKQahwxPIuvrkAYnTVKKuT+TemfbQ
         z8SSIdZYxLZOn2m0TH+4K+9lNY6mvz2l7ZQ5CcX/ceGN8EZ96dq0eHQUUnVkvErnoner
         GnfqvtHEKB7Kc7rnII55drHrIDMXsLGQWQdCsudE4WmTrANsQ1dRmGAmoG2MnhPw2vrW
         mRYQ==
X-Gm-Message-State: AJIora+gsuVo4xLiy6HWmjg4484TZxUKqYZH7bItBa0iMYuul27wPXz6
        1SMoA9sZFPlptroTqTyd9pzuLw==
X-Google-Smtp-Source: AGRyM1seX4ZkksCXeRPMkaLKK5W0HwS2FvD9c/bqAUsr+AUyprpmhST58KhyYKsR0XgOay0M5lAMhA==
X-Received: by 2002:a05:6402:d0a:b0:421:10e6:2ecc with SMTP id eb10-20020a0564020d0a00b0042110e62eccmr4430327edb.329.1655907834622;
        Wed, 22 Jun 2022 07:23:54 -0700 (PDT)
Received: from [192.168.0.225] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906293200b006f3ef214e20sm9337863ejd.134.2022.06.22.07.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:23:54 -0700 (PDT)
Message-ID: <b6a8e40d-ca4d-a688-988d-6800150d4e68@linaro.org>
Date:   Wed, 22 Jun 2022 16:23:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 02/13] dt-bindings: Add headers for Host1x and VIC on
 Tegra234
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20220622113733.1710471-1-cyndis@kapsi.fi>
 <20220622113733.1710471-3-cyndis@kapsi.fi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220622113733.1710471-3-cyndis@kapsi.fi>
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

On 22/06/2022 13:37, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Add clock, memory controller, powergate and reset dt-binding headers
> for Host1x and VIC on Tegra234.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  include/dt-bindings/clock/tegra234-clock.h     | 4 ++++
>  include/dt-bindings/memory/tegra234-mc.h       | 5 +++++
>  include/dt-bindings/power/tegra234-powergate.h | 1 +
>  include/dt-bindings/reset/tegra234-reset.h     | 1 +
>  4 files changed, 11 insertions(+)
> 

It's not the fault of this patch but in the past you started encoding
some register offsets or values in the bindings. That's not what
bindings headers are for. Store here hardware-independent IDs or
nothing. For new Tegra SoCs I might start pushing this back...

Anyway, it's not this patch which introduced it, so:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
