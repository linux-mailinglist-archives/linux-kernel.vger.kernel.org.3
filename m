Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F79C518386
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiECLzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiECLzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:55:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3200913F80
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 04:51:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so32902160ejj.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rv99hBfno0qOL+aJOJfuksngdxD+2uIqY8ytFa1+blI=;
        b=pjGq0IxyZlGYOJ1/YXCRtENGHPJJtoL/q18+eYCY642KYNWAhz0wzVBwp4iEKq1hBp
         rPvpom2yqEMxJnB/7jg4f4lDh2hd463y2HbCIaGN+zJJVLlun8UsgIqL87aICSmwlzxZ
         Guau0WGAFfzoHN28T4kPdeiYXImqyIfYlE+SHCTfYykPL23v4JbpxQ/6N7/HvyBgQO4d
         N/ukbTIeRcn/FQnj/ThkcK5X5coON59ffgYS8SpOlPLeYGDmG91mXM+j/DUeFW/HwW/7
         9ZmRR/UUCWReEJEsmslEqOBdusCsaLoxC6V4KQgdUKWwCbYycJ9/8LmhgmUc3OP+eylh
         H/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rv99hBfno0qOL+aJOJfuksngdxD+2uIqY8ytFa1+blI=;
        b=dDYELAJ5KgnqHItrt55zeglGe4BqbRgG3sW//H0eLhbexNpQrI/ZdDxgnnLEGlS2xI
         6AwLaJQ4bCSAighC047HrCl8xXuAxFyJZmC5VR08DwXumxFXjWi41yQNADC2BBkPm28I
         dHGrKBsP0HEfNdDNmaBk2winknRKq4MNE5kkEqPavrpbXQmI4cm1z2cFuOQOqVSAwocA
         +hx32d5jdaWlbyc0dGglXxZBMwlMNo7lAyHUUW6itDcWs8rWT5rlFLBmVE7iOv/Pcgah
         8UCaMrqTfl1uMTHcxrjoMNaGvCZ6NKCtZXGuj2gbjcTFR5l0SFPocBHdqVjJs0TyJAdv
         PRCA==
X-Gm-Message-State: AOAM533NQ/bohCbGUA32rugxCHn+VzI8Cb+jCXdrjKK/gHXUbGoVlaoM
        wziImQqO3Rseh9VEWaUHjdHJrw==
X-Google-Smtp-Source: ABdhPJyxhgnSbtd0EMK3V9WEOF72q96vY9amO57yVEVCxTwkU7DNsi7dPir6mI5OrKTCCB/aES0jWg==
X-Received: by 2002:a17:907:9723:b0:6f4:77c7:8fef with SMTP id jg35-20020a170907972300b006f477c78fefmr4582618ejc.680.1651578693704;
        Tue, 03 May 2022 04:51:33 -0700 (PDT)
Received: from [192.168.0.202] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y20-20020aa7ce94000000b0042617ba63a3sm7830369edv.45.2022.05.03.04.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 04:51:33 -0700 (PDT)
Message-ID: <ac466735-80eb-4773-3ced-f6e0ad9edeaf@linaro.org>
Date:   Tue, 3 May 2022 13:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/4] ARM: dts: qcom: sdx65: Add interconnect nodes
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1651482395-29443-1-git-send-email-quic_rohiagar@quicinc.com>
 <1651482395-29443-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1651482395-29443-2-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2022 11:06, Rohit Agarwal wrote:
> Add interconnect devicetree nodes in SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
