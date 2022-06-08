Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9545429AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiFHImS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiFHIl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:41:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C04E24D692
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:03:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id v1so29126485ejg.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cQPf4o0FLnpYr0g5LbwDliAY1aq0umFdw17thSCyAkQ=;
        b=IT7kg1hUsFCC4KIhHK9UBHSRA/L6ZJf8/FCqxk//PYSuHm07tU87J7tskZJsXs2iUk
         65nmqD3JZDK8GWwZA1QzEkfCK5q3Uw6wFS4MbxKAu8V5ctq96H4lxRDRUdFy/7oMk7oU
         q9/TqrkNsswIyenivpNqoRapjHhRkB/ocEjgzWRU7I7Ht/tL4cX30a1X/cMP3gNyKXHp
         /Q1WTc9jxbY6XkaM05W62GfqmsLHiwBor/0MBhZcWSVuDCIiP7b36foQU9i76UJB1sWg
         rl4ICPicXVD82jvw29E7In3j0XzJul7/V/g5OwQp9DFodGMNPVmF27rO+pNjqYTnDmFb
         FmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cQPf4o0FLnpYr0g5LbwDliAY1aq0umFdw17thSCyAkQ=;
        b=CXPxZzj6DXO4pSwFOfX54KZz4ItwYgfulnr0qnejSJcVvjVi26eNI8qjwr5+V1O7GU
         0xWKIdX1mQV80zRNAMtsZ6kS7mhSRxXkQyw7+KV+YG4P5OcNHC8DPiMGn4Ijm1kSmmtn
         Wigv+k/NfoY1d4evPMfZz9xdecgBvD35ZBp3uXRY3pgNFZumTNHcBBLJOS8OAuHCpIfc
         45MJPV2wk3k7cLkzKL+VTqHuJC/0tVUiwxP6nwkNb/cUWyI87g75VJ4t8z1jiGDJGnUG
         zVdb/1wVVnFV/MWppVytAeAvDiHZbciiT+VdQa8lrlaK9ORKmLUBTGT5312/hQEUV3KT
         +dBg==
X-Gm-Message-State: AOAM533xrxMfGGraqj+4rVgvLRfCQOs5PprbG64Tob7k8WIRx/FT1K7K
        woyebtSkEgHwDIDVXwr0CK/nHg==
X-Google-Smtp-Source: ABdhPJy+FA+lFViN60Z3sT0HRKAT4Bbth/WPynt87kUH6G6DDkAoN3SmsMGKsEXRtLSB0IiTCJPwmw==
X-Received: by 2002:a17:906:8a59:b0:711:34fd:29ff with SMTP id gx25-20020a1709068a5900b0071134fd29ffmr18762082ejc.439.1654675194443;
        Wed, 08 Jun 2022 00:59:54 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l4-20020a170906644400b006feb047502bsm8778738ejn.151.2022.06.08.00.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 00:59:53 -0700 (PDT)
Message-ID: <0dc3ff06-4afe-a465-9681-9b51b2944cbe@linaro.org>
Date:   Wed, 8 Jun 2022 09:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-bindings: mailbox: qcom-ipcc: Add NSP1 client
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
 <20220607214113.4057684-2-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607214113.4057684-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 23:41, Bjorn Andersson wrote:
> Add a client for the NSP1 found in some recent Qualcomm platforms.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Jassi, there's no code dependency on this constant, so it's only going to be
> referenced from the dts (patch 2/4). I would appreciate if I could get an Ack
> and merge this together with the dts changes.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
