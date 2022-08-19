Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A385994FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346614AbiHSGKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346725AbiHSGKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:10:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC05B051
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:09:00 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id l1so4338325lfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Xp2c5pFCOLrl7+po3ij5+B4vFWZhRzSXs1VLLppjgg4=;
        b=qg0XIBi/5efpkZ/OAXqtzgC4qVpxlU0UbGn+Radq4W+kZ8xPOc9GpZXVy+Dg/MR+Ai
         6uPFIGjq3Ii0ob7pE65JDVB97lvL31mt/y2i21vzxjjxbH1J7FcbHclPRryafxIGLLPX
         UYl/RnB6Unc/TzDO5hYhdzIs9vCpfR3h1X1lq5hyisAPVztS0UgIoPkVTzOM92fxCmKa
         M8InKN4SE7HpArmBAUtJXWvoWSaFomcGyGgknkqscnNZ8a/b3k6GddVCGEjVzhvE/e2R
         KNNfNyw7e7BpxeVGTFN7o/FlfKmQNM61gv0fPno+saxA+dAlSQ1iOBovMq1mi+SkvA9P
         Pj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Xp2c5pFCOLrl7+po3ij5+B4vFWZhRzSXs1VLLppjgg4=;
        b=fVghek1n4FgKNeAVpM0R8CvOVr1UpYjRhbu3BAnPIY8wDTgWcuj3gmcu90UNhSyRU0
         npLWyLYgstw0/baKGZn9TO3rOo0BnEAwp5E6p9mKhudvhp+i6s9ngonYL8nLWe97kCWQ
         fpFO7O7H9RAbP/z51BzEKtOORM9YdaFdOxfHqny663sQDP4+c3qckP7Oo2LE8pFFfbET
         7L5KGZjGAIDhIDv0HAE9JR+qnJygSb2M+1kar01us2ZMg58lug0IVb/bB39YUNd3PpAa
         +mt6DJbAU+0ZkSXNjLE6l7mRZSYPqCVHM5rWE5pDf7jGq4tHpXu0nw8CEBKqKDFLFGgT
         5eYQ==
X-Gm-Message-State: ACgBeo26PU4xUh76A+v3drzzXuGBWflGHss1I0iimJMatUyBz7/3okKi
        u29nG2E3nri9mDQP4vk4tuWNDg==
X-Google-Smtp-Source: AA6agR7UzgH5UTsBnwxbvuRzyJKCTfID4WLnQkd9FvwR0hWwoOUk4cYrfd9owT7O3xzArFodV093uA==
X-Received: by 2002:ac2:4466:0:b0:492:ca0f:d5f2 with SMTP id y6-20020ac24466000000b00492ca0fd5f2mr520740lfl.155.1660889338499;
        Thu, 18 Aug 2022 23:08:58 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id f27-20020a05651c03db00b00261b6faab6dsm342618ljp.115.2022.08.18.23.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 23:08:58 -0700 (PDT)
Message-ID: <228e6194-b7e9-5f15-1815-6d1299190852@linaro.org>
Date:   Fri, 19 Aug 2022 09:08:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] dt-bindings: phy: Update Pratyush Yadav's email
Content-Language: en-US
To:     Pratyush Yadav <pratyush@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20220816132131.75591-1-krzysztof.kozlowski@linaro.org>
 <20220818194409.zicuzhcg36qw5her@yadavpratyush.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220818194409.zicuzhcg36qw5her@yadavpratyush.com>
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

On 18/08/2022 22:44, Pratyush Yadav wrote:
> Hi,
> 
> On 16/08/22 04:21PM, Krzysztof Kozlowski wrote:
>> Emails to Pratyush Yadav bounce ("550 Invalid recipient"), so update to
>> match one in commit 92714596cdbe ("MAINTAINERS: Use my kernel.org
>> email").
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> I am not yet sure if I will have the bandwidth to review the patches for 
> these. But anyway
> 
> Acked-by: Pratyush Yadav <pratyush@kernel.org>

Then maybe it should be someone from TI? My v1 was changing the
maintainer to Kishon Vijay Abraham I.


Best regards,
Krzysztof
