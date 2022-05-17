Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC1529F77
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344306AbiEQKaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344241AbiEQK3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:29:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A299642D;
        Tue, 17 May 2022 03:29:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v191-20020a1cacc8000000b00397001398c0so1097891wme.5;
        Tue, 17 May 2022 03:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=T5Y1b6MSTSDc62ZZyWayGESS/DrDYqtlxsbdBnKwLdA=;
        b=VYKzS2kN0FFAnX4lzjuqVDsdNLyYCFES8rKBC/KPUC10SmAUCTYRjrYHOHoe2vJcm8
         sdqBCD17ys08EY/HTqVXZLqMkOyOOZtAjHd/hKG5s/sNRz0J5kGvWGalPCK2vzX1c/A3
         DfP9N7ZpIsOWXofYldFzgQXCXlPrDhPSxOGHcdkLWMKhVkTeFIYq1bOiL5hwl6e42PuN
         UWZMShCJQyI1kgQxVuXBVY1cCNuV3sfpiIraCzqfkgVnPhpMJWdm4PKL9N24GtOfNXXW
         WJCjrCG1YbH4stgQhDmDa6kxrCM/6EhF7eM5fN4uVnltsWkQz4pEpOIFFM2SHMvCwgcB
         Y6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=T5Y1b6MSTSDc62ZZyWayGESS/DrDYqtlxsbdBnKwLdA=;
        b=MYc9aWDP6FqGG8nmAjg9B25nh9ENQLSvIAJIV8dpChQeTWbeFQOpx/3LrpqmldNN7M
         TLQBxtUqgbvWzIsTTHty89Hv7BF1rkE+0MNbmlFk87KfB4/3XBNFliwcfjFzkOJ2I2Da
         O/kppqgc4zYMeTzZMHbwgxUbeS0gLZZ7oM6gyRNZwmm1lf+aNVGAtW8Sk4IvFa8jHlok
         Enl5On25cSimTQPwWMg3W4OnQqyYinUKPfKI+7KE9AjLVN59Ok8ftXH9kVbsfQqU0A3h
         OiHe/fdLCB1AszDZfgJk4SbWwcvQuQZCEoWvyXYjNv9zBCDMohKhYTIZhwBNYzbyQMOL
         XLdQ==
X-Gm-Message-State: AOAM532lcVnWTVxM/oB2yDeyLYYwaC4YWs9Ux1iJccTnWND9f+oTBCOe
        jqI21vqohi7u5LHenXagEXjnOkKUksRjjA==
X-Google-Smtp-Source: ABdhPJzfBnWPJiwfC93HpWH7vV0YVhtEQkrGLNuwAocWmFPYATQgc990iZt3LWEWWO4aApv9rLO3pw==
X-Received: by 2002:a05:600c:154d:b0:394:8d64:9166 with SMTP id f13-20020a05600c154d00b003948d649166mr21054212wmg.102.1652783380402;
        Tue, 17 May 2022 03:29:40 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v8-20020adfa1c8000000b0020d050461c9sm7968570wrv.54.2022.05.17.03.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 03:29:39 -0700 (PDT)
Message-ID: <5965f488-714d-0456-50e0-bef79dc5ad0c@gmail.com>
Date:   Tue, 17 May 2022 12:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220419094143.9561-1-jason-jh.lin@mediatek.com>
 <20220419094143.9561-9-jason-jh.lin@mediatek.com>
 <402f0e60-8d3c-850d-84ff-af5424b72b73@gmail.com>
 <CAAOTY_-jiX_BhaZ5+skRu4RSZLjcHJerVtwH34fz4N6_jbVK0w@mail.gmail.com>
 <623fb170-b59a-84a0-3826-4b78968924bc@gmail.com>
 <CAAOTY_9gReO45qVhd5-9UrDYsDkOeS+FZT2Dw2McVgZvK3jfeg@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v20 8/8] soc: mediatek: remove DDP_DOMPONENT_DITHER from
 enum
In-Reply-To: <CAAOTY_9gReO45qVhd5-9UrDYsDkOeS+FZT2Dw2McVgZvK3jfeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/05/2022 00:45, Chun-Kuang Hu wrote:
> Hi, Matthias:
> 
> Matthias Brugger <matthias.bgg@gmail.com> 於 2022年5月13日 週五 下午3:42寫道：
>>
>> Hi Chun-Kuang,
>>
>> On 02/05/2022 00:54, Chun-Kuang Hu wrote:
>>> Hi, Matthias:
>>>
>>> Matthias Brugger <matthias.bgg@gmail.com> 於 2022年4月22日 週五 下午8:42寫道：
>>>>
>>>>
>>>>
>>>> On 19/04/2022 11:41, jason-jh.lin wrote:
>>>>> After mmsys and drm change DITHER enum to DDP_COMPONENT_DITHER0,
>>>>> mmsys header can remove the useless DDP_COMPONENT_DITHER enum.
>>>>>
>>>>> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
>>>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>
>>>> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>>>>
>>>> Chun-Kuang, I think it would make sense to take that through your tree as it
>>>> depends on the previous patches.
>>>>
>>>> I provide you a stable tag so that you can take it:
>>>> v5.18-next-vdso0-stable-tag
>>>
>>> After I take this tag, I find one checkpatch warning:
>>>
>>> WARNING: DT compatible string "mediatek,mt8195-mmsys" appears
>>> un-documented -- check ./Documentation/devicetree/bindings/
>>> #670: FILE: drivers/soc/mediatek/mtk-mmsys.c:390:
>>> +               .compatible = "mediatek,mt8195-mmsys",
>>>
>>> I think this tag lost one binding patch, it's better that this tag has
>>> no this warning.
>>>
>>
>> Sorry for the late reply I was sick.
>> The warning is, because the stable branch misses commit:
>> https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.18-next/soc&id=81c5a41d10b968ea89d5f44fe1e5c2fc70289209
>>
>> So it's not a real issue and will go away once our branches land in upstream.
>> Is it OK for you to ignore the issue?
> 
> It's OK for me, but the patch would go through different maintainer's
> tree and I'm not sure it's OK for all of them. So I would wait for the
> necessary patch land in upstream.
> 

Ok makes sense. Sorry for the bad coordination from my side on this.

Regards,
Matthias

> Regards,
> Chun-Kuang.
> 
>>
>> Regards,
>> Matthias
>>
>>> Regards,
>>> Chun-Kuang.
>>>
>>>>
>>>> Regards,
>>>> Matthias
>>>>
>>>>> ---
>>>>>     include/linux/soc/mediatek/mtk-mmsys.h | 3 +--
>>>>>     1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
>>>>> index 59117d970daf..fb719fd1281c 100644
>>>>> --- a/include/linux/soc/mediatek/mtk-mmsys.h
>>>>> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
>>>>> @@ -16,8 +16,7 @@ enum mtk_ddp_comp_id {
>>>>>         DDP_COMPONENT_CCORR,
>>>>>         DDP_COMPONENT_COLOR0,
>>>>>         DDP_COMPONENT_COLOR1,
>>>>> -     DDP_COMPONENT_DITHER,
>>>>> -     DDP_COMPONENT_DITHER0 = DDP_COMPONENT_DITHER,
>>>>> +     DDP_COMPONENT_DITHER0,
>>>>>         DDP_COMPONENT_DITHER1,
>>>>>         DDP_COMPONENT_DP_INTF0,
>>>>>         DDP_COMPONENT_DP_INTF1,
