Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD35B583A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiG1IuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiG1IuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:50:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF152E67;
        Thu, 28 Jul 2022 01:50:00 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26S8nTdw039676;
        Thu, 28 Jul 2022 03:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1658998169;
        bh=14U9HxjRh3e7yTIKwyD4/eeKKqDboG34PmiiATYwwTE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=NV13UGLCAMCJCt6vhQyGtTtxqSEKbKYuQR7XRPyavSabi9oQ9BTfsWW6YV6RPRz8B
         sQwuAl3EfdFx6B/jkX5bVFxZUL//rzQ6xCpgilGhcxfQQqWK8nHqf1G2ZTQ7tbBD16
         0Uk4S4CrZk1CTbr/LIj4bbxaWOxDz4S9dgrvgDWs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26S8nTKG064147
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jul 2022 03:49:29 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 28
 Jul 2022 03:49:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 28 Jul 2022 03:49:29 -0500
Received: from [172.24.157.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26S8nO9k028827;
        Thu, 28 Jul 2022 03:49:25 -0500
Message-ID: <0d9f4301-8af5-4497-8e59-affdc0541285@ti.com>
Date:   Thu, 28 Jul 2022 14:19:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 8/8] drm/tidss: Enable Dual and Duplicate Modes for OLDI
Content-Language: en-US
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     Darren Etheridge <detheridge@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jyri Sarha <jyri.sarha@iki.fi>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-9-a-bhatia1@ti.com>
 <83df99ee-1304-121f-97e6-85ca416aef1f@ideasonboard.com>
 <c72e64b5-fbf0-0605-1d50-5b1f9b99eacf@ideasonboard.com>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <c72e64b5-fbf0-0605-1d50-5b1f9b99eacf@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On 28-Jul-22 12:16, Tomi Valkeinen wrote:
> On 27/07/2022 16:22, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 19/07/2022 11:08, Aradhya Bhatia wrote:
>>> The AM625 DSS peripheral supports 2 OLDI TXes which can work to enable 2
>>> duplicated displays of smaller resolutions or enable a single Dual-Link
>>> display with a higher resolution (1920x1200).
>>>
>>> Configure the necessary register to enable the different modes.
>>>
>>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>>> ---
>>>   drivers/gpu/drm/tidss/tidss_dispc.c | 44 +++++++++++++++++++++++++++--
>>>   1 file changed, 41 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c 
>>> b/drivers/gpu/drm/tidss/tidss_dispc.c
>>> index 0b9689453ee8..28cb61259471 100644
>>> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
>>> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
>>> @@ -1021,8 +1021,8 @@ static void dispc_enable_oldi(struct 
>>> dispc_device *dispc, u32 hw_videoport,
>>>       int count = 0;
>>>       /*
>>> -     * For the moment DUALMODESYNC, MASTERSLAVE, MODE, and SRC
>>> -     * bits of DISPC_VP_DSS_OLDI_CFG are set statically to 0.
>>> +     * For the moment MASTERSLAVE, and SRC bits of 
>>> DISPC_VP_DSS_OLDI_CFG are
>>> +     * set statically to 0.
>>>        */
>>>       if (fmt->data_width == 24)
>>> @@ -1039,7 +1039,45 @@ static void dispc_enable_oldi(struct 
>>> dispc_device *dispc, u32 hw_videoport,
>>>       oldi_cfg |= BIT(0); /* ENABLE */
>>> -    dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, 
>>> oldi_cfg);
>>> +    /*
>>> +     * As per all the current implementations of DSS, the OLDI TXes 
>>> are present only on
>>> +     * hw_videoport = 0 (OLDI TX 0). However, the config register 
>>> for 2nd OLDI TX (OLDI TX 1)
>>> +     * is present in the address space of hw_videoport = 1. Hence, 
>>> using "hw_videoport + 1" to
>>> +     * configure OLDI TX 1.
>>> +     */
>>> +
>>> +    switch (dispc->oldi_mode) {
>>> +    case OLDI_MODE_OFF:
>>> +        oldi_cfg &= ~BIT(0); /* DISABLE */
>>> +        dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, 
>>> oldi_cfg);
>>> +        dispc_vp_write(dispc, hw_videoport + 1, 
>>> DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
>>> +        break;
>>> +
>>> +    case OLDI_SINGLE_LINK_SINGLE_MODE_0:
>>> +        dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, 
>>> oldi_cfg);
>>> +        break;
>>> +
>>> +    case OLDI_SINGLE_LINK_SINGLE_MODE_1:
>>> +        dispc_vp_write(dispc, hw_videoport + 1, 
>>> DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
>>> +        break;
>>> +
>>> +    case OLDI_SINGLE_LINK_DUPLICATE_MODE:
>>> +        oldi_cfg |= BIT(5); /* DUPLICATE MODE */
>>> +        dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, 
>>> oldi_cfg);
>>> +        dispc_vp_write(dispc, hw_videoport + 1, 
>>> DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
>>> +        break;
>>> +
>>> +    case OLDI_DUAL_LINK:
>>> +        oldi_cfg |= BIT(11); /* DUALMODESYNC */
>>> +        dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, 
>>> oldi_cfg);
>>> +        dispc_vp_write(dispc, hw_videoport + 1, 
>>> DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
>>> +        break;
>>> +
>>> +    default:
>>> +        dev_warn(dispc->dev, "%s: Incorrect oldi mode. Returning.\n",
>>> +             __func__);
>>> +        return;
>>> +    }
>>>       while (!(oldi_reset_bit & dispc_read(dispc, DSS_SYSSTATUS)) &&
>>>              count < 10000)
>>
>> This feels a bit hacky:
>>
>> - The function is dispc_enable_oldi, but the above code also disables 
>> oldi. We have code in dispc_vp_unprepare() which disables OLDI at the 
>> moment.
>>
>> - The function takes hw_videoport as a parameter, and is designed to 
>> work on that videoport. The above operates on two videoports. Isn't 
>> the function also called for hw_videoport +1, which would result in 
>> reg writes to hw_videoport + 2?
>>
>> - No matching code in dispc_vp_unprepare
>>
>> Obviously the duplicate mode (I presume that's "cloning") and the dual 
>> link complicate things here, and I have to say I haven't worked with 
>> such setups. But I think somehow this should be restructured so that 
>> common configuration (common to the OLDIs) is done somewhere else.
>>
>> I would guess that there are other drivers that support cloning and 
>> dual mode. Did you have a look how they handle things?
> 
> Oh, I see now... There's just one dss video port for OLDI, the same as 
> in am65x, but that single video port is now connected to two OLDI TXes. 
> And thus this function will only be called for the single video port.
> > But... The registers for the second OLDI are part of the second video
> port (DPI) register block?

Yes! The config register for the second OLDI TX has been (incorrectly)
added in the register space for the DPI video port. 'dispc_vp_prepare'
is the only function calling 'dispc_enable_oldi', and
'dispc_enable_oldi' would not be called for hw_videoports = 1 (DPI)
because of the conditional check.

Hence, to activate both the OLDI-TXes connected to the OLDI video port,
I had to use the (hw_videoport + 1) way.

However, I will remove the disable part from the 'dispc_enable_oldi' and
I will implement the disabling properly under 'dispc_vp_unprepare', in
the next version.

Regards
Aradhya
