Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75C254F5F5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382244AbiFQKsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382236AbiFQKsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:48:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CFF6BFE4;
        Fri, 17 Jun 2022 03:48:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ED2B5660179A;
        Fri, 17 Jun 2022 11:48:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655462919;
        bh=iolRVPHpQh6u3gC87otykET26yu59XGpf0xquwJFbtc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XRs4/BwLMzqZniW2WQLPzcxJs6DepjVBYQa2NqHJpTL1av7Khq/gdaL+nLrDEyn07
         /gHguPuCdGwlXhpoxmLoKUeoxg3Xk2yk9vJ6qwvinAbc/Wbob/QdYw8TOcIWeL7AUC
         yXyuajtPBLCLGs/orx4F4ZHVuZwavLZNZ7yHZI7VumHdqNqB7BHdL/OlZiXRrWUv7N
         dspWvd1xqc9JENEkB4sW/inqQPJbmRrF3ZLRurk40raNh9icJDGstAyH2iGL/5/0zZ
         C0MKJ7N3lZXU5ysNCR5BNdL78R93hH5yJaXAKvPZHa4fPb/dKk6yjPQ4ll04rXwKqS
         0aufFhxGXKFIw==
Message-ID: <7da07c36-e449-dcfc-b1d3-897bead0f23f@collabora.com>
Date:   Fri, 17 Jun 2022 12:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] cpufreq: Add MT8186 to cpufreq-dt-platdev blocklist
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>, rafael@kernel.org
Cc:     viresh.kumar@linaro.org, rex-bc.chen@mediatek.com,
        jia-wei.chang@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220617090652.56247-1-angelogioacchino.delregno@collabora.com>
 <71bf73f9-fa60-e4ba-a339-64d876514af2@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <71bf73f9-fa60-e4ba-a339-64d876514af2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/06/22 12:16, Matthias Brugger ha scritto:
> 
> 
> On 17/06/2022 11:06, AngeloGioacchino Del Regno wrote:
>> This SoC shall use the mediatek-cpufreq driver, or the system will
>> crash upon any clock scaling request: add it to the cpufreq-dt-platdev
>> blocklist.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Fixes: 39b360102f3a ("cpufreq: mediatek: Add support for MT8186")
> 
> Fixes tag should be before any Rb, SoB etc tags.

Oh wow, I really did that.

Sorry, I'll send a v2 in a minute or two.

> 
> With that:
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
>> ---
>>   drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c 
>> b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index 96de1536e1cb..2c96de3f2d83 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -127,6 +127,7 @@ static const struct of_device_id blocklist[] __initconst = {
>>       { .compatible = "mediatek,mt8173", },
>>       { .compatible = "mediatek,mt8176", },
>>       { .compatible = "mediatek,mt8183", },
>> +    { .compatible = "mediatek,mt8186", },
>>       { .compatible = "mediatek,mt8365", },
>>       { .compatible = "mediatek,mt8516", },


