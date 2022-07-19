Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2775796D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbiGSJ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbiGSJ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:56:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589AD2B62F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:56:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z22so10229343lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=EFk86uRdewz20VUPRQoIRx5Kk1NiNLCImIzNnjafFSw=;
        b=NaEFPoUIoFBZewiWjqCiOipe2laBUlv8dhgR/MiPD0lhGWVW5G6q+Xcks8lKbu6TYi
         52gJeMIctRvHSAAIoa1XlCU+fLNf9sjKiJcvbj471F/Uo2Gb1eRDRePSmzppxhbNdDMs
         NIIsE2UL5FJ99T+GWfuXENJtkQlTortap7a9sNbvpKXq/3HhIrNo155OttfR5hYoO+t/
         3NEiA9HQbbm7Oy/tUGFZs4DQgkDXJnDELmJokiXk1OEc7nvwuLRQ61WY7MBI87atPt7E
         qXsQ2s00PsjS5vjkoWawQIef4tbig+2CApWdp3zYqJe0Ef8s6Dz4FmcVHSF8wPsVDdS+
         tzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EFk86uRdewz20VUPRQoIRx5Kk1NiNLCImIzNnjafFSw=;
        b=Ufl2KSFp+cD4zAQ4arc44JSyEVRkr/ycfD250w5HggFCwIpcRZSLwzyJVucRDPwsCN
         Q2mIdrctCNwvSS17ZYeWn/NgyUlGX0GptmasW5WZEGSLVQWOwyflApCQUYnWPjAKH6bm
         +pCZmFqcYxlSnuqn5fYu+YZpky89jIWfOvswfPjt1Q4OkF/RaczaMxQzL+JVS+FMrCJk
         EWaQWmvWop1zfAQStb14kB4vDvSA+MA1C7S0171l2kgshA6Gracxj55RnX7aLAoQ9O7w
         7+1p20D/UCGHeEPvkxaaar3kfGk2h3eaJb4MFTLRal/bGYc77ScKiEApgFQUXLcw2Wn9
         oDDw==
X-Gm-Message-State: AJIora/1PxjQDSjfE93vppw5V+ZZBe1QBKaryYP2CY4OAvAehnm867Xg
        rJxSfpHPDGotgSLjomehgdTFeA==
X-Google-Smtp-Source: AGRyM1sba1t9L/GuBtsauW7d+8roMzRXpt0qdqU8mEVQ7dVaiHZev8zFGCXhF0HwZQzr8cIbmpgr6g==
X-Received: by 2002:a05:6512:344e:b0:489:f4ad:88d8 with SMTP id j14-20020a056512344e00b00489f4ad88d8mr18715016lfr.297.1658224582722;
        Tue, 19 Jul 2022 02:56:22 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id j18-20020a056512345200b0047f67dbb533sm3098436lfr.70.2022.07.19.02.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 02:56:22 -0700 (PDT)
Message-ID: <7f2a4f21-5e07-9320-8f7b-573ccc562f43@linaro.org>
Date:   Tue, 19 Jul 2022 11:56:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: ipq8064: reorganize node order and
 sort them
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220718153815.29414-1-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220718153815.29414-1-ansuelsmth@gmail.com>
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

On 18/07/2022 17:38, Christian Marangi wrote:
> Reorganize node order and sort them by address.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> 
> This was picked from for-next qcom branch [1]. Reorganize dtsi as requested.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/?h=for-next

If this is picked by qcom branch, no need to resend it.

I don't see value in such reshuffle. Reviewing is not possible and you
did not mention tests (results should be equal).



Best regards,
Krzysztof
