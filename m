Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646844FA9A4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbiDIQoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbiDIQon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 12:44:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859F91EEC5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 09:42:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d10so13418866edj.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XsH2pFq43CvFY73l+/GgB2uoztvGWddzgwUrA1kSrVw=;
        b=IRwgvKag9QSbIOlqy4VlWGOSiEVKZ+SqpZ1LeSzMCgjcu2ht5lp5ZLxW0SyCEFkPTe
         /oFoZ4TvrFr21eQpjo8aMrifvopWnj3qV1TsMO+XZqwDxMy4WLkFCYESoy/+btGXsrJS
         sfcLNB2KTWyTmpUbf8qD1pPAhK3Mlzj6AHSQvVCjw58KcrSfJz/aeu3gans4CoCizpNq
         SkWeXmhvoSDhzESqg4uSyyut/zoEDVUoFY5i4AWxsKfrcgxebcqT3eJShfz9ttis3ORW
         j7QCALpZkNakrQk6RWXaH8aofm97FtHAkihA1J2BLZfTvlCmeirPGUpw+VRpP7EZ+9b6
         aSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XsH2pFq43CvFY73l+/GgB2uoztvGWddzgwUrA1kSrVw=;
        b=fh8PMfB98ATukv/mmZxw1xszbODAZPbjOxvc6GpOoyOxk93pNXDuFARvgiGxwx2sK7
         07JFlcJENINP3vUgyxfP+MpYdIy622i/9VYYavVjrTV6522Mg8x3oqlQYWTSbV9XfoZj
         xr+feL7rf9CjPCzXcalujelSdjxbwzDQQCBYscYij89db3arOy/lx0MEvWHMqvn+UaKp
         HEHuU2KRseEZW3A9sVyrWWFaH1IWigWFv0nNzHnNuyq7g8EDPyWagf+k4TfKTWdFBrbL
         ee6iDlSTK2TN582pBWDdXzEvXY8OBKpGF+PXWi2phmKHQwPPTY0JgALINnYaOG+SBbyp
         2mEA==
X-Gm-Message-State: AOAM533OtIw9pQ1ZWewUpkXIrKiBV7HYQ3+KoV3HdbqHfWfJYaU4FWk6
        ZYOyGjnvMz0SZS6KTijZHvbOgw==
X-Google-Smtp-Source: ABdhPJz6aFkro9j5CioPZ/nYrDF9DGmaP1OpV4lKes4BKxuMXJC1nz8mDFZ5vktRzzk86gIaAKS+iQ==
X-Received: by 2002:a05:6402:492:b0:404:c4bf:8b7e with SMTP id k18-20020a056402049200b00404c4bf8b7emr24307832edv.318.1649522554196;
        Sat, 09 Apr 2022 09:42:34 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id v8-20020a50d848000000b0041cb912717asm9980305edj.91.2022.04.09.09.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 09:42:33 -0700 (PDT)
Message-ID: <de5e1f33-6e32-938d-953e-e54b217859ea@linaro.org>
Date:   Sat, 9 Apr 2022 18:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: qcom: pas: Add sc8280xp adsp
 and nsp pair
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220408220539.625301-1-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220408220539.625301-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 00:05, Bjorn Andersson wrote:
> Add the Qualcomm sc8280xp ADSP and NSP pairs to the binding.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
