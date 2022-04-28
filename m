Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED133513798
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348692AbiD1PDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiD1PDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:03:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427A512A9A;
        Thu, 28 Apr 2022 08:00:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q8so4597310plx.3;
        Thu, 28 Apr 2022 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=FYUWi4vkuGypzkaoW/GrEwcwOVXevYtnTdO9X9e1buU=;
        b=iLbZNiSk+pMv0mMhNDMobKgLlw5630f+/sUl3Lam0GQG0pgIk/yXL0ofgK0TBslC9H
         q93kE+LYs8WflCxBaf3jLWNlBbes1MkU+ZUqgAHXV+9bAuSsT9I5lMweqEdZyVE/AjVV
         1H50PTpLhuMZRu1WqaYiciexF3gHJ3ok3ERQC0kDd5f2ikPlpEBpBgByKkN2M7DXfxDl
         HhPaOLHjdz1OwGEAgmccAkzvrjUtucBK3mUH7SDZpukCLx/tp3TunvVby6nvfVfQ+yiL
         SvXnpI/Q4AkJQ+3F1HnbfDbEvr6MIcIMjqYySQc+mrJwzpUvHwTuhOZRsLOwYBLA3U/U
         ElQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FYUWi4vkuGypzkaoW/GrEwcwOVXevYtnTdO9X9e1buU=;
        b=cAIgzg3rSct4Y9OPPYJ3kiIO0bDg6QqOfdoZ+YbC1mV4v5oSefUnpSfqz0kVhU18+q
         96TpsdVPKc8T05M9FDDtigelkd3aXpbBsPqv+lHlqTEgM6FbEkw4wD3QnGYRGdlNnfnQ
         B6wdtAYvldvcKf8KqgXYrL0EDGlyydUAPRS/tRYwrxydXQwV388EOJ9a5puXnEXo9E16
         5VdKH08Qqfadbp/IDbvRZ+nx1Y0+yvOR0PRpB1mpZyHFjZenUdOT/vx2eJKd2GYyV/xF
         RtOPx6oZQbcydGXz7hixLCFPsoSQWMOzMzns0Vkm/Ug4PSLI18JeK/+5MZq2NmfJHLq1
         FUcw==
X-Gm-Message-State: AOAM533EeP8eAem6eIHwgW7Cz42d8Cx/YJmDf8nOCp8kQ4Lt2cumKEq9
        lL+p3bN5iq/f/8yNLRawIrUHapzgSeI=
X-Google-Smtp-Source: ABdhPJyg+1m3ua5MWgkCAUcgXZ0Dtwt+jstW9vVHiB6nSOMYMh+3mbDaT/pv0lRwmNriyngKnrhSww==
X-Received: by 2002:a17:90b:4b41:b0:1d9:b562:5bbe with SMTP id mi1-20020a17090b4b4100b001d9b5625bbemr15012080pjb.61.1651158022765;
        Thu, 28 Apr 2022 08:00:22 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:e9ac:ce6:5da2:8724? ([2600:8802:b00:4a48:e9ac:ce6:5da2:8724])
        by smtp.gmail.com with ESMTPSA id w9-20020a056a0014c900b004fb2ca5f6d7sm133968pfu.136.2022.04.28.08.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 08:00:22 -0700 (PDT)
Message-ID: <e25544bd-6fc1-e5c0-79b2-71e5d51bcde2@gmail.com>
Date:   Thu, 28 Apr 2022 08:00:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: mmc: brcm,sdhci-brcmstb: correct number
 of reg entries
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220428081817.35382-1-krzysztof.kozlowski@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220428081817.35382-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/2022 1:18 AM, Krzysztof Kozlowski wrote:
> The binding should not allow infinite number of 'reg' entries, so add
> strict limit.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Given Kamal's patch series:

https://lore.kernel.org/linux-devicetree/20220427180853.35970-1-kdasu.kdev@gmail.com/

we should probably merge those via Ulf's mmc tree to avoid conflicts.
-- 
Florian
