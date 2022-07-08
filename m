Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4453656B40C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbiGHIEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbiGHICa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:02:30 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10247E035;
        Fri,  8 Jul 2022 01:02:29 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id k15so19060500iok.5;
        Fri, 08 Jul 2022 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hODnMtf+5EqhbkNx2oX7wxZqY8zZUB9OLPetFR2uH7A=;
        b=I1oaVBalKTFKJVlbbTyhQWS1ol5E6FcVkwflucZasxRgPj/Kt3Y/wo+VsrsGKPfEK9
         WbRFB7uTsXHD1sjwAiU4jzq7HjI3kqUC7ZIGCdt1Ya2aFhyZdhd9sJamF8KF8keifkrl
         gjSzpl8EDPbvrNYPZM1PmW41ZfqJHD71UYrK0topX6tbCbA5um5EP9691DUMHpPE7M3O
         s1SXAw+K7y3GUQxpfyElP0H7NiPCm3RMMX7KsqRYaSl7LXLYfpmznJ4DsY+xY8hmHuPm
         QbciU7n6qBFcQnzz8dl6yyf1U2Gy+R2xx/5kJpMUPZza2PgUBSjN0FsMro5mt+B8eVzx
         0bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hODnMtf+5EqhbkNx2oX7wxZqY8zZUB9OLPetFR2uH7A=;
        b=0F8L+ddVWNByMv/RBYgKhV0dc+zLTWUscdPuw7M9QW21L6YbaK4uNm2+xwvI/zaxWC
         7pfevjAZbcE4Cm+xxolPk6YGqjyvDIHugaIxgPqFDT6JOsj5CpaCGEdm9FtoHeNshJJH
         jHQEzTeccypJ7pKqgqxUO0N1TbpLipushvicyTG71sBEiZkxT6ODUDaZIpRAAiAua9oh
         bUVViXRKw9z9H/ev9TA5PAJoKHPzFz5KX3gVa9RJdpxbMF+9Ne5gaiqWVY86/MIZPb66
         Fo2lSQ4Ovf8GUgtRiJWS/Cp0TL1ipYAngGxy9gufpHlGTuCRdR0fAtlfAZJwg9MUHHBp
         32zg==
X-Gm-Message-State: AJIora+U023aLzNg8f7XhrSd4va93CBwOMCcxejiB5MLXhVgti5yfDtE
        QIhEpBHPWL40s6EllFxQTXHO1lSKvdK86Q==
X-Google-Smtp-Source: AGRyM1vbUvAEnsSVMwsqK+d3yPV/Acfg2dPnTr9AEZlB91dT5n/m3+vacP7LrXDKsxdL1C5fh2Ls6g==
X-Received: by 2002:a05:6638:dcb:b0:33e:bd5c:2195 with SMTP id m11-20020a0566380dcb00b0033ebd5c2195mr1321012jaj.312.1657267349186;
        Fri, 08 Jul 2022 01:02:29 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id w13-20020a927b0d000000b002dc33dbed87sm2642328ilc.39.2022.07.08.01.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 01:02:28 -0700 (PDT)
Message-ID: <d2872f3e-1dc0-01ea-9385-29c089bc10b8@gmail.com>
Date:   Fri, 8 Jul 2022 10:02:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: phy: mediatek: tphy: add compatible for
 mt8188
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220708065834.25424-1-chunfeng.yun@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220708065834.25424-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2022 08:58, Chunfeng Yun wrote:
> Add compatible for mt8188
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index 7b2e1bc119be..9fd27d64aca0 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -85,6 +85,7 @@ properties:
>             - const: mediatek,generic-tphy-v2
>         - items:
>             - enum:
> +              - mediatek,mt8188-tphy
>                 - mediatek,mt8195-tphy
>             - const: mediatek,generic-tphy-v3
>         - const: mediatek,mt2701-u3phy
