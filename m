Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C3253B81E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiFBLu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiFBLuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:50:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95626133279
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:50:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id fd25so5933972edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 04:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wpBUobv+zTk3pdLoR7N20MDqJUuOfaEKEA6qjnXONEc=;
        b=A7IFp7EFWP2gtSqA3FcMsNaOvTPmwO3asdjDpQV5JmLEAsLVX8l1GYiUanOqRLFXjV
         hznkk8Q4o1272G28YDzUY3wxIMxZ9508w6REp7wSieI/b5zWcjdxi+BX+gRpZN//7Mi0
         8DFJrOySxI98ETvKO2A2XL2vgAyI8xyfuxdefusfWpeBnPJkAOQsZ9be5fIHHy5DXCYI
         mMG237vpicVQ2zIZY8zhCVSZbvglqobTKka9eVSlHjY4XJTLaHnVGwm9JYWqzQA6GXoe
         rTD70/hUQKYWKMuQAP8tMKJJ1RmN7CvjjXVRxKWhwaBo8HJcQn5i89z7a5kmHyPtCMPc
         KfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wpBUobv+zTk3pdLoR7N20MDqJUuOfaEKEA6qjnXONEc=;
        b=pVvlFxIJGU9A87ey/p4nAakZT+Y8mpxiczGNy1X2Xc2fAv5Jm1cISptFF5dRapkrvX
         g6g0cFM+jMzTUlJKOtpcYSqszZi3470Pb7WHwxGNRy1WY1DSv8aysSLDK93wrtM92lKR
         GqwYf2JxTXKnZxQZr3IbMN4nXegd0lpHWB2lZOjFz/QXAd4VHxDqnM++DjfPrzFkMkMd
         gClqji0kBZX5unPc99X/FX+JMwbCqseo+Ln2VuBDThtMivcwriI3dEoT7xBZUKH16N8V
         C90bOGl4WBXZOcP7/5HZdHNGBxjreAui86AxQpRtLVRU+Ylyl8B8MwJgxcli9dDoqjb/
         QTWQ==
X-Gm-Message-State: AOAM531pAVpq3iDU7CX7QLim+Id3O5GTn6H+kalcYFddUc2K1RWt6zs6
        qQJ9soxl+LhX4GwPwazyJN1TPQ==
X-Google-Smtp-Source: ABdhPJwwtvpAPWA82iz7xzVdST8RGddMP38QsXTMAQs+1dgZ/kQQUB7oPABE038NM+DHNu6+286n6Q==
X-Received: by 2002:a05:6402:5205:b0:42b:2678:998a with SMTP id s5-20020a056402520500b0042b2678998amr5084554edd.250.1654170613244;
        Thu, 02 Jun 2022 04:50:13 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170906f6cd00b006febc86b8besm1619601ejb.117.2022.06.02.04.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 04:50:12 -0700 (PDT)
Message-ID: <f2f031dc-0b1e-4ed9-d16f-a543a12f6f14@linaro.org>
Date:   Thu, 2 Jun 2022 13:50:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/5] dt-bindings: arm64: add bcm63158 SoC
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
        kursad.oney@broadcom.com, philippe.reynes@softathome.com,
        dan.beygelman@broadcom.com, samyon.furman@broadcom.com,
        anand.gore@broadcom.com, florian.fainelli@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220601225654.18519-1-william.zhang@broadcom.com>
 <20220601225654.18519-2-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601225654.18519-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 00:56, William Zhang wrote:
> Add BCM63158 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
