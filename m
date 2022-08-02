Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECA158798F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiHBJE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiHBJEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:04:55 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D814F1AF
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:04:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e15so10987251lfs.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=U7fi6N3RABOBMWCOgXAfDv4FFDxZNs+uf8Zr2BRDwwM=;
        b=GSSGq7vw+gfPL5DS1fzXCWGtOOLgZihO8lBtwUiKoowGyKAM+fJ/5z8hP9GXdYUBBw
         DekZ7LSMCREQRYnRyqfd8/kncQPpsbOGd0S99QkBqAFgISMsGSLRppRLqEzzIncNdnVC
         p4aYeSUHKy6kbwfAm4oLSAoUf2EImlmLAYT88cE9m7eCzu4CSjoDbIs3JXsY/Y7yel8q
         GodG5ttDEOkXepK3vEZxpY36LA2ri4We0HNJdmf2ZJUk/VQj7MTD7Xe8VxMfi5YyNGJ0
         xR2FKmDHxQDcnvZtQXOITQLfR3lElnwVVePA8M4uXbHmZV2luleiZ6K2cguR9XwN9wrd
         gZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=U7fi6N3RABOBMWCOgXAfDv4FFDxZNs+uf8Zr2BRDwwM=;
        b=vC6wkTbrndU2G03riaLrf4Wgr0udqsr2RwSj9aUQenH06ILDHpHcdqbr4QmEAHOIK/
         YKn0ocMxT9Sd5eJ3c16inXdEfzBwa/FSHWgr7wHQh98sqxvKpI58fMMscnYa67wbWdof
         g/Z40XDai+YSHh6UffcaIDEPsCXx2NWRWZ0npNFwcvI7nr4yUaJZMccuwsxTmRgUdw53
         Y7Uz+S1NmdMMsBqR+F7aSaT+E/mJCGtI+RCCm32fFHDhxyWeGnpWEhk9WAMBeTSFNGcg
         6f+El9BTBrcxz9pEJ+se8exMHO8RsrUW68VRTnJXZl+qkqfxab1MLA8aTM9YsgjO5900
         NMIw==
X-Gm-Message-State: ACgBeo09woaHLHdp2MiFrez41I+L/MHq1oHYFki0Sozazc2bzuMFNylj
        Sf6T/q30PpI4VotNE4rdUDfQ+qXXnGCsMhdX
X-Google-Smtp-Source: AA6agR7XJvJo2wL06pAjhFP/KvfRGXfogwSBNC2DgxGwjN/ZOnOsAf3UUYbcZ3s7sM2T4pU/8YK2Aw==
X-Received: by 2002:a05:6512:2313:b0:48a:e615:289b with SMTP id o19-20020a056512231300b0048ae615289bmr5959623lfu.201.1659431092326;
        Tue, 02 Aug 2022 02:04:52 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id h14-20020a05651c124e00b0025e6415bb8csm40755ljh.32.2022.08.02.02.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 02:04:51 -0700 (PDT)
Message-ID: <3fdbac20-5ccd-7974-300e-2d78d0be048a@linaro.org>
Date:   Tue, 2 Aug 2022 11:04:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8188 and MT8195
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>, Rex-BC.Chen@mediatek.com,
        TingHan.Shen@mediatek.com, Liju-clr.Chen@mediatek.com,
        Jian.Yang@mediatek.com
References: <20220801113709.12101-1-jianjun.wang@mediatek.com>
 <cd9518e3-9cb4-5165-af03-00e5300ab927@linaro.org>
In-Reply-To: <cd9518e3-9cb4-5165-af03-00e5300ab927@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2022 10:59, Krzysztof Kozlowski wrote:
>>  
>>    reg:
>>      maxItems: 1
>> @@ -84,7 +91,9 @@ properties:
>>        - const: tl_96m
>>        - const: tl_32k
>>        - const: peri_26m
>> -      - const: top_133m
>> +      - enum:
>> +          - top_133m        # for MT8192
>> +          - peri_mem        # for MT8188/MT8195
> 
> This requires allOf:if:then restricting it further per variant.

I see Rob proposed that way, so skip this comment.


Best regards,
Krzysztof
