Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8A74FA7C5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbiDIMwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiDIMwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:52:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EE0124C30
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 05:50:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id p15so22186349ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mZ2Ei9Pw71xChRYUdbzHz+g7cxbDuw0G+n2AKi4cwrM=;
        b=fbcRIrQpcbSQPL7/+1JHVXWGoEk4lhGwvpVASn7a9/Tfpu6VnXHYOeVBe4fK8hw3+J
         dxJ9ExO4khrVA0HvVPr+MGAMC/YfMuL5KRfEHRhjtHynycN+4Ahg2P6t2Ds3sGE/CHnC
         HukO24gnPUXM7EKqn4VV22kUJzB2M0UH6oA67FiNT7XpntuTq5MhwVzKLRu2ae8EdLO3
         wcCZnv1xkRJyPFBLlWMQ+QR2EQ0eo7clJ4I/TILzXHBxFFpMrRS2kUTAQYccaRWqGal8
         CPh8ELTgIrg7IXQwsCtYGpzTJzBTtpNVgnKpeN+j+uXXNTE+qo565XQk8XqrI083m8lF
         HRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mZ2Ei9Pw71xChRYUdbzHz+g7cxbDuw0G+n2AKi4cwrM=;
        b=m87oWP38XEsFM4ue3r/84xLDljzNjQTFtu2WZmeEsrkCFvhVFbPvwg3jFMlY/926pS
         JuwndCuMZt3VezqTtfpMMmzUYQ6iVKRo12IHCA+zGqjTS11Q30xZccVDUZR5amMSTSo4
         h7NSgHfrZpigca0gOi3cbaL+zLHbpJ8S1fZXwSk6EDGqHnbZhnh3Y11VNHPY2SBTfeU5
         RzU2PkaH5GBH7rXzEGSQLOnTgOoa6l9oi9S8PuY5pOnCtgon8l0GlNpvft7D3aFUtAty
         XnYHI2ybPDC5/e1w2KpL1HnM2BIC6ttWwd7hRzNQcTmQR2YU5jkWhXdhhgCTy6szFdAg
         v8lA==
X-Gm-Message-State: AOAM531AuXlo/yLcZ4HJDEDNu/5yf1Xq49meWxXf0On7j3/1+sOY17lt
        ShZk5Bho7KtpqCL1LE3KQlyCBw==
X-Google-Smtp-Source: ABdhPJxMQS6Xs91cG5pLCViSOliYY8Gc+cfaZTEhqJevdonVPQzdQaHXnqHvQ+kKOZbJ4dSdVCca/A==
X-Received: by 2002:a17:907:9724:b0:6e8:4421:c760 with SMTP id jg36-20020a170907972400b006e84421c760mr9397722ejc.658.1649508599735;
        Sat, 09 Apr 2022 05:49:59 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id s10-20020a50daca000000b0041cc361b1c9sm8822949edj.68.2022.04.09.05.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 05:49:59 -0700 (PDT)
Message-ID: <aea5e032-5cd0-7480-13c1-2af924237532@linaro.org>
Date:   Sat, 9 Apr 2022 14:49:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for
 Sercomm parser
Content-Language: en-US
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Karim <Karimdplay@gmail.com>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>, M <x1@disroot.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20220406195557.1956-1-csharper2005@gmail.com>
 <20220406195946.2019-1-csharper2005@gmail.com>
 <1649339427.653492.795407.nullmailer@robh.at.kernel.org>
 <9cf4e596-83d7-00cc-afcc-585309cb4852@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9cf4e596-83d7-00cc-afcc-585309cb4852@gmail.com>
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

On 09/04/2022 14:35, Mikhail Zhilkin wrote:
> Hello Rob,
> 
> On 4/7/2022 4:50 PM, Rob Herring wrote:
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit.
> 
> Thanks for your great explanation how to test! I found and fixed a mistake.

One? Apart of broken compilation, there were other mistakes. When you
run the tests, you will see all of them.

> How I have only one WARNING: 
> "added, moved or deleted file(s), does MAINTAINERS need updating?"
> 
> I hope it doesn't require additional change. What do you think?

This is not related to dt_binding_check. if you ask about checkpatch,
then no, this does not require fixing.

Best regards,
Krzysztof
