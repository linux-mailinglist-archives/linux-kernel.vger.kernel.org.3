Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2475B025C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiIGLGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiIGLGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:06:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC0D82FA3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:06:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bx38so15490887ljb.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 04:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=C5hIp9nN3W2D7dzzH3jnznt8lv8D1GoBfgVUxQcYfdA=;
        b=V20/cduvs2Gj/9+T9/F/hCxAVQhflNMvFa6KbJQ16AHXe27a8mPFJEeMH7nD10zhgo
         Tp3pwTeLQNQUNUhAtoHFogTUtv4dWPrLp0INzI4j5EWNJlzs4j/m9HKSlxuoo4Zx4Vc4
         yHf7+xApdFQLTragTbZVbtQdBpa38jGE+Mfxbkxaiu0Ba3w1U8IzZQO/cT4VhvHBriHE
         KnmWQeK9d5YV94Jvq3O6m0CCuFmQlIxEJuZEopJZUmsmx3trzm8+kZYWNq5RlRHBDwIx
         kjesDAAQE/JcKDYkwXOgdGpAHH2YNvNIZQY2FhyPPrVSic5buTvS+joeuRJSm4CcAfqi
         J1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=C5hIp9nN3W2D7dzzH3jnznt8lv8D1GoBfgVUxQcYfdA=;
        b=39RRtJYpjT613VwOg7XJd/71UDAlJobiG4tDKetqKk1K+tUmSxpot4h12R7vEIPI5O
         oCC17ueM1H1XodkJ5LGv2mPJsxpumXrmcY/pJ0oQZoh/kRrSUbwp1bWINne1ipgRUTjk
         hMGR+PFclCkyd6DoZqvpRJELx7lOQb8HSS1o8udFgJsDcHX9G8WkZWTj5niOtGhbkRYR
         Q/oxCZWl5h7Jhw0Ej+FANhe2JD8G/BDehnep1b42IaisvtVbQ9Ip76ffnKa0T/ZcGafa
         qZV7wlCPWhh7MZhSS+WkPi5FjJDx+0OI/Ee49ZjpER+t9kifIEs9NpO1M99DocsxFr3O
         7vhA==
X-Gm-Message-State: ACgBeo2sNG6nIbEAkYFM6QVXWkrLShs4nJ78D9KWbqEFVp7KKExHIOvh
        4bpKCHFHeGQ6nQR4VX+u6tMObQ==
X-Google-Smtp-Source: AA6agR4kVpxGb+hu/RdLINCQjhOEouQk7sPF/ixkY18l6sQPYqSK2LTnY52/7OGqIcu4I1Dl9coZWQ==
X-Received: by 2002:a2e:a54a:0:b0:261:caa2:8d74 with SMTP id e10-20020a2ea54a000000b00261caa28d74mr778475ljn.11.1662548794272;
        Wed, 07 Sep 2022 04:06:34 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h23-20020ac24db7000000b00496693860dcsm1292490lfe.232.2022.09.07.04.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 04:06:33 -0700 (PDT)
Message-ID: <aad73da2-101c-6d76-5103-c6e66d7f2ea6@linaro.org>
Date:   Wed, 7 Sep 2022 13:06:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 08/30] thermal/drivers/exynos: Use generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
 <20220906164720.330701-9-daniel.lezcano@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906164720.330701-9-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 18:46, Daniel Lezcano wrote:
> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops are
> needed and they can be removed.
> 
> Convert ops content logic into generic trip points and register them with the
> thermal zone.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
