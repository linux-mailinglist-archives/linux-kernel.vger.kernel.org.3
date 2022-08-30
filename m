Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228B55A5DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiH3IGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiH3IGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:06:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AB6267E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:06:33 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F1BFD6601E8E;
        Tue, 30 Aug 2022 09:06:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661846792;
        bh=q3hz6lam6ByJZFG8AQKAq6AKbuWIaklHb+CToWCW60Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=elOrtcVL18D5qLmrky4vEOBy9QkcMtBFUGfLp8RpLC97BehAQhqmFtweput3RR/J6
         LPIjesKRFEIeGOQVSwTdJLJ+V4yijxQAb4CXzj4Hfk+jz6AkRakIBFC+FCXPgl653s
         yd8MaMrED5m/yZMG1ycFCE+e90RCxssUSsip5m6v8qIXxjVZERER8p+8WaAtG9fadi
         lM42gcshgTQM7MXuTVwQkVc38D9fNI5WNEkPcn6ZtcfNENZPtMgTuHpsqBgqHeB9ed
         DzsWtupeyrR1vfi/rE2BJAgfiKXlMtrPkDFoNaVBe35GqHGV0yRRUZQnGFshHMb5X6
         wy4uSSlCLfy/g==
Message-ID: <ea7b7b08-cb9a-b6a3-bc7a-050616696e89@collabora.com>
Date:   Tue, 30 Aug 2022 10:06:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] soc: mediatek: mtk-svs: Explicitly include bitfield
 header
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220829204439.3748648-1-nfraprado@collabora.com>
 <5a8a2b0d-fa7c-e8c6-bb04-152f8c17aa76@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <5a8a2b0d-fa7c-e8c6-bb04-152f8c17aa76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/08/22 09:37, Matthias Brugger ha scritto:
> 
> 
> On 29/08/2022 22:44, Nícolas F. R. A. Prado wrote:
>> Commit a92438c5a30a ("soc: mediatek: mtk-svs: Use bitfield access macros
>> where possible") introduced the use of FIELD_GET and FIELD_PREP macros,
>> which are defined in the bitfield header. Add an explicit include for it
>> so we're sure to have the symbols defined independently of the config.
>>
>> Fixes: a92438c5a30a ("soc: mediatek: mtk-svs: Use bitfield access macros where 
>> possible")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
>> ---
>>
>>   drivers/soc/mediatek/mtk-svs.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
>> index 64dba9f830f3..f67f3e971653 100644
>> --- a/drivers/soc/mediatek/mtk-svs.c
>> +++ b/drivers/soc/mediatek/mtk-svs.c
>> @@ -3,6 +3,7 @@
>>    * Copyright (C) 2022 MediaTek Inc.
>>    */
>> +#include <linux/bitfield.h>
>>   #include <linux/bits.h>
> 
> What do we need the bits.h for?
> 

bits.h has the definition for GENMASK(h, l), used in this file :-)

Cheers,
Angelo

> Regards,
> Matthias
> 
>>   #include <linux/clk.h>
>>   #include <linux/completion.h>


