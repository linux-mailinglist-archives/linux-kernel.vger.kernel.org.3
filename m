Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1CB581639
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiGZPQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbiGZPP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:15:56 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48AA2528C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:15:53 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-f2a4c51c45so18958295fac.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qi27YQV2llDIQ9MD4a8mHofES1qIg++Nu2kwK03YD9s=;
        b=CQAIm7dsoQ67sdv3ZNlQe6NjLz8yY6xJUmn7p6/mRDOJU4AfuiFJiSoeJElIgg+tAG
         mFMrcjFV63EHW9qUCC6hD/DIPS7bFjLG5uHUNoS1kGMSxsOgyukFtbcOG5hcNandjbup
         xs4PRGPwsd9nAJw0a02gw1hvB8oQ71GiWPhIS7Sa/gVtWAKHNFvVykm9NRZ++5yJMnUE
         ty3Y/OtxIaKGQq/omAtGXpNGE6FGbRmEK6T9/LLkQJTuu0yCUC6k3ufqEv16KlMVrlB9
         grZTXFo08BOg6O46yegyIGx8YZplppu+dB0fP8UW3g+MU2okGzhAnk1YL/4NrYCrdKoY
         wzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qi27YQV2llDIQ9MD4a8mHofES1qIg++Nu2kwK03YD9s=;
        b=DyjnVgpqC0HD3fSYo21rh6QGHhEW2GX+xh/6E3rWRRPM8EWAtWxhVsTa6kSC9s5M40
         2IyP4uQ1qo5MtowmI3MiMzxlfbw3J55G1R8QantU/PFagCHWCNl8IOdR8M6b6GSNUGCe
         w5Fc0wGqHndCC11zgHi07EXCP1xzAfVLH5o2IdBtMm0RlbuP2rBy4onPPUBK16bY9EKI
         13DlB+eatx5gZ4x6GUiGqzoH+erTtsdB43lsU5xXQTKsCbEtvDMNrzOZSPwZLVSA1RZF
         0YdMIgGLDNemmsg3RDyYKtR2kaCdyrXcFkPDR5kKoTR7o8IB3fbPgfnHZ20fr/h1wwvm
         ZhAA==
X-Gm-Message-State: AJIora+WtQlvXGUC0EIQJMNajB4qfdrB7cmCHd858ItunKbDJ/TgEg/R
        X7farkDFux+NSOhEbo2Eh5hMNg==
X-Google-Smtp-Source: AGRyM1uhgZZGXaCq2SBFY+o1bwUROWuIuAPgjZwj+YCssxLFM98pvrFIosfruR3nTAuuiAaROu1fpw==
X-Received: by 2002:a05:6870:b021:b0:10d:438:15e2 with SMTP id y33-20020a056870b02100b0010d043815e2mr8713667oae.162.1658848553012;
        Tue, 26 Jul 2022 08:15:53 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id w4-20020a4aa444000000b0041ba884d42csm6015111ool.42.2022.07.26.08.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 08:15:52 -0700 (PDT)
Message-ID: <68600ea4-9f65-f365-382a-444c60b4a25d@kali.org>
Date:   Tue, 26 Jul 2022 10:15:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 10/10] arm64: dts: qcom: sdm845: add LLCC BWMON
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
 <20220720192807.130098-11-krzysztof.kozlowski@linaro.org>
 <25673493-4171-62b0-f696-1316d115f388@kali.org>
 <96552a95-8939-3ac2-c9b3-14dabaf53923@linaro.org>
 <d814a6da-b0d7-2fd1-fd14-8f1f3b88666f@kali.org>
 <d89a540f-672d-83de-d19d-00f10e4370d1@kali.org>
 <fec6bd98-5efd-fe34-6d75-1765219acd82@linaro.org>
 <25321f37-dbea-188b-1b11-e983a00701b2@quicinc.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <25321f37-dbea-188b-1b11-e983a00701b2@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/26/22 6:31 AM, Sibi Sankar wrote:
> On 7/23/22 2:06 PM, Krzysztof Kozlowski wrote:
>> On 23/07/2022 04:37, Steev Klimaszewski wrote:
>>>>
>>>> Currently it's 5.19.0-rc7 (torvalds tree at 4ba1329c) with a few extra
>>>> patches on top, the bwmon set included.  It's possible that secure
>>>> world uses it, but I do not know enough about that to say one way or
>>>> the other.
>>
>> To test patches you should apply them on maintainer's tree or
>> linux-next. Applying on other trees of course might be useful for
>> testing some backports, but it is independent process and different 
>> issue.
>>
>>>>
>>>> -- steev
>>>>
>>> I think you may be right; I just applied this patchset to -next
>>> (20220722) and i do not see the error message there.  On my 5.19-rc7
>>> tree, i am also testing a patchset that enables qcom devices to access
>>> efivars, so possibly we are ending up in secure world there?
>>
>> Actually mapping of IO space should not touch secure world, so this was
>> a long shot assuming you test it on the next.
>>
>
> The memory region specified in device tree overlaps with the llcc system
> cache controller node. Steev probably had the QCOM_LLCC config enabled 
> when he tested it out on his branch.
>
>>
>> Best regards,
>> Krzysztof
>>
Good catch!  You are correct, my -next config did not have QCOM_LLCC 
set, and I am using QCOM_LLCC=m on the 5.19.0 release candidate.
