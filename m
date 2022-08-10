Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03A158E5EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiHJEEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiHJEEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:04:42 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886426FA0F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:04:41 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w197so3313055oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XU0Ac1GCss7BeX+7wQZsonyyhY+oJyLZfcAs4hLs930=;
        b=Z9+DV8QyBZuVJ9FKP8Yy0lmju+Z8wQkiILVu/3F/RlBoLAiXZoAV9CH9WDq1a1ys+Z
         LuQxfT5FTc7kbaDAjAxmhgU1o+h/UiIVkmZyW29YL+uyb6j75ekcUBHMmaj7yo6GQVbM
         Yku5aRmwv/9ykjO89j0twj9bS6H+6DCcoQwFYenDq/gV0RjNCSACE5N+tQvKfsJzhCZl
         +nxZz5WR8UPfLpWay8wBGSE1tW59WUig3hI+Yg2mc6wUVvFniV1WF0Qk1pfDtMkqfpce
         mWy5oewkZLmREL/DXxWbo4Y56rBK4pO0pfdYnTlDp7/N0k7dD5ZvDnbRXKOEW/0n+yLN
         pteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XU0Ac1GCss7BeX+7wQZsonyyhY+oJyLZfcAs4hLs930=;
        b=sC+aHfKUby11sOpbRxDNhpg/YuTqKqtWkm7PMdoHK0RVMGjaZ8QtdywUWnZx5GgUMl
         TpgBt/PEEgymEJO5nBKfFUyaAEUnJw/DJ95IeOXr/4iKQXnB0xbzz92ZagMn/BCtN3QQ
         elYD0yJMSB2XEXGjwMfgiqMJ1JSCI2C9aHgVSJZZ2AAWTBK63QaYyl2EvYmGtL3KYOmV
         haWf1+x2AbQWPN4LGHJYTlUkCTpChiqitOwBMN2/ziqDYIbpsgzLOnnPN15mG9OMS7VI
         sHITda21x2/GL+sQmsclMW8xA2LL0gIkMEKuvo8fyfyEoKl4zlay1y18SKJP11ABUOFS
         DuRA==
X-Gm-Message-State: ACgBeo3WjSoD9sMbrWK5NcBJiEJpPsW63+PP7o9PkGgE3p01ey2Y6V1+
        Zjb4t5Rna0h6N3rnwtxMylPnFg==
X-Google-Smtp-Source: AA6agR4ZhVepjq9h3rXwhD0cyVYuwMNwkpcM8ICnBahQKN82LYxZqx/0+ccZv4fgoDu7/7mTqvf+/A==
X-Received: by 2002:a05:6808:1244:b0:2f9:e450:4bc4 with SMTP id o4-20020a056808124400b002f9e4504bc4mr652208oiv.290.1660104280931;
        Tue, 09 Aug 2022 21:04:40 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id y10-20020a4ab40a000000b004359da266b4sm463355oon.14.2022.08.09.21.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 21:04:40 -0700 (PDT)
Message-ID: <b06adc0e-6e24-5419-4e6f-33ae2029b828@kali.org>
Date:   Tue, 9 Aug 2022 23:04:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 0/2] power: supply: Lenovo Yoga C630 EC
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20220810030500.2793882-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220810030500.2793882-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 8/9/22 10:04 PM, Bjorn Andersson wrote:
> This adds binding and driver for the Lenovo Yoga C630 Embedded Controller, to
> provide battery information and DisplayPort support.
>
> Bjorn Andersson (2):
>    dt-bindings: power: supply: Add Lenovo Yoga C630 EC
>    power: supply: Add Lenovo Yoga C630 EC driver
>
>   .../power/supply/lenovo,yoga-c630-ec.yaml     |  88 +++
>   drivers/power/supply/Kconfig                  |  11 +
>   drivers/power/supply/Makefile                 |   1 +
>   drivers/power/supply/yoga-c630-ec.c           | 547 ++++++++++++++++++
>   4 files changed, 647 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
>   create mode 100644 drivers/power/supply/yoga-c630-ec.c
>
It will be so nice to drop the "some-battery" patches that I've been 
carrying in my kernel sources since 5.7 :D

Tested-by: Steev Klimaszewski <steev@kali.org>

