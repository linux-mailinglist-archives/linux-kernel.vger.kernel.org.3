Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208CB568069
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiGFHoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiGFHoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:44:10 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30358237D5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:44:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f39so24489399lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 00:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TKtOmU40I0PUl50L6vzWbju5L1un8dLolA/wVeGLNsY=;
        b=Rr6Gww0YYOAWIJPTkzmTj1EksjkDVCborzvqk1T4ai+taLNzlmUbbYvFG2zDZokRca
         89CwRWtqqVobU6euxqVyxJMoxEpQhS0fKjWtDOg+mXsCRnnaw8hcDv86P75yNTOWfVc7
         RyFY7oIQ7udCTVqYx+Gp3IzIMD3OLhkgGl6HVPCThRxukrNCavEo9zDC4wBVuAaSjuWU
         NON9SBpcnxTjEjoVbbrWQ8oHW1UWDeAyJW2+NdSc+XLyRZUARHsfGc/jA6OH/pD1Kq1o
         HeCuU9aYMmd8KcunwBRYVCysmcOuMc1DJCaypokmrsdUoUhbBj6SUS9wvs9xjhu984wI
         NLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TKtOmU40I0PUl50L6vzWbju5L1un8dLolA/wVeGLNsY=;
        b=fT1n+pjl2oU0giK/ve2oBS2OsagOk8ZU4L4d4i81bIdTIhrDaUGblkM0AgzYATZuH9
         vcBfPbD8SGwaIZRPz3Js5GMwZn0o3ZVFuK/+MEMgXIXQ5urPwqIA05Gughyfl2a6ilhH
         tSzaXoI9RTPJHfZfmfS0AnVutBTQu782bk/Y6wV6z68h7GR9HuAhEobkgesRSssad5w/
         qa3nVMTm1PHARe2DTtzf4hFh+kK07R4+J5LWxr4N5MYiZRtDi/3cvxtDJJd+clBRxBhr
         9toppcBG8pD5qskspmFZHzg42Z6Z0zq2C9v42x3Kh/lqMwfM3zKEqEZQvVJ4vMHZ1AwB
         a07w==
X-Gm-Message-State: AJIora+SWlCPu2ZkOAfVcohaMdKP65k8zeeKB6EZkcMvdDcC8v+mwkKE
        7nadAVAWM+f+/GSDA99jpmaXOA==
X-Google-Smtp-Source: AGRyM1vxk/QhmIZGTEXTY9O9WCE+a3P2JkZ23N45jsZ36w/x4GSakc/YWr2IjX44OLNvuoRPjz3xyQ==
X-Received: by 2002:a05:6512:3147:b0:487:2557:9d9c with SMTP id s7-20020a056512314700b0048725579d9cmr29340lfi.566.1657093446259;
        Wed, 06 Jul 2022 00:44:06 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id v22-20020a056512349600b0047fac1feb6fsm6137453lfr.210.2022.07.06.00.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 00:44:05 -0700 (PDT)
Message-ID: <18e40247-7151-b50a-97fe-00ee88f47d9b@linaro.org>
Date:   Wed, 6 Jul 2022 09:44:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] ARM: DTS: qcom: fix dtbs_check warning with new rpmcc
 clocks
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705202837.667-1-ansuelsmth@gmail.com>
 <20220705202837.667-3-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705202837.667-3-ansuelsmth@gmail.com>
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

On 05/07/2022 22:28, Christian Marangi wrote:
> Fix dtbs_check warning for new rpmcc Documentation changes and add the
> required clocks.

There is no warning in the kernel, right? So the commit is not correct.

Only the second part of your sentence applies, but you should extend it.



Best regards,
Krzysztof
