Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F18A53A458
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345738AbiFALuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352864AbiFALuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:50:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979CE7379C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:50:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x62so1798756ede.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 04:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NCu09c7It8PCgWDIsBdAVtichE5PsFctC0ahaIHP8Xk=;
        b=KD/GF46y0L9iV/6oC8B0iJGCrA1YOd1ZDr5ZyyRZKnNDXwqFSyH7pMugTFD19FNvuK
         DLG3zOI1/3Fg4wUPC6NHPSQsy5OZb4b0Gzq06f1NQQgETWqm89FW05A3FR2gVOXq19JI
         CVJ6LZEFdk42WkWzwgK+DKTWazScy0oP4rYwVZuAJM9xGuHcCJziiPFOQ+DYiY0ziLC9
         879vFCoj64XlDCsamSFbS8NsBkT6Wd/mB/bfROk0lZwGArhZOmwQjbsMRzUVQWJzSFqQ
         TKzfvDC846UfKtt8N47ycGDKj/fiFXjMu2XbHSJn7sd2vqALeK2+srAsZBIKPsgY1YKN
         9Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NCu09c7It8PCgWDIsBdAVtichE5PsFctC0ahaIHP8Xk=;
        b=UP9iYiSf7ZCR7cwq9VkTMSO5uYJz+HQ1B7/PTWa3E7BstiPzgg4pfoYwXnr27IULm5
         42xO13waE4kSZl+lW8eB6B1W9EwpkjRliayzgjf0BAAJeclHZimmZvZ+I3q9Ng4QB199
         hUPlk608cKSQQGp1OgksIk+kqE5PB/ABMPrQ5ZPj9dvbksHgLHHytpYODFG88Q8YEzq3
         /qe40kUK/Al+YBhs3/uKg90lfczKHUP9ccKzEmklvlwe3Qjjpg7Di14oRQ1L2SjhqwMQ
         Ol2UM2ACeYgLIn+tHkxP6MpoZd0Xj0YukLA6hOyYyBID4CPycK6hPc8+bzIM2UVjDT4S
         SfhQ==
X-Gm-Message-State: AOAM531HD7S6qnlRdNwbFTWM3qVOJ31+kUdScDHAZNjBRa8itNMbg3MC
        K3ZWSewXDsQnXVUCHQLnPSGNng==
X-Google-Smtp-Source: ABdhPJyELI2heE5E7DXJZNsKABuJGaTaxV4OxNBunIxicg2IcK642ipDPhUCnEa0+rHGU5oepmuQnQ==
X-Received: by 2002:a05:6402:1851:b0:42d:c904:d73b with SMTP id v17-20020a056402185100b0042dc904d73bmr20563379edy.417.1654084213214;
        Wed, 01 Jun 2022 04:50:13 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e26-20020a50ec9a000000b0042ad0358c8bsm855792edr.38.2022.06.01.04.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:50:12 -0700 (PDT)
Message-ID: <dd3ea397-fa21-abe5-85ad-b8a4818dc011@linaro.org>
Date:   Wed, 1 Jun 2022 13:50:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 01/15] dt-binding: remoteproc: mediatek: Support
 dual-core SCP
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        weishunc@google.com
References: <20220601112201.15510-1-tinghan.shen@mediatek.com>
 <20220601112201.15510-2-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601112201.15510-2-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 13:21, Tinghan Shen wrote:
> The SCP co-processor is a dual-core RISC-V MCU on MT8195.
> 
> Add a new property to identify each core and helps to find drivers
> through device tree API to cooperate with each other, e.g. boot flow and
> watchdog timeout flow.
> 
> Add a new compatile for the driver of SCP 2nd core.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../devicetree/bindings/remoteproc/mtk,scp.yaml      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> index eec3b9c4c713..b181786d9575 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> @@ -20,6 +20,7 @@ properties:
>        - mediatek,mt8186-scp
>        - mediatek,mt8192-scp
>        - mediatek,mt8195-scp
> +      - mediatek,mt8195-scp-dual
>  
>    reg:
>      description:
> @@ -57,6 +58,16 @@ properties:
>    memory-region:
>      maxItems: 1
>  
> +  mediatek,scp-core:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      The property value is a list with 2 items, a core id and a phandle

uint32, not phandle.

> +      to the sibling SCP node. 

Skip this. First part is obvious from the schema, second part should be
described via items.

The core id represents the id of the dts node contains
> +      this property. The valid values of core id are 0 and 1 for dual-core SCP.
> +      The phandle of sibling SCP node is used to find the register settings,
> +      trigger core dependent callback, and invoke rproc API.

Entire description did not help me to understand what's this. So far it
looks like it is not a hardware property but some programming help, so
it does not look like properly described in bindings.

> +    maxItems: 1

In description you said - two items.

You need allOf:if:then disallowing this property for other variants.

> +
>  required:
>    - compatible
>    - reg
> @@ -115,6 +126,7 @@ examples:
>          reg-names = "sram", "cfg", "l1tcm";
>          clocks = <&infracfg CLK_INFRA_SCPSYS>;
>          clock-names = "main";
> +        mediatek,scp-core = <0 &scp_dual>;

This looks like phandle, so wrong type.
>  
>          cros_ec {
>              mediatek,rpmsg-name = "cros-ec-rpmsg";


Best regards,
Krzysztof
