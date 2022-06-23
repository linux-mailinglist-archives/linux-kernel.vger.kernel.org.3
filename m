Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61942557CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiFWN2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiFWN2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:28:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1403DDEE7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:28:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id cw10so17361222ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2ftA11LhUg9ITcz2UG0AifqKe5tyT6rWUbzdPwI/e0Y=;
        b=HYh1BDvjV6v4/X3cr5Ub1T3cIl9aMkTXPhJnrdqZoQopSTZ2huaUGfPWmBoxPWxjjc
         y9WVI8HA8iryzwoaNAuPa5vuUzExKoKFkf0fkOq1JkCSKLWa/L2o5SEB9taAhn9jWtUC
         9RVMVcn/HwWfdUPik0qNAxcPSBOybNwL9uGBaWrc0CUogfWxpQEpQ/R86ENDY1eVCLPS
         3X7n7TuhPCuNs2Q4qTxvvVCB288zkoGL21KkugL1W2Q4XHVyFagtLlj6iRRte1k/fgOe
         XizEWQhu3xl+kKHBKD8xcJoBqCUx7wnKxhMPqa9hfof4KhOQtFL1NQZWogV0T4HAthMu
         Jp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2ftA11LhUg9ITcz2UG0AifqKe5tyT6rWUbzdPwI/e0Y=;
        b=h+lULF22AQWIt/QumnWATSwMnxemMKHhJPLGMNSsm48gg3LaNYltn1lzukBwmyeE2P
         xASvYGT7jgXBlzArveUVcQfDjr4lnjXn/5i/yUK9dALpR9LO4UQms7EZKUZxPJQkKiC5
         a6Lr9cFp5RXnCWJubOhgMNUyYXziMXcRg8U55pjAbrtFiKEewqWGDZRSNihhf2Y5IRvm
         /qE4HhPIQVEJUQR/b01jTVI76cyq2Pjei5DPrp/JkSQEbaSh6caskg/B2bZR+l3aK/UX
         Z22pZ+bUXCB2yUfV23BdOpsscE5ddGi5fNGS4AShKbcTvSwTfylOpOmRoOC8+HkHYH6n
         tXLg==
X-Gm-Message-State: AJIora9mhJUCN6W0rQyNE9jBzUKNXrKCUOuXnSZete+MDK/V786aAO2e
        39wrNPQ76qiEOqk9DOw2BOx38Q==
X-Google-Smtp-Source: AGRyM1sucymQxFRb2BgudQk5P0ib7kBWtCIEnvAvsSPo/loMwW7aAIAOh222tazFshxCFniQzhqjkQ==
X-Received: by 2002:a17:906:53c7:b0:711:d2e9:99d4 with SMTP id p7-20020a17090653c700b00711d2e999d4mr7961903ejo.716.1655990887432;
        Thu, 23 Jun 2022 06:28:07 -0700 (PDT)
Received: from [192.168.0.230] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170907784300b00722e8827c53sm3547342ejc.208.2022.06.23.06.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 06:28:07 -0700 (PDT)
Message-ID: <53e8c8c6-5d13-b1e3-454f-f4fe4edf6361@linaro.org>
Date:   Thu, 23 Jun 2022 15:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] regulator: dt-bindings: qcom,smd-rpm: Add PM8909
Content-Language: en-US
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220623094614.1410180-1-stephan.gerhold@kernkonzept.com>
 <20220623094614.1410180-3-stephan.gerhold@kernkonzept.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220623094614.1410180-3-stephan.gerhold@kernkonzept.com>
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

On 23/06/2022 11:46, Stephan Gerhold wrote:
> Document the "qcom,rpm-pm8909-regulators" compatible for describing
> the regulators available in the PM8909 PMIC (controlled via the RPM
> firmware).
> 
> PM8909 is very similar to the existing PM8916 but lacks 3 of the
> regulators (s3, s4 and l16).
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
