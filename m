Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC0550B75B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447549AbiDVMeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447543AbiDVMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:34:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ADE517EA;
        Fri, 22 Apr 2022 05:31:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r19so5016580wmq.0;
        Fri, 22 Apr 2022 05:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CBcYiF6362uk33z6W6pwWYiGiENSgVP0CPFI16Cm26o=;
        b=GxGdiWg1HKUPuzArMV6q7mYMHSw5fVQXbIsdKBZEmY18qLoQ/3od67tJgJavDorpuh
         x3QJ6ZiBT9hn3e+ycWnWXxTP/kzAchfYGmDC2xiXsNoJC7vZ9d7jONp4FlmPsoJgEV19
         1o7JeRo5p2q9xwzmxzTNXU1/RdbHeh9Cpxikpcc8o//YNZJeefFjbx5EKIQhBdHe85se
         MBS5Lo62p93P41R9OSuhcsGmWxq1Xd/+L+p4TD6Iizs8qUvSO5TX7LEiw0V//4Zf9XkV
         +QcE5kkh6m2dTwgVTKdPpJ+L2C3jTZefzjRzV0qPTTv0F9BZ7bL+mxO6V5zXNaxYjlVN
         aKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CBcYiF6362uk33z6W6pwWYiGiENSgVP0CPFI16Cm26o=;
        b=YXHrPyC3MFIoCcGKPYdMOYLZJATM8HgIGWJ0KEjF4Exi2C+KCCD5CifCtpJWvWUbaX
         ZyP+sVi0FgiMWBGKgeaNB7eZspCNYtRLEVaykxvNa6yMCuXdwBkfuVEK/frWob+w8VWc
         o2KSkyG7+6C6b/bHC4Y3C3oJ5Se2yfEycJ8liKvb67aC19P9EkLBFc2YJpExLAn9OE4y
         8AtyZs2y2j/LObLh8yex+FEgId0+n0nxshOPfdVebQZxzlbREFUlXzJkZh8nwPYGS0lX
         zSYZSNW5PwBfwTyLlHu2atIOfTCNbtau3flKgtjMCY6BpgWCYP7lJEEIiIGTzSvb0UGf
         MpiQ==
X-Gm-Message-State: AOAM532N340rvuayW25K4/lxwHyVt1iucOsSS6rDpyHfCtB4muMw+DCK
        moMNJa/t4th2ziYI3dQf7bE=
X-Google-Smtp-Source: ABdhPJxAXSLZr0cbOfuaLrq9lwbUFGLwRJ/KMqDo3dR+G9jBSah8w2G7ldUeCdqYhnSSMDrXLwu2pg==
X-Received: by 2002:a1c:6a02:0:b0:38b:3661:47f1 with SMTP id f2-20020a1c6a02000000b0038b366147f1mr3933534wmc.5.1650630684935;
        Fri, 22 Apr 2022 05:31:24 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d588c000000b0020a9e80d2b1sm2041357wrf.107.2022.04.22.05.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 05:31:24 -0700 (PDT)
Message-ID: <074d8c26-3fb7-bee1-d559-7ce96f583fee@gmail.com>
Date:   Fri, 22 Apr 2022 14:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v20 2/8] soc: mediatek: add mtk-mutex support for mt8195
 vdosys0
Content-Language: en-US
To:     Jason-JH Lin <jason-jh.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220419094143.9561-1-jason-jh.lin@mediatek.com>
 <20220419094143.9561-3-jason-jh.lin@mediatek.com>
 <82cc5e6900138e13ed9d75c6d2a42c6d7afc1959.camel@mediatek.com>
 <c3de9ccb314316b5296b115dd3e9f8171577489f.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <c3de9ccb314316b5296b115dd3e9f8171577489f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/04/2022 04:32, Jason-JH Lin wrote:
> Hi CK,
> 
> Thanks for the reviews.
> 
> On Thu, 2022-04-21 at 14:50 +0800, CK Hu wrote:
>> Hi, Jason:
>>
>> On Tue, 2022-04-19 at 17:41 +0800, jason-jh.lin wrote:
>>> Add mtk-mutex support for mt8195 vdosys0.
>>>
>>> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
>>> Acked-by: AngeloGioacchino Del Regno <
>>> angelogioacchino.delregno@collabora.com>
>>> Tested-by: Fei Shao <fshao@chromium.org>
>>> ---
>>>   drivers/soc/mediatek/mtk-mutex.c | 87
>>> ++++++++++++++++++++++++++++++--
>>>   1 file changed, 84 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-mutex.c
>>> b/drivers/soc/mediatek/mtk-mutex.c
>>> index aaf8fc1abb43..729ee88035ed 100644
>>> --- a/drivers/soc/mediatek/mtk-mutex.c
>>> +++ b/drivers/soc/mediatek/mtk-mutex.c
>>> @@ -17,6 +17,9 @@
>>>   #define MT8183_MUTEX0_MOD0			0x30
>>>   #define MT8183_MUTEX0_SOF0			0x2c
>>>   
>>> +#define MT8195_DISP_MUTEX0_MOD0			0x30
>>> +#define MT8195_DISP_MUTEX0_SOF			0x2c
>>
>> This is identical to mt8183, so use mt8183 one instead of creating
>> new
>> one.
>>
>> Regards,
>> CK
>>
> I'll fix this in the next version.

Please send this as a follow-up fix on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=v5.18-next/soc

Regards,
Matthias

> 
> Regards,
> Jason-JH.Lin.
>>>
>>>   
>>> +static const struct mtk_mutex_data mt8195_mutex_driver_data = {
>>> +	.mutex_mod = mt8195_mutex_mod,
>>> +	.mutex_sof = mt8195_mutex_sof,
>>> +	.mutex_mod_reg = MT8195_DISP_MUTEX0_MOD0,
>>> +	.mutex_sof_reg = MT8195_DISP_MUTEX0_SOF,
>>> +};
>>> +
>>>   
>>
>>
