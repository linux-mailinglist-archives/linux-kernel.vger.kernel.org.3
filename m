Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C455188DD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbiECPq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiECPqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:46:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52FB2E0BA;
        Tue,  3 May 2022 08:42:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b19so23897644wrh.11;
        Tue, 03 May 2022 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XDylvy7QE0kYD97hsx4drglUv8+IINBzIZbB9OPqGXE=;
        b=ZJYwAxzSGuKry0eJEW053CQ3oAluqeMsuTU14GRLW87JrLEj87UUdoPmmw7tk1XGoD
         pCRoW39Vy/AfTPYvcxFrpvSgEn782zg/+C35/mvCs4EueKcWcnFj/gVwUswX5R0UHd6L
         xCmZN/3n2B993Zbm/EaaIMAhGm9S6L7Itjb5q0SonKluuQDklES1idhgBYDpKFNoC/KI
         xWqYCeH7QOXogOLeRs31Mz+PvUW534/PjZDSEJRGGz1IvikdIN+VL0C1+M9ZOczUxbkT
         +lhBMwARAq+YifD+YhSd2ltvLkLpeleVyA71PwXhhrzEAy9Dn6m2YicXWoFGDp4qdbR9
         uOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XDylvy7QE0kYD97hsx4drglUv8+IINBzIZbB9OPqGXE=;
        b=pj2mGpISHwrAIY57A2sg4brt6AikFRL+jRGXOtryqOqETtkTNJJ2j9+NAgsc9rOstN
         B5zRFCwl6mjuUoozpOgLZ6qWez+MegIKR3O1zzBx9epYGIV8arW9XWX+fvFfEEZifkgU
         diAIdi1Xt2TQOB9j6eRflApUEDWVMZn9AxPp6K2nHAJY8ob03Gej+qFqX/CrIkk6xtsT
         iPfCAQGghVrkwk6xnaPVPoguj/1jEib+JUq66U9kNvtJUCCoalKWPz3yE3c9I3SQvJz6
         xW49pAAhubly7YLNYvJa/NnQN0jgB8hoobshePKRws4406MUoTT8qkmWiMqQyhocM7iY
         o2VA==
X-Gm-Message-State: AOAM531o/aFgWMBrPiz6H5YSPrysEcswUYnNZamYcwLsI/ZdV6CmIWP+
        boMZWNoRB8VirIlQTVcWU1A=
X-Google-Smtp-Source: ABdhPJwLLvLMdvhxJHphyb/0OfT7WhR6rKov3KwUfnfYP9M4/JSvhMG6BrphlKUfnuLfVwFUtofWKQ==
X-Received: by 2002:a05:6000:381:b0:20c:5e07:f75f with SMTP id u1-20020a056000038100b0020c5e07f75fmr5977802wrf.678.1651592569137;
        Tue, 03 May 2022 08:42:49 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id s8-20020adfa288000000b0020c6b78eb5asm3971282wra.68.2022.05.03.08.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 08:42:48 -0700 (PDT)
Message-ID: <b82985d5-984b-4de7-35f2-57b2085d9dc7@gmail.com>
Date:   Tue, 3 May 2022 17:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 00/36] MT8195 and MT8186 IOMMU SUPPORT
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com
References: <20220503071427.2285-1-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220503071427.2285-1-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/05/2022 09:13, Yong Wu wrote:
> This patchset adds MT8195 and MT8186 iommu support.
> 
> MT8195 have 3 IOMMU HWs. 2 IOMMU HW is for multimedia, and 1 IOMMU HW is
> for infra-master, like PCIe/USB.
> 
> About the 2 MM IOMMU HW, something like this:
> 
>          IOMMU(VDO)          IOMMU(VPP)
>             |                   |
>        SMI_COMMON(VDO)      SMI_COMMON(VPP)
>        ---------------     ----------------
>        |      |   ...      |      |     ...
>      larb0 larb2  ...    larb1 larb3    ...
> 
> these two MM IOMMU HW share a pgtable.
> 
> About the INFRA IOMMU, it don't have larbs, the master connects the iommu
> directly. It use a independent pgtable.
> 
> Also, mt8195 IOMMU bank supports. Normally the IOMMU register size only
> is 0x1000. In this IOMMU HW, the register size is 5 * 0x1000. each 0x1000
> is a bank. the banks' register look like this:
>       ----------------------------------------
>       |bank0  | bank1 | bank2 | bank3 | bank4|
>       ----------------------------------------
>       |global |
>       |control|         null
>       |regs   |
>       -----------------------------------------
>       |bank   |bank   |bank   |bank   |bank   |
>       |regs   |regs   |regs   |regs   |regs   |
>       |       |       |       |       |       |
>       -----------------------------------------
> All the banks share some global control registers, and each bank have its
> special bank registers, like pgtable base register, tlb operation registers,
> the fault status registers.
>   
> In mt8195, we enable this bank feature for infra iommu, We put PCIe in bank0
> and USB in bank4. they have independent pgtable.
> 
> MT8186 is based on MT8195, it just has two patches.
> 
> Change note:
> v7: 1) Update the changes from Matthias. like add a new function for readability.
>      2) Add mt8186 into this patchset, It may be helpful for maintainer to apply.

