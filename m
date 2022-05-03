Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24C051866A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiECOWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiECOWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:22:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF63B24945;
        Tue,  3 May 2022 07:18:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D4B381F43BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651587519;
        bh=tdv2h2YB7zXn+XefewHbbfpKCqa1mzg1E2iD1t5Fl0Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W/X2MZsTr5pSE6d87lpmbCbBlJC9AMs64S21CzIf3kd2N/0cR07RkdqQ8c1rOjCr7
         GWa59KAOqnXJRQOUvDSwkMRr0s9D0TbhacQJjMQZSjy3ZYz9mVtrMgJ3eKGF58mWDS
         ygmQz1eLM80QUkZxErkCqhtwBMTSROdyODJzCbCvpii961xIzSelnbE1kwTU+JGQGX
         YPeTiHtz20KhkJLlact+A2AOMpJQzL4IVMq/vP9+7KCyvBwkq5WVeFI8/SoaRndo0k
         xjnl7B9fvC0D57pMzgYrphqtVwRhtz8RfFmXdXjnCib9wEFKQCU0xzhu62pMJgkVzq
         Xitg5vdLU9OZw==
Message-ID: <9a6ad743-b8c8-9ac1-824e-63295d03498a@collabora.com>
Date:   Tue, 3 May 2022 16:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] dt-bindings: remoteproc: mediatek: Add optional
 memory-region to mtk,scp
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        Tinghan Shen <tinghan.shen@mediatek.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220502192420.2548512-1-nfraprado@collabora.com>
 <20220502192420.2548512-3-nfraprado@collabora.com>
 <YnE5Sq8H6juQHpbM@robh.at.kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YnE5Sq8H6juQHpbM@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/05/22 16:16, Rob Herring ha scritto:
> On Mon, 02 May 2022 15:24:20 -0400, Nícolas F. R. A. Prado wrote:
>> The SCP co-processor can optionally be passed a reserved memory region
>> to use. Add this property in the dt-binding.
>>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
>> ---
>> I left out Angelo's R-b since of the 3 lines in the patch from v1, only
>> 1 is left.
>>
>> Changes in v2:
>> - Dropped type and description since it's a well-known property
>> - Set maxItems to 1
>>
>>   Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
