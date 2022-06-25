Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C3155AC5F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiFYUGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiFYUGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:06:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0251B140C3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:06:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z19so7785970edb.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G+O94VcDTtwbrcVKx/+ZQ1mO7kffs6WRdpcMIlGbZkw=;
        b=zaFPw4+a7OLQYwpz7lsAI46E5WXeCd6y3P2HAHzXf/G1JCAiYj5ELtObWDkDuOOW1A
         V0+hVFmG2q4UKw2Kvafmn/Z+q5yQQLXhg/B2347dNO4gYLrIxj83Ns8+5aqawGHe3fBH
         E6mAV48lLxRv8c+WV0uCND05k107DOzYKJsxxxA7UdHLoLoGkpWj/1O/kB87FKkC2WeI
         WXkkeEK+4jOoD69nMIrMbVpZDftAqqkLk0qrXZ3/tgPN/vtmDMb3WtlQIpVGPoxnAAJK
         m2Czdob575dF0so3qAne2W7fcuKeSACmbXSITWVfiE+Ce5Hd1J/HZjsNSNY67sZC3244
         KR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G+O94VcDTtwbrcVKx/+ZQ1mO7kffs6WRdpcMIlGbZkw=;
        b=5maQ/0N23WHuKxhyeeaN3Hs/LUqB3IhHa3U6DAh7Wvf/hyIydBWYX3TK6eGC/jecwh
         wLrk8M2pfAZee/1CIJtvOiBYurts6Q+/FbiMzQw01sbNYUcZNlNfvBfuir0wG3/NZ+L/
         lxVEbCeYn2nvL+uBahgbQWNdlEfjJvLXaKf/R0BtLrD+MNd/vm92wTtRy6wzgpkQXiU4
         iyrCyXyavR81U+M8tTzNLCKA0yv7HNQrwh3RFi9OwIFUlyV8TyOgr1JgW84CLyoD8uwR
         w4DZ/pbT1hmWo2rwWcVXngBZ9BwXhh86vbUKW+wsu82SUyQqR+alCD+MH3KfZzHMPxlL
         8fIQ==
X-Gm-Message-State: AJIora/SLm+08QTSKGTtMwcOY+fHs6H2K0GJ9nUxeYif+aLVRaEMQwF8
        8hn8OGqZX02NF1ciN5sU6IK4Eg==
X-Google-Smtp-Source: AGRyM1skFoOAS415YobZwbpZc3SvDFRLuL0LmIj9Z9dcWxQlEkNQADeploUM3OA5k/vHKAIH2euACQ==
X-Received: by 2002:a05:6402:5193:b0:435:9a5f:50a8 with SMTP id q19-20020a056402519300b004359a5f50a8mr6964593edd.212.1656187565646;
        Sat, 25 Jun 2022 13:06:05 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jl18-20020a17090775d200b006fec8e8eff6sm2990023ejc.176.2022.06.25.13.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 13:06:05 -0700 (PDT)
Message-ID: <b3482122-8d2d-61c9-7d11-ad4fa2798aba@linaro.org>
Date:   Sat, 25 Jun 2022 22:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 05/10] dt-bindings: iio: adc: mcp3911: add
 microchip,data-ready-hiz entry
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
 <20220625103853.2470346-5-marcus.folkesson@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220625103853.2470346-5-marcus.folkesson@gmail.com>
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

On 25/06/2022 12:38, Marcus Folkesson wrote:
> The Data Ready Output Pin is either hard wired to work as high
> impedance or push-pull. Make it configurable.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
