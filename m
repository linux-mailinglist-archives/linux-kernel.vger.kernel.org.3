Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844D74C65CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiB1Jjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiB1Jjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:39:45 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847185E76C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:39:07 -0800 (PST)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D8936478;
        Mon, 28 Feb 2022 10:39:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646041145;
        bh=PFehvEiXF30wC6an5vLf49LvGgKwjVvaSRlxJwK8Wz8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tf1SqDGUh31iiqRENKsA94L2Q7hIhz1Khg1tyh8b5cW4OAkSjrK1Qt1imNYjxjXVZ
         ZLmmrI6BPCEdCCUuDNHkwGt5dG51E7PATkiMTYg7ZSsc4JgxI3J6lEAl0p2XvgNwsn
         aupS7baEUiVvyvPqNRiJYQNjWKjjuikBn2eNWnoM=
Message-ID: <613c0fc8-8cad-ef38-a47d-794b08b1a083@ideasonboard.com>
Date:   Mon, 28 Feb 2022 11:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/bridge: cdns-dsi: Make sure to to create proper
 aliases for dt
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, nikhil.nd@ti.com,
        r-ravikumar@ti.com, Milind Parab <mparab@cadence.com>
References: <20210921174059.17946-1-nm@ti.com>
 <20211109145538.fh3vsfnvfvvmcovb@automated>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20211109145538.fh3vsfnvfvvmcovb@automated>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2021 16:55, Nishanth Menon wrote:
> On 12:40-20210921, Nishanth Menon wrote:
>> Add MODULE_DEVICE_TABLE to the device tree table to create required
>> aliases needed for module to be loaded with device tree based platform.
>>
>> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>   drivers/gpu/drm/bridge/cdns-dsi.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
>> index d8a15c459b42..829e1a144656 100644
>> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
>> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
>> @@ -1284,6 +1284,7 @@ static const struct of_device_id cdns_dsi_of_match[] = {
>>   	{ .compatible = "cdns,dsi" },
>>   	{ },
>>   };
>> +MODULE_DEVICE_TABLE(of, cdns_dsi_of_match);
>>   
>>   static struct platform_driver cdns_dsi_platform_driver = {
>>   	.probe  = cdns_dsi_drm_probe,
>> -- 
>> 2.32.0
>>
>>
> 
> Hi, Ping?

Thanks, I'll apply to drm-misc-next.

  Tomi
