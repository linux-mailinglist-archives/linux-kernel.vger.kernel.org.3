Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4EA4FAE38
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 16:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbiDJOYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 10:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiDJOYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 10:24:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E8A1260C;
        Sun, 10 Apr 2022 07:22:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b21so22463886lfb.5;
        Sun, 10 Apr 2022 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t7pObmncMzBR1tkMh2q+nNaqttzfu0scJK9f192tQRc=;
        b=BAsWf4aEYT7tKfRl5VmGbCeuiBnf7izA99Gu2BuZDc/HUNmT4HCYdn98MrFovbBqU7
         SAu09k5ZoZes7wGrTC8M9nfHBbFAszPJ+GaYbVDAG0tTnpviPvEJfo4ZO6PVrwehLJvR
         W0+8jCD1f8pKb2JKjsc0lMz4EZz4JwRtrjDuGrBo6DwvkakR5k218Oszi4xtCun8i2Wn
         wPrwCGZIyUaLfl7k/UkGb6aRMlqiZD6KjWPgRiq6IhdBDQzEm2V4xLbjg8mOiuUsz5Zw
         BGF9wbYGk8MspIYyTU3T+m7E6Cvpv+D9fpKOeokwOIZ8Swz4izNXe6RcL+dTMa1uU65q
         ksQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t7pObmncMzBR1tkMh2q+nNaqttzfu0scJK9f192tQRc=;
        b=oPvoK1HHnFweNbhgnV0qxaVKubCWGFid8pCtbKS90kMmrr0bb1212oXCfnBk58Zrro
         wvyMYmj7Y2YPQfBrWK9U19v0kMEhZYfFGhBAHdw5Me0IyejnHMsG3u9Xeppk42MUnYQx
         l1z0VjlQzSmppPPiy2ddyRPEzRSjsGjCDmX09L2jBMVHTu1nBB9ZYASt1KlSq1KByDQc
         HlUAnd6RHPlVbYmKMbGsqWanJ0Roq/yCbYRUpgGYXtsYvT2tEyQypcwxCcwk3A7O0L6R
         NcQmb/kItDQ67MP0xBR8cdjPtsposoeGAC0rwVcZKrQp8ULLMQK34l4eAe7e/4nRLxvg
         ciBw==
X-Gm-Message-State: AOAM5300yBbFLI4oVaEdw9mdh7rN5EoeudHI8WuWjx0R8rT3FBi27t9D
        +vLKivaKg0tnivd5q4NmmB0=
X-Google-Smtp-Source: ABdhPJxeYklrJDVBzdUMYMHvnR9R3jMdTjhanlZ0+DrqT4rZQHDH16W00lXvt2Dl1DQvlA8Wx1BVUA==
X-Received: by 2002:a05:6512:3093:b0:46b:814c:3a69 with SMTP id z19-20020a056512309300b0046b814c3a69mr9004775lfd.376.1649600518811;
        Sun, 10 Apr 2022 07:21:58 -0700 (PDT)
Received: from [192.168.2.145] (109-252-138-167.dynamic.spd-mgts.ru. [109.252.138.167])
        by smtp.googlemail.com with ESMTPSA id o18-20020a2e9b52000000b0024af0b04d04sm2881405ljj.1.2022.04.10.07.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 07:21:58 -0700 (PDT)
Message-ID: <3e044f9e-3200-bb26-897d-1977e3825c92@gmail.com>
Date:   Sun, 10 Apr 2022 17:21:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v6 3/4] dt-bindings: memory: Update reg maxitems for
 tegra186
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-4-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220406052459.10438-4-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.04.2022 08:24, Ashish Mhetre пишет:
>          memory-controller@2c00000 {
>              compatible = "nvidia,tegra186-mc";
> -            reg = <0x0 0x02c00000 0x0 0xb0000>;
> +            reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
> +                  <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast channel */
> +                  <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
> +                  <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
> +                  <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
> +                  <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
> +            reg-names = "mc-sid", "mc-broadcast", "mc0", "mc1", "mc2", "mc3";

The "mc-" prefix feels redundant to me, I'd name the regs like this:

  "sid", "broadcast", "ch0", "ch1", "ch2", "ch3"


You should also add validation of the regs/reg-names to the yaml based
on SoC version. I.e. it's not enough to only bump the maxItems.
