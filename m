Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2157F159
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 22:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbiGWUji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 16:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiGWUjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 16:39:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FDA183AD
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:39:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bp17so12669959lfb.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=30Q3Mov+xUcHtaroWn9KhpjvlVfGQAQUMUdIfMSPO9g=;
        b=VFJPJlLbZyczA6sL69wUQJp7nULarv/JKfF1X2GvlL7+xIFJWHYf/v6FTiaEFyC96W
         tgrSEpGFZFSrybANlSuq6QxtdAiHZS/2oiHquKVFoj6IiPK5VioA4EyDiL/ndDGzD4y8
         nq8hCWnOsaGZuzijMSSulMUEqYcUzBBNluCWYxCxleSUXjXgfcRtpwsfk8eHUR/V6tFL
         V7YyRhoiFiuCMlwlG5CmEFUx8LNK2zreB0aHz932eVWic9fXf3LIwmW6o0jd4aiaQe7K
         RsADfA/6EXTkhduW4rlSxIF+DplihttT9SeWl9a9CidnqU7i27p/BsuBKO7Gs+h/jY7H
         D9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=30Q3Mov+xUcHtaroWn9KhpjvlVfGQAQUMUdIfMSPO9g=;
        b=S+Mr4AsDVcAgvsVdDHc+C+MqqFPS1vLYxKmHGYOrVRjzdteL/8XqlfhYiKaLn6XmOM
         oa1wKo+KxgMyCgkFAUbaaxas3wNGbt7r4UKl0buc1b5gecHf5XxWcqps1Jt4I9Oad4nF
         Si2MxxWc77QhUwG6dRhvSzq0ae790o1D4TrQOXBwiQNHY836NtGxEAYT/hAchCRkcJrO
         sfB6Fw3s1zgSjZVvDNsJx7821GsHDVSpvc3cIUt3D3ebVsstMEOKsXQaPlq7rtoFKFfo
         U1OIIEULGT4uZMUOY2FAAVxfk/Xi/wIZSRmLTOvX8H5CnSZq4c4warTjZmIS8dj5X7gv
         lw0w==
X-Gm-Message-State: AJIora+4/pcR4XYraMVkCLGgCDQT6v0anav6iIT1khWthKDGzyqLpSju
        /iCzThhNzrpuxJpf1owkjZVtIg==
X-Google-Smtp-Source: AGRyM1vvMkuX3UzPqmEIMziQeOmAteJdFjHyqdwrQvuiIaOt4cRLcxy//GUBKdH1M/hlaoO9GVqr3Q==
X-Received: by 2002:ac2:4d06:0:b0:48a:765d:144b with SMTP id r6-20020ac24d06000000b0048a765d144bmr2096286lfi.208.1658608772023;
        Sat, 23 Jul 2022 13:39:32 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id g1-20020a056512118100b004811bf4999csm1810451lfr.290.2022.07.23.13.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 13:39:31 -0700 (PDT)
Message-ID: <c5a73ed6-c2bb-8c99-b675-c5baa3c41f8a@linaro.org>
Date:   Sat, 23 Jul 2022 22:39:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: qcom: Document
 samsung,matisse-wifi device
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220721230231.98886-1-matti.lehtimaki@gmail.com>
 <20220721230231.98886-3-matti.lehtimaki@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721230231.98886-3-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 01:02, Matti Lehtimäki wrote:
> Add binding documentation for Samsung Galaxy Tab 4 10.1 (2014) wifi
> tablet which is based on Snapdragon 400 (apq8026) SoC.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
