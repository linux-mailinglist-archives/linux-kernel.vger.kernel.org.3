Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D27B5818D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbiGZRss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbiGZRsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:48:39 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7861513CC0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:48:38 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a13so17140720ljr.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ctzPl5frmb/YoGH10Wg8TSeiwequFD6UNo9wAiW5Nf4=;
        b=kaaxXkImhFO4vK0QMRJ/+WeBINGdwAZ6r/az/bpjbT0++NxJzUZP+7Y+qP1F8U/57H
         nHscvRB//Y2s7XCj80eI4RdAoRD0QvU4od1sp4ElzWogq6IK+rwcsA6oFRTeZzpKy7ky
         0F91nvkSWYVLk/t2lkfQILRYO//iGz80yos1aETzZt+BjF0ReGuSbRaP72M1spKVrpD9
         ePk45R0DBZCxwVlHiobjJHjsfSCWeCbiShI7WcH/WcoJv2X5iQWkm9gNlR98XTlGYRTG
         j8zWZd7yyQV8GVXadRoxWaivB3ku7ymhK3MYFC9OVjXTHGaUIluyDUlH7PT05n0m866i
         uzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ctzPl5frmb/YoGH10Wg8TSeiwequFD6UNo9wAiW5Nf4=;
        b=HQ+jSPdChgIm78oBpZOZeZIbRBmgBpcxxrbqT85hV9BAFHNyfrQ9EXMlqBrMqkYCDp
         xpIPUoNO/Va12NJB++DYJ3h9AcWek5hAuTsMU2igguurv+gH37yGNEZigRJpgfvmvMz8
         sjGbiX9AbweMu0tlUP6Zwbsh5uCqjx59+s6ETp/ZabNc7EC/jD+BNnpUoduNybroPSdL
         qMnI+1att7CV1VArfy2LRhUql5gzIy6OReQIC6H8NxuJ9Ay0qZXnqbK14tKD0Zi1Y9JP
         zAQsEFb8uCsjRQwX/5BVIIX/dhsAvN44UlTJ+2HsLszWJZ11i4zhJPe3OiuGy9d+XNZg
         xuJQ==
X-Gm-Message-State: AJIora+bfkGOu54I4q307PtdIU3xWTlWf8Ep+WLdf2Xfmp8Fa59gpD4S
        cJsEju82qhq4UjZI0DeTwYJkjQ==
X-Google-Smtp-Source: AGRyM1vQm0t5vDuroCaPvzxeqKGhulW1RTmsSC5Ln18JTIpOTqEW3j+lwzFTRlTRMYFkWNFF+gQaVg==
X-Received: by 2002:a2e:9cd9:0:b0:25d:e81e:7b5a with SMTP id g25-20020a2e9cd9000000b0025de81e7b5amr6397430ljj.32.1658857716853;
        Tue, 26 Jul 2022 10:48:36 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id y19-20020a05651c107300b0025d72c1f646sm3436746ljm.58.2022.07.26.10.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 10:48:36 -0700 (PDT)
Message-ID: <e07cc297-1b89-e6f5-c16e-26750c8402c4@linaro.org>
Date:   Tue, 26 Jul 2022 19:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V6 1/2] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220726102404.564498-1-gengcixi@gmail.com>
 <20220726102404.564498-2-gengcixi@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726102404.564498-2-gengcixi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 12:24, Cixi Geng wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add bindings for Unisoc system global register which provide register map
> for clocks.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> 

The patch depends on patch in clk tree, so either it goes via clk tree,
there is cross-tree merge or it must wait for v5.20-rc1.


Best regards,
Krzysztof
