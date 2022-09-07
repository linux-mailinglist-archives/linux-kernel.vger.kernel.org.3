Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897CF5B0469
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIGMyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIGMyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:54:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23D518E3A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:54:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so9976539lfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cy/trsDd8yLTVEJh558cDfunHTs2Qb/idq4sWa7wWtQ=;
        b=QiseaVKCS5hUrwI2xGuLM/GjaR8lfhJQrIIsBqcLm8+s8oHqS0PtwAmV8ReO7E1HUE
         UWVzN2lW2f8oY4uGFGT4H4xNxxMYDjDJt4dt87iK4ESQAiK3dBHBAx0tVAAra8tGmFeT
         2AM5LZbyIClWoAb+bTcLpwYa3i+7MNLHHay6eWOHtUcccntXWpLtjK/M68Qt2U3lENFR
         6rNsm9h4S83DOoqsrjFbqJQisYTzrJXkMjJz+2gIHbpJww7rVylEsinQ4BbDcT9/mWEZ
         5SK0hfZgjT6EAwdx29hg5boGYbrEj+hEdtUNOKT3sLXrgEp3Nh5K6iz95zj8DkF54xG9
         JDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cy/trsDd8yLTVEJh558cDfunHTs2Qb/idq4sWa7wWtQ=;
        b=rL8coWo7U7w6D/9CMai/BXYOK2fh25OYKYeoVOXz+zE1PhrAS3ChZYhx5FbRyjgVB0
         2E+hT4s/OoOmLGpYU4KobXtlezSUNGNxxHiP0WnZueK7bxAT3tw9H8A7YGZgmMaWg1uG
         Pp000+8T2HQl2gqgVu5qlmbTHUN9n4YRMc2WLReZU8hUC31dehNBhxQ1V/3ciBzxxSfH
         OdfduxOU0nXzRDxewluUgPcyggE1wKv2hy7dR6GsDg7bY+NrFrjqBDG2lx9jOsktG1ez
         Jx5+2otRkcwQAY12xXFhRNvhKLzcLbIludUNwKdZLE0ADkxABPigwr8R/60PqFm2PLVy
         wXzQ==
X-Gm-Message-State: ACgBeo2x8WYIsAvYDTAp+JLKJfGqhtt4bH+gDpsv+DlU3FzRUMZEDTDi
        OT+xVoBkpzEjM6VVMz/gMT8R/g==
X-Google-Smtp-Source: AA6agR4X82GuLVgZJmrma1mw0oOP+orTMPigc9OEMYQBmWdiVJQeXqwdqzGeABYFTlI5gKlLDikahQ==
X-Received: by 2002:a05:6512:2255:b0:492:f5b8:ef2d with SMTP id i21-20020a056512225500b00492f5b8ef2dmr1009522lfu.128.1662555283241;
        Wed, 07 Sep 2022 05:54:43 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z12-20020a056512370c00b0049465afdd38sm2470499lfr.108.2022.09.07.05.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 05:54:42 -0700 (PDT)
Message-ID: <2ae421c4-5e14-d4f5-1cd4-df227d3b85d0@linaro.org>
Date:   Wed, 7 Sep 2022 14:54:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add regulator suffix to
 BPI-R2-Pro
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220906164212.84835-1-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906164212.84835-1-linux@fw-web.de>
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

On 06/09/2022 18:42, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add -regulator suffix to regulator names on Banana Pi R2 Pro board as
> discussed on Mailinglist
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> https://patchwork.kernel.org/project/linux-rockchip/patch/20220825193836.54262-6-linux@fw-web.de/


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
