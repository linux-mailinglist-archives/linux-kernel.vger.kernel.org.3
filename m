Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58F053B835
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiFBLwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiFBLwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:52:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B0D2B1948
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:52:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b8so5906374edf.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 04:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qhAYW3a2ikU2PnoUIZdtUQfyTZMvQEAxI5UwchugZ2A=;
        b=hNVG25SlcHKqqF8NQqVUlighIPFIDb8myt0HYhRR9lZbyu/uaRI2mtSi001u7xUy2l
         zZhPfh1/TMOiSTBW/CPGP4ER5WgOm/M5xY/C/laiaIdGMrWrmbBzYOJxgCBzTgkFrN9q
         eiunnKj52kby+YTQ1TvldsZoW2s7clcvhXWrIHXhKvAxCbA4LBstDQg9tcKBRXgcwfam
         9Mna3l8RtLDqZyRVE2Gylum9y98jHT9wlyIHBxMupNyjDe5xkz6W0opuql72h/ieVZ86
         rj+2sJ7Hk3SdrG3teTDWu3dgX7e15u3ess9qHlI7TgsgqSUPt4YpROcLH8JH34/3yinh
         rlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qhAYW3a2ikU2PnoUIZdtUQfyTZMvQEAxI5UwchugZ2A=;
        b=q3ec3OyXbo64EFx274MTQEbAtuaJcCJCkpVkt0IeZfNysPD+08Nx4kQuz+nTsmyul6
         0afrPq5ucZb5k1rXSI5KCMG1m9O4xUXbuictDtGGDhKCf6nXJcUrQADtRLyNtcC9l9dU
         Q8eMyVUM7AY1QxvRwZFnZSTlKpf9dUvOt63KaVyMVmoKgTjOiTIacDW3oEHc4IbcRTvD
         u4ww6kOTxkbJHoccmrE5LPtRGPUnXQDAxb0nlLmMjrk3aKMjbrh2AhDFkcordiuCIU4h
         PmrXwKB1Mrcvc4QeDvWAWF0XOazJ40KWWd6UDzr4BuArg4NYjZ3buVaaiMDik1viSPfO
         cjEw==
X-Gm-Message-State: AOAM532lWF14B0zojb4VBm53caLZSXENGyaMPVxFBs7cnNFCxUDKDyxf
        EvJjyzEGXgjpEsW9BdqywjJsdg==
X-Google-Smtp-Source: ABdhPJwjpEJBtVyfodbNE0OXvWGP5lUXFY2bMlol4Z4Iz/7ehrih0oZ13xdQEM/QydmnHngYOS0xFg==
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id o16-20020a056402439000b0042e0b7ee9acmr3683404edc.97.1654170747697;
        Thu, 02 Jun 2022 04:52:27 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090628d200b006f3ef214dbesm1658761ejd.36.2022.06.02.04.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 04:52:27 -0700 (PDT)
Message-ID: <a27584c3-6a5d-a1ba-d8fd-1c9d9a052786@linaro.org>
Date:   Thu, 2 Jun 2022 13:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/3] dt-bindings: arm64: add bcm4912 SoC
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     dan.beygelman@broadcom.com, philippe.reynes@softathome.com,
        joel.peshkin@broadcom.com, anand.gore@broadcom.com,
        florian.fainelli@broadcom.com, kursad.oney@broadcom.com,
        tomer.yacoby@broadcom.com, samyon.furman@broadcom.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220601201737.15896-1-william.zhang@broadcom.com>
 <20220601201737.15896-2-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601201737.15896-2-william.zhang@broadcom.com>
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

On 01/06/2022 22:17, William Zhang wrote:
> Add BCM4912 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
