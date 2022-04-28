Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C9A512B51
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbiD1GTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243313AbiD1GTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:19:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0365433373
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:16:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l18so7448147ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MFsuND3deEikwDCrPgJTnpdq0PRuR+XEOkINDbDvzIs=;
        b=dm7IIP+sI4Ep4b8lV07ltQtn5GmcD1I83e3a9lsIhs9/CpyP9r/tPoMOX8W4zzn3H+
         Fnt8biujUBQUzZCgmruQol7neI5e+1oPmN5ass7Ow7+tzP7X5FdV0FQ0qyI/rAF+r5Mg
         lAeLuF11cdUQUy4YFabaaRYnqLq018egODyaKP9JjXFOaZhXBy/NwY09f4qxt3kzykN7
         4p0ourLjeTSMhlLuSxZvUNgwovcqwZtXZXFk+bVoa/X84oLITrXu6yFaEGwrMwht7O6d
         9m1/hNubS3pgiwdFHmW3hduT9tqT//aF9r0q8V2nzdHv94WQpalZLz9yq4nLaP3AKEkM
         +5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MFsuND3deEikwDCrPgJTnpdq0PRuR+XEOkINDbDvzIs=;
        b=N8BKHvshYBAO0vr7o4H1eyRQ4KOaUGVjFt91mV6dACA+djrOWlFYWk+fThbvae8M9p
         H8RdZD/Ocv5U2wkjy+UFumuRYCfqODl8ZCgmLe3LJh4iU2qzGlExfzfQ0PCD0mxqvnTQ
         y5QBJ/zGdZlQ04NFjgQlkxpoIa8AUtF2FJm4Y4lMybbgVTrg9SaRBUoAFI5ziPdIGaYJ
         bG2MNEWCB/TTLo/F1IEC0p10U12S/vfxaIpbGdAhG85/F2wPfb1OPtQCliqIDJDVKLgY
         3sqdF/mX+ed47EQ359RyNdth40NOt88IwtltWOj6Ct4n1IZoCdKC036xR5G/lasc8QuE
         1PGg==
X-Gm-Message-State: AOAM533/tnsntE+AQGB2ILvkBjth0cFH2oSUtBMG97jgkPIUL/poW97j
        Ph6iCOnv3poJ3N1hhqjJtju51g==
X-Google-Smtp-Source: ABdhPJwBZ1KNRfTA1HAA4LNUtcVVMcP6eFpjtMb2TWZhJ9REFtbQpTpqXSRQVZsbPWfRPDqMyAnXmQ==
X-Received: by 2002:a17:907:9628:b0:6f3:5fbe:c28 with SMTP id gb40-20020a170907962800b006f35fbe0c28mr28506329ejc.754.1651126581596;
        Wed, 27 Apr 2022 23:16:21 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906170400b006e87c7b8ffasm7971376eje.32.2022.04.27.23.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:16:20 -0700 (PDT)
Message-ID: <8d9130b5-7459-bb26-79c7-3d83f7dd29a0@linaro.org>
Date:   Thu, 28 Apr 2022 08:16:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/4] dt-bindings: interrupt-controller: fsl,ls-extirq:
 convert to YAML
Content-Language: en-US
To:     Leo Li <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220427075338.1156449-1-michael@walle.cc>
 <20220427075338.1156449-4-michael@walle.cc>
 <AS8PR04MB89464877E53B7F7B14A814178FFA9@AS8PR04MB8946.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AS8PR04MB89464877E53B7F7B14A814178FFA9@AS8PR04MB8946.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 22:08, Leo Li wrote:
>> Convert the fsl,ls-extirq binding to the new YAML format.
>>
>> In contrast to the original binding documentation, there are three
>> compatibles which are used in their corresponding device trees which have a
>> specific compatible and the (already documented) fallback
>> compatible:
>>  - "fsl,ls1046a-extirq", "fsl,ls1043a-extirq"
>>  - "fsl,ls2080a-extirq", "fsl,ls1088a-extirq"
>>  - "fsl,lx2160a-extirq", "fsl,ls1088a-extirq"
>>
>> Depending on the number of the number of the external IRQs which is
>> usually 12 except for the LS1021A where there are only 6, the interrupt-map-
>> mask was reduced from 0xffffffff to 0xf and 0x7 respectively and the number
>> of interrupt-map entries have to match.
> 
> I assume this change won't prevent driver to be compatible with older device trees using the 0xffffffff?  The original 0xffffffff should work for both 6/12 interrupts or whatever reasonable number of interrupts that maybe used in future SoCs.  So the purpose of this change is to make the binding more specific to catch more errors in device tree?

Yes.

Best regards,
Krzysztof
