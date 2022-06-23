Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BB9557D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiFWNar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiFWNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:30:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD9947AC7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:29:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ge10so9570329ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ePFuz9gjvneLUbo3iN6/MzxTmZntguROUvpcqfx6Iwo=;
        b=kilEQhJrekBj3tVAycBQpE9BNm+Hip30HCPN/XSCTP2U3wbVhI+hKk23MdWIJ3Dypl
         qffhEEQuVyFUbz5J/1MdRBYKZboWhtStOI0k9d4Aup1BGLOrMrpYY+seBOosUnKwLsVL
         MR8LYhAjJ7oxOGmAxEiBhJVdCYG5Px8Hk5taqdBpD4drG+ZVVNZdVDHoKm/h/QUZCtRE
         S/rsZcWp/qiddxN66KL5ZRoB7s5KVyCOidfIT7Tj2vaZ3puYEijJfvMh3qbsM5C2CTmU
         wm6I50k0AELikWo0VYYaG0KVFje/4tZd3tKtvxfUODluU2IRXxgw5OElq49HM1lYwZfp
         tMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ePFuz9gjvneLUbo3iN6/MzxTmZntguROUvpcqfx6Iwo=;
        b=F73Yip10Vl20Y2VoJf0Ol7UR655sqgv8O6olpsc1oByV8rOUE9Mn4xBgghVNuamHxu
         SIUvG4InPJCR+uMcyBczr1G+qzmDFBhf5juHrH9DYSvAHrMgch2UkzGl/Kw+qpXV8nkS
         COoaEKJQxqecRBRC545iQnpVEDVU+4hD0noQUMmpTE4T4p984vndRlKRu72ayrK0fJV+
         vZKbCXeqE/A6800MNou/J182UxYeM2Cl8lWirvGJvTxTsqnoZIXWlIHiUcUb9HEgydWc
         AV/XcVlyXJsQPLCWvZAL+fHE3n30Gn9R1Po48Ua9JKQyeD64pS36aRGYKht3jLelTASG
         WTNA==
X-Gm-Message-State: AJIora+HLFMVVSebAiokzo3vOqOmgG0+3UQGCCcSIUlJvN7T7PWXwngW
        xaKZOz0S3/z0x1ANMCnDy9Y6rQ==
X-Google-Smtp-Source: AGRyM1vKuGTywgyEw2jM3zmPBBBXUc+7mwZ7taGR4hWf4ZepG7VJH9Yci4kWlWodvrYiVNk2KnX7tA==
X-Received: by 2002:a17:907:e93:b0:722:e082:2787 with SMTP id ho19-20020a1709070e9300b00722e0822787mr8647094ejc.618.1655990988030;
        Thu, 23 Jun 2022 06:29:48 -0700 (PDT)
Received: from [192.168.0.230] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ff10-20020a1709069c0a00b006fec69696a0sm10604906ejc.220.2022.06.23.06.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 06:29:47 -0700 (PDT)
Message-ID: <ddfae1cc-ec28-3433-8c3c-24f63a1ad0a8@linaro.org>
Date:   Thu, 23 Jun 2022 15:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: display: ti,am65x-dss: Add am625 dss
 compatible
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20220623103504.26866-1-a-bhatia1@ti.com>
 <20220623103504.26866-2-a-bhatia1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220623103504.26866-2-a-bhatia1@ti.com>
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

On 23/06/2022 12:35, Aradhya Bhatia wrote:
> Add ti,am625-dss compatible string.
> The DSS IP on TI's AM625 SoC is an update from the DSS on TI's AM65X
> SoC. The former has an additional OLDI TX to enable a 2K resolution on
> OLDI displays or enable 2 duplicated displayw with a smaller resolution.

s/displayw/displays/

> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Reviewed-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  .../devicetree/bindings/display/ti/ti,am65x-dss.yaml          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> index 5c7d2cbc4aac..0fc77674eb50 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> @@ -19,7 +19,9 @@ description: |
>  
>  properties:
>    compatible:
> -    const: ti,am65x-dss
> +    enum:
> +      - ti,am65x-dss
> +      - ti,am625-dss

Alphabetical order? Avoids conflicts...

Best regards,
Krzysztof
