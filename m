Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214F648DB66
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiAMQKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiAMQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:10:21 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED18C061574;
        Thu, 13 Jan 2022 08:10:21 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so2693708wmb.1;
        Thu, 13 Jan 2022 08:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SPmaJub/jt94ihGwagtrfHtir8UBrBvypTKNKojeyrA=;
        b=BVBB+Qut1wf0yDLs2pgabC7QOG2Sq+20jm8ssrux8M/cL6yIEQ1cLoONRsJ3tAFOB7
         mAVtexOZomadjCBu5HS3//ck38nB8thHf4Vsb7B2Gu4SmYo1PXrWLt2A/RhTYRAs6chT
         A2yuc9kt7p1baJ7py4FCWgs7rw24L85tVk/4W8LVfElgZ03rT963kaaa4VkbN1DiwUXJ
         qnZsvby+F23F9gT8jaP+rJib0mnv6iej7oPfza94pno6s+bMVe/moC6XsPcGH0KE1brn
         /SZzMZYnKFEdbiVSWGxvCwwKgWv2AzgqwSWAiyOixbcDRB9AlAXLXpExApLKl7EkW3Oy
         FPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SPmaJub/jt94ihGwagtrfHtir8UBrBvypTKNKojeyrA=;
        b=dQ9gccG12CqSEiKpACY/C7PlAQsCRfgUwgp+Bteq+i+dB7o5j5Ri4KT5fI+opJurTs
         PdHFowPUowmxG3eMVriz8esY88HfXtcT28LAN9uei6Myj+AdnFiK475ryG0TQ1Tpl97I
         ON3MJeNOGiRohnUnGiItUnOXcmz6MM6kj8OJkBZORxEHGnQdglk0rTGmKUGtjQdQ9wwj
         NANXyilOXCc7MIU6sV+UroMbd28xbzkzPHKl5/uuUlnHMGmaV9eDIyRs+uvc/24lSkon
         vU9YOr0AczNd3q9g+Fcl2vyKZYnHGntE/CjKZjB1eGARHaUszPn+A7+1E/WGWwAPUZVr
         l9tA==
X-Gm-Message-State: AOAM5303p1AsrO0DFLP1dLf9K8sPyg08jhuFkew6mhKnwh26ZHhhO5At
        39qBRm93aYtSsk82PmWs+nc=
X-Google-Smtp-Source: ABdhPJz71D45GcRwagirhvSlyWM52OERaCgTDonsBE7CR9XIAMLCsE2GIYUK2N2X+W/NKuR3LQ9Flg==
X-Received: by 2002:a1c:7316:: with SMTP id d22mr11718665wmb.5.1642090219767;
        Thu, 13 Jan 2022 08:10:19 -0800 (PST)
Received: from [192.168.0.18] (81.172.62.207.dyn.user.ono.com. [81.172.62.207])
        by smtp.gmail.com with ESMTPSA id f8sm9488614wmg.3.2022.01.13.08.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 08:10:19 -0800 (PST)
Message-ID: <e940d705-2057-4d5e-0a21-8464ca04caaf@gmail.com>
Date:   Thu, 13 Jan 2022 17:10:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v9 12/15] media: mtk-vcodec: enc: Remove
 mtk_vcodec_release_enc_pm
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org, yf.wang@mediatek.com,
        anthony.huang@mediatek.com, youlin.pei@mediatek.com,
        Irui Wang <irui.wang@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, mingyuan.ma@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>, libo.kang@mediatek.com,
        yi.kuo@mediatek.com, linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>, anan.sun@mediatek.com,
        srv_heupstream@mediatek.com, acourbot@chromium.org,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
        Robin Murphy <robin.murphy@arm.com>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
 <20211112105509.12010-13-yong.wu@mediatek.com>
 <68c3a573-8453-38e9-93b2-2067bedcd06f@collabora.com>
 <4bd9e849-96dd-6f1c-2841-979459366ee5@collabora.com>
 <fa9b2b73-c6bb-5737-93ac-ba2ab6b3b771@xs4all.nl>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <fa9b2b73-c6bb-5737-93ac-ba2ab6b3b771@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 13/01/2022 11:15, Hans Verkuil wrote:
> On 13/01/2022 11:11, AngeloGioacchino Del Regno wrote:
>> Il 11/01/22 11:57, AngeloGioacchino Del Regno ha scritto:
>>> Il 12/11/21 11:55, Yong Wu ha scritto:
>>>> After this patchset, mtk_vcodec_release_enc_pm has only one line.
>>>> then remove that function, use pm_runtime_disable instead.
>>>>
>>>> meanwhile, mtk_vcodec_init_enc_pm only operate for the clocks,
>>>> rename it from the _pm to _clk.
>>>>
>>>> No functional change.
>>>>
>>>> CC: Tiffany Lin <tiffany.lin@mediatek.com>
>>>> CC: Irui Wang <irui.wang@mediatek.com>
>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>
>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>
>>
>> Hello Yong,
>> the mtk-vcodec patches were merged in Yunfei's vcodec patch series and Hans has
>> scheduled that for v5.18.
>>
>> Can you please send a v10 and drop patches 10/15, 11/15, 12/15 (all of the
>> media: mtk-vcodec: *) from this series?
>>
>> For the records, I think that after sending v10 this series is ready to be merged,
>> as it was well reviewed and also tested on many MTK platforms.
> 
> Good to know. When I have the v10 I'll try to prioritize reviewing it and running
> my usual tests.
> 
> Yong, please make sure you run 'checkpatch.pl --strict' over the v10 patches and fix
> any issues (using common sense).
> 

Can you please take me in the look when you take the patches. I'll take the DTS 
related as soon as you queue up the others.

Thanks!
Matthias

> Regards,
> 
> 	Hans
> 
>>
>> Thank you,
>> - Angelo
> 
