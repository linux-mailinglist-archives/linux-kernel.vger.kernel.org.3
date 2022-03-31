Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0F34EE2A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241410AbiCaU2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241402AbiCaU2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:28:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0349237FE6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:26:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id pv16so1801178ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=f73Q9p0qBCca26wqwVLG1FDBxAuPXokqsFB4tXzSY4s=;
        b=P1skQxIlyDTPvqcv9bZzPF+oUpOHenY/Gfo0gUL4RedTQ4WTOA22DjejZ964QW9UOd
         bAAY5DyScLh5swcrBUpsuWKxnCByTweeiZ9jTEmsXZ/+QHpPdNOQDXUhIqAhzzag81zB
         MnKxir38ncBHR/4uVJtUpE2SPTnoSlAkaEXYEf/0QJvo18vX65LtePtZOLI8gjeRB5Og
         VoxSi0fs/58Ozvx3++XfoCLAZtIzM6UmHXHVr4pMcq1Rn5tqGjxpC43U0bmsqK1wCOYg
         gCJywvyZ/I1MKiltB4X6f9mhEdTv9/3L0klCkkT/qkF/Opg6WSDJR7/dOhLh1PAgydMS
         ND3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f73Q9p0qBCca26wqwVLG1FDBxAuPXokqsFB4tXzSY4s=;
        b=bPEpELgdVlEFVOwJC4yreD9l2byZqau41Cj7b4vEwbBBNbGQkTqOCrs8FnKBEIm95e
         Yui+w9Oro+m0yLX068g+Fnuy8z67uynHgGsAVKASbVBBk62dSUzaH9FH1h9rIvVuHaPD
         IXcdT50kxHVbbAV5007WUE5XWwrLGGeAteIZmO+GFlMIu79RNHnA7j49IfggIv163Dm4
         uJRkDd9Z/9fNt4VswPbAmxL2ipgv1qQSZuya3INBOgiLtc8aM/yAXQcyeQNQKMe78OpL
         8a027qQroYBEphU8uqEO2KjZTZ2nwJ0K6SKZlJsVxZb5jbbh4aJ8kuImXqZTNRa+gMuS
         vlCQ==
X-Gm-Message-State: AOAM530AMBXUZGE5dGJ0mf6Kqi8oqVMLmjnWxczkCZ0QbX1slI33rv8T
        qwmzBQc+0orv+fSCbHNGvdyayw==
X-Google-Smtp-Source: ABdhPJyCds3H8JnxYm26h5BcmMiI9/uHrBY5EdQ2TztoTWFjtsUXlKgqLZSrG4ZzrDNPIR7yzNIFmQ==
X-Received: by 2002:a17:907:da0:b0:6df:d4a4:9d0f with SMTP id go32-20020a1709070da000b006dfd4a49d0fmr6678791ejc.407.1648758405390;
        Thu, 31 Mar 2022 13:26:45 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b006a625c583b9sm170876ejd.155.2022.03.31.13.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 13:26:44 -0700 (PDT)
Message-ID: <00b2d9c7-6052-45f7-6176-e6d7694508ce@linaro.org>
Date:   Thu, 31 Mar 2022 22:26:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 4/4] dt-bindings: pwm: Add compatible for MediaTek
 MT8186
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
 <1648730873-18505-5-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648730873-18505-5-git-send-email-xinlei.lee@mediatek.com>
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

On 31/03/2022 14:47, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of pwm for MediaTek MT8186 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---

You could squash all three last patches into one... It's a bit churn
with every compatible. :)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
