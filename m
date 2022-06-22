Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB48D554C37
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357942AbiFVOID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357924AbiFVOH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:07:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3B3E73
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:07:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c65so1054258edf.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tfUwLbFH30zmp/z35DalxVO24hi1rhwfx7b55xzocKU=;
        b=rlCwhnKPtzSVZZuVC1UbT0IPVt64X1EOy+slNVxeAmucc5roLa5rpVOtMonNyOqsTV
         RnZK5Q2j7df/zqRTIMIik5jb4JunCx+qLCTgdTposl/bbzob/5DKDqvUQQvOwtI8Vwt7
         u/MhbsJapoBvZI23SZsMxmfmzSzlrnV3bdEKU9ByPnn48kJykdYimVoj0wwnXRDlnrC7
         vHO8zq8mdP6cd9CLs0m/5gc/qFzThlVoiEWvfSWxDN+mU3vrvd3hRdszv7J4mLlpzoxf
         BdGPRuAQ438EVImmScyf85fpdNXdQNHaA3rsT8Oe7k3wHmD+Emhtb54cQk0MTddQcNk7
         Qwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tfUwLbFH30zmp/z35DalxVO24hi1rhwfx7b55xzocKU=;
        b=MTh7ruBiJW8QLwq2vNPbhML7LHcpZTmRr/ksckERZbXrlVmZaJaDGKbulcqpPcEoaU
         Ia8U6xcGRAyFsM+Pznz7EIJh+22KUyntogAuZX9Bwc3o1ORPbk3S7AvAykxKbPFWkHAr
         x3bx05KjTWYzS088nA4dl2/Mtj9p6FAwV+rnZCsIws7fc6YN1GGgsU3P2KPisnatYsmZ
         mZyXR6tmSBGqk+oWymg6gKkNGlxha1t1Xjw1+EBXK2minISfO2SRa3q2KhMm+zvnIayP
         wpnRGqwRLbrNWscbpXrAF+lkx8mNAlSZRjrY3XKqWWJqVGoDCHK9YyaJ1gFelUGPLCRW
         yhTA==
X-Gm-Message-State: AJIora8vzTpzpfACiglCUVnt7G0mUZUzUo6AWRTeORjPCHppTnjfvSlP
        l0wYttJZHkuT2c+XSeQnU82ycg==
X-Google-Smtp-Source: AGRyM1tUvKsUxzsrufF8tQYt5LOqzpwycvAUZRsjtsjXAq10wM9KnyyC0XG1vg9ClhI5dS1Qd4fp9Q==
X-Received: by 2002:a05:6402:4248:b0:435:9150:ccfb with SMTP id g8-20020a056402424800b004359150ccfbmr4370512edb.374.1655906876377;
        Wed, 22 Jun 2022 07:07:56 -0700 (PDT)
Received: from [192.168.0.224] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p26-20020a170906b21a00b00722f48d1f19sm943361ejz.67.2022.06.22.07.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:07:55 -0700 (PDT)
Message-ID: <dbe4cf98-da75-8f31-d76a-3c77f3448179@linaro.org>
Date:   Wed, 22 Jun 2022 16:07:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: add SC8280XP platform
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-4-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220622041224.627803-4-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 06:12, Bjorn Andersson wrote:
> Introduce initial support for the Qualcomm SC8280XP platform, aka 8cx
> Gen 3. This initial contribution supports SMP, CPUfreq, CPU cluster
> idling, GCC, TLMM, SMMU, RPMh regulators, power-domains and clocks,
> interconnects, some QUPs, UFS, remoteprocs, USB, watchdog, LLCC and
> tsens.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Reordered "status" last
> - Fixed invalid unit addresses on USB phys
> - Dropped multiport USB controller for now
> - Fixed system-cache-controller sort ordering
> - Moved &xo_board_clk frequency to board dts
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
