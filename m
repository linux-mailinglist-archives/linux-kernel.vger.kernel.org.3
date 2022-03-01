Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448204C8ED5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiCAPUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiCAPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:20:48 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9743E0EB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:20:06 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r65so95691wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 07:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RNJbl7QnMaZHEdtpLJkjMDRJiXx7D4kOmJTqeX5y70k=;
        b=q6E+iU2XlbDNXAYZWnPf50rPIht37/jkRm9royBk+AJcyVqBTb7Gt5ZuvGjzfqqCqe
         z793MVf2Aii7E4//Sj1HqjL0IRC9pwaJFXYUNhaHxZVspnEupnzo5s75huu3UWjJQZzp
         0gFECRKA36n05FCgtpCSNWbwliO7n3JvuDMLuVt4V0GIp4jMlcfFbSO4c7K0OJHlPgad
         7XQjONpB+QCS4wPIjYsM7tCcRdOLXkKyQ5pLukc2n104OTVxMyJQH18b3tblCv75F2v7
         Bfg8wZYzZ441ndUowrrFvoAUGFWWJKQ0/q3MALwdQqkL90Iql5mJ/H5zVzzTLbVr7S2E
         fq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RNJbl7QnMaZHEdtpLJkjMDRJiXx7D4kOmJTqeX5y70k=;
        b=Kuk4BxhEU/2r6hZ9eBC3gAEXpfcr8m1nbHYH+UxpD12P816sOuprztz6z39Oacdw53
         EsJ1tt1/KGSIQMbv4/jZTTZ6/vGLipOsbgqGuUQSvu2jD71UrrX2GaRsihMpGZumjge7
         2rIND3IYSq8Wx27hbXbZ0rjOaQ58mPryOtEmk+bizyq/0UYRva6wXRWs4dq1KGhX91kW
         GThJK2WLoGnWXyVsovstXS88mPiTuLoXgSNdx0touT2MMNTcn6bRP4DIlzXmAruGStX5
         mP3D1AXSii6ek5QcjrcLHM3Us20DDVKlin6g4wnn4GbN8hPUFqytOPl+QsOJN18KyBXw
         +PcA==
X-Gm-Message-State: AOAM533LuoJ+LhZwFYsGq1chYel1KpZypTmgEyV4oYBpGnM7KyZPN4n2
        JlhGH2xp4zzlBPb5eaJGlHs=
X-Google-Smtp-Source: ABdhPJwwHoAsmZ8g/+CJWiQlouGQfJxCYoXkWtii8W5cSPPbm9HFKETEu0x/vVOeb/Mc9HZbavaSiw==
X-Received: by 2002:a05:600c:19cf:b0:381:7ab1:46ef with SMTP id u15-20020a05600c19cf00b003817ab146efmr6053227wmq.104.1646148005388;
        Tue, 01 Mar 2022 07:20:05 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u4-20020adfdb84000000b001e8d8ac5394sm14714533wri.110.2022.03.01.07.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 07:20:04 -0800 (PST)
Message-ID: <53df3112-869c-e05c-4b6e-0c6db60a536d@gmail.com>
Date:   Tue, 1 Mar 2022 16:20:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2,0/2] Add mmsys reset control for MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     chunkuang.hu@kernel.org, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220217082626.15728-1-rex-bc.chen@mediatek.com>
 <09ce5aab-0cc6-5903-8238-551085abd739@gmail.com>
 <31507af7c67640fa8161b13a4f279fea1a050f55.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <31507af7c67640fa8161b13a4f279fea1a050f55.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rex,

On 01/03/2022 12:13, Rex-BC Chen wrote:
> Hello Matthias,
> 
> Thanks for accepting my patches, but I didn't see this patch [1]
> in v5.17-next/soc.
> There will be build error if [1] is not included while [2] is applied.
> The sw0_rst_offset is declared in [2].
> 
> If I have mistake, please let me know.

Thanks for the info. That was actually my mistake. Should be fixed by now.

Thanks a lot!
Matthias

> Thanks!
> 
> [1]:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220217082626.15728-2-rex-bc.chen@mediatek.com/
> 
> [2]:
> https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.17-next/soc&id=831785f0e5b919c29e1bc5f9a74e9ebd38289e24
> 
> BRs,
> Rex
> On Tue, 2022-03-01 at 08:35 +0100, Matthias Brugger wrote:
>>
>> On 17/02/2022 09:26, Rex-BC Chen wrote:
>>> v2:
>>> 1. Change variable type from unsigned int to u16.
>>>
>>> v1:
>>> 1. Add a new variable in mmsys driver data to control different
>>> register
>>>      offset for different SoCs.
>>> 2. Add MT8183 reset register offset.
>>> 3. Add mmsys reset control for MT8186.
>>>
>>> This series is based on mmsys patch for MT8186 on [1].
>>> [1]:
>>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20220216084831.14883-4-rex-bc.chen@mediatek.com/__;!!CTRNKA9wMg0ARbw!wp2uW6phbST6ySpYRlb7iwmATAVkkCL1JBau9dCwhXj8KRasrAWnLd1EUT9gLE-oF9Yq$
>>>   
>>>
>>> Rex-BC Chen (2):
>>>     soc: mediatek: mmsys: add sw0_rst_offset in mmsys driver data
>>>     soc: mediatek: mmsys: add mmsys reset control for MT8186
>>>
>>>    drivers/soc/mediatek/mt8183-mmsys.h | 2 ++
>>>    drivers/soc/mediatek/mt8186-mmsys.h | 2 ++
>>>    drivers/soc/mediatek/mtk-mmsys.c    | 7 +++++--
>>>    drivers/soc/mediatek/mtk-mmsys.h    | 3 +--
>>>    4 files changed, 10 insertions(+), 4 deletions(-)
>>>
>>
>> Series applied, thanks!
> 
