Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869155A94AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiIAKcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiIAKcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:32:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB2512204F;
        Thu,  1 Sep 2022 03:32:18 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A0CEA6601DF7;
        Thu,  1 Sep 2022 11:32:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662028337;
        bh=TzpDrl8aXnnF1e6jwiJCsiOD00pZJii9Kr+EB7ormQE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iTqWZoDS3yvgnt+jDw5Qc5NchAtI2im7o+mTfK8C6XSsFjd7qsITKhYmIyd+NA9ov
         7GaKfswPrjdZfi6wLkAIs542bKH2o4JPwyL+zt5lfgLgbTGIu1puZRN0rExw/FqnVA
         h34K/IyizJVRxOmo66uipkYL8TYz02/6YiMTD8u8oebvommu1l9iBcx84MglmSPBcf
         K9hOBwTkB/mTI6zMRKhrKFieVg7ZW2yqHEzxYDoJah00DYpYp125eulNdq4tB6exZn
         oTQXfJQ6w8HfyaxHpso/olsozh2iyFx20xHsHKTeiAFml65UEXz9XwKCudVt/5ktiV
         7yliHyLci4y7A==
Message-ID: <9b82849e-516b-c798-994e-6bc8945c4831@collabora.com>
Date:   Thu, 1 Sep 2022 12:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
References: <20220831124850.7748-1-johnson.wang@mediatek.com>
 <20220831124850.7748-3-johnson.wang@mediatek.com>
 <b1296c37-5283-81f7-1939-7ea20e1f4d0d@linaro.org>
 <1fae0c47-fff9-89e9-c849-536d167d741d@collabora.com>
 <38910de5-89ad-e7a1-261f-18b51c8e7877@linaro.org>
 <955f7200-9d08-0d21-2d1a-5ccbd0f3a8af@collabora.com>
 <93d5de8e-31b2-4412-3348-7ba1903cde84@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <93d5de8e-31b2-4412-3348-7ba1903cde84@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/09/22 12:30, Krzysztof Kozlowski ha scritto:
> On 01/09/2022 13:22, AngeloGioacchino Del Regno wrote:
>>> That's simply not a proper
>>> hardware description, so again:
>>>
>>> 1. If this is separate device (as you indicated), then it needs
>>> expressing the dependencies and uses of other device resources.
>>
>> Agreed. In this case, what about...
>>
>> mediatek,hopping-ssc-percents = <&provider CLK_SOMEPLL 3>;
>>
>> or would it be better to specify the clocks in a separated property?
>>
>> clocks = <&provider CLK_SOMEPLL>, <&provider CLK_SOME_OTHER_PLL>;
>> mediatek,hopping-ssc-percents = <3>, <5>;
>>
> 
> I propose the last one - using standard clocks property and a matching
> table.
> 

Right. I like the last one a bit better, as well.

Thanks for the advices!
Angelo

