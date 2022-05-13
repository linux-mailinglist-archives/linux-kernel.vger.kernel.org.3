Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF764525BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377518AbiEMG4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377517AbiEMG4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:56:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAEB2ED6F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:55:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p189so4250380wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rMyWOXlx04K/zowhHekykpBIHTTdSbgPuSq98Q0e2qI=;
        b=eoOJyapNT+ndXvlawo63JdbVBFmEdqRdH4Zqo7XfhXfh7jiokbYlD3fvSFxH8iNUb9
         Hs0oo1xQltjLHrOVsAcBX+D3UU9DPAoL4C9x0aIEFrVFqK0NYFAMLaBp0uZ+ei5SPn+R
         g4r7Jkq6CApI5SJDmN3o2lINVFkSWbqpltFfTu4wDL0J5b/CC1v8c3U6TlwmiX27HhT0
         pGRpGeBq2ntBAhzbrU4BW3wg8dklujFaZJBrQzAm73AbSJUxz1G4Y1E5XCGRnSDybhzK
         tPs7bgTSIC52wguL5ujiEq/FD6JN6x9MY0ZXdGxHGGWdyRAQXi4yVV3ltDME2+WUAkNq
         PffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rMyWOXlx04K/zowhHekykpBIHTTdSbgPuSq98Q0e2qI=;
        b=YqzXhc7YY6lM2LeYKL3+9n2NPU4q7vFLfs8rwuhrLOeZO2WT1IKSe4YfSunDXCHdNg
         +qaVp/8lkRHx1EIX2AgoPv4H5zVlvdsR/z3XgrNYMxpKHMSYKaC5hmJODgw6T+/Rnu3O
         vXfa51zhBnq95Uzoy7wgPRXePJpOMmwkJEdKeFm0NP1dRxmeJOKi79kaWQ2bDLFndrzR
         +2wk/EJJR9DLNq/NLy+nFeqHlwc8v/kLPd5IAePBck/zor6tACRLB+DjgRXxahqX6dg8
         wg3mjExP9ug80PcH3GTb+qtIlwweeb0EHblZcSB1xbeFEVQ/n5ODx5cGkUYP5sILMC92
         G+aw==
X-Gm-Message-State: AOAM530AttWzYtMyx8SsQji/I3wTJkTfmluSK21BXfoulzT6wJxPgwUW
        AO6Rka3zv6YbfXvHtWgHyWVYDw==
X-Google-Smtp-Source: ABdhPJxu8EE8mgrVxwIbOZhYZD044+qoLpoYp9uv95jr1zn2Ow26I6yTvslJlxbVK3cVtkTnoedKxQ==
X-Received: by 2002:a05:600c:3ca7:b0:38e:50d2:27fe with SMTP id bg39-20020a05600c3ca700b0038e50d227femr13413746wmb.159.1652424956122;
        Thu, 12 May 2022 23:55:56 -0700 (PDT)
Received: from [192.168.0.167] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bd19-20020a05600c1f1300b003942a244ee4sm1788560wmb.41.2022.05.12.23.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 23:55:55 -0700 (PDT)
Message-ID: <9b2ecc28-df1e-903a-c652-2d65fc7d41ec@linaro.org>
Date:   Fri, 13 May 2022 08:55:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V4 0/5] Add initial support for MA35D1 SoC
Content-Language: en-US
To:     Jacky Huang <ychuang3@nuvoton.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ychuang570808@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, SoC Team <soc@kernel.org>,
        cfli0@nuvoton.com
References: <20220510032558.10304-1-ychuang3@nuvoton.com>
 <CAK8P3a1k8y8U99bBmqBYE1vYAc0q-UeaM0oLP4tTHZCpyYNOgA@mail.gmail.com>
 <8be62b40-077a-7634-7d34-7776909a2abe@linaro.org>
 <CAK8P3a3=YD7WV+Www8pf+JTv14DwcnSjD+f=YFCNMxXYT9FAZA@mail.gmail.com>
 <51ce4fca-f7b8-92ab-c9c6-1e57a2a5b5f3@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <51ce4fca-f7b8-92ab-c9c6-1e57a2a5b5f3@nuvoton.com>
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

On 13/05/2022 08:53, Jacky Huang wrote:
> 
> Thanks for your review and help.
> I will run the dtbs_check, add binding document, and include serial 
> driver in the next version.

Except dtbs_check you have to run dt_binding_check because this is the
one which was failing at the first place.

Best regards,
Krzysztof
