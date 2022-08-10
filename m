Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5158558EE95
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiHJOkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiHJOkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:40:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E03E56B9E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:40:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v2so12892427lfi.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=L/tgf+Z48s9Th7NBCKhEbFwg777iQ/j64Fh3Yh4ebMo=;
        b=A9UCf83dopJOUiY/S85JlRChGLQgcu+YYkKuAqbulaDo6uJ6dzdQHMyBtb4ehsX3Wq
         LZVdNkBsIT1BW0oKFc5Tq1UHJCqZAxebmI90gOj+fTTGuV+llMpkME6edHStGDJAih4b
         EaGtGi2Ot87f7Kd414tmhIaRa/yBFX2vdZydFJX83HM7N2vZHII/VJ34GYZ0XxZnXdge
         6Jgt1aS8i7d6UdOtk/EhfhG3xP0+EUkYckZY6Cg19u/pTRKbPaL5kKPvEumFiJdwSxsS
         dksEzyEiP7JuSN5XWUD4YEm4Q131snKqUyCuu0UmW4Et1s7YK684OaiysTM2mVinEjlj
         oLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=L/tgf+Z48s9Th7NBCKhEbFwg777iQ/j64Fh3Yh4ebMo=;
        b=frlgf2vwgPCvP4vCKSRc1jzBWMVlRnSiTO2pDTRHMhXIvvFgg6WE6DD4GY75/wZrX0
         oyqFyYkO+KacM1LQTjxAn+wBIuVE3n4w6CsnYO6n1xFlAdLGGQszTkyH//NTqmlwfbcZ
         45DBDPpZcnSTDH+XJHGS85G3WQhjNITtPHCsRQP9byxcV8fkrJwwxuAzZJah+HQA2+Zu
         QgROM4yOyfCxcEnqCxlcDwomrKW8k3l8kIz3Bo5ZAu6zdeD81KmdUw/KMcwIWeJ9c9TB
         c5FORxuUlCv1zci9lqWXYPomEc2pu+Ak36Oq11eLRtl/2rMOmw+zCk216teMXP3eaJlY
         8AlA==
X-Gm-Message-State: ACgBeo2jFSIp35yqtVjrpxVguAtjV72Lx2pg8m8AFLRFYCjZVj2tUiHv
        rOxsnyn9OMCU/xUIpYCINndAOg==
X-Google-Smtp-Source: AA6agR5QLdeSd/K8cbeNS1YGUCuixyr5QLObCJ3tlY/soLXDvGWMFOLqSStz9wiLP8VXBb+DCFYzbA==
X-Received: by 2002:a05:6512:3b06:b0:48b:239e:be with SMTP id f6-20020a0565123b0600b0048b239e00bemr9463551lfv.586.1660142402540;
        Wed, 10 Aug 2022 07:40:02 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id a17-20020a056512375100b0048b969ac5cdsm370434lfs.5.2022.08.10.07.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 07:40:01 -0700 (PDT)
Message-ID: <826f20ca-fdf0-cd40-339a-6fa9786756b3@linaro.org>
Date:   Wed, 10 Aug 2022 17:40:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 1/3] dt-binding: counter: add ti,am62-ecap-capture.yaml
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>, vilhelm.gray@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
References: <20220810140724.182389-1-jpanis@baylibre.com>
 <20220810140724.182389-2-jpanis@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220810140724.182389-2-jpanis@baylibre.com>
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

On 10/08/2022 17:07, Julien Panis wrote:
> This commit adds a YAML binding for TI ECAP used in capture operating mode.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Subject prefix is "dt-bindings".


Best regards,
Krzysztof
