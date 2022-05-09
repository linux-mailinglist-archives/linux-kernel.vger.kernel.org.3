Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7B551F984
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiEIKRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiEIKR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:17:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B3B27EBA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:13:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 129so8081991wmz.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 03:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qgkx9ZC8YGJJeK5iTMZYlOqvFF3Oqattg27UJCiRY1Q=;
        b=Pi3Xgsw+zt4lcSvgy01HxAxeKPFRomrVRyzr1Mh7iUX24+iKZGe77eE/XeZokDgUK8
         yUpbrar1CwEtSqJpt1JaYJ+Vcm4ESYQMY5t8/5jvPYr9NRz6jW/7mcM8vSfHXYhoZvrS
         28hHPFW/5ec+50Fces0xUNsRNMNMrSqjjieqIR28jeszSVFYacK7MUZ8Xrq/JzblklgI
         CjGsMLz3dVfBZ6g1SBY8xywboRbMcVIVPCGx9vV800o7TB3nMkShpEkkIIVxlKWahg2s
         8YECUEGbCuReXVLhhsK8RcgUFWbViaxNg31dPs8Ms/zPhjMxtuXBn0Ir46i/rGa4KNzQ
         wxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qgkx9ZC8YGJJeK5iTMZYlOqvFF3Oqattg27UJCiRY1Q=;
        b=TvqWnoDzhahBPOEjrS2msql/rTHTTrXQnWuhvNntWHo21BGivVZkN7dQ7BCk2ByEjd
         kKXCweuW3r448Lxu/oYJEOYKhYQ50qhkwIpMD+xm6WLdtc0Tj/ZbQsmHTGaHcmyUPR4q
         NJFDhyUzCZUOettnYqCYGSvQgoAIjNUB1Q1BkG68oM017q2SGD2wycFV0VRd/ygV+vxe
         hDA1uyorDcFFKZrAWkjvj0rOoIgc8tC4wTn0pcliYCtnGg0+wlSc6ueDzGYIK4rc2gUs
         2u7QnsAenEiUF9gi1DEUn9vT9W8blFTe4WQpickEkZME98HrW8DKtJQ+Oa+CMIWGL+qV
         Dj9Q==
X-Gm-Message-State: AOAM530s4gOPQ8gSW/v/ElOe3tnDEXXAJmL7cnu9gs0VaCFnabcnuh+w
        b0P2vOlJQ8JU6AVC49e+MfFbJg1LGxK8wg==
X-Google-Smtp-Source: ABdhPJwIftT/UsBQmfVV48i+Vgca7Yqe2sTYcpBIUm433z+geRhMUia1x9txLA/Oj+TL2SMmKfKeXQ==
X-Received: by 2002:a05:600c:190b:b0:394:96d3:5780 with SMTP id j11-20020a05600c190b00b0039496d35780mr1627274wmq.82.1652090567943;
        Mon, 09 May 2022 03:02:47 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id n11-20020a056000170b00b0020c5253d8c7sm10283350wrc.19.2022.05.09.03.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:02:47 -0700 (PDT)
Message-ID: <bb05dd4b-3114-73bc-0bd8-81e30dac1497@linaro.org>
Date:   Mon, 9 May 2022 12:02:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] thermal/drivers/qcom/lmh: Add sc8180x compatible
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220502164504.3972938-1-bjorn.andersson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220502164504.3972938-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2022 18:45, Bjorn Andersson wrote:
> The LMh instances in the Qualcomm SC8180X platform looks to behave
> similar to those in SM8150, add additional compatibles to allow
> platform specific behavior to be added if needed.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
