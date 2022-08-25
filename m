Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EBB5A14DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbiHYOwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiHYOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:52:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A88B515B;
        Thu, 25 Aug 2022 07:52:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h5so24142039wru.7;
        Thu, 25 Aug 2022 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=EuJPtoYgjjN5/e0jyvbLMFRYdN9rtOzOfHKRxWyYoBU=;
        b=eg7BC7KjISFyUh8Fm26l56dTvHw7nfA0x7+7uYfoLZ4Dyk6v88U+OAMc9JIripiW4H
         E8Rnc+Tq5whRFWEewjB8GSe+zjUlUbwJ49gkVu4T+6S35u+S2RoD+QFM4+XYL6b1ombc
         PYGGjlcqmZrIxw8GD3Jj5qN3+60Su5jPaLNjZmE9BXRM+TGBTVNrPtQWiKLOam6OwaqB
         bIiCXfHjH9O/kbBUrEYy0bwGcCBhz2UZ/IzCkG1RApHHhMhLUlX4cja/VgIyIMpdVE9Y
         51S7IwNis/iWsX/XLc/uRkXUn2FPVITfB6IL1MaHfxJyu4Z9CNppmAQGj7a1isZqh4Or
         vGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EuJPtoYgjjN5/e0jyvbLMFRYdN9rtOzOfHKRxWyYoBU=;
        b=P1116+FiRPiCchp6tJb06bEf6OVMiwrxcVzImpdrUVxuDG2aXWDcqUdyMxc6PG3in1
         QEdSGYi66wLbUfkQEpR6EU/WzuRdN7TBT4mICvWdrNk6ir1BCssByR+65dmIxYEMr1Lb
         x4VSnOZB02YNJrQhenE/8YQi19pn2yarcuuyfac9Mf3XiY8pyXT7AfO8E4OTUz0DgZUk
         Tmg1SrjILL996MdwqiDnKFpOp8P3s2KSpiWip4ywDuVC92QPH1nLknCLpM1QqWkCg5Jr
         zyhNp1O2uXrspyn/aRE8+dYD5eWh7INO7Fj/qNOnLGmlKTCQ5gAb4ywTyxf0wha82DyK
         RPhQ==
X-Gm-Message-State: ACgBeo3OFnHY0L0vWYAOr3Sac9D16vtshdLoAcDO6yhi33oeRCnfgjij
        +s1FXheVlpMSjKrdaukNyDQ=
X-Google-Smtp-Source: AA6agR5xjrDrbHwGtRMFWO2CBXbtGRrUyxMfRYWrcPVy4NZm6akviQOSxZVXcpH40iI9WsgKXmA9xQ==
X-Received: by 2002:a05:6000:1d82:b0:220:5f9b:9a77 with SMTP id bk2-20020a0560001d8200b002205f9b9a77mr2511169wrb.622.1661439166564;
        Thu, 25 Aug 2022 07:52:46 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d5907000000b00220592005edsm19918911wrd.85.2022.08.25.07.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:52:45 -0700 (PDT)
Message-ID: <e48c22e9-3fa6-2d26-4829-77b7fb737da5@gmail.com>
Date:   Thu, 25 Aug 2022 16:52:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v6 00/20] Add driver nodes for MT8195 SoC
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220811025813.21492-1-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220811025813.21492-1-tinghan.shen@mediatek.com>
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



On 11/08/2022 04:57, Tinghan Shen wrote:
> Add driver nodes for MT8195 SoC.
> 

Applied 7-20 of this series.
Patches 3-5 were taken from v4 by accident but AFAICS didn't change.

Thanks,
Matthias

> ---
> v5 -> v6:
>    - rebased on linux-next/next-20220809
>    - update the if/else condition comment in iommu.yaml
>    - some v5 patches are corrupted caused by extra line wrapping
> 
> v4 -> v5:
>    - rebased on linux-next/next-20220802
>    - fix indentation in scpsys.yaml
>    - rewrite if/else condition for infra iommu in iommu.yaml
>    - remove unused clock from infra iommu node
> 
> v3 -> v4:
>    - remove unit address of power-controller node name from v3 scpsys bindings
>    - v3 patchset 7 and v3 patchset 6 are combined as v4 patchset 6
>    - add more commit descriptions for updating mt81xx scpsys node
> 
> v2 -> v3:
>    - fix dsp node name
>    - add descriptions for iommu interrupts
>    - limit the levels of power domain nodes
>    - update maintainer list of power controller yaml
>    - support naming power controller node with unit address
>    - add SoC specific compatible string to scpsys yaml
> 
> v1 -> v2:
>    - add new dt-bindings: mfd/mediatek,scpsys.yaml
>      - update compatible string for mt81xx scpsys nodes
>    - apply comments for yaml files: iommu, smi-common, and power-controller
>    - apply comments for dts nodes: power domain, vdosys0.
>    - apply comments for commit message of watchdog, i2c, and smi-common.
>    - add review-by tags
> 
> ---
> Jason-JH.Lin (2):
>    arm64: dts: mt8195: Add gce node
>    arm64: dts: mt8195: Add display node for vdosys0
> 
> Tinghan Shen (14):
>    dt-bindings: iommu: mediatek: Increase max interrupt number
>    dt-bindings: memory: mediatek: Update condition for mt8195 smi node
>    dt-bindings: power: mediatek: Refine multiple level power domain nodes
>    dt-bindings: power: mediatek: Support naming power controller node
>      with unit address
>    dt-bindings: power: mediatek: Update maintainer list
>    dt-bindings: power: mediatek: Add bindings for MediaTek SCPSYS
>    arm64: dts: mediatek: Update mt81xx scpsys node to align with
>      dt-bindings
>    arm64: dts: mt8195: Disable watchdog external reset signal
>    arm64: dts: mt8195: Add vdosys and vppsys clock nodes
>    arm64: dts: mt8195: Add power domains controller
>    arm64: dts: mt8195: Add spmi node
>    arm64: dts: mt8195: Add scp node
>    arm64: dts: mt8195: Add audio related nodes
>    arm64: dts: mt8195: Add iommu and smi nodes
> 
> Trevor Wu (1):
>    arm64: dts: mt8195: Specify audio reset controller
> 
> Tzung-Bi Shih (1):
>    arm64: dts: mt8195: Disable I2C0 node
> 
> YC Hung (1):
>    arm64: dts: mt8195: Add adsp node and adsp mailbox nodes
> 
> YT Lee (1):
>    arm64: dts: mt8195: Add cpufreq node
> 
>   .../bindings/iommu/mediatek,iommu.yaml        |   29 +-
>   .../mediatek,smi-common.yaml                  |   11 +-
>   .../bindings/mfd/mediatek,mt8195-scpsys.yaml  |   67 ++
>   .../power/mediatek,power-controller.yaml      |  137 +--
>   arch/arm64/boot/dts/mediatek/mt8167.dtsi      |    3 +-
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi      |    3 +-
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      |    3 +-
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi      |    3 +-
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 1054 ++++++++++++++++-
>   9 files changed, 1176 insertions(+), 134 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> 
