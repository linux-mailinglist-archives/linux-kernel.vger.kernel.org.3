Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1AE4DE917
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243526AbiCSPoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 11:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243519AbiCSPoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 11:44:00 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B2A419BD;
        Sat, 19 Mar 2022 08:42:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r22so14785311ljd.4;
        Sat, 19 Mar 2022 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kHXKQzwJmhlZm9Q6HsnUIDYvPEX0jMlvgPOzWlUbyPQ=;
        b=Jr251LSi2pxWK1C2BVeKSm01mIZxEDFp8jRsd+N5zEOYRoKEV1hRMaRPkp6yuQiTzu
         kd8mnZThjkWxv/R+UWZNPmjxY3e40Hc5/3MWvzfYEfalERwA8ANZFwE4REXdlDFcUg/D
         afrbfyYz9lbnbj/DYNPtmWdqZG7j5VcJpv8VKUDJbVXLwvTofNW39om24qwJ9uPQ9Idn
         +p/mLzQIOuRK6W0W2W9zPNWkqlx4X1Xt7v7uhB1h2tUf8694hMJOfTAs4YG78G4XtTIX
         r+67pBlvduQUN0Vg2FgLc5o9tWw24flhiQmuXZEG42li0jlztU7M68dEgUkPNjqnRwxx
         JI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kHXKQzwJmhlZm9Q6HsnUIDYvPEX0jMlvgPOzWlUbyPQ=;
        b=0D2/AfLYY7wX131eCwOkCsqKA2cz2E7J5dqv73KWijn/qnnFYW+sVnp7Gl7SekjJwB
         tz8sWIuORaVsISlWmpu09pJ+BRWd1i4lbvlmO3o8j0h8Ep+3s0I6P2RuiwngTtyWCGv+
         5+KTggkkvQJYWB8HNtwqVsqSbM9pZlS2Lh6k7TRh8dXe7TdpFkN4dUcd+kvEUSPlgpF1
         M15pO71XEbkYg79Mc0B/6xh6mAtOO3QbkUweaQvNdMbmUqfsD4hoiZxEeFhAA5O7YUOa
         /Qhs4Ye4KM6mUNlVSisgolYYJ0DCjS/NS4HmgfEdqEpHnCzgumo5gbAaGnb1VQtEDrOO
         Juiw==
X-Gm-Message-State: AOAM532sNVAhmOPQm34zbQDS1E6eOpgdgiFcWHoCfnVTtP2TO9LMzfx5
        msJke2bgW2/UUPR3ncYwlgk=
X-Google-Smtp-Source: ABdhPJwxdr62nhI7YmR79ve4MytrCU7uG/qS0hnhEnjCTyTf6sqzHDbIlrTHrTjQrmMLVIPaYPgIbQ==
X-Received: by 2002:a2e:900a:0:b0:247:df2c:7607 with SMTP id h10-20020a2e900a000000b00247df2c7607mr9839891ljg.262.1647704557173;
        Sat, 19 Mar 2022 08:42:37 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-171.dynamic.spd-mgts.ru. [109.252.136.171])
        by smtp.googlemail.com with ESMTPSA id k10-20020a2eb74a000000b0024965dbf2d8sm1215655ljo.82.2022.03.19.08.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 08:42:36 -0700 (PDT)
Message-ID: <274dc445-b2c2-9a3a-df04-ded95f2223ad@gmail.com>
Date:   Sat, 19 Mar 2022 18:42:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v5 3/4] dt-bindings: memory: Update reg maxitems for
 tegra186
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-4-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220316092525.4554-4-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.03.2022 12:25, Ashish Mhetre пишет:
> From tegra186 onwards, memory controller support multiple channels.
> Reg items are updated with address and size of these channels.
> Tegra186 has overall 5 memory controller channels. Tegra194 and tegra234
> have overall 17 memory controller channels each.
> There is 1 reg item for memory controller stream-id registers.
> So update the reg maxItems to 18 in tegra186 devicetree documentation.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  .../nvidia,tegra186-mc.yaml                   | 20 +++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> index 13c4c82fd0d3..3c4e231dc1de 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> @@ -34,8 +34,8 @@ properties:
>            - nvidia,tegra234-mc
>  
>    reg:
> -    minItems: 1
> -    maxItems: 3
> +    minItems: 6
> +    maxItems: 18
>  
>    interrupts:
>      items:
> @@ -142,7 +142,8 @@ allOf:
>      then:
>        properties:
>          reg:
> -          maxItems: 1
> +          maxItems: 6
> +          description: 5 memory controller channels and 1 for stream-id registers
>  
>    - if:
>        properties:
> @@ -151,7 +152,8 @@ allOf:
>      then:
>        properties:
>          reg:
> -          minItems: 3
> +          minItems: 18
> +          description: 17 memory controller channels and 1 for stream-id registers
>  
>    - if:
>        properties:
> @@ -160,7 +162,8 @@ allOf:
>      then:
>        properties:
>          reg:
> -          minItems: 3
> +          minItems: 18
> +          description: 17 memory controller channels and 1 for stream-id registers
>  
>  additionalProperties: false
>  
> @@ -198,7 +201,12 @@ examples:
>  
>              external-memory-controller@2c60000 {
>                  compatible = "nvidia,tegra186-emc";
> -                reg = <0x0 0x02c60000 0x0 0x50000>;
> +                reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
> +                      <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast channel */
> +                      <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
> +                      <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
> +                      <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
> +                      <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
>                  interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
>                  clocks = <&bpmp TEGRA186_CLK_EMC>;
>                  clock-names = "emc";

This is the EMC node, not MC.
