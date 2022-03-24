Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C74E68A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352612AbiCXS2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiCXS2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:28:20 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BDEB7C52;
        Thu, 24 Mar 2022 11:26:48 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id m30so7858691wrb.1;
        Thu, 24 Mar 2022 11:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ll8lTEzX7b6jQhE2gytfK7yWoO7uXMFriD9yXNvHFxA=;
        b=pc9foDc8dCFqm7VQIpAcoKtPeoqWCIlBdxVU9aPoC0YD/SWqKY91YiohYUvESizT/f
         uy4VAF7oioWUSePuK6qEaiFpqc87ZlKGVqK0FpXL3SqGNzlHx8w8o7FzDmXggmwGYcGh
         zq6A3AkiroI90hwTGExxrOuHVs6mbt1jD74KPbICdHe82FShJxjyULCFgqkrJ0CVnzQW
         ddyP2Bc7RxdXcX2Ue7nf9pfI2/u4KGQQFuZwfzRKZIeOtIACRpgl3wGJ4tsUAy/IQOc2
         JW/1p6Tjczn+7w/hnwdz8aPbaY4fyim1kC6ef0iUJMjFhU6InbHwqaxfMjXB0UHhELRd
         OAdw==
X-Gm-Message-State: AOAM533g3yvyGERlCBPzNUlZ6uN1iTmxhP6MF9YCfmVMxgNE43KV6Kwe
        Y/DnCRb0bBUUgUS3cRrv5/Q=
X-Google-Smtp-Source: ABdhPJyk9Ii8AQjHwYY3xi67+Wyfe9bye7WPGut9xFho/54di6GA0bmhFtFrG3MCqfnv4Bylbidwcg==
X-Received: by 2002:a05:6000:1704:b0:203:d857:aa7a with SMTP id n4-20020a056000170400b00203d857aa7amr5430360wrc.513.1648146407177;
        Thu, 24 Mar 2022 11:26:47 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id a4-20020a05600c348400b0038cd743830esm1459999wmq.29.2022.03.24.11.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 11:26:46 -0700 (PDT)
Message-ID: <a222efb1-4f95-d65d-919b-ed55c5448c9a@kernel.org>
Date:   Thu, 24 Mar 2022 19:26:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: mtd: ti,elm: Add support for AM64 ELM
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        robh+dt@kernel.org
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220323111851.4699-1-rogerq@kernel.org>
 <20220323111851.4699-3-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220323111851.4699-3-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 12:18, Roger Quadros wrote:
> TI's AM64 SoC has the Error Locator Module. Add compatible and
> related properties to support ELM on AM64 SoC.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  .../devicetree/bindings/mtd/ti,elm.yaml       | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/ti,elm.yaml b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
> index 24ed0fb84204..bc01d35ce605 100644
> --- a/Documentation/devicetree/bindings/mtd/ti,elm.yaml
> +++ b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
> @@ -17,7 +17,9 @@ description:
>  properties:
>    compatible:
>      items:
> -      - const: ti,am3352-elm
> +      - enum:
> +          - ti,am3352-elm
> +          - ti,am64-elm
>  
>    reg:
>      maxItems: 1
> @@ -25,6 +27,17 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  clocks:
> +    maxItems: 1
> +    description: Functional clock.
> +
> +  clock-names:
> +    items:
> +      - const: fck
> +
> +  power-domains:
> +    maxItems: 1
> +
>    ti,hwmods:
>      description:
>        Name of the HWMOD associated with ELM. This is for legacy
> @@ -37,6 +50,18 @@ required:
>    - reg
>    - interrupts
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,am64-elm
> +    then:
> +      required:
> +        - clocks
> +        - clock-names
> +        - power-domains

Are these new properties also valid for am3352?

> +
>  additionalProperties: false
>  
>  examples:


Best regards,
Krzysztof
