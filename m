Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3826D5130E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiD1KK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiD1KKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:10:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DC563EB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:00:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g6so8523272ejw.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JxtII36nbuZuqFFrQ9crloovDc3cIeCGPM1GWAJ7BLU=;
        b=pCcEyqd+tkY2mhRqzUUk2rMCfWrt8QcgDfnX0gsm1FZpbqGI6rPrEyrizoMKSKapta
         etMIIfDFbsyRBj8/PTEVu6q3AJRLazQgshAi6dZAJ1UhocnkGxM9ZA1IwhwwrOEdcYVI
         YhpZ5OD9k77k+MSb2dBpaGNqBPo7mUcTvzjImkOWOKWwcNGf85qD9fe413357VAaKaLV
         bxZy/sdWDrtJft0G9rYfgpeSWwzuHN7SfP7BZwHeL6Mn+JXXGR1du2CstnxVezhBZx0M
         wL2Vs1ikBdvgGlsNEWZHASqUOpAfL4mt4eUHjYhGHyWI0qRnfiYez74TN+XDibV04YdP
         H1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JxtII36nbuZuqFFrQ9crloovDc3cIeCGPM1GWAJ7BLU=;
        b=IHZgwltjrx57BBliA2QIu4+LcduN4gYsE3uV4Lt/cFrgZBLNQxr9SUDpbi6PQkKdST
         UMFcYVKyDGy94BpNY28kEujC/rgUojCLUiGZW4inyk2Xe8aU4zBgbxgSTAlBjAR+p8vg
         e5dY/02C3BWKQKIG/BNclRa0VVdQFRzpzsFz7SeNvDY9TkXQaBYOWEan1wwKxGYzgDE6
         MQiCI3eJrov9jr4QgSme/lsD7WwsUfn+rgzFtB25mHDIznnsMrzZWPReZ5NbzBwq6kjN
         Wj1OnNdVs/gRVEIoQlVLQ5lxcNE+2Mou+/r8j8CwfHXmFghH5hxSjJzJx+47tMdbn/9B
         C52w==
X-Gm-Message-State: AOAM532r8Dn0W6+q13E+eDxG21KpW6XhQ4t5vIamgVV/G7kvxWFgVbWb
        gECkDtIMST9YhbJtsnSk4qCfQw==
X-Google-Smtp-Source: ABdhPJwcRvWItyXHeht/LhlESqknYCeryLeRXleMGkm95QPziD8ZUk2gXtIdbAX58t/rHGBMibiUTg==
X-Received: by 2002:a17:906:4408:b0:6da:bec1:2808 with SMTP id x8-20020a170906440800b006dabec12808mr30471083ejo.543.1651140016399;
        Thu, 28 Apr 2022 03:00:16 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o2-20020a170906768200b006e89514a449sm8021480ejm.96.2022.04.28.03.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 03:00:15 -0700 (PDT)
Message-ID: <1399774c-f188-81f1-4d15-367b9d0e4a59@linaro.org>
Date:   Thu, 28 Apr 2022 12:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 08/10] ARM: dts: exynos: use proper
 'dma-channels/requests' properties
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
 <CGME20220427160347eucas1p23ce51e0fb49160d437961d98fd682c28@eucas1p2.samsung.com>
 <20220427155840.596535-9-krzysztof.kozlowski@linaro.org>
 <5eeac2a0-4293-675e-9dc2-25ed8ab3fb8f@samsung.com>
 <6981f93a-ef01-6ba0-4451-26526372d666@linaro.org>
 <05c908ce-217f-6938-6745-7405ac39d8ea@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <05c908ce-217f-6938-6745-7405ac39d8ea@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 11:57, Marek Szyprowski wrote:
> On 28.04.2022 11:54, Krzysztof Kozlowski wrote:
>> On 28/04/2022 11:50, Marek Szyprowski wrote:
>>> On 27.04.2022 17:58, Krzysztof Kozlowski wrote:
>>>> pl330 DMA controller bindings documented 'dma-channels' and
>>>> 'dma-requests' properties (without leading hash sign), so fix the DTS to
>>>> match the bindings.
>>>>
>>>> Reported-by: Rob Herring <robh@kernel.org>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Are those properties really needed for PL330 driver on Exynos SoCs? I've
>>> removed them and I still see the proper values read from registers and
>>> reported in the log (Exynos4210):
>>>
>>> dma-pl330 12680000.dma-controller: Loaded driver for PL330 DMAC-141330
>>> dma-pl330 12680000.dma-controller:       DBUFF-32x4bytes Num_Chans-8
>>> Num_Peri-32 Num_Events-32
>>> dma-pl330 12690000.dma-controller: Loaded driver for PL330 DMAC-141330
>>> dma-pl330 12690000.dma-controller:       DBUFF-32x4bytes Num_Chans-8
>>> Num_Peri-32 Num_Events-32
>>> dma-pl330 12850000.dma-controller: Loaded driver for PL330 DMAC-141330
>>> dma-pl330 12850000.dma-controller:       DBUFF-64x8bytes Num_Chans-8
>>> Num_Peri-1 Num_Events-32
>>>
>>> I also don't see any code that would read those properties. IMHO they
>>> should be simply removed at all, at least for the PL330 related nodes.
>> In current Linux implementation they indeed are not used. Nothing parses
>> them. However:
>> 1. They describe (hopefully correct) the hardware.
>> 2. They might be used by other implementations of pl330 driver.
>>
>> I would not remove them from existing sources, but indeed maybe there is
>> no need to add for new files.
> 
> What's the point in having dt properties duplicating data that might be 
> read from the driver registers?

Hm, indeed, there is no point in this. Since they are read from
registers, what was the idea behind in commit 42cf20980cde?

Best regards,
Krzysztof
