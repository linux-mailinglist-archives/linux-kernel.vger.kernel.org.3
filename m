Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA65597F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243837AbiHRHsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiHRHsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:48:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4A54457A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:48:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a9so1073761lfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Gtx/1NtYRUpYFSNfi/ck/6ru5mDdKGyHys400ty/Xyg=;
        b=pA3vT8XbKPIIhMfNE2PsUnmxJJkmWap6JQJqjWxUjeuEtfkhAgrmbdfO6Yu/ZTLP7+
         SI16XaknZ5obeqxRLBGSBSc/1r4y45MRiSyeB6pwmB+cHec/6aTD4/5RxkzzmL0Ot/9z
         ucg0vtkF5wz+5MDMOvy8h//s+2H7ILParQqB74iLotZzx2nxXSbGhZQI24Ixe40Is7v0
         65gvD5eRu1tOo3oAL0u2bfaNj4l7CH9hHkZSIkk5HWj+82cUPcedRrWETKf4N+2+mHdR
         mseUANI8JD0T1a+1+jpxDM6W0m72On92z7wq5nbOpfJsU3BCUQBKBF/iRSe/qQwiJCap
         xc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Gtx/1NtYRUpYFSNfi/ck/6ru5mDdKGyHys400ty/Xyg=;
        b=IFBR8ndMksAvvNZNC4mO9DfY6Rllty4zelOH/hZLBVu4GP5bW+g7hspO551mqVxQ48
         d0DssfqisJNImNSxArZbsMwQ8vQoi83LbCfQX+OxzoDSAiHWGe1tOSY1a5XWb5cRPL+J
         +HGpWiC300+X4C5NVvtM3+b8ypAqmYQClFQ9BAc9Z1uAJPvTq5HqL+w8dZM02S+2aMRX
         mIG3N3JKOx/HMw30C73JocpO3oqXwjp/eL0XIxnn55kRW0aT8m3EmKef6LFdXqtAD36D
         ClfgGiXC5n5wTKtcr/YFV1yb/3qlDJ+vP/BsoMFZZ0g47J4qJ3p4F4UyEWwJvEdnzjoh
         MQXA==
X-Gm-Message-State: ACgBeo3V7NFgLcvEqjdQOzyuTJPn/ilolwzHPSO0idEETQTdKvTkTu2/
        p4onsL5rJi+/5puGNmXIXnnMfQ==
X-Google-Smtp-Source: AA6agR4KTEWECDn55d+h9/m11+vRY/poYCh80L5VL5lneKWL68GDtDsqJbwN9MQNwzUWsQWSiQTv3g==
X-Received: by 2002:a05:6512:201a:b0:48d:1101:cc9b with SMTP id a26-20020a056512201a00b0048d1101cc9bmr644396lfb.152.1660808908249;
        Thu, 18 Aug 2022 00:48:28 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id v10-20020a056512348a00b00491203d6cc9sm121513lfr.131.2022.08.18.00.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 00:48:27 -0700 (PDT)
Message-ID: <5a916595-12ee-92e6-d380-84146dd75218@linaro.org>
Date:   Thu, 18 Aug 2022 10:48:26 +0300
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
> On Thu, 2022-08-04 at 13:13 +0200, Krzysztof Kozlowski wrote:
>> On 04/08/2022 12:58, Chengci.Xu wrote:
>>> This patch adds descriptions for mt8188 IOMMU which also use ARM
>>> Short-Descriptor translation table format.
>>>
>>
>>
>> Thank you for your patch. There is something to discuss/improve.
> 
> Tkanks for your review.
> 

BTW, none of your emails seem to reach devicetree mailing list:
https://lore.kernel.org/linux-devicetree/20220804105834.626-1-chengci.xu@mediatek.com/
which means they won't pop-up in Rob's Patchwork and won't tested by bot.
https://patchwork.ozlabs.org/project/devicetree-bindings/list/?series=&submitter=84571&state=*&q=&archive=&delegate=

I wonder if this is the same issue as with other Mediatek emails
filtered by spam...

Anyway, you should sort it out, otherwise patches won't get to Rob and I
won't apply them.

Best regards,
Krzysztof
