Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD495AE2A6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbiIFIa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239076AbiIFIaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:30:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A9B1F60C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:29:46 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b19so11449187ljf.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=eZmxXgHJXdgFMKIz5p2FbAR+53IIfucrS164Tgcj3tA=;
        b=U6BuOk5lX2zNRmwrUGUNquG8mjL1UetWHN9Ufxlm9iDRuUYbo37VMcZxj0WhRn0+8I
         L6/22pr1DAP1uywr7/Ed6HMGSqAAYg8UTfX0RqYL9OdZK5AsPJhmeo/HWnWebxJOVYgo
         VJZetLfgW0da0CntsHwV/FvBV1i0bYdmdQpszxiz1WwbejxtUoyexLN1IZFgboqyBclC
         TSxuLXRXgrZL8zPMbARtO2PENiqnXXELjKdmNyYeA7b3J3vUbWB31NQqIFnEsUHCeFxU
         EpwNAuv8ycxJ1ZxFnllVVchMTSfKX50iFVdVZh4e+c0QJCdaVE6593Bc0CGaG+HezO/6
         qidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eZmxXgHJXdgFMKIz5p2FbAR+53IIfucrS164Tgcj3tA=;
        b=n1ob+iQIqBTFlvmNJNpsRsTINJlG//anIU0H0+PWEoDUd9PnngV1Rt/YBaIn3GQ9o5
         3DfErhHzTLVjoV7G/vp2aYDloUVO1u43pFVHilPtmNVn4HgNaK4V0qT3HqbUckxLSVvU
         NJWDSx3aG57IHu197rYNyqvYNrshDNjGS8FKHxEJGGi/sJZkvv9kA4kk4CHD6RYK7IoC
         9dxaK3Vr5aBUXQqFHn74hxjGZexb8W/nizGC8FqODoOXRMa8uoo5Zjg2Ofz7zSTYRK5p
         t30M84+l8fRDyoA1tZtqTSQ0CVwOPgjQBQlYf7T1iT9pVXwmlKHQUXBjMuGcBBy/cgbf
         9Klw==
X-Gm-Message-State: ACgBeo0KWK9/pYbx4r6Z4NUw9xcQJjyhwSo9Bsf8TVbj7Ca5VH49oYZe
        klLYymtdTUXUMms3iNcfzuXWyg==
X-Google-Smtp-Source: AA6agR6Gw/VKeIdLq6nNen6IXooe3Xz45L4UaHxcawpyb78jakwf/lIImSam4aDh5PAEfJBCo9INAw==
X-Received: by 2002:a05:651c:516:b0:25f:f52b:3c86 with SMTP id o22-20020a05651c051600b0025ff52b3c86mr15620883ljp.523.1662452985055;
        Tue, 06 Sep 2022 01:29:45 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i22-20020a056512341600b00497a123d8b7sm1583lfr.172.2022.09.06.01.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 01:29:44 -0700 (PDT)
Message-ID: <26b96770-ddb4-94f7-c205-3c7b55bfe9c1@linaro.org>
Date:   Tue, 6 Sep 2022 10:29:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: sm4250: Add soc dtsi
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
 <20220903174150.3566935-9-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220903174150.3566935-9-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2022 19:41, Iskren Chernev wrote:
> The SM4250 is a downclocked version of the SM6115.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm4250.dtsi | 38 ++++++++++++++++++++++++++++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
