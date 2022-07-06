Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725E25681B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiGFIgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiGFIf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:35:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464CF248CF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:35:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y16so24630599lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aLZXwYZ9gaGI3SCl2i3E+E/g2ZEGIRcqkI8rVEaH1qw=;
        b=T4xkDpLRVDEQWlHSzQdxjULMapkSmr7pfUsTQW2VNV4GbleRHs81JU3aaLlxoF8Upk
         A4S+kknexXROJuatHbcBBnpIZlOklSx5YSN7wTRIUmZ1QMiLpUNksl9aYDfnWTY1aJYO
         eT0hxo1jXxxwXuZjr5GoykE+bK/3gzB0FOMWrnp0yBAk33tbYE5Mqnv7B0F1mahd4KAA
         eBWzEt6wsXi70VZo0+YmEQVWewFg1zVf4V0gg7piWT0mZgfIhjWoefKeBU8+Dq2DXaRW
         O9dDRZDYpSIfLLupwZT5SxFOTxLmruk9LWz2017w6XVADhlmBiPwRmdRjn52dhWCyVO1
         Yk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aLZXwYZ9gaGI3SCl2i3E+E/g2ZEGIRcqkI8rVEaH1qw=;
        b=lSk9143B8T+OkfMDrht8XJZXhe+y/TJhq6and8mN4CQooSZhtIpmODv+cLfa0tLgzy
         y3CJLaYBIDL8J15TPhtZdCSgZKAXOGcV7HW9hGdFm0KhLZyrzQoogD9PjJv4J3Gb3Hdu
         F/J+UHnMzP78RD340VqSEu2ixsE2mFxDoxNdA5Ho0q4WRs7i/tdqsIY5UeNbMnYpFwTA
         kibtHpzfKbTgWVuqgphdEJd6yXo6Da34cFxOejxOfwiJeVz1rxjCD/+sW02e2bv3QULD
         80eeFRstj29JDxVkN/fRNoyxqXEA5NcqZQucy9IcME6HUeBdUQi0Kv2wS1Oh2Tj6RuZB
         wrFQ==
X-Gm-Message-State: AJIora8xvrU0VyONkGM+8GrLfcLRmPCrwIFvyU+54KO6IQdh4xENDCvE
        6+xqJPPKa20aiSxTureSuGnXuA==
X-Google-Smtp-Source: AGRyM1tnFZkCYGMHFa3J1Rdr08wR3i3EnsXPEtGkc1h4e7ivcWI375TBG1djOjRH5o75QQiNyl7p6Q==
X-Received: by 2002:a05:6512:3086:b0:482:deaf:9c8 with SMTP id z6-20020a056512308600b00482deaf09c8mr6930503lfd.169.1657096553544;
        Wed, 06 Jul 2022 01:35:53 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id b16-20020ac247f0000000b004791b687235sm6142372lfp.119.2022.07.06.01.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:35:52 -0700 (PDT)
Message-ID: <0fc38d25-a03a-35b8-44c6-543daaa2bbbc@linaro.org>
Date:   Wed, 6 Jul 2022 10:35:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/13] ARM: dts: qcom: add missing snps,dwmac compatible
 for gmac ipq8064
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan McDowell <noodles@earth.li>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-6-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705133917.8405-6-ansuelsmth@gmail.com>
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

On 05/07/2022 15:39, Christian Marangi wrote:
> Add missing snps,dwmac compatible for gmac ipq8064 dtsi.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Tested-by: Jonathan McDowell <noodles@earth.li>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
