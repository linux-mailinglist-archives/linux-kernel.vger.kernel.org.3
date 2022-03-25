Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4954E7844
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353843AbiCYPpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377625AbiCYPnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:43:41 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D90C54BDA;
        Fri, 25 Mar 2022 08:39:09 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id bq8so2174525ejb.10;
        Fri, 25 Mar 2022 08:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2vdz+4IsKGSl/VaCF7VHXVQKmTtRzfU3MmHP/EXqhjE=;
        b=i/viws4clWTJnrUwf+MCrDWNst3gDgJP2yCK6HGes0MoPNSTqDehX8NqcGUeTQmiEP
         2IzRHu+D3UiNQDdTsKIs25uHfjoG3E4urC7FSfv/nYRG1sTAHeLznjukRUtS2RxqabeL
         oUarJ7tTa7osN9AcsW7YBfunSaA/sX7BRDs+OzWWXjMwhVT0Ua+J96sWlG0nA5RHoVjh
         h94P8zJPZSTrZvTjrOEOboCyZH+a953vtT2LIxRYIEwwxnaHfnZVenXMLmknUjauV8Ie
         R5gWL0pnx/Evfkiqp/9qPR57DaGb4+4O/9J9hMykHrEmuRQyurOceSkiBSt6zmFaXLBE
         NILg==
X-Gm-Message-State: AOAM531GAumUgneTR4BwGtHi6bJhV6uYzl1qPXCCLEQJ3/ZRJ49Euexu
        cWnIksbSqUcwcCca4gMa+BU5Hzu3Bv8=
X-Google-Smtp-Source: ABdhPJzFcQ7dPxMRO1kZd0xEII3KM8S2HW7kJRS0lJCQxfRv8r/lHFSFTAIcwqb4fv7ynnjkOxTXHQ==
X-Received: by 2002:a17:907:9494:b0:6e0:ee8:4b29 with SMTP id dm20-20020a170907949400b006e00ee84b29mr12572625ejc.337.1648222747603;
        Fri, 25 Mar 2022 08:39:07 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm2435372ejk.119.2022.03.25.08.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 08:39:07 -0700 (PDT)
Message-ID: <c56c4bd2-e985-f8b3-80c9-4b75fa3dde23@kernel.org>
Date:   Fri, 25 Mar 2022 16:39:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: convert
 rockchip,rk3188-cru.txt to YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220325150146.18638-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220325150146.18638-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 16:01, Johan Jonker wrote:
> Current dts files with RK3188/RK3066 'cru' nodes are manually verified.
> In order to automate this process rockchip,rk3188-cru.txt has to be
> converted to YAML.
> 
> Changed:
>   Add properties to fix notifications by clocks.yaml for example:
>     clocks
>     clock-names
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V2:
>   change clocks maxItems
>   add clock-names
>   use clock-controller node name
>   remove assigned-xxx
> ---
>  .../bindings/clock/rockchip,rk3188-cru.txt    | 61 ---------------
>  .../bindings/clock/rockchip,rk3188-cru.yaml   | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
