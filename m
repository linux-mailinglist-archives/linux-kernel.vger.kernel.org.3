Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB4527FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiEPIpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbiEPIoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:44:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30AEF580;
        Mon, 16 May 2022 01:44:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AA2351F427F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652690660;
        bh=/A+cNqtSPHG/D4qhatlAKYS/dqSWn1bu3i/Z2T9OGN8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XDOVMGDR+NJ6s8VoO9u2vElluOF9m3hpIu+RFa3HjxJBsrZRUvXxnHq4iSzXqxW3O
         dfQpBXHhFN/+Rc62GprPJ0M9G/kPT5GiZRc/xxU3bonQwqoyGID8I90+SLMwQmr7l7
         9bP1jxx1FV8GBCxK/drzz+SBpEKbhlOwfc4aDVteuYCrcn3tk3UXC2wovIC/IBiOPH
         V0wXYHwPixsUeKzr4W5Sf5/254a7Y2o+GNp+ap3oXvEAN7AO0LnlVmlRdTC2JULXvM
         paQk33Y9eAgNHfa842LRJ6yDI6IOhpxDZljnp1VvwrUr3k2dROpNWIQlh3VZvF5hgs
         eqJLVkEIB4iIQ==
Message-ID: <a7afc559-4e0a-6552-190c-19e58851ce68@collabora.com>
Date:   Mon, 16 May 2022 10:44:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] soc: mediatek: mtk-mmsys: Add support for MT6795 Helio
 X10
Content-Language: en-US
To:     CK Hu <ck.hu@mediatek.com>, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220513170350.502501-1-angelogioacchino.delregno@collabora.com>
 <7c996c665a57fdd9ba8d6df4dc085f70afc1b933.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <7c996c665a57fdd9ba8d6df4dc085f70afc1b933.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/05/22 07:43, CK Hu ha scritto:
> Hi, Angelo:
> 
> On Fri, 2022-05-13 at 19:03 +0200, AngeloGioacchino Del Regno wrote:
>> Add MM support for the MT6795 SoC, using the mmsys default routing
>> table.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>
>> In order for this patch to have any meaning and functionality, it is
>> required to also have in-tree the [1] MT6795 clocks series, even
>> though that's not required to actually compile this code.
>>
>> [1]
>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=641493__;!!CTRNKA9wMg0ARbw!ywDb_Gj4oV0iYHK_PbtJSNejzsJGlFVjX-1O0G1mR0vZX_5VeMtlZJ_AS6K_Mg$
>>   
>>
>>   drivers/soc/mediatek/mtk-mmsys.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/soc/mediatek/mtk-mmsys.c
>> b/drivers/soc/mediatek/mtk-mmsys.c
>> index 06d8e83a2cb5..38b36b881a3b 100644
>> --- a/drivers/soc/mediatek/mtk-mmsys.c
>> +++ b/drivers/soc/mediatek/mtk-mmsys.c
>> @@ -57,6 +57,13 @@ static const struct mtk_mmsys_match_data
>> mt6779_mmsys_match_data = {
>>   	},
>>   };
>>   
>> +static const struct mtk_mmsys_driver_data mt6795_mmsys_driver_data =
>> {
>> +	.clk_driver = "clk-mt6795-mm",
>> +	.routes = mmsys_default_routing_table,
> 
> mt6795 should have its own routing table instead of default one. The
> default one is used for mt8173, mt2701, mt2712 which no one knows how
> to separate them. If you don't know the routing table of mt6795, just
> left this as NULL.
> 

Hello CK,

I agree with you, in fact the first test that I've done was with leaving
routes to NULL, but that did not work (I couldn't get the display to work),
while assigning the default routing table resulted in having a working
internal (DSI) display et al, which is why I have done that.

I am sure that this may be a quirk that is required due to my platform's
bootloader, but still, it won't work otherwise.

If anyone from MediaTek wants to help with providing a better solution for
that, you're welcome to - but otherwise, my proposal is to configure MT6795
with that default routing table and eventually come back to this later if
any issue with this gets discovered... I couldn't find any, though.

Cheers,
Angelo

