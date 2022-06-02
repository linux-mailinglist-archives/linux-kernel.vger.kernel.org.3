Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BBB53B3AE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiFBGix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiFBGis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:38:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7463298588
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:38:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t5so5003479edc.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 23:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1wxMCYEgqlVivRD4HY5DqQDhLenuj8U7P5PW5a3QHQk=;
        b=el47hvHkdldD4DhYPsEdzJ9uWLUA75a24YrlfsTMs7Mmj03BaEdwNxXfkNAj/Nzm+J
         RMaIxY5rmbKxo/4VguHcGYZ02hLU9jsr0U5Pox2+A5YCdJBhC54QV0WE5pxVDSqv6edI
         iGXGUyOCvhNBWJlk9yaRRyyt6yGqcIGCAePMB9ds4ZwLqDtZoBQRkxZLuGrYSzkum88L
         nsastr3sPAyYuBer0jzzKyRq3Vr3fIX3Y0d+ioInjCnwGeKMD2ZYu9MgKtpawPriZXxg
         IWm+7cJ5r79DdkJSPYM5ls3b9nsj4lXmfBI3DWeW5/EUK5j/c/JmF2ZCtnomjZbCSHpS
         LmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1wxMCYEgqlVivRD4HY5DqQDhLenuj8U7P5PW5a3QHQk=;
        b=nV2SBwH3qdBbzvpE/KKsgwqEImClSRPI5us467nCyjKIY3/hokuhvIg0F23Naw/GYy
         7ifD94YKeKYYCV6eBTGebUQkdr+1Ju9fN6FDzS6/KQeL48GeLLVJCs4SxnGLcGWXVTam
         2OibBOpW1IEDnd2D3LcSYA91LThjRuJV1vTwYXZPEGoUu3uLbRU2As1I0uzLcV+H//ON
         xrAr3r84OvJOQcWYddYyzaiHKfmHkOUMSxmXhusiVoa5eYweICKSN9bwAg2Rwiy6JSDh
         IXErJDIT8hSKMoLtWJXzPPFMENJPmdeZNaesMdmga4zYdAzIhOGQC139mYksdCnkbpp+
         dpjA==
X-Gm-Message-State: AOAM531VTCGIMXAi0FXjcGydL1HFWkUCE3SlACSMcAstz6VCUW1vzUk8
        KmBiIA3/R1U87WmMmpqhaZPIYg==
X-Google-Smtp-Source: ABdhPJzAdDOnCA/9/xqyDlCJBA0X21aXMdmMJTa0YP/OB98Eizxj8yDUt6hi6kfNCmoVy251BrK4Aw==
X-Received: by 2002:aa7:cb1a:0:b0:42b:7869:3c68 with SMTP id s26-20020aa7cb1a000000b0042b78693c68mr3629849edt.55.1654151924355;
        Wed, 01 Jun 2022 23:38:44 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ck16-20020a170906c45000b006feb20b5235sm1444548ejb.84.2022.06.01.23.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 23:38:43 -0700 (PDT)
Message-ID: <7c8ee58e-1f60-b42f-e6e7-6365ff1209f3@linaro.org>
Date:   Thu, 2 Jun 2022 08:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/3] [PATCH] dt-bindings: arm: add BCM6878 soc
Content-Language: en-US
To:     Anand Gore <anand.gore@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     tomer.yacoby@broadcom.com, florian.fainelli@broadcom.com,
        samyon.furman@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        dan.beygelman@broadcom.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220601182707.3037131-1-anand.gore@broadcom.com>
 <20220601112700.v3.2.I383a14e417ffde9d8180ee578abbafdf09141c29@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601112700.v3.2.I383a14e417ffde9d8180ee578abbafdf09141c29@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 20:27, Anand Gore wrote:
> Add BCM6878 SOC device tree description to bcmbca binding document.
> 
> Signed-off-by: Anand Gore <anand.gore@broadcom.com>
> 
> ---
> 
> Changes in v3:
> - Simplify subject line

Thanks, subject is simplified, but you still have two of [PATCH] prefixes...


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
