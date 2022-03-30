Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AC24ECAD9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349362AbiC3RjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiC3RjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:39:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62C9C625A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:37:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b24so25278821edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=37nZjpO60xxhw+JhGH6lR+UcPHceWR6JokhRQOsZJzc=;
        b=Y9OImyp0CCzDW/sTETs6Oeh2Q8dOngiPcTEP4MIS7vr96udYAzC8rHKECvJDt9Eqzl
         4iukmxPudcgcFH0/jRiF2Q7fGJuzrWddCoVl5lEdBWbtZ6raVW08IvYiThZ3+PJ6lBCW
         5Lwz0bIWijGZ/1V4jIy8BFVXf6M8XSkrl4NrOf/uBcQ1fL+StwDXfNPnoOz25WnKKavD
         eVuIaibiVjpIICWqLyuGzG1WxP3PhlOjDWgbTTmGpbX/fubtIR1AfA4Nzdk1h8aIgA3j
         egKxhxYEMU6YyRo5jnrAroMzW0mT8otY02piLFs7NdeAdHpFFss8nCbWEmUbpxBKR9Wb
         kbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=37nZjpO60xxhw+JhGH6lR+UcPHceWR6JokhRQOsZJzc=;
        b=WkOVcEvzTu7ijG/M/t7OgumWOYkb1QQ7rHCQPEf4D5w2eM0UbxM+s0P2lnfugQsT8s
         uO+46GNO5AEaR8A+K2I8FIu9AKmqiYiLtFjluRd4GlRNaNcD/qkvNSYJciTQW0b/Yjbi
         9L0q8K90jcP9t2gGssJICfjDmZZT1BVpAtR6NlAqLezBC3k+sAxZdsEyvSaSPxQCyXFC
         i1DDIOZ+AFhxUCCh0Rio4ljbmoszPczmS2gclQ9GjLfe4imaI0LOEdY0M0RFtOkVYA3M
         0E7Sp9FZKgbco0Sb2PH/flBaNwofLz5YYYB5QSuoZvg2dGgrYeSgcBK1cNTJvj4tgZaB
         EHjw==
X-Gm-Message-State: AOAM533od5FAHfFWTNecoWsREob0myMNAA8tKBKQpGWTze7k3aeu71A7
        s2FhZXbzNPtW4RrxZi0CW7ktsw==
X-Google-Smtp-Source: ABdhPJz7vZ9tC2lfdY7bX8RqCZsPKm+v2cUMHBva3FJdit23w5ftndodH19y545GvEWK2Lzj6vutNg==
X-Received: by 2002:a50:ff02:0:b0:418:e736:e003 with SMTP id a2-20020a50ff02000000b00418e736e003mr12208703edu.370.1648661839135;
        Wed, 30 Mar 2022 10:37:19 -0700 (PDT)
Received: from [192.168.0.164] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm9911169edb.27.2022.03.30.10.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 10:37:18 -0700 (PDT)
Message-ID: <569026b9-b73d-b8fb-c32f-8ed920bb73f4@linaro.org>
Date:   Wed, 30 Mar 2022 19:37:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 1/3] dt-bindings: clock: convert
 rockchip,rk3228-cru.txt to YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220330121923.24240-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220330121923.24240-1-jbx6244@gmail.com>
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

On 30/03/2022 14:19, Johan Jonker wrote:
> Convert rockchip,rk3228-cru.txt to YAML.
> 
> Changes against original bindings:
>   Add clocks and clock-names because the device has to have
>   at least one input clock.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/clock/rockchip,rk3228-cru.txt    | 58 ---------------
>  .../bindings/clock/rockchip,rk3228-cru.yaml   | 74 +++++++++++++++++++
>  2 files changed, 74 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
