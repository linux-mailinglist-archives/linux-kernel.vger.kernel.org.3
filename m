Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C334E9F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245399AbiC1TAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245386AbiC1TAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:00:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C896DF39
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:58:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h4so21682258wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E/lv74yXlf5dC/6MenQmc2ZtVjQIh9equ8kVJX63xWc=;
        b=OrbhPIDn83kWAtJ2oKWtBlRPdoYiHN8t/eY8BJB3jH/rszwQdeGByqRBVTNOFh7DGF
         uPuQdVtk8BprelsP/U01tDroOw5hDaDmq5TieJlEY96VNfg3EEGecwwoBEcbJ64//oGE
         LEPFC8R1wxmBG875/AHuw6ChS+xb7pGaUna2JSRYSLB54r9w+YdjPCbqdR8lrlKeLu0+
         goT3cScyNUIrKsPMKWp3tVD925tJvUTuliFjNMgvPtLWLWDqaUitc5AyX8mdXRtYLbLt
         802O0+xZ0zoZY1SZ5+V+ubAuGQp/AJ74kAdvFlZJ/A4SWlBh8wm5NV2GRjDLMNMaoEin
         V5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E/lv74yXlf5dC/6MenQmc2ZtVjQIh9equ8kVJX63xWc=;
        b=i6SAsgPWHFS61wVn9ZnTwjUTGPEV1CN7EdIv9Sc93n/nugMuvc4dbMvL+lNixZELMk
         cZLT2e1BBfDKrVpO1wN08o1DZWldd8wFtm6Ri7aDrcwIVNWyqssZ+P3wu0vAkVby7I6q
         uoZphOpA7nLKZu0ZfCuLB0Lb7F8dXa3h5fVMKzExS610rWLZlq//Lm1fPYVZP69EDPxS
         XL6pzOOXUhTjJJvbA6GWtmTkkXVsXVBeG8B3OIR3GSOzEHA74B9c2T7B1qi9nKrtg1DF
         LTTc4TPi7qmte7koxxCcqBZs7LSS52PTS1lQzQy26tZpmO11FPG0Oof25K9iIikwMkwH
         tDDQ==
X-Gm-Message-State: AOAM532WjzbusUMz2ImhMtSG/1TT06Aw7jKzlsqhecQ7ljjqOVV06Gqn
        70KNbSdqQanqMh9HDXHyWzFwqg==
X-Google-Smtp-Source: ABdhPJx9v0AU8NnuBgNH2WbRla9KrXbvI6qxt4kIbC2y4evVDkLfSE1Wz2vp2Q/2cceLaGPYRL1XZg==
X-Received: by 2002:a05:6000:508:b0:1e4:a027:d147 with SMTP id a8-20020a056000050800b001e4a027d147mr25574286wrf.315.1648493902229;
        Mon, 28 Mar 2022 11:58:22 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600002c600b002057f1738fcsm14033191wry.110.2022.03.28.11.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 11:58:21 -0700 (PDT)
Message-ID: <2e0be70f-f800-e3f8-363e-6598468fa091@linaro.org>
Date:   Mon, 28 Mar 2022 20:58:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] dt-bindings: phy: uniphier-ahci: Fix missing
 reset-names
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648433152-23126-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648433152-23126-4-git-send-email-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648433152-23126-4-git-send-email-hayashi.kunihiko@socionext.com>
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

On 28/03/2022 04:05, Kunihiko Hayashi wrote:
> Add missing "phy" reset-names to fix the following warning:
> 
>   uniphier-pro4-ace.dtb: ahci-phy@10: resets: [[26, 28], [26, 12], [26, 30], [36, 0], [36, 1], [36, 2]] is too long
>       From schema: Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>   uniphier-pro4-ace.dtb: ahci-phy@10: reset-names: 'oneOf' conditional failed, one must be fixed:
>       ['link', 'gio', 'phy', 'pm', 'tx', 'rx'] is too long
>       From schema: Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml

There is no ahci-phy in current sources...

> 
> Fixes: 34f92b67621f ("dt-bindings: phy: uniphier-ahci: Add bindings for Pro4 SoC")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml   | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> index 3b400a85b44a..14f7579e7daa 100644
> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> @@ -43,13 +43,14 @@ properties:
>  
>    resets:
>      minItems: 2
> -    maxItems: 5
> +    maxItems: 6
>  
>    reset-names:
>      oneOf:

As a separate commit, this oneOf should be converted into allOf:if:then:
cases which will enforce the resets per compatible.

Can you do that as well?

>        - items:          # for Pro4
>            - const: link
>            - const: gio
> +          - const: phy
>            - const: pm
>            - const: tx
>            - const: rx

Best regards,
Krzysztof
