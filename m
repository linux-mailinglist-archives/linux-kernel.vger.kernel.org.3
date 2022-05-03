Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048B25184AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiECNCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiECNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:02:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1F133A20;
        Tue,  3 May 2022 05:58:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B82D81F44301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651582714;
        bh=x3OQ1oHSHfYp4EWTit5w0xva4dWoTSyHlpVA/f0sBc8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oE4Gzqh7OQZobIVPBHen/agv7mJlYdisUly3VljCB4nzrklgVosKcpjP/KQOtoNfk
         DAMgQab7UjiiKvjE3rCyi2RSCQQQWkTKn4wGCfOX6CXlnWkLGX0mBI8thk68jbVXjk
         HzzCj5qWKP6/ZkqopFTk/2M9IexLWkJfU9KS/YD/nygGcXa8XFDSDlUV9EQVpnk6k5
         LMf45muBV7e0FDFb/S9UQzm4bmQWbn9z1HXyrS4ZaG6uaoROVu/6/GbcMEhT26IQCo
         A6df+5G40WYA9IITkq57SlpR9v/ftM3fPD2jB+bwwc4jIsaDQbkWXna/+MEW8XMP+C
         MvmEEtEa0xFAg==
Message-ID: <64129cb4-f33f-6017-4923-63f67f7067fa@collabora.com>
Date:   Tue, 3 May 2022 14:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: power: Add MediaTek Helio X10 MT6795
 power domains
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
References: <20220503105436.54901-1-angelogioacchino.delregno@collabora.com>
 <20220503105436.54901-2-angelogioacchino.delregno@collabora.com>
 <ac774c74-4577-3dfc-7bf4-3c180d45b420@linaro.org>
 <94dbb7ee-764a-5568-a044-80dbfe77c29a@collabora.com>
 <d371fff5-0d45-b827-2696-3862b3c5fd59@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <d371fff5-0d45-b827-2696-3862b3c5fd59@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/05/22 14:57, Krzysztof Kozlowski ha scritto:
> On 03/05/2022 14:43, AngeloGioacchino Del Regno wrote:
>>>
>>> If it is not a derivative work, should be GPL-2.0 OR BSD
>>>
>>
>> On that, I agree with you, fully.
>>
>> Though, all of the mt(xxxx)-power.h headers provide this license tag and I
>> wanted to follow that to give the same.
>>
>> Should I change it to (GPL-2.0-only OR BSD-2-Clause)?
> 
> Yes, please, for this one.
> 
> For the other bindings - you would need acks from people involved.
> 

I'm glad to read this. I'll change it in the next version. Thank you!

