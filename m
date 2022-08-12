Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83579590F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiHLKqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiHLKqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:46:10 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B920D6B15C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:46:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l21so577017ljj.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HcymQXHxdtVOcEgBn0VssZp+OhA8MUztfXg3luej/30=;
        b=KQyT9gkSS80tNswQCnw26mDxHyeZJq9+pzb2ka9Yzwn9zYkidpK61b6E9pz3isHsO0
         +6TmO5PpQtw4Qm2WypxV4fdSEueXnoeAbgzQxtlee25FcWCBQYRN+4jd8QIKLsPi0czG
         WLbpWCuvqMr2R/lW2afcZkC9f77xJpEq7FL0AxBKVVNyPSrs1zcLohk35ateRH6k0prb
         +3T59aW2f1cm129xT+z5xk3wzHUO7AFzBzvFxjRqLefAxHTF3EdpjZ0gGa4GgCgVERul
         uMyJjr8ytyBkO2bkXG/EXgcXMVTwsJIcoPS6T3YcjqZD1XIc6gGPcfaC5QaEWRc74fKS
         yUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HcymQXHxdtVOcEgBn0VssZp+OhA8MUztfXg3luej/30=;
        b=ATV8OGVzHPBUbXtOmpIaR0RghPiU6X7FOskp9yEGPr9+kqi/YMP3VbCcdJE1nic6JQ
         UFwTVj/mg8D/CXABkWT+PqO07my8cX8rJEKtkRnyL0JC7aNGJp0XvrF6+uzBrCJQ4iJ9
         cehEFo7z3BgJONMzUcG/a32LtUkYzXEzOKioo/Xwlm2bam9WoRyCJAnv/+uMkNOMHYKC
         4HXBWs3o5WtFA3Pm2mQVp0KyTS3PJ4XAHr6pMRzjmmXaVXg7RSuCZwkmlf+ZkbzgLGoN
         1FVV7snEDJA54mbXervP1ckvl8p/WRacXoNtLAG0Sc+qXZTwTi9gIf0Kcq+hZm4hECLX
         i1lA==
X-Gm-Message-State: ACgBeo0QvqYFTOY5ZAas+Fj+mc455850X1SUyi2ROXu6VTiNjwj74YhL
        YpGv9Yzb1KmaPdUkShx8aVzvaw==
X-Google-Smtp-Source: AA6agR6bi6AwFioTlQi1smxD8HeUMQmnbOqDkeVxg95idAlpnE1omPwD1bXNcdWThP0ZO5GBYtYk9A==
X-Received: by 2002:a2e:9c8a:0:b0:25f:84fb:c98f with SMTP id x10-20020a2e9c8a000000b0025f84fbc98fmr1043315lji.478.1660301166150;
        Fri, 12 Aug 2022 03:46:06 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id x9-20020a19f609000000b0048a9603399csm172667lfe.116.2022.08.12.03.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:46:05 -0700 (PDT)
Message-ID: <c85ec3a3-fa6e-aa71-a847-22062b9683e9@linaro.org>
Date:   Fri, 12 Aug 2022 13:45:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/8] dt-bindings: sun6i-a31-mipi-dphy: Add the interrupts
 property
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220812075603.59375-1-samuel@sholland.org>
 <20220812075603.59375-2-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812075603.59375-2-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2022 10:55, Samuel Holland wrote:
> The sun6i DPHY can generate several interrupts, mostly for reporting
> error conditions, but also for detecting BTA and UPLS sequences.
> Document this capability in order to accurately describe the hardware.
> 
> The DPHY has no interrupt number provided in the vendor documentation
> because its interrupt line is shared with the DSI controller.
> 
> Fixes: c25b84c00826 ("dt-bindings: display: Convert Allwinner DSI to a schema")

I don't understand what is being fixed in that commit. That commit did
not have interrupts in D-PHY, so what was broken by it?

The Fixes tag annotates the commit which introduced a bug.

Best regards,
Krzysztof
