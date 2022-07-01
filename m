Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0000562E34
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiGAI36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiGAI3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:29:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F45271245
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:29:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lw20so2719367ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dxZbpRkh5l4JeCdeImv9Ijljaa3y0PVNYCMebKYCl5U=;
        b=JzK4vRtf2boD93GH5GeGpymBSJi2/wRmfBUvwyV19BN6BECcAB5LUoqtwFaeVfUBPz
         nY3OwaYESyX7QZ2Tnule/458OtqLPPcxlVeD/+2ZKHRAQhy5jC2pcksMsOQuFSWnqOxJ
         Tpfj6eWejLln5hf23mQfXSdxfxSI7BWuccMLNcFpgO3LjeEJ7gi0P8vjxNPZsL7Nw7hm
         e7QVEpvH84B7eLpa/73jfdZ+TC8BBN1cB0VRzFDCkijH+T39KeYCFXZW3uh5MbZgS+oD
         l3Zz1bfBNd6KWcd2PZeAZkA7B9oi/Hzjkfhqv740zDyyVEkVfoXgOGqsp7veVEdGnqt4
         2ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dxZbpRkh5l4JeCdeImv9Ijljaa3y0PVNYCMebKYCl5U=;
        b=IleLmXNNgpB0tKSHdIXbqrxb3GoSBrtJdLfAherHCkizmNFuIfSrAlg+QlwN9iLN0G
         abcKdYg3YxmRiAOEWQPmuwnm58TOQWFZ+1IN90Gy5cWfq+BuJU63mb9dXzqixuWTzKsG
         WCGPvKZZQZA0PZ/ACuHYYz0Uzddh9QH0ZgPZ5wg/IpjrAnkb91LGuzIVwdGq6aJgwLIP
         cwPghu1sdbQOUs16Zmtv8TwrN41B/XAKPfp2kIKSALNOUnooMELi1G2Y1YUgVj583+b7
         Cpl1hOZFLwkwoKa1jgap7CHHN4fag1Y4RTgrZSYI71eSV54X0scIGuK9gu2SD7ZHtT+i
         DC8A==
X-Gm-Message-State: AJIora/Fh5MK/iXQ7crMiDWaN/k2w0WT8sb3iYJEeYWU4BHJacTrPFBP
        k6mxm4IoYr6J1N0yoG7Qp2qQWQ==
X-Google-Smtp-Source: AGRyM1vRa+C2UOMEzZXuI0s812xXVlGPUrJ3Cy8g8SB9jAZEyZodSm6NyqwYhJ9kBMUX7Gh97vNwVw==
X-Received: by 2002:a17:906:7288:b0:722:da04:da51 with SMTP id b8-20020a170906728800b00722da04da51mr13174406ejl.316.1656664182607;
        Fri, 01 Jul 2022 01:29:42 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s6-20020a1709062ec600b00711d88ae162sm10147597eji.24.2022.07.01.01.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 01:29:42 -0700 (PDT)
Message-ID: <3c17965c-a588-0580-c7d5-f6252712c35d@linaro.org>
Date:   Fri, 1 Jul 2022 10:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 01/10] dt-bindings: PCI: qcom: Fix reset conditional
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-2-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629141000.18111-2-johan+linaro@kernel.org>
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

On 29/06/2022 16:09, Johan Hovold wrote:
> Fix the reset conditional which always evaluated to true due to a
> misspelled property name ("compatibles" in plural).
> 
> Fixes: 6700a9b00f0a ("dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
