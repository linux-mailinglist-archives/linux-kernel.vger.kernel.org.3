Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E909569B2E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiGGHAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiGGG7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:59:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CC13204F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:58:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z25so11985877lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 23:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=hvUzTt/hWuggOtdt8jKqR4jgNLkATU6+KSsc3GgXz+c=;
        b=VgBQJmVRd2BDZ9PeNdyrJAOvcPlTYn2PPTUzcs9LnhK0yYy8j3p18dyh+DltJm8dJV
         z5+zQAs1wXeP3uhRq9AQC8OzSDDtPUAo6vlVNuX/ASq0wzPGOeYTSRYuUEdE3OEQRwHq
         uvqil25uIWpRmRZGgE2D3hZvmIVKnN6Aitk9Hlz8izL9eN+AyJw0KGlm21FTXk0SptZU
         emsKK8QHsgseMyHsQD6JlLI9hSu3khmWuA9TIVNKrWUQrRSbrvxdVhkREjKXrdJilvtJ
         i5OGUPPoDjPWPb6xwEvEUz53MsRb3W6PMPaOgcy7EZdalm1MWbIB4ypuw9cAhxrIyxyJ
         0bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hvUzTt/hWuggOtdt8jKqR4jgNLkATU6+KSsc3GgXz+c=;
        b=Eg6j6PEGJQtv0FdXtG8EJIie8UmxLr8D3ysuwjFC3wiLxx+PpgQfnhBr8U40fibBkX
         XBeD1Y6966n47uEE+RQGHMERvf/iSLXz9oYzglhQZqXBCsixcz0nv9oBVGahkoPSeCpm
         gu2LNWRajDuel4ZwrFxsxZ2uuraQHcBrR32fCmDxhumrIIm/37KrL6QwIK1MhdMk5puB
         DOX7tlr/2ecmCFwD6tfOWw6GsfNe6CxNksRV3Jc6Xv9kH3BkoQyKlL7oo8em5JxmTiW8
         w3MNECkqq2bhaOTQl3628j3k2HIV19jao+9D9Du0HZT49nuIiq8F4WLWILkK8nT+I3hc
         jcjA==
X-Gm-Message-State: AJIora/jl93VUoGJJEFLqwkbMDSqQpU2L2dBwYzz/EKkDidJjGNXaLKL
        /BBsA0ksc+q/MmWFdYooWlzB4g==
X-Google-Smtp-Source: AGRyM1tDaP3INpKJsy7RLE6N1Scip5mqFubiHpw1TEPBwZruoEcL5MnxC3Ndykpp+awMhrLd/txSqg==
X-Received: by 2002:a05:6512:ac7:b0:488:de2d:ba23 with SMTP id n7-20020a0565120ac700b00488de2dba23mr223870lfu.653.1657177134963;
        Wed, 06 Jul 2022 23:58:54 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id h4-20020ac250c4000000b00483e5f0192esm1252115lfm.87.2022.07.06.23.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 23:58:54 -0700 (PDT)
Message-ID: <95062dd8-0bc3-c350-7fd1-a02dfc4ef1d7@linaro.org>
Date:   Thu, 7 Jul 2022 08:58:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] ARM: dts: qcom: add missing hwlock for ipq8064 dtsi
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20220707013017.26654-1-ansuelsmth@gmail.com>
 <20220707013017.26654-2-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707013017.26654-2-ansuelsmth@gmail.com>
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

On 07/07/2022 03:30, Christian Marangi wrote:
> Add missing hwlock for ipq8064 dtsi provided by qcom,sfpb-mutex.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
