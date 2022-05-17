Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA0A52A3BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242145AbiEQNn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348066AbiEQNnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:43:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0894B84E;
        Tue, 17 May 2022 06:43:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 003711F444FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652795027;
        bh=+vxAUI6qKyUQAmObp8ZvzIBwGFIgr6ojIgBi09Xt4YM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aAhhin3zWwGwST2l5CGT5EBMXYau3h/7LjM8C7QMtUBkMoSQmLPDrlI8TM4gNUkhx
         95LdjA07hdX49lW/mb9NQWTPNX2sCDNmVGnd7WBpvr8pMqlZfpiDSwkg2ODpwPhGdi
         fg6d/IW5XbbzLEo2AJTYk8H8Zvor7jSPviWugyVEdUMWRP6Mdi3/VOSE+eXAQtcfxl
         RSu7P1Oh3VTL/oHBmTIJnpvUOBunvX1aDn0itF6moexJ6tIVzBXnb5jBZzQITyq92s
         akuTAxQ0KDTfHbbnm0Mce0Rt5RTxvZLdI5MXW+yUD5vhOlcR1ecD+d6QKER1FwISoF
         5BEwdKulF4KzQ==
Message-ID: <7f1660f4-63bd-8f24-4c7a-4b92f0d38e16@collabora.com>
Date:   Tue, 17 May 2022 15:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/6] dt-bindings: arm: MediaTek: Fix clock bindings
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        wenst@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
 <21581440-a65c-ee8c-95e4-0e179c2838dd@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <21581440-a65c-ee8c-95e4-0e179c2838dd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/22 15:39, Matthias Brugger ha scritto:
> 
> 
> On 17/05/2022 12:15, AngeloGioacchino Del Regno wrote:
>> As per Rob Herring's review [1] on my mt6795 clocks bindings patches, for
>> which I've used the already upstreamed ones as a base, it was found that
>> these bindings have some issues.
>> This series is addressing the issues that were found by Rob on my series,
>> which are present on all of the already merged bindings.
>>
>> [1]: 
>> https://patchwork.kernel.org/project/linux-mediatek/patch/20220513165050.500831-5-angelogioacchino.delregno@collabora.com/#24859953 
>>
> 
> I would say we could squash patches here and make it 3 instead of 6.
> In any case for the whole series:
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 

I had the same initial idea, but chose to do it in 6 patches because otherwise
the titles would be too generic and not really effectual in the end...

If anyone wants them squashed, now you know what was my difficulty and my
reasons :-)

By the way, thank you!

>>
>> AngeloGioacchino Del Regno (6):
>>    dt-bindings: arm: mt8186-clock: Remove unnecessary 'items' and fix
>>      formatting
>>    dt-bindings: arm: mt8186: Set #clock-cells as required property
>>    dt-bindings: arm: mt8195-clock: Remove unnecessary 'items' and fix
>>      formatting
>>    dt-bindings: arm: mt8195: Set #clock-cells as required property
>>    dt-bindings: arm: mt8192-clock: Remove unnecessary 'items'
>>    dt-bindings: arm: mt8192: Set #clock-cells as required property
>>
>>   .../arm/mediatek/mediatek,mt8186-clock.yaml   | 29 ++++-----
>>   .../mediatek/mediatek,mt8186-sys-clock.yaml   |  1 +
>>   .../arm/mediatek/mediatek,mt8192-clock.yaml   | 46 +++++++--------
>>   .../mediatek/mediatek,mt8192-sys-clock.yaml   |  1 +
>>   .../arm/mediatek/mediatek,mt8195-clock.yaml   | 59 ++++++++++---------
>>   .../mediatek/mediatek,mt8195-sys-clock.yaml   |  1 +
>>   6 files changed, 71 insertions(+), 66 deletions(-)
>>

