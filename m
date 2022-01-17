Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C5490755
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbiAQLuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbiAQLuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:50:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2D9C061574;
        Mon, 17 Jan 2022 03:50:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g81-20020a1c9d54000000b0034cd1acd9b5so989814wme.1;
        Mon, 17 Jan 2022 03:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qh9qlD7Xxyuod6l2VHcORITt556iH0cP6xXy3RESnzc=;
        b=Mlh7ovtSMXfYuLtZJBDHb8iGlTGgdK+kw1r5kJiXwtkbGmEsnjbmlZKUV5ho5ALXtc
         ErsaGGPcarRlcH0t4J9vPlE7jazy1cyw4hGIdk5wDin+9M1XbOFs7iX0+erqOXDuyLDU
         N13wuTcAslvW26atfDB8z2bt5QcgcQx0NvYODdDPvmJu5WOEdUigB3+CL6bozU4yXHIO
         z5RuHGs7a1T0dgtc9eifrjqDUx3C7Cj1uVvulqDbFgE7j4WbdpSwVcPr5oIJjqyg57+1
         JsTSCgmyV7thCpmP1yut4igRrUJ/m74v/GBfEAf36/FiwfUXtIG2YDJO9iRXKAcSCsHW
         HgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qh9qlD7Xxyuod6l2VHcORITt556iH0cP6xXy3RESnzc=;
        b=iOX4ti44lj69MuTQbgjNq4mVl5bcDUlENfExRpiiyv9ysDRhUKzL2u+mOR0P4wV0sS
         2LFb//a3v4FTAVH3tRcj77p4+BXscTDdkUOOVW9327aDbBwo8eU+T+fckc7Y1fOI1lGg
         GPoPkQ+p7NmC+Hf65Tbeydm7pFpHMI8LP+FQcZvbtg1IYO69FjCbkJEnJlj6EAKmIs+p
         gHHRaYd7sPucrZ+zmC2dc1AR4xnsEEGzRSf6geyLxcuQf1IgVGHtxMu/uc4ouuEh0/fh
         JvFZ2SaWI3nz05QoQV8sPSLQUcKvoZB8GGasXD7jCCv38rDlVVro7RtUhE7LjV8avePU
         HcGg==
X-Gm-Message-State: AOAM532r0OntNu2o50mAZGTfjEEUcov8QmTzl6bJYbAUr+8fn4nOm0Yg
        R4d22Da8lybdbUpwwIAHjmY=
X-Google-Smtp-Source: ABdhPJxnzn9RYFSiRwIN27xe7uwz9Ej9yjcj/6lztBm/AGx+ZaPHnqv2QULOgW5amVoWsoNmN1+5pg==
X-Received: by 2002:a5d:453a:: with SMTP id j26mr15627235wra.348.1642420199348;
        Mon, 17 Jan 2022 03:49:59 -0800 (PST)
Received: from [192.168.0.14] ([37.223.145.74])
        by smtp.gmail.com with ESMTPSA id n7sm13895148wms.46.2022.01.17.03.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 03:49:58 -0800 (PST)
Message-ID: <c8fc24a2-9ee3-75a2-0928-95a217d9dfdf@gmail.com>
Date:   Mon, 17 Jan 2022 12:49:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v10 00/13] Clean up "mediatek,larb"
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Joerg Roedel <jroedel@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>, anan.sun@mediatek.com,
        yi.kuo@mediatek.com, acourbot@chromium.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        anthony.huang@mediatek.com,
        Frank Wunderlich <frank-w@public-files.de>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com
References: <20220117070510.17642-1-yong.wu@mediatek.com>
 <06e5e76c-557a-20a5-b8dd-37b25b3384a3@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <06e5e76c-557a-20a5-b8dd-37b25b3384a3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/01/2022 11:27, AngeloGioacchino Del Regno wrote:
