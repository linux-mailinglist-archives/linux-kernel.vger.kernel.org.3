Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A11558207D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiG0GwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiG0GwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:52:04 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29031024
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:52:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t17so13520280lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GT9LN0318tRK8V+lMJWQAJaAZNlEVObvqSXexfzllV4=;
        b=UmlTDtfeW3VDKjFHvkuOpaDYmOnM6rh+nohyv8VnauNAQNgBb68dKFZxIr6xcEDAmw
         8J57ifslgRYhVaJqQf7b6XURFC4sHbEg8HHfrhThzEx3l5aDZb+Dvp0EHfNP9IDvII4j
         4JSY7zqhjtJkNf1r+7Hu17Nk4RseiaijdrCPEL5BWrYQ8qxxTPO6NPgkSieS2HA678Cs
         n9D/57IUgTJ+gVR2R5HSr6I3ENWWq/Cwo85J65F1UDaSLOzDinpAgmn0GAPOExQZP0mL
         U9T2T61YB1hIty63Q1J9pG9a0V+72WzcZ0uUYijRg8fDIVFH6cRX1SC1eZYw3t/vLqwN
         91Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GT9LN0318tRK8V+lMJWQAJaAZNlEVObvqSXexfzllV4=;
        b=FSoKWqW1jW772on755aIGHi/X4EUE+pBLU7bikTRjXFu8L9PYYvhJ7gHwqFQxL8WwY
         BimmoM7J4wSPML2IHX40LfXMUw7YF6NenH5VfMNDcB1BCkqRPoCpp0o1X/9Jn28L25gm
         oeEFmZ1h7O+WDL0Mn8u1shv66TXqIjMdDH7xFQ8UjxVxcfoPwqsu9aoqP7Vt4GVG6G//
         PqmW31v3fTVktMiiZFiT+OWX0HucTC6Kl4XTSSbsoDX6LxW1OoXc2l0/m16MzQIL3ylq
         33ehx49NMaaQhXfIixJ35hW9aUz1a3ELCXtlhDDiVd39BrRvswtDxc4wkPd7HM46YLna
         hg9w==
X-Gm-Message-State: AJIora9ozZRx08IRnwwdhqMhpD9PQ14Bg/HaJqwXTsvtjn7/WlBfvYG7
        QEx8JI/Xf+AYbWxBRJF1yS1AZQ==
X-Google-Smtp-Source: AGRyM1so+qJ9ymSEdwmy108s1d9Dlc2EdM1pFqfwnXQFtfBLFU6LlktU0CWd6/D4IknxjViqpJMYtw==
X-Received: by 2002:a05:6512:13a4:b0:477:a28a:2280 with SMTP id p36-20020a05651213a400b00477a28a2280mr7256491lfa.689.1658904721193;
        Tue, 26 Jul 2022 23:52:01 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id q24-20020a2eb4b8000000b0025e053564f3sm1783059ljm.18.2022.07.26.23.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 23:52:00 -0700 (PDT)
Message-ID: <1fbc0f83-4fe6-031a-73cf-7bbe68e4d08c@linaro.org>
Date:   Wed, 27 Jul 2022 08:51:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/5] ARM: qcom_defconfig: enable more Qualcomm drivers
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20220726150609.140472-1-krzysztof.kozlowski@linaro.org>
 <20220726150609.140472-2-krzysztof.kozlowski@linaro.org>
 <CAA8EJppMNUV0eEF7BV6=7RgQK_XUEsqcLpmf_zu0XjSRLTLQ6w@mail.gmail.com>
 <a9356472-0fef-d500-837c-ad6d9ed27b94@linaro.org>
 <76bf4b19-54e8-c8cc-be71-356233b1cd57@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <76bf4b19-54e8-c8cc-be71-356233b1cd57@linaro.org>
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

On 26/07/2022 19:43, Dmitry Baryshkov wrote:

>> I was considering it, but it seems none of ARMv7 DTS use it.
> 
> Argh. The driver has support for 8974 and 8084, but nobody has wired 
> that up. I'd still suggest marking it as =y/=m. I'll send dtsi patches 
> in parallel.
> 

OK, that makes sense. I'll add it to defconfigs.

Best regards,
Krzysztof
