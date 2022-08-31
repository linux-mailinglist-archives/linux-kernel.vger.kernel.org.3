Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F053F5A77F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiHaHrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiHaHro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:47:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E187337FB6;
        Wed, 31 Aug 2022 00:47:43 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C8206601688;
        Wed, 31 Aug 2022 08:47:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661932061;
        bh=W0y4oUWuQ2sZvJSfYO8MdMV3XL/CKswNqbqU/lyBoyw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ln16OWmxMVHFq6RDvuyB5G4weOtKDPCtEvlw/LKzyRI6QvqpqazUNDh6p7Y8kzufF
         gRJwaOpeFU/rIfp6mbRB/lBHK2aUjmb8QIB1hTdoME0XKp3BlF7ga6nC4112pkglzZ
         jmCuklfEHfDvmXPeTiGBJOkG7rRf9DtvFS5RhwJb8kpUoUjyZZ3ufojMvr1lzMCdJq
         4q0SUs+ox5wdPLjqxMy6+gnh1ELoTZkB+V1TBlYa1H9Tlemp1Rj1uhVwQIiWjTjPnq
         Za9XmZaGxAERAKVxeD9rEo07KZxRpodMEZnlDWL0SD04POTQ+XCBi/AjhOj3pJ3skX
         DnoBqoYG+wbHQ==
Message-ID: <2620c49f-1e55-efb0-bd21-ab8567030485@collabora.com>
Date:   Wed, 31 Aug 2022 09:47:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 3/3] arm64: dts: Modify gamma compatible for mt8195
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "zheng-yan.chen" <zheng-yan.chen@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220830063929.13390-1-zheng-yan.chen@mediatek.com>
 <20220830063929.13390-4-zheng-yan.chen@mediatek.com>
 <a209aea3-bf23-4670-91d0-e7f41ac57833@collabora.com>
 <bf2b277e-8b02-6a44-e463-6b7c4a697ce7@linaro.org>
 <b61776761eb0ab9a0b1dcf29d908e4bfd789d2ac.camel@mediatek.com>
 <22eb5611-84e2-23e9-f70b-48bef351133f@linaro.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <22eb5611-84e2-23e9-f70b-48bef351133f@linaro.org>
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

Il 31/08/22 08:04, Krzysztof Kozlowski ha scritto:
> On 31/08/2022 05:29, zheng-yan.chen wrote:
>> On Tue, 2022-08-30 at 12:14 +0300, Krzysztof Kozlowski wrote:
>>> On 30/08/2022 10:49, AngeloGioacchino Del Regno wrote:
>>>> Il 30/08/22 08:39, zheng-yan.chen ha scritto:
>>>>> Modify gamma compatible for mt8195.
>>>>>
>>>>> Fixes: 16590e634f1d ("arm64: dts: mt8195: Add display node for
>>>>> vdosys0")
>>>>> Signed-off-by: zheng-yan.chen <zheng-yan.chen@mediatek.com>
>>>>
>>>> Reviewed-by: AngeloGioacchino Del Regno <
>>>> angelogioacchino.delregno@collabora.com>
>>>
>>> Please also perform review on the commit msg and backport status.
>>>

Ack.

Cheers,
Angelo

>>> Best regards,
>>> Krzysztof
>> Hello Krzysztof,
>> Thanks for the review,
>> I will fix it at the next version.
> 
> This was to AngeloGioacchino...
> 
> Best regards,
> Krzysztof