For the whole series:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> 
> v6: https://lore.kernel.org/linux-iommu/20220407075726.17771-1-yong.wu@mediatek.com/
>      Rebase on v5.18-rc1.
> 
> v5: https://lore.kernel.org/linux-iommu/20220217113453.13658-1-yong.wu@mediatek.com
>     1) Base on next-20220216
>     2) Remove a patch for kmalloc for protect buffer. keep the kzalloc for it.
>     3) minor fix from AngeloGioacchino, like rename the error label name
>     (data_unlock to err_unlock).
>     Note, keep the TODO for component compare_of[26/34].
> 
> v4: https://lore.kernel.org/linux-iommu/20220125085634.17972-1-yong.wu@mediatek.com/
>     1) Base on v5.16-rc1
>     2) Base on tlb logic 2 patchset, some patches in v3 has already gone
>     through that patchset.
>     3) Due to the unreadable union for v1/v2(comment in 26/33 of v3), I
>     separate mtk_iommu_data for v1 and v2 totally, then remove mtk_iommu.h.
>     please see patch[26/35][27/35].
>     4) add two mutex for the internal data. patch[6/35][7/35].
>     5) add a new flag PM_CLK_AO.
> 
> v3: https://lore.kernel.org/linux-mediatek/20210923115840.17813-1-yong.wu@mediatek.com/
>      1) base on v5.15-rc1
>      2) Adjust devlink with smi-common, not use the property(sub-sommon).
>      3) Adjust tlb_flush_all flow,
>         a) Fix tlb_flush_all only is supported in bank0.
>         b) add tlb-flush-all in the resume callback.
>         c) remove the pm status checking in tlb-flush-all.
>         The reason are showed in the commit message.
>      4) Allow IOMMU_DOMAIN_UNMANAGED since PCIe VFIO use that.
>      5) Fix a clk warning and a null abort when unbind the iommu driver.
> 
> v2: https://lore.kernel.org/linux-mediatek/20210813065324.29220-1-yong.wu@mediatek.com/
>      1) Base on v5.14-rc1.
>      2) Fix build fail for arm32.
>      3) Fix dt-binding issue from Rob.
>      4) Fix the bank issue when tlb flush. v1 always use bank->base.
>      5) adjust devlink with smi-common since the node may be smi-sub-common.
>      6) other changes: like reword some commit message(removing many
>         "This patch..."); seperate serveral patches.
> 
> v1: https://lore.kernel.org/linux-mediatek/20210630023504.18177-1-yong.wu@mediatek.com/
>      Base on v5.13-rc1
> 
> Yong Wu (36):
>    dt-bindings: mediatek: mt8195: Add binding for MM IOMMU
>    dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
>    dt-bindings: mediatek: mt8186: Add binding for MM iommu
>    iommu/mediatek: Fix 2 HW sharing pgtable issue
>    iommu/mediatek: Add list_del in mtk_iommu_remove
>    iommu/mediatek: Remove clk_disable in mtk_iommu_remove
>    iommu/mediatek: Add mutex for m4u_group and m4u_dom in data
>    iommu/mediatek: Add mutex for data in the mtk_iommu_domain
>    iommu/mediatek: Adapt sharing and non-sharing pgtable case
>    iommu/mediatek: Add 12G~16G support for multi domains
>    iommu/mediatek: Add a flag DCM_DISABLE
>    iommu/mediatek: Add a flag STD_AXI_MODE
>    iommu/mediatek: Remove the granule in the tlb flush
>    iommu/mediatek: Always enable output PA over 32bits in isr
>    iommu/mediatek: Add SUB_COMMON_3BITS flag
>    iommu/mediatek: Add IOMMU_TYPE flag
>    iommu/mediatek: Contain MM IOMMU flow with the MM TYPE
>    iommu/mediatek: Adjust device link when it is sub-common
>    iommu/mediatek: Allow IOMMU_DOMAIN_UNMANAGED for PCIe VFIO
>    iommu/mediatek: Add a PM_CLK_AO flag for infra iommu
>    iommu/mediatek: Add infra iommu support
>    iommu/mediatek: Add PCIe support
>    iommu/mediatek: Add mt8195 support
>    iommu/mediatek: Only adjust code about register base
>    iommu/mediatek: Just move code position in hw_init
>    iommu/mediatek: Separate mtk_iommu_data for v1 and v2
>    iommu/mediatek: Remove mtk_iommu.h
>    iommu/mediatek-v1: Just rename mtk_iommu to mtk_iommu_v1
>    iommu/mediatek: Add mtk_iommu_bank_data structure
>    iommu/mediatek: Initialise bank HW for each a bank
>    iommu/mediatek: Change the domid to iova_region_id
>    iommu/mediatek: Get the proper bankid for multi banks
>    iommu/mediatek: Initialise/Remove for multi bank dev
>    iommu/mediatek: Backup/restore regsiters for multi banks
>    iommu/mediatek: mt8195: Enable multi banks for infra iommu
>    iommu/mediatek: Add mt8186 iommu support
> 
>   .../bindings/iommu/mediatek,iommu.yaml        |  24 +-
>   drivers/iommu/mtk_iommu.c                     | 974 +++++++++++++-----
>   drivers/iommu/mtk_iommu.h                     | 101 --
>   drivers/iommu/mtk_iommu_v1.c                  | 235 +++--
>   .../dt-bindings/memory/mt8186-memory-port.h   | 217 ++++
>   .../dt-bindings/memory/mt8195-memory-port.h   | 408 ++++++++
>   include/dt-bindings/memory/mtk-memory-port.h  |   2 +
>   7 files changed, 1485 insertions(+), 476 deletions(-)
>   delete mode 100644 drivers/iommu/mtk_iommu.h
>   create mode 100644 include/dt-bindings/memory/mt8186-memory-port.h
>   create mode 100644 include/dt-bindings/memory/mt8195-memory-port.h
> 
