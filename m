Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551704ECABA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349318AbiC3Rfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349319AbiC3Rfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:35:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7323193E5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:33:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j15so42930798eje.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v0ypuDOZ9iczYgFgx1CgxJv5DcfIjupX67FG6Uawm28=;
        b=Dm4NkdgRizF5UQHrmqClnq9Isje3UUn/6mfSP4EzRO9H4lnnvVVEQ6DnQATUMmZ1Fa
         8tLkTSxaqIdLUv20E/Gu7Q/D+Bf2phajGvNvFRcAngMSJKL6GvlLqrF3BVOqwVYo7dv2
         O5eUq/V1HRa3gacQHhwgilqItG9HfX7McmwvquTGOF29bJRWfX+E49xK+IuBEfn30fo2
         HEKTJ3Ktt2hOU9Q5TFLhrMKTBW6WGIdyda3iv6ewbq/rX9fCGI27hnE2eDFYjQT7L1pz
         dzYq71C8W/guTKY5YxX+v4lUmxUR0ypPvaLjgttweJWRW5YIBMAkQ3JecwKv8cPbpASG
         UI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v0ypuDOZ9iczYgFgx1CgxJv5DcfIjupX67FG6Uawm28=;
        b=eGHr4cbAWB6FGXxJCuWuM0LJNi5wS3i/nFQo5aqrFGUrQTykzJFuZOyoIz+QLhJ4tN
         uxK8f0R9GSwasGvgxGP3nmyNPnP8C09nIUJQ39yylxHw5bT6x1Z72IcMDsYwvcdoSx8b
         87HDBRMQkO42Fy6lB8wEwjicO//ss28UUtry7XBRK6iQTM3dJXVQtcw+NlMyPwBiwD7+
         FdaGRpfMuWymdbLKHUm/tUl3Eq5JzWrBvRguwnVmw/1aftmqhzYOPz7D+7nOGgETBH0K
         KYsAqZayFD/tyt9Nn6b7GGkhiz7myD8WsoS5qE0c4h5ifzfIwtRrq16ryc8ftvTuj8P1
         tbng==
X-Gm-Message-State: AOAM531NGoBzRp/hKQNpXLorarFkGwWK+l6lqjf/lcMYzvu9uXWFqlPJ
        JfNOMjJYSQrnlkmRCevbhjEAWw==
X-Google-Smtp-Source: ABdhPJx8VM85FNTNB3nTJF1PZIQmaZo0yaLCn/umk7bKrByJw9kErPb8vzRj3m4+OkxUDwCBIhXXlQ==
X-Received: by 2002:a17:906:7944:b0:6da:b834:2f3e with SMTP id l4-20020a170906794400b006dab8342f3emr681549ejo.353.1648661625373;
        Wed, 30 Mar 2022 10:33:45 -0700 (PDT)
Received: from [192.168.0.164] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b8-20020a170906728800b006e0351df2dcsm8533922ejl.70.2022.03.30.10.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 10:33:44 -0700 (PDT)
Message-ID: <5ecf5ad4-a0f7-69f6-7d00-2ae4a83e5f29@linaro.org>
Date:   Wed, 30 Mar 2022 19:33:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 3/3] ARM: dts: rockchip: rk322x: use generic node name
 for dma
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220330121923.24240-1-jbx6244@gmail.com>
 <20220330121923.24240-3-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220330121923.24240-3-jbx6244@gmail.com>
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

On 30/03/2022 14:19, Johan Jonker wrote:
> The node names should be generic, so fix this for the rk3228 dma node
> and rename it to "dma-controller".
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm/boot/dts/rk322x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Squash it with your other change that type and submit one commit per
sub-arch (so for all arm Rockchips).

Best regards,
Krzysztof
