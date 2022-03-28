Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20894E9A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244140AbiC1O7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbiC1O7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:59:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4D35046D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:58:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m30so20827061wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7it7nWrxUCI0Qv2Lqtc/Tbf+JLAGcefs/bHK1LyDZJI=;
        b=fbwnZjOHQnljc13VEvxcbjuH3175Wbr+RmxQnH+Xqemb6P2ueDbwLqe6DJwS14Otvy
         oMGmV9+E+6KUDg6gn832tUiQ/RokB/TDY16cIN+z+BHnHW7j+g4H/HiW1TF8FryaMFZv
         RGqUYQhEDSUKe234IYYn827QNv/pPS4+l7LInt9e7o3e/UOXBnYafJgu4EvvXotklboJ
         B+0IsQsI6AiytNerl/zalOeaXoojP2n/Tku2ruzuRbZO9jbWmhLk2Kog2nJOcnA/0VyX
         Aq+MIco6r/v5Vn46BWAhY5MZdFMQ0CmdmOcfjiOk6iS1tlnVGsDO8wSEq/P9SqWrcqsE
         A4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7it7nWrxUCI0Qv2Lqtc/Tbf+JLAGcefs/bHK1LyDZJI=;
        b=49X0rnMLvKkbxL+UcCCe7V2nhxi/g02Bn3EZaqXf9Nh3B/arqjdwmNpeN+fsNsT6vU
         LNjpNZ3jbsfyGjtt7Dh9BTX8KXI8nTSjgTpdKj5ZeT1iwCbg2viKSe0Xl4nBw6++j8AL
         pk3TtYX/kVCejYwPRaM+TnLyC4AqesRq+wIWDqG/SrhcB/GSQAeaJRp9RMV6Lt2S2vQJ
         E9tm6l+JE7bO6nDpttbENYnizNT6M6rYqwhTeaa87RNHXIPghFMjjQn854Ewepi94h/d
         eN5tnriTm9KCSbU2+/XI+O2hfzNV9kXzgxmZ5MwQXb1Uy9cSSddPhj/WGhQhfNZ4b0U7
         xb4w==
X-Gm-Message-State: AOAM531Jp4P8evh1jWcH4SqcvFGZCUfx8bvJZ5egdbIhdBt53srKOTdL
        gyeF3A/24p2JORhq8bpe5vqWTA==
X-Google-Smtp-Source: ABdhPJxDRBZSnakVm9V5mdFns3aK835p2QU77pO1+SVKkhMh+amBCAX1GxI92vtJXr1OkcB2lwjAHQ==
X-Received: by 2002:adf:ab09:0:b0:203:f9ce:cc1d with SMTP id q9-20020adfab09000000b00203f9cecc1dmr24122187wrc.269.1648479481303;
        Mon, 28 Mar 2022 07:58:01 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm15878962wry.53.2022.03.28.07.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 07:58:00 -0700 (PDT)
Message-ID: <e9f23a89-864f-e7a4-db89-0dc4499a5864@linaro.org>
Date:   Mon, 28 Mar 2022 16:57:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/4] dt-bindings: arm64: dts: mediatek: Add mt8195-demo
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
References: <20220327200312.3090515-1-fparent@baylibre.com>
 <20220327200312.3090515-2-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220327200312.3090515-2-fparent@baylibre.com>
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

On 27/03/2022 22:03, Fabien Parent wrote:
> Add bindings for the MediaTek mt8195-demo board.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> v2:
>  * move compatible next to the MT8195-EVB compatible
> 
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
