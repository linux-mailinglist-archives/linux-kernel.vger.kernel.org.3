Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18782566787
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiGEKNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiGEKNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:13:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3DFD132
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:13:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y16so19687846lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cLjhHLrbRBnYiVAOCNhcYbbg+1XpO08dGVEQiEigido=;
        b=NokVD5aeNj9stoX6SL9K7J5iP98z+qj56ikZljVqZfxNlvBdGGeYXxMh0F5JndN1FC
         GtOq9Ejxu35KdYEDvApSJA5U7E8l8jCd9wPmco0VlUftMK6OspoEKj0gsE3fkzJdKLRG
         Y5Lqu69MWowm2utmq73ikL5F63glMys4dDxIU4dVtr7VwlPhsq54UOrAyALxpu/izWK8
         KpX9f5FLxeVfLqcJ1U4k817QRBe/uxD1DUsNiyxsoy5QQuZmuWLG6Y/ccQS2jaKU/meQ
         +6NF0zGrSlSfPnlykGS1k0h/Y8yt1ptey2o4l/BFh8H17mwFekV/9ParMWFzH4gp2R/7
         CwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cLjhHLrbRBnYiVAOCNhcYbbg+1XpO08dGVEQiEigido=;
        b=d5rPU8h7GhKE1v8CFeaKwQyh0PUZpHbOtYqjHeapt3E8AuKX8ZnVg0Xs53bpEZ4Z7Q
         T2p8Vj7NyGVvhf9F0CxoRdbXX9sL6jAJsRJfEyc2UGQu9762yK0gN5HHtP4fXgcIFMWT
         PYI9fWeCT4tTr4HaItjhayUt8Ru+BhOV2cCFzF+SgVHxpmE25Vw2p9ENCTG3tMGMDF0b
         VdsAhR17VDi0tCmWClmXCK6ZAAbKnBQQF9WCRFHiBnjIV3WSjmz//0c68YXetf3sZKNJ
         h3LYmHv477uIL2NLN2ghDgS/RWd8E84cCvdlbwIT8F7DbyyS8Sd6Rd/XZ35sc5i02NGs
         nakA==
X-Gm-Message-State: AJIora/Yho/pU3XOtbK3lWcY41yUUsrXWJLnTXDeLgmTJtN4StPo65Ui
        8nGwFKni51o6a2725AhmhGSRRg==
X-Google-Smtp-Source: AGRyM1uZsAzZdN771jYqFkZTGKGgnuxS95JZHOFMEG9qBWCRtFMChuq0B2wnLKhmNJ/+m+DoTVFchw==
X-Received: by 2002:a05:6512:128f:b0:47f:879b:dc9c with SMTP id u15-20020a056512128f00b0047f879bdc9cmr23369198lfs.478.1657016026738;
        Tue, 05 Jul 2022 03:13:46 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id r25-20020a2e9959000000b0025a70f7ea3asm5468127ljj.138.2022.07.05.03.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:13:45 -0700 (PDT)
Message-ID: <1db53d76-575f-53f2-d52d-1241e5053f59@linaro.org>
Date:   Tue, 5 Jul 2022 12:13:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 13/43] dt-bindings: phy: qcom,qmp-pcie: clean up register
 constraints
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-14-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-14-johan+linaro@kernel.org>
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

On 05/07/2022 11:42, Johan Hovold wrote:
> Only some USB and combo PHYs have a second dp_com control block.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml | 2 --
>  1 file changed, 2 deletions(-)

Squash it. This patch does not make any sense on its own.

Best regards,
Krzysztof