> Il 17/01/22 08:04, Yong Wu ha scritto:
>> MediaTek IOMMU block diagram always like below:
>>
>>          M4U
>>           |
>>      smi-common
>>           |
>>    -------------
>>    |         |  ...
>>    |         |
>> larb1     larb2
>>    |         |
>> vdec       venc
>>
>> All the consumer connect with smi-larb, then connect with smi-common.
>>
>> When the consumer works, it should enable the smi-larb's power which also
>> need enable the smi-common's power firstly.
>>
>> Thus, Firstly, use the device link connect the consumer and the
>> smi-larbs. then add device link between the smi-larb and smi-common.
>>
>> After adding the device_link, then "mediatek,larb" property can be removed.
>> the iommu consumer don't need call the mtk_smi_larb_get/put to enable
>> the power and clock of smi-larb and smi-common.
>>
>> Base on the media branch [1] and a jpeg dtbinding patchset[2] that already got
>> the necessary R-b.
>>
>> [1] git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.18d
>> [2] 
>> https://lore.kernel.org/linux-mediatek/20211206130425.184420-1-hsinyi@chromium.org/ 
>>
>>
>> Change notes:
>> v10: a) Rebase on the media tree. Respin the "media: mtk-vcodec:" patches.
>>       b) Add Joerg's Ack for iommu patches.
>>
>> v9: 
>> https://lore.kernel.org/linux-mediatek/20211112105509.12010-1-yong.wu@mediatek.com/ 
>>
>>      1) Add return -ENODEV when the dev is null.
>>      2) Add more strict about the case that a iommu consume device use the 
>> ports in
>>      different larbs. Don't allow this case.
>>      3) Remove two codec interface: mtk_vcodec_release_enc/dec_pm since it 
>> only has one
>>      line now.
>>
>> v8: 
>> https://lore.kernel.org/linux-mediatek/20210929013719.25120-1-yong.wu@mediatek.com/ 
>>
>>      1) Rebase on v5.15-rc1.
>>      2) Don't rebase the below mdp patchset that may still need more discuss.
>>      
>> https://lore.kernel.org/linux-mediatek/20210709022324.1607884-1-eizan@chromium.org/ 
>>
>>      3) Add Frank's Tested-by. Remove Dafna's Tested-by as he requested.
>>
>> v7: 
>> https://lore.kernel.org/linux-mediatek/20210730025238.22456-1-yong.wu@mediatek.com/ 
>>
>>      1) Fix a arm32 boot fail issue. reported from Frank.
>>      2) Add a return fail in the mtk drm. suggested by Dafna.
>>
>> v6: 
>> https://lore.kernel.org/linux-mediatek/20210714025626.5528-1-yong.wu@mediatek.com/ 
>>
>>      1) rebase on v5.14-rc1.
>>      2) Fix the issue commented in v5 from Dafna and Hsin-Yi.
>>      3) Remove the patches about using pm_runtime_resume_and_get since they have
>>         already been merged by other patches.
>>
>> v5: 
>> https://lore.kernel.org/linux-mediatek/20210410091128.31823-1-yong.wu@mediatek.com/ 
>>
>>      1) Base v5.12-rc2.
>>      2) Remove changing the mtk-iommu to module_platform_driver patch, It have 
>> already been a
>>      independent patch.
>>
>> v4: 
>> https://lore.kernel.org/linux-mediatek/1590826218-23653-1-git-send-email-yong.wu@mediatek.com/ 
>>
>>      base on v5.7-rc1.
>>    1) Move drm PM patch before smi patchs.
>>    2) Change builtin_platform_driver to module_platform_driver since we may need
>>       build as module.
>>    3) Rebase many patchset as above.
>>
>> v3: 
>> https://lore.kernel.org/linux-iommu/1567503456-24725-1-git-send-email-yong.wu@mediatek.com/ 
>>
>>      1) rebase on v5.3-rc1 and the latest mt8183 patchset.
>>      2) Use device_is_bound to check whether the driver is ready from Matthias.
>>      3) Add DL_FLAG_STATELESS flag when calling device_link_add and explain the
>>     reason in the commit message[3/14].
>>      4) Add a display patch[12/14] into this series. otherwise it may affect
>>     display HW fastlogo even though it don't happen in mt8183.
>> v2: 
>> https://lore.kernel.org/linux-iommu/1560171313-28299-1-git-send-email-yong.wu@mediatek.com/ 
>>
>>     1) rebase on v5.2-rc1.
>>     2) Move adding device_link between the consumer and smi-larb into
>> iommu_add_device from Robin.
>>     3) add DL_FLAG_AUTOREMOVE_CONSUMER even though the smi is built-in from Evan.
>>     4) Remove the shutdown callback in iommu.
>>
>> v1: 
>> https://lore.kernel.org/linux-iommu/1546318276-18993-1-git-send-email-yong.wu@mediatek.com/ 
>>
>>
>> Yong Wu (12):
>>    dt-binding: mediatek: Get rid of mediatek,larb for multimedia HW
>>    iommu/mediatek-v1: Free the existed fwspec if the master dev already
>>      has
>>    iommu/mediatek: Return ENODEV if the device is NULL
>>    iommu/mediatek: Add probe_defer for smi-larb
>>    iommu/mediatek: Add device_link between the consumer and the larb
>>      devices
>>    media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
>>    media: mtk-mdp: Get rid of mtk_smi_larb_get/put
>>    drm/mediatek: Get rid of mtk_smi_larb_get/put
>>    media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
>>    memory: mtk-smi: Get rid of mtk_smi_larb_get/put
>>    arm: dts: mediatek: Get rid of mediatek,larb for MM nodes
>>    arm64: dts: mediatek: Get rid of mediatek,larb for MM nodes
>>
>> Yongqiang Niu (1):
>>    drm/mediatek: Add pm runtime support for ovl and rdma
>>
>>   .../display/mediatek/mediatek,disp.txt        |  9 ----
>>   .../media/mediatek,vcodec-decoder.yaml        |  7 ---
>>   .../media/mediatek,vcodec-encoder.yaml        |  8 ----
>>   .../bindings/media/mediatek-jpeg-decoder.yaml |  9 ----
>>   .../bindings/media/mediatek-jpeg-encoder.yaml |  9 ----
>>   .../bindings/media/mediatek-mdp.txt           |  8 ----
>>   arch/arm/boot/dts/mt2701.dtsi                 |  2 -
>>   arch/arm/boot/dts/mt7623n.dtsi                |  5 ---
>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi      | 16 -------
>>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  6 ---
>>   drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  8 +++-
>>   drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |  9 +++-
>>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c       | 15 ++++---
>>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   | 36 +--------------
>>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |  1 -
>>   drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  5 +--
>>   drivers/iommu/mtk_iommu.c                     | 34 ++++++++++++++
>>   drivers/iommu/mtk_iommu_v1.c                  | 42 ++++++++++++++++-
>>   .../media/platform/mtk-jpeg/mtk_jpeg_core.c   | 45 +------------------
>>   .../media/platform/mtk-jpeg/mtk_jpeg_core.h   |  2 -
>>   drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 40 -----------------
>>   drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  2 -
>>   drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  1 -
>>   .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  |  2 -
>>   .../platform/mtk-vcodec/mtk_vcodec_dec_hw.c   |  1 -
>>   .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 41 +++--------------
>>   .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
>>   .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
>>   .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  2 -
>>   .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 45 +++----------------
>>   drivers/memory/mtk-smi.c                      | 14 ------
>>   include/soc/mediatek/smi.h                    | 20 ---------
>>   32 files changed, 115 insertions(+), 333 deletions(-)
>>
> 
> Hello Hans, Matthias,
> on my side, this series is totally ready for merge, hence, green light from here.
> 
> Can you please take it for 5.18?
> 

@Hans: I understand you take the series through your tree. Please let me know 
when you do so. I'll take care of patch 12 and 13, which should go through my tree.

Thanks!
Matthias
