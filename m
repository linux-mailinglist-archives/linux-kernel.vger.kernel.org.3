Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04A0581A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbiGZT3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGZT3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:29:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013632A711
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 12:29:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v13so13700890wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=WUOSkRQ3fQqq70wMpzepWE3fWlY6MVxN11eTEnWzzQE=;
        b=MyeztoY+OUnOXpaoBRs0XFJ2UH5Apm1p/Enuxaps1LrEATW9K0ljoZXzeCAz3plZrM
         G9SO9hAKUfHImcfKiPpr3yg264Iyvtph3mvf/27Dxs08w0mK1Efd2n5UVNaEEr3tz9gB
         oGfyK/d7tnd2snsDkM7AQ7Je/z3ZeM4H8RXERMxYWR/cB4ehGxZeb2HBN1AhiqibbAHW
         hZxnaV2XnOc1WV8Z6MA1roOy1mV47J8SUSu6C+UUxXHSyPEwSSBUFYrPv9yZIhYoTYJt
         u7dVUNUenxyWY1N5VbNlAzm5+kYFR+9jpsSn7qGgog8kWLTFgzf05e+6A6PhH5eEB8zw
         RUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WUOSkRQ3fQqq70wMpzepWE3fWlY6MVxN11eTEnWzzQE=;
        b=n5uUDPGpvWZ1ylo4mYEPkuem4w5nHYIQKYYKKAtbtU9gy62/FjLLJXwhUUOgBaUSCG
         4bLEF90aacrz/gNxfsjod2IToqFdd2QCO7LJWrcXMFJKVzYIH8VNcfe2Q5dEtXEB1xLV
         FVdL3UyJv6BFrLvX29R++kyt0Cfmf2EqI873Eb2dGKF1e8C4LQIp9a7b99jS4lvURkj6
         09utqG6E+vX38YiR44hEA4XBaQw1m2vj7M8fnqmqn6al//o8ii+cOG8iy0Pbga+zF0pH
         a+Sd/oHCL5KD4XvoQz1sMD9gTeoF3MvtI2tFTp2FR0LvHYTZzzDPWmoVmP1lxhgklfA2
         5zeg==
X-Gm-Message-State: AJIora8+tVIBeDjC3YuspLbEz1oWCyqP+nuOOvrXrA8q5oRCpBo8p+c/
        yS0jTCbsZ7VxgDtbXCyGkHDmeQ==
X-Google-Smtp-Source: AGRyM1uPRQE2CT3+NMtMbvn2eH53F1Bgd6i5gZcFUuwu8XnFYFmHZUeNsQ+iHpqXZKMzppVLoBypUA==
X-Received: by 2002:a5d:6da3:0:b0:21d:cde7:cb7 with SMTP id u3-20020a5d6da3000000b0021dcde70cb7mr11258338wrs.683.1658863761366;
        Tue, 26 Jul 2022 12:29:21 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d08b:b37:d7fc:8179? ([2a05:6e02:1041:c10:d08b:b37:d7fc:8179])
        by smtp.googlemail.com with ESMTPSA id i13-20020adff30d000000b0021e4982270asm15628288wro.13.2022.07.26.12.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 12:29:20 -0700 (PDT)
Message-ID: <b1972a54-324a-63af-fe6c-51715fa972ba@linaro.org>
Date:   Tue, 26 Jul 2022 21:29:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: timer: ingenic,tcu: use absolute path to
 other schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220726115937.101432-1-krzysztof.kozlowski@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220726115937.101432-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 13:59, Krzysztof Kozlowski wrote:
> Absolute path to other DT schema is preferred over relative one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
