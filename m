Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145EB520E86
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiEJHgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbiEJHMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:12:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE7B2AC6FC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:08:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j6so31019575ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p9rFwui8qFv3D06bPKxMzPoYvOKPlTEJVhlh9Zqdx1w=;
        b=TdU8LbGlVRxBSPYtz0mhN9i9uxyzw8bY1ut6wEPTul0WfOPPRebYrZ2xsIK5qxk02t
         4fZJQMUobia4VGX5PZJ4DWGJo/wR+x8CP29+GEdaW248Gqq0n2u9ithAqtRKtCOT5eJJ
         ineg4IvK5bxEYr2fLM95EFh0pLn+EY1SHMo8O2FvErbUtyWQARxMvHMj4ObE0nwANTp4
         uGYCzUlka7WJecy3Fiv7DGl/Y0AZkHBxQMeK9v9qvNvxk01vQNW9H9Nn1KUjuGRrZDnp
         OvsMWNI/rBh+MFMle2jYtkfEmKIa9XTPyyxqcwmJekVGmT/PO0xP52bWE0GUnzJCfhR+
         PC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p9rFwui8qFv3D06bPKxMzPoYvOKPlTEJVhlh9Zqdx1w=;
        b=NuZyS3OgmEYuDcRamhHx8jW5exwcc5Wk1LM1/og0bJV1Ef+X9mG8NXkjWcKeXgUun4
         D0ST6dB6w46uAC3AH4MPIUa704dN4Huf0xZzMPNCMmJ9oEAm0xFlM1wse34a6Uk0vYkY
         BjeDDcvz8B6bk4vojSo71LTUtR5Ah0A5nM2XjH+iWXyS/ujgOuj2KdXxPUSNDArEfxpv
         L5XaAN0OfBQ8VLtFDR2E8mmIL8RPf5UTvMRcliylZBCrdUKZaewH+gw+UNW2PAJmuXtX
         K9kXZ6tRGWZX9uEqEnK9ycd6OW0etBNzY+afrxf0nfyZoU+9e9lrh4ahB+VwduaduBED
         CKuQ==
X-Gm-Message-State: AOAM530ddQAGk4qKVbHA8zSXHGe5Y9u+j9DMEY4rxb9aic4yoxFBnCMA
        zSQuPU5epCMUftCoVp5MloWNmA==
X-Google-Smtp-Source: ABdhPJzUxpNwUAy1pUdVz626Cey5CndaqgWoEysyQ7g3Og/sisEby4NSXlLNOHYIyHim9EHxucfJ3Q==
X-Received: by 2002:a17:907:1c92:b0:6fa:51d2:4005 with SMTP id nb18-20020a1709071c9200b006fa51d24005mr8670212ejc.307.1652166490434;
        Tue, 10 May 2022 00:08:10 -0700 (PDT)
Received: from [192.168.0.250] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id zp15-20020a17090684ef00b006f3ef214e56sm5806154ejb.188.2022.05.10.00.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 00:08:09 -0700 (PDT)
Message-ID: <3498643b-cb2e-5685-65e0-7efe1113783f@linaro.org>
Date:   Tue, 10 May 2022 09:08:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
 <20220504044624.951841-2-chris.packham@alliedtelesis.co.nz>
 <dcc80690-c159-99f8-4686-536b9e87eb69@linaro.org>
 <6770d320-b998-0c9d-3824-0d429834b289@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6770d320-b998-0c9d-3824-0d429834b289@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 06:14, Chris Packham wrote:
> 
> Based on the information I have (which isn't much) there is a ref_clk 
> input that is connected to a 25MHz oscillator and then I'm assuming 
> these are all generated from that with various dividers. 25MHz is the 
> only documented option.
> 
> There doesn't appear to be any documented register where I can read out 
> the divider ratios. It might be nice I could have the fixed osc node and 
> have these 3 clocks derived with fixed divisors but I don't see any what 
> of achieving that.


OK, but where are the dividers? The ref_clk is outside of SoC, so should
be defined in board DTS (at least its rate). If the rest is in the SoC,
they are usually part of clock controller, because usually they belong
to some power domain or have some clock gating.


Best regards,
Krzysztof
