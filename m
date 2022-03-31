Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74444EE297
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbiCaU1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiCaU1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:27:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BBB231AD9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:25:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p15so1645139ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EnDTCNJ+7XU4ln4xyk+2CVy4Rghf4UHAtu/NaCOKaBw=;
        b=JjMKEBcrX7m9SwYbSuUNE9FeMNTF0HKQRWR7m4rnjwg0CugqGEiVkTz49KWmhsD+Pt
         DQFcJWQpiouy4sd/+3AMtRgy3AfPM1hz0jKgR6xnBZxOVy0cx/j+WQPWCRDYK8BM1dpQ
         BXUUmmUY4dCPCjkebnVvsUB/jwMde9ZLABKuwn9ANjdhyghM+V2+tt1xq6KNVfneoc65
         C4AUVQGb65ENqT9sO5nR6ME075xaY0fifaf3ph+kzzROF+T3nV9jHZzV+BC2vPf+K1e3
         oUqO/59TmJ8zDeKFHNqzOl2tm3otQyj0pesutRdiwDO2pJdv/ewPt9iScOOoG9KF0vcP
         Jo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EnDTCNJ+7XU4ln4xyk+2CVy4Rghf4UHAtu/NaCOKaBw=;
        b=mPxTUkR3KRbqUduk6HWg0xrw4MiH2ariFgXPnJWhLK0HUVTM6/S8XTvQ3lsvi+3oft
         Rq+x3jalTPF4jPYw9ay6ibfVnl/IJYWAnWZQV9eQNw72Ms9yP0Uo2Z2osWn0lSzt+jzB
         w2lCtRjfR6xmsYdGyAH/SumfU3VljN+kvwVJEi63MMIGM7vYU809QtHyYp0tq1rg/6Fa
         5ot9iryCdBTv5eH4yvU1RAqZXJapOWXMS3PnP7ARtOiscAfutNGOdwhYYQWqJfAvqPO3
         ttWZ6q7QvSQpiaIF355HhnxvkARV8SoHT3uM1clJuxsTHqWKD/QfSORG0sbSxfIV+hj+
         iYnQ==
X-Gm-Message-State: AOAM5311fhzVaUFmHTtfb5bxbESo24bNacTdClvdKfNaxzkdJNclTGxG
        N98BAfKtm62uBN8UkyXMyd1UPg==
X-Google-Smtp-Source: ABdhPJypNYgpGQOMm7TyLEDGxO2W5njStEgyvsioj1MkvFKTEWNVFi1MFwPb0ZXBrqnEMm1OubfDnA==
X-Received: by 2002:a17:906:1153:b0:6df:d816:264a with SMTP id i19-20020a170906115300b006dfd816264amr6259674eja.546.1648758331416;
        Thu, 31 Mar 2022 13:25:31 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id wj1-20020a170907050100b006e0f9bc719bsm168499ejb.72.2022.03.31.13.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 13:25:31 -0700 (PDT)
Message-ID: <3eb287ae-3eb7-604a-ed5d-8b71e8315323@linaro.org>
Date:   Thu, 31 Mar 2022 22:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5,2/4] dt-bindings: pwm: Add compatible for MediaTek
 MT8192
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        rex-bc.chen@mediatek.com, jitao.shi@mediatek.com
References: <1648730873-18505-1-git-send-email-xinlei.lee@mediatek.com>
 <1648730873-18505-3-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648730873-18505-3-git-send-email-xinlei.lee@mediatek.com>
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

On 31/03/2022 14:47, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of pwm for MediaTek MT8192 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
