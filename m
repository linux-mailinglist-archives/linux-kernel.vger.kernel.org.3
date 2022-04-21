Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5195099F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385963AbiDUHmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386027AbiDUHlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:41:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBFB1BEA0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:38:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g18so8183706ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+JREelw6laYvmBddqI3EC14b1vQSIevLCDNJfmzFR2g=;
        b=WDBW92vG0q4gsIhJeK1naDiFI4MbinA4vSOTB7TPvvbig288kf3Cu23BuaAGhT2gQE
         yoMVoFBH+t7BkGd3eiBC1sbcYROV1DjbPgpG2jCMCfvUhN6AfJlTP5Wedu5RfwMgoINq
         PpJ5iECwAN0DVjlD0jep13MWadZKuy5go9Aky6/VYdkDl3vGfNMML084FJP/X1F/rYUE
         sfAEzYxqr+rI7eqafyMgHQkqAtYNJrh6HzkXAVQ2EI3MtxRUQChYMLuj3KqNqq0DGGf7
         CovTosZ11cMllpGetNvTUF72tbFwCyZf3PATPU9G+fv07HnL73xDNFgpx81TqdbB6lM4
         wNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+JREelw6laYvmBddqI3EC14b1vQSIevLCDNJfmzFR2g=;
        b=jOajr0z0khtuTxGaiaUNTbNpxPWxMnDq6Jh+yzqHLHk3KELy5C5AFWNMKlv2J5swfT
         AiaCHM1Qd5UKpdSduje9NSFnJnlr9YJXXsHU4SMGhmSDFQLHxRSWbixT67JkebZyhh/Z
         AgReSC4sZr9oVX/PdwfmMBgXRHKKSnFuL3tHC9OQO4ZMrVnOF/5SBX13g5MW7GLI0Iwb
         k/XB4Ql6rVy7ekcJP0tIkIGlvtRUqaQ2xDMatLblj/zKlPp2WQ2zGHeXktr9QymKBz0N
         jUmnRmNaMvYoMM6csy+IlX2EnRDmZyi9sQR/UfpP6rpvFEalPjh26gI6M5xXpye3EnXn
         lpsA==
X-Gm-Message-State: AOAM531sjyObaiBp+uwp05TgYXvsDW0iTlU3XWYwkr2OtVTn3trtscBk
        9yNB05qnoKNnw+jNZ9JIxDf4CA==
X-Google-Smtp-Source: ABdhPJwEX9Azhs73zsMaeaPiRIxEJNmtzI+MiCPqqVr+i68qFBVnLhjq+9N3+ut1oLawkJuUCRzkDQ==
X-Received: by 2002:a17:906:4789:b0:6e8:7ab7:e843 with SMTP id cw9-20020a170906478900b006e87ab7e843mr21389705ejc.374.1650526710879;
        Thu, 21 Apr 2022 00:38:30 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v20-20020a056402349400b00425a5ea1bb7sm276423edc.57.2022.04.21.00.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 00:38:30 -0700 (PDT)
Message-ID: <0dc122bc-c2de-8d3b-8d94-55586df35fc1@linaro.org>
Date:   Thu, 21 Apr 2022 09:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] arm64: dts: qcom: db845c: Add support for MCP2517FD
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20220421073438.1824061-1-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220421073438.1824061-1-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 09:34, Vinod Koul wrote:
> Add support for onboard MCP2517FD SPI CAN transceiver attached to
> SPI0 of RB3.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> Change in v3:
>  - change underscore(_) to dash (-) in can-clock node name
>  - remove superfluous status = okay in can node

FWIW:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
