Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F708597F69
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbiHRHmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243778AbiHRHmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:42:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1504BD08
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:42:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z6so1068509lfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=MShj7bLv/0nXMa1+Mpubq1Kb89/01zNVMLHcgTT9z2k=;
        b=YHqqkucWXRjBvTIxJw0qxFunWWDJ3R2dX3GNCnIzdCv4OlisfZbhurbjMi9j1Soj+W
         47ltrVwrnQpn7+p9sFPfXVH3aIbJMWSKa66QQvxao/SVEM68GsP0P26yQ4B+n6o4OpvV
         f0PkBk6GImk/jSuhRcNp4b4p7WqXQcqwqjOMcFVf/vE5ttwif1GAwWHtHzM1RZc3sOyt
         SwEaDTWRR8bQqw2qd3n47Rfe8JZqCQDjf1/f/IEjWhHC5xWtBFKhm7221NfK17rZ+ciA
         YKbCGMQUMzgWdPAExP5QC8S0RIIW6I8/mNGXAe6rbyjMkzyCm6pSOxx0iID28wmeWS+5
         A+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MShj7bLv/0nXMa1+Mpubq1Kb89/01zNVMLHcgTT9z2k=;
        b=kVgko0X+MyTn2jPEzNjaCX7h8r3pge84FZ7kG/OEuznDG8E95nZp6YjSsUZw0Bv/gF
         l3Txw7Oq8icjaN6beXdB0OmxtxbDE6aOCgNfHh1lYCYmmfxKi/sJg4IRLoSCnZlYnY9y
         6Lbj1DwpXqVFxd/hZhSnu8d17KwXXh7qNAP5FYN5nSIUiTxap2SFmZfAvikCjO6fHz6Z
         O2J9JUx7HOKIM2kwsIr0/j+ODfrA7LKwuzgap1JOrY3a842ghVVrk/gXNqihLpNjmw/G
         v5QxVUkD99r/mxuaFWyPf7pdHiheQXCUF0pPtQtNsb0gxfKxn0QfrQkkSU4U9949VYHt
         PZVw==
X-Gm-Message-State: ACgBeo0BCgq9k18YvpHiHt6NEpZRJVhl53+xMEJdLejvQjRNSeOXfKIH
        WCbEeiDy3qAuuw3QT4zuuho8Pw==
X-Google-Smtp-Source: AA6agR7PpZvNHmLb+qevA7oB617jiMAhR6HzQHvikURalXdanu3cXl5ZOPY+cac1GOxiwZ4UbXAsxA==
X-Received: by 2002:a05:6512:ea0:b0:48b:2d45:f254 with SMTP id bi32-20020a0565120ea000b0048b2d45f254mr545086lfb.365.1660808557206;
        Thu, 18 Aug 2022 00:42:37 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id y8-20020a05651c106800b0025e42f8e771sm118132ljm.34.2022.08.18.00.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 00:42:36 -0700 (PDT)
Message-ID: <61c0d3bf-cf1f-77f0-bb47-dec7cde5b488@linaro.org>
Date:   Thu, 18 Aug 2022 10:42:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: mediatek: mt8188: Add binding for MM &
 INFRA IOMMU
Content-Language: en-US
To:     "Chengci.Xu" <chengci.xu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220804105834.626-1-chengci.xu@mediatek.com>
 <20220804105834.626-2-chengci.xu@mediatek.com>
 <ae06f644-b988-8fc3-fde8-258299f8f2ae@linaro.org>
 <f34db3a295b8c83e03bf79950cc25d39b6f81240.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f34db3a295b8c83e03bf79950cc25d39b6f81240.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 10:26, Chengci.Xu wrote:
>>>      then:
>>>        required:
>>> diff --git a/include/dt-bindings/memory/mt8188-memory-port.h
>>>  b/include/dt-bindings/memory/mt8188-memory-port.h
>>> new file mode 100644
>>> index 000000000000..612fd366c3a7
>>> --- /dev/null
>>> +++ b/include/dt-bindings/memory/mt8188-memory-port.h
>>
>> Use vendor prefix in filename, so mediatek,mt8188-memory-port.h
> 
> Is this a new mandatory rules to add a vendor prefix in dt-bindings
> file name? we have never add a vendor prefix before.
> 
> If possible, we'd like not to use vendor prefix for the consistency of
> fliename's format(mtxxxx-memory-port.h).
> Such as "mt8195-memory-port.h" and "mt8186-memory-port.h".

That's a generic rule, although loosely applied. The consistency is
rather to have a vendor prefix everywhere. Why Mediatek should have an
exception?

Best regards,
Krzysztof
