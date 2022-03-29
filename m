Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03634EB296
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbiC2RWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiC2RWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:22:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AE016D8E4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:20:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id c10so18106169ejs.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ROsQcUJTGNxUVGtLXxEiy/5+m8Zgw5SGAV2688lVg4g=;
        b=o/5vMuNiIBEAuZd0SjplKcjp4d+racjVgUESBlfA7iYult41e/OVKGwOCEAy0g7c/z
         +c4TtwYJM7xxJXIPEGKsjG2JI/W60wL58H1Ex3ebbr5vicEqqSeSRUqXK6i8F+7PnxCr
         XA+25ysr6U44Tp3sL0L8TMGMwO31zYmhOvetAvrGt/1NjtqLE49OUBtpw5G2bxUyg3rH
         cA2m5BVCkFXY4DtvCZ5oerGtLJ9Oo00/ByywRHHYmgL6t46w0NByYO+clPjtup72Vdr2
         GpdC+9GdcFUdCotzU2JNFHyJt+Ere370OakHWs5NR9tyAdWCdxd2egttVqvgHPmb9dJw
         aU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ROsQcUJTGNxUVGtLXxEiy/5+m8Zgw5SGAV2688lVg4g=;
        b=F3EnvjlIXUxI8jRwNvnhAoMDb5riTIoWbNc7qRYmk+82moQ5oDPJueO7Aw9JeOH/iq
         WWxXDMZ68sDco9oRnuAXS2VLSB6TsQKwgNcP5EkY9a6Q2brIuRKBkv8BfJ2KADv4xdfe
         86Suh00iKiZuusLpCti5N5r8lQKUPgdf54uCZ/dVVXwQBxh3EJI+vuS9il/ckpDcsT/I
         /d7ajNcVLrXjIgX3Pzxfa5yAka0Dc2C3PvRIQjfiqACpRfVXuxW1OSAXADI2XDQAeXFb
         RrnBYj1kqCJVPnqXhHGnpyq8tKA07A102jZuon4FWizU1sZYagSMJu0eVxdXvWox7PDA
         BLOA==
X-Gm-Message-State: AOAM530WgAg03bZ8nOyvDmZeQ3DaHZTZXzG5lmcTX2ToSgTa6Ne3KV6j
        e5fhX6QYuQqsEE17KAMVDM/Dtg==
X-Google-Smtp-Source: ABdhPJxkbDZq562GC5mkdl0Wlt68amgyNMSrc+Yo4YTeVWsfVfweU8TsmgnU6j66uTFhrh1FbFO/8g==
X-Received: by 2002:a17:906:c110:b0:6e0:dc2a:3393 with SMTP id do16-20020a170906c11000b006e0dc2a3393mr20631113ejc.512.1648574418760;
        Tue, 29 Mar 2022 10:20:18 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b006da6436819dsm7295462eje.173.2022.03.29.10.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 10:20:18 -0700 (PDT)
Message-ID: <5e3ef437-82d3-ae4e-f8bb-0b508b45050d@linaro.org>
Date:   Tue, 29 Mar 2022 19:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/3] dt-bindings: clock: convert rockchip,
 rk3328-cru.txt to YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220329163016.27458-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220329163016.27458-1-jbx6244@gmail.com>
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

On 29/03/2022 18:30, Johan Jonker wrote:
> Current dts files with RK3328 'cru' nodes are manually verified.
> In order to automate this process rockchip,rk3328-cru.txt has to be
> converted to YAML.

You know that this can be one or two lines max?
"Convert RK3328 clock controller bindings to DT schema"

It's equal, because we all know the benefits of DT schema. :)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> Changed:
>   Add properties to fix notifications by clocks.yaml for example:
>     clocks
>     clock-names
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/clock/rockchip,rk3328-cru.txt    | 58 ---------------
>  .../bindings/clock/rockchip,rk3328-cru.yaml   | 74 +++++++++++++++++++
>  2 files changed, 74 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.yaml
> 

Best regards,
Krzysztof
