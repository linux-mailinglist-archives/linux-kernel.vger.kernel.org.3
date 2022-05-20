Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7582852EE88
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350521AbiETOyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348564AbiETOyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:54:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADFC1737EF
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:54:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id g16so9964244lja.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4BJIT7CG+Ul2K/EB6KaL6cJMzPTA3sPqOQKdczNQrz0=;
        b=XiL/0TCBEhD5jOpMvf+4h3Uz3adrFQvHz3m15JiIOFF50t8K0dCctWQJl5TyuG8HSK
         /FQIIGd4+oZKqiRff4nW3Twkj4PAvbPHoDI2DICGKZWZMllrazXCk5yfr8//Esgu7Ksa
         AQErmMxiLKzR4Ei3gYnxDo1EMiWL6jVe45bRsdShKs3j/dyr77n7/dRxQ/o30byqYsDa
         cCdQDzHt+XL/p+WOjSsKg+5Qkfoq5l3xh86Rr8jCcnkOVBlAPg3woP7CBrlYG/Lt7aPG
         G66gvKCftnM2GZPyMVkg2V995CxPHLuCzQ1DN0zwTmNwJ0LJtIhG79uXq9RBn4rLj2wi
         85xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4BJIT7CG+Ul2K/EB6KaL6cJMzPTA3sPqOQKdczNQrz0=;
        b=Do/KO/lBxfJ26id0I12wuhsUgvae0dindKQYAL+5e2wibA0m81gqMdVpOi1XIVClRx
         psmPmBtA8Y8KpHMmIntgO62bWzNm8voaDKdg6huoPHbik2nxzCSpC8OtPMz4HW+JBkql
         Relg2ja38XAi5z8y4X0mPAwHovDL5+vea7NSiFjJ3mKHJIbjMqZYtdNAblB+hG+Yl77J
         gzFqO5kYkBLXDNgmPQVhhppHHEO3oCBfiWMtVPbtBM0B61BqEo9YC4LvhxysTPsiFZZz
         iddnITz1hkWhoLf0ldm2MbRw3r82TLTiDMcGcbkeLoe+NGmx62Y3nqvpS91Bnr9cN+zd
         1V0g==
X-Gm-Message-State: AOAM532MoKXKZfPTT+bD2yIG118/C/CI0DTSggRKanAJw5l/k80mEQMs
        CTmA8s7jmC7i8YIwtuFbazfBPA==
X-Google-Smtp-Source: ABdhPJwsgGw3Tfn2I01xsNTM/Xrzfl3SCvqSwPoFgoVuLlutxeYLQV0lqlxPCwxh7WUHbRKLbAru/Q==
X-Received: by 2002:a05:651c:179a:b0:247:d37b:6ec5 with SMTP id bn26-20020a05651c179a00b00247d37b6ec5mr5616804ljb.112.1653058477877;
        Fri, 20 May 2022 07:54:37 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f3-20020a19ae03000000b004779f2ce1e7sm689290lfc.53.2022.05.20.07.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:54:37 -0700 (PDT)
Message-ID: <1b39bff2-7eb1-b613-654d-59d11dcfe03a@linaro.org>
Date:   Fri, 20 May 2022 16:54:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: soc: qcom,rpmh-rsc: simplify qcom,tcs-config
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
References: <20220426110757.80603-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426110757.80603-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 13:07, Krzysztof Kozlowski wrote:
> The schema for "qcom,tcs-config" property can be a little bit simpler,
> without the need of defining each item.  Also move the description of
> each part of "qcom,tcs-config" tupple to the tupple items description.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi,

This was sent a month ago... any chances for pick up?

Best regards,
Krzysztof
