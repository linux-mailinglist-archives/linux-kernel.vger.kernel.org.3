Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5659D546
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 11:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347324AbiHWIuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347212AbiHWIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:49:30 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DC37C32B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:22:18 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l23so1762143lji.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7OeB8Tp+OOwxfVzGDUyLeilyGzUattAzk5IIpdva6ZY=;
        b=si2Y9iR4wS0U+CTbpxGEWgAJE2CrTZaT6v+mk0E4Iah0XzOxpiPEnhb0sIo1bQAlpp
         1PBunFRZ0tjTAaZYVf+EyjqweOqXSWLr86qSdvbUz35BYt7cN5A51lgECAgSvLWdEPah
         5xNmmioWpNQ1hx8Y6RWF3JNx5jd5KHP28NXEWCvs/eIQN+uR4bpWq2oqcgakSkypwewF
         UrOOfFNiedgslFjlPx+RSnpRhqIydL6gQl1gJSsxTvl7xT/+iWik/4kSuXeyEgub6LwY
         ALmtcBsiYCFnlISYXo6ATDjk1sEQ2Ho26/KBWruk8544WYxlUr/TaRbUPfYIkeMrYXPR
         O5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7OeB8Tp+OOwxfVzGDUyLeilyGzUattAzk5IIpdva6ZY=;
        b=tf2AJljGTJsFuV3HLJsF2ssDFionAnXrQvh+yLL6xvmARbIw2Fog+12XsSI1af7kAr
         M4fOfAFcuHaVClSUc6gEEfB1RF8qrD6b5UaZV0o7EIbElxz903jMIvE9Owvs5zhaJRRs
         6oatBHkPsSjqbWcC+xadyixbh24/beiKG5WQ6oI6Ng1v5hMk5oBBRkF7tMBnQwqDjr3l
         D2xGGdECiu5Xr8Yv3PejuoCR7l15oY/nGnq6XbbgmUkjNYOWBqNF8hFoTE+zwWemNxfk
         1/2uu7U0BxLlKeVvTTWM3n/hLEOMn7L1g+nPfFX3qWiDTUb+CGYB4H/4sBVIAk7wwBWm
         zlyA==
X-Gm-Message-State: ACgBeo3vep1SmrUemk9J7+WZJKpqBIWr66rJ7Ab0jLRNYHmayEIWgypv
        HmzuspoMOhNCom6iHrDqVSj8sA==
X-Google-Smtp-Source: AA6agR514Jg4jXCHaxroFgOoHvEij+oqXEDgwNZ5KuUhk8nI3kUOCKgtXiPrrHbAkfgemPuZOemASg==
X-Received: by 2002:a05:651c:154b:b0:261:d6f3:5550 with SMTP id y11-20020a05651c154b00b00261d6f35550mr423701ljp.528.1661242930625;
        Tue, 23 Aug 2022 01:22:10 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id k14-20020a0565123d8e00b0048cf0fef301sm1887405lfv.301.2022.08.23.01.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:22:09 -0700 (PDT)
Message-ID: <835938e3-e4f5-5029-9373-5dd59bc3b625@linaro.org>
Date:   Tue, 23 Aug 2022 11:22:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 16/20] dt-bindings: memory: snps: Detach Zynq DDRC
 controller support
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
 <20220822190730.27277-17-Sergey.Semin@baikalelectronics.ru>
 <a5a15749-1047-74ea-831e-54d27a6d6cdf@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a5a15749-1047-74ea-831e-54d27a6d6cdf@linaro.org>
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

On 23/08/2022 11:17, Krzysztof Kozlowski wrote:
> On 22/08/2022 22:07, Serge Semin wrote:
>> The Zynq A05 DDRC controller has nothing in common with DW uMCTL2 DDRC:
>> the CSRs layout is absolutely different and it doesn't has IRQ unlike DW
>> uMCTL2 DDR controller of all versions (v1.x, v2.x and v3.x). Thus there is
>> no any reason to have these controllers described by the same bindings.
>> Thus let's split them up.
>>
>> While at it rename the original Synopsys uMCTL2 DT-schema file to a more
>> descriptive - snps,dw-umctl2-ddrc.yaml and add a more detailed title and
>> description of the device bindings.
> 
> Filename should be based on compatible, so if renaming then
> snps,ddrc-3.80a.yaml or snps,ddrc.yaml... which leads to original
> filename anyway. Therefore nack for rename.
> 
> BTW, if you perform renames, generate patches with proper -M/-C/-B
> arguments so this is detected.
> 
> 
>>
>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>> --->  .../snps,dw-umctl2-ddrc.yaml                  | 51 +++++++++++++
> 
> This is a mess. I did not get any cover letters, any other patches any
> description of relation between this and your other one.
> 
> It seems you make independent and conflicting changes to the same file,
> so this has to be properly organized.
> 
> Send entire patchset with cover letter with description of all
> dependencies to all maintainers.
> 
> This is unreviewable now, so a no.

And also untestable by Rob's bot, so will have to wait.

I found the cover letters, somehow they got buried in inbox.

Best regards,
Krzysztof
