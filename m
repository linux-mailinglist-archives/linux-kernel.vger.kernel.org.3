Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0860F58EEC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiHJOsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiHJOsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:48:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7937391B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:48:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r17so21523650lfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Q7MGG/JhDz1hCo+Yj3+IF7giB4w6hr60tquTBJCK01o=;
        b=LinhzaJsrpvYmtMhRVN1UMKuEdrrqt9uV753Bf6YBB22ZtW8JNLVWZLHCtxz1pV7df
         fRkrLH1dyiBv0DFqagWT8Jl2KRvHHtq30GIurffTxrHSZxHznOqyADkiON5LbKe59b43
         dNSAxRVXYKPZl92mscObu5YDeRw8Li/oZsp54iAis+5e/vh7nnduL1Br9dg+NTQSFaEG
         J54/gw9Svfq/d9rZlI3Sji+vSzHlyWkEzeKtxdRF17z2AWhBFPHz3E8eqPbrXJ+cBSdL
         CjLqmg0defBo+g8rENt7nQO+wlguN8x1soSaUJxgIjtyhy5dy88XiCD/VvFES8DA3xnI
         CjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Q7MGG/JhDz1hCo+Yj3+IF7giB4w6hr60tquTBJCK01o=;
        b=pJu4YY8axraUHpXjGifpXqkQQu9IkbeD9NV7Py/MraUyvDDnTXvf9UapEtO40MZpuY
         0kzs0qOJ9acPlNMiQrm08Q4VGV5UtH/hMxX6yeojJgk+K1yOqjNZoqSn8kQrwm2IqoDP
         LZVVWUHW6Rtd4SGd4XB7VWaYbUpqmO8Ox+guWiALUlnp65stOEPub+i+2y+VX2ZUzbqs
         VTd2IMg8UfZ9ezWsCJPuWZSDRM1IMWq1bs/ijkBv+nGx4blG2qdJiRc/rV8aVzfTF3kC
         C79FoE49QzAfB7HJHMqJFYe8iNpGBNTNKmJtJoAT45JVaP99mlZGONQPqb1Zf1GMuL+T
         hlaA==
X-Gm-Message-State: ACgBeo2i+WeXcQ4bO9ofcSoBm2ZqtnGotiEzLEUKS29Gq6qhm84NusSR
        XJMEU35TDHn9DmmBkglORyITkQ==
X-Google-Smtp-Source: AA6agR6mphtaBT4wBqYjxE2rrsNOOPH2FORhjukhTqlukW+3+UIzqtcrK9a42UTUOUyrpaXuBUQd7A==
X-Received: by 2002:a05:6512:3501:b0:48a:ef16:2b5d with SMTP id h1-20020a056512350100b0048aef162b5dmr9223152lfs.186.1660142929726;
        Wed, 10 Aug 2022 07:48:49 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id v19-20020ac25593000000b0048a828b6b2dsm363258lfg.182.2022.08.10.07.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 07:48:49 -0700 (PDT)
Message-ID: <7cf24606-e216-994e-9056-6dc5a274e5d4@linaro.org>
Date:   Wed, 10 Aug 2022 17:48:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/5] dt-bindings: phy: qcom-edp: Add SC8280XP PHY
 compatibles
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220810040745.3582985-1-bjorn.andersson@linaro.org>
 <20220810040745.3582985-2-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220810040745.3582985-2-bjorn.andersson@linaro.org>
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

On 10/08/2022 07:07, Bjorn Andersson wrote:
> The Qualcomm SC8280XP platform has both eDP and DP PHYs, add compatibles
> for these.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
