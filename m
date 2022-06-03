Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF9353C43E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbiFCFbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbiFCFbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:31:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A42538DB6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 22:31:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w27so8748073edl.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 22:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=yFbf+rXeDHG885MgXcNO51F92YtprLRprfusKhUHuBo=;
        b=HvAPt7FU+EKdVfe4M56mrmA88Z2Sb3LN+iFmf/An2t2gpkgvQ3W83g/WnnJYQ84SdT
         G7vi61e8GzCWZspwwxCSSBF3viBVC/3S5Ooy5miiKnW+QvHV+rzvgrcYQ4BmpHIk0XFN
         3KVL8DoTsQJNNy8KwExUyusxwt/t+80CJvD7NsoFEpDOw0erh8mxFBxIkQMSQ3iWpLNf
         CnVyUovmE1Q1SfpjyDcnjnGXMQxNUivUPDTFGJ/OsmymUY4YPMnOOukeHzR50frZZ9rf
         ozXjhkMPf9lKrPRJAshFOCcSMEUyevHZ93/5fYXSuExQKpEiuVJD78+8x7UUSwSkc6XN
         iCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yFbf+rXeDHG885MgXcNO51F92YtprLRprfusKhUHuBo=;
        b=T0PHv3IUXhXoag0OK6M/OMQvYyZ6NBytTCAdzdnx0F51ZRAOpBNKKETnNElqDlLwCH
         PcNEXInV5xNyWMyo4u/KT6GMLtQ4pEr9ga9KYaod2DIy4I1fpO3mSkNIHIM3R2hYIe9X
         tdq0NYtRhAjBBsURoMK6ThJuEhOjTnwbAGn2DY4+XW56DiEMwUSOD0VL9zXh1OjlAPgz
         IAijY92C80huEgx7Twfxn9uOrw/rQ8ws7Ryh833Qm5XLGghugZck99CMOYLw3vPOrdF2
         2htyLLO5yn4Xkw3zp3y7o2IIBYEsjDDrw+lkQmSTYQBwT1OvLHM2L3WtTVUw1hIhh6dH
         nFAQ==
X-Gm-Message-State: AOAM532S8qY5jwqvXVfVu6r770rAz+Z2KCvyiodd4097y6h5WTNqo1zX
        Hv6c7caE6Q/I6FXMD90iC6DLXw==
X-Google-Smtp-Source: ABdhPJytg9hlGbrqAJkmbUkOLFwR2Mp42qHfQVrb4vP92ORErxOSUQl/RMSZVGmH5dPo0cpyKWBMFw==
X-Received: by 2002:a05:6402:1d4a:b0:42e:93de:17f4 with SMTP id dz10-20020a0564021d4a00b0042e93de17f4mr693550edb.8.1654234276765;
        Thu, 02 Jun 2022 22:31:16 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170906b0c200b006fef557bb7asm2422104ejb.80.2022.06.02.22.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 22:31:15 -0700 (PDT)
Message-ID: <65daf4b7-212d-b726-cc7e-bcdf5d4664b8@linaro.org>
Date:   Fri, 3 Jun 2022 07:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/7] pinctrl/arm: dt-bindings: deprecate header with
 register constants
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski+dt@linaro.org>,
        'Alim Akhtar' <alim.akhtar@samsung.com>,
        'Tomasz Figa' <tomasz.figa@gmail.com>,
        'Sylwester Nawrocki' <s.nawrocki@samsung.com>,
        'Linus Walleij' <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <CGME20220601152757epcas2p30927b9924e9371cdfa79986c6efb6eaf@epcas2p3.samsung.com>
 <20220601152720.232383-1-krzysztof.kozlowski@linaro.org>
 <000501d87703$211ff7a0$635fe6e0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <000501d87703$211ff7a0$635fe6e0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 06:33, Chanho Park wrote:
>> Krzysztof Kozlowski (7):
>>   ARM: dts: s3c2410: use local header for pinctrl register values
>>   ARM: dts: s3c64xx: use local header for pinctrl register values
>>   ARM: dts: s5pv210: use local header for pinctrl register values
>>   ARM: dts: exynos: use local header for pinctrl register values
>>   arm64: dts: exynos: use local header for pinctrl register values
>>   arm64: dts: fsd: use local header for pinctrl register values
>>   dt-bindings: pinctrl: deprecate header with register constants
> 
> nit: Put the comment closure to the next line.
> 
> + * Author: Krzysztof Kozlowski <krzk@kernel.org>  */

Which file has the comment in wrong place? I checked now and everywhere
it is:

+ * Author: Krzysztof Kozlowski <krzk@kernel.org>
+ */
+


Best regards,
Krzysztof
