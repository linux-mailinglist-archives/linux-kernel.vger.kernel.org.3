Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1044E8961
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbiC0SqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiC0SqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:46:17 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BE94FC48;
        Sun, 27 Mar 2022 11:44:37 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so7269960wmb.3;
        Sun, 27 Mar 2022 11:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AxR3p4JpHPgr/VlvsFgwAIBMlsSazNinrnYeQnbHHDI=;
        b=gpwxC6zuEUERQd3mxOFSW78ZoPsaPLpcVl8BMp9SRCtAqrxtihnIQPpeIZ7cMva09D
         KUUWeoOkhSFsRO1mxZK/8NSrwutu091ShQTpJnAswHYOYNKx5IQmW8BF5k3hApMkCpZm
         AqLWsuQBWcAnzpJxoJwXJwN7ERKTvHJWd5nIOT6mD74OdYc5td2fAsj4lfvmOwWdhQD1
         Ip4OHEu7KStNFHK7KfDy2MOrFmP+md+nC7sktOCylPqQTnjWkqj78KgInsI2g70SUEBN
         bfNQU2/o8mi5TOZZCXKw322powpx2d/63azqpYqa//PAK+KTQD4eBF6S9mdoTzRSfW/O
         lHEA==
X-Gm-Message-State: AOAM531YAoXTu8JE6ZIPi7og+5WSg53uWtwHkaaNmhm2jOEXKvzKO+qu
        MPVq269o077hC4MB3qINQdw=
X-Google-Smtp-Source: ABdhPJwewBgMpiPjnGygzz6MM1w7bJIXiSaYTxbNpycR3YhFVvV5QsOeyiwdS3vDi/xpJT5Gf7VxPg==
X-Received: by 2002:a05:600c:4e12:b0:38b:b715:18a6 with SMTP id b18-20020a05600c4e1200b0038bb71518a6mr20385514wmq.17.1648406676176;
        Sun, 27 Mar 2022 11:44:36 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id o10-20020a5d47ca000000b00203fb25165esm12023109wrc.6.2022.03.27.11.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 11:44:35 -0700 (PDT)
Message-ID: <03277cc9-fa7a-71a1-331c-02734755d07f@kernel.org>
Date:   Sun, 27 Mar 2022 20:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] dt-bindings: arm64: dts: mediatek: Add mt8195-demo
 board
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220327165837.3048639-1-fparent@baylibre.com>
 <20220327165837.3048639-2-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220327165837.3048639-2-fparent@baylibre.com>
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

On 27/03/2022 18:58, Fabien Parent wrote:
> Add bindings for the MediaTek mt8195-demo board.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index ab0593c77321..1f68afb19d81 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -131,6 +131,10 @@ properties:
>            - enum:
>                - mediatek,mt8183-evb
>            - const: mediatek,mt8183
> +      - items:
> +          - enum:
> +              - mediatek,mt8195-demo
> +          - const: mediatek,mt8195

No need for this entry, should be combined with existing 8195.

>        - items:
>            - enum:
>                - mediatek,mt8195-evb


Best regards,
Krzysztof
