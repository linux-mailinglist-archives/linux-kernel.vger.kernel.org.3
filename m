Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE3551961
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiFTMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiFTMuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:50:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5560C13E2C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:50:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mf9so582914ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wVGPCyQyPkXTNhupcCugMyUqAIjoQ2WAlQx451WBx0I=;
        b=dYC9w8eDKPI+JGg49DsE+daHrtI1etV780GnsMfr8ha5KntBMDTWbv4sYUG4CY9gNn
         fbvpsVmFnde2GARCnt42yjPrlgz1A/fHOjq2aQwU58khMNY+OzzgHto+iU/g94o0LjsH
         HIDWiFwMjvQUN/Qp7xywZefNzn+qJympTQOCkfIqqaSVU4S2NkcmSDPQKbEin+5+b5Xm
         nXD17eBwKop1QpWM5iySrFoK9usHrVWafJVabIYCIyYuVWln8bH3THIxC4E17oMEew5e
         Iysip+1On7OdaqNte+TrbeAGQHryGTDFQyZF5rkt1LyGKR1S4ARKUJ8vUh3StZpSJfU+
         839g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wVGPCyQyPkXTNhupcCugMyUqAIjoQ2WAlQx451WBx0I=;
        b=yfCWPD25/Ee10zVBZijYbi0SjpC4I79iGM0nHpB3B/pl3dtZYGJHJYw6MJDWNnd/XF
         4LzjCnt/HcWZ8U+rN1X3VLBk9rXeDY9c0vu5Qog6y6VhXNfk6UZB07LNQgjNY+cLm1vl
         tRqaF/BLcUgt1cUnXXQJF8ibh7B3YX5rPrelGBEmdGO+sSrwuf8I/BwUA6JgubhRnWan
         ezePT8K36hVmPwFmea9UiBrL9z911rDETw57J3x2PzKbV39EC2mkISCwvzobdfoXwBj/
         Uoi1YlLr62kjazClbB9bhS0xCt93oKgNFIcFuReYA0ZFzXJ+8ke8Iqjlkk6soazoMW6V
         ueqQ==
X-Gm-Message-State: AJIora/3Gz9wc2oaVQkT/QNvzSyyz3OrZJoo4trzrNHYWfbSSawgsb96
        oqy7FgOdlPzul/l/qtZ4ncT+IA==
X-Google-Smtp-Source: AGRyM1szXn/V8sntLjlItwCnzxeR/PMgaxIVnmKQ5ioDo/U2K9vNJYDX8XT2OfmCLsGo4DE6u1he+Q==
X-Received: by 2002:a17:907:6e0f:b0:706:9a4f:2f3d with SMTP id sd15-20020a1709076e0f00b007069a4f2f3dmr20880444ejc.413.1655729447921;
        Mon, 20 Jun 2022 05:50:47 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z7-20020a05640240c700b0042617ba63c2sm10546832edb.76.2022.06.20.05.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 05:50:47 -0700 (PDT)
Message-ID: <c3785da1-0142-5c4c-4f46-c569c8c06efa@linaro.org>
Date:   Mon, 20 Jun 2022 14:50:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC binding
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, ulf.hansson@linaro.org, will@kernel.org,
        devicetree@vger.kernel.org
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-3-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220613195658.5607-3-brad@pensando.io>
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

On 13/06/2022 21:56, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 4207fed62dfe..35bc4cf6f214 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -13,10 +13,24 @@ maintainers:
>  allOf:
>    - $ref: mmc-controller.yaml
>  
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - amd,pensando-elba-sd4hc
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Cadence host controller registers
> +            - description: Byte-lane control register
> +          minItems: 2
> +

Except Rob's comment, the entire section now should be moved to bottom -
just before unevaluated/additionalProperties:false


Best regards,
Krzysztof
