Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163455B1A87
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiIHKw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiIHKw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:52:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06825F5C7B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 03:52:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q21so12833069lfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lLiZm3F7DHpwT1soBBOPDPPi1PUUeNiA/64S4ap2JL0=;
        b=Wnhq67R04OunxdAsXcTFJ4FqT0EJs+BejDR4UgYcZnjWuXzdpwUvJLgQo8cT283Pkr
         Sz6Q7PD4ZrrWk5WRtxxxr9y02HMEFX5D91KhYlGXXnjYinkQ+BFjfn4EswhS7jfMKUKV
         DYE2p2jOtla/kZv2dXy7+UHSHSC5LEAI38R1xJCnTC/KvPBe9MDLwdAfdK7hK849WwUY
         mKQLIVXHb6FmaY034nmqB6lmRYjNvRfMlWRouOdBv6UHbBC5JXkR0O+o9qPfvv7IL7jD
         ETCJ2CqqlCDjwUnx2nli7dwedHORBlYm0uB0ZZUoIqcxJNikSTJqAPoWSCVOkLDGzquA
         nhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lLiZm3F7DHpwT1soBBOPDPPi1PUUeNiA/64S4ap2JL0=;
        b=6GN/52XYP5E5M5n8DcJzsjnFcYG+SSSgHJW3IhSemQlwk187S6kCKH6J3o3Nk2KztE
         bWNuMbTUVW63GGUDtfPwBMP24X39LYnBB026x6mEQBqy3+a3gwek8lk2YBzg8GWNhQkw
         su2jGukMXqqmDzupDf8+UDPaMTuZhha/SCtDoIxxZ+qSOuXrKY11aI3lavbdu2DRjhft
         GtGaeklEicrZzZfwackqBhNuwy4j0BBfEIt6ovMkFmtyRD662bBfuGLGN0LCgAcbijQ6
         RvhDgIwmYfitB0SJx5c6zXAfMYyRZ539xciuwAD0XxjzZOztvBtEhuSt8FNA0dh328gQ
         Ex8w==
X-Gm-Message-State: ACgBeo3Cqj301ucsN7iuYUp25w+C9H3k+eV8hhtCWdeaPXoArBr4D6Di
        e04Xs06kMmdJC2l6Z4eoEZGvOCrvLGTnvQ==
X-Google-Smtp-Source: AA6agR4oC2P7OxbXsVkDCbos0XwdwBT5MRWn157kGrbH+fNz/QIGE0jcG2JnxEEyG/5Gti7OP6VMhQ==
X-Received: by 2002:a05:6512:1515:b0:497:a102:3951 with SMTP id bq21-20020a056512151500b00497a1023951mr2833690lfb.290.1662634373423;
        Thu, 08 Sep 2022 03:52:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e2-20020a05651236c200b00492e5d31201sm1797304lfs.7.2022.09.08.03.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 03:52:52 -0700 (PDT)
Message-ID: <9d19d32a-c1e4-2100-62ee-908616ea7a5a@linaro.org>
Date:   Thu, 8 Sep 2022 12:52:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: sc7280: Add missing aggre0,
 aggre1 clocks
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1662626776-19636-1-git-send-email-quic_krichai@quicinc.com>
 <1662626776-19636-2-git-send-email-quic_krichai@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1662626776-19636-2-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 10:46, Krishna chaitanya chundru wrote:
> Add missing aggre0, aggre1 clocks.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> changes since v3:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
