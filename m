Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF8457B586
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiGTLbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240252AbiGTLaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:30:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1199565EA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:30:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u19so20932161lfs.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WJjXEnNPTkK2c4ZskShLvtffo+d4r+VWntp/C6IGnFI=;
        b=Hys8yTVBMoGrb1azZuNMuNuNCZF04BoogUG8lBRLU0XlBAMGzONoGaoX+lI2btbpl+
         BLHOf5iy0d3ulybWx0SM1pU8RvtqCdqEP+V/RcKY4+cOXWHuX5OC4cH0ZybarXc4Nvs0
         wzygVWMR9imx3E4QGKpa82ihwacsbRaounBN+Gmw0wyXI4cgqBl1dlUKgh6obu9DevAr
         443FvsuhjbedJ1s+C28EobXsG7RwZdl+/oH3rTYuT04xte17XNyIa+gmHt23xk8CLEcy
         bWhYmpipJq9BdXGwcMlum37S6v9eWFSg/BVZqOBwdzjQ3q6cc4L5ZK3QhbOvj+1myvjF
         2zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WJjXEnNPTkK2c4ZskShLvtffo+d4r+VWntp/C6IGnFI=;
        b=Xz/l1pXE+ZQGjPdVtLQBklkACMuyq4IF8qSYzQVbHHHEHAEXKEuxeF9mDFK1qmocA1
         wg0jX63iGUW9QTPijqVqSZ23dcz0Btap9ifKxJ5HB0IKamFcZ3s1Sy9DGN+VmpYaAlil
         7lt/vkB9z19AnfjVUy6/WAt4eTD2JxNgShnZNLYFLBT9n+BuB0GmqBj+lGzH/iCpNQy2
         0yQ1HqPAvsfhKTvt98JCEdoQ1auqRhBFbO81M/qpOcezm+VQdC8v56kIN1fPivSWbruS
         xvMxvCcjLfJ5keSsalfspHgSpv2PqucFgStm+OsnERMMLXXBh+nn+fLeq8ddYt4T//BK
         5SoA==
X-Gm-Message-State: AJIora9YZNDdC0zVdtJgI+KYI8TxF76tvEeRosHZaMCGZeKLsuuLm/Ql
        ItJ9SRKSwc+R5MvDJ8LsHqdTxg==
X-Google-Smtp-Source: AGRyM1s5xt0n7g1foRtf28OnqMNl0q/C7r3knv4E2zTtZeWv/EE9HOcqtrVGMtxBd4Aop3iyt3EbvA==
X-Received: by 2002:a05:6512:2390:b0:489:f0bd:9fa7 with SMTP id c16-20020a056512239000b00489f0bd9fa7mr21278766lfv.430.1658316650352;
        Wed, 20 Jul 2022 04:30:50 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id m1-20020a056512114100b00489fdc9ac15sm3778934lfg.42.2022.07.20.04.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 04:30:49 -0700 (PDT)
Message-ID: <c159e299-a3db-e071-2506-9c4380d0721b@linaro.org>
Date:   Wed, 20 Jul 2022 13:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: arm: msm: Fix typo in comment
Content-Language: en-US
To:     Slark Xiao <slark_xiao@163.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220720112748.17752-1-slark_xiao@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720112748.17752-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 13:27, Slark Xiao wrote:
> Fix typo in the comment
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt | 2 +-

Maybe instead convert to DT schema :)

Best regards,
Krzysztof
