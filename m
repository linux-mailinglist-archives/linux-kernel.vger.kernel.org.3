Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E6550BA8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448898AbiDVOvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448896AbiDVOu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:50:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C465C361;
        Fri, 22 Apr 2022 07:48:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bv16so11368059wrb.9;
        Fri, 22 Apr 2022 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kszdO6wU0Mqq85Z4KS0Qv5qQ/jWZuPbQJLH0mbPBngY=;
        b=ckimHfSHANKWUZV3VNpsoUCavtkIeyvi842IphJyJDXHazb6pz6QO69HxtEqvgVPGi
         zumAINHBO2LlvtZM5M/MSFotIgPRrjYEWorlg7qKlvb2lguNYF8A0ktY8sU3TD0MQkV5
         6J1q6l1l2ALaOrpIx0xccDzU+Jti7wY6R6NHPX/xyDl6Nj+kJ6mnqe/4Wppxn4Pub5n4
         mGW7zNZEUp7hFZL2MUIeKS4RmOJvmzlmdud5eGqr4RpxswqyIJKWEyrx2pNiyTD+zmrQ
         YbOwF6caCllB37Wq1zfBi3uSBB1fk56owycsj0buZuZru3OVC9zG3ZkMs+SLRP0OAB+I
         ocTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kszdO6wU0Mqq85Z4KS0Qv5qQ/jWZuPbQJLH0mbPBngY=;
        b=VYeS74LFehmN8X3DMTIzKjYAH5EL2LbZTGstoGmKeeVW/Tqko77g7lOL5TJF6lZYZt
         WNTc2xgHk7UmWaYW2Fx6O0nE3BLlrnlhriUIjt9EmzLmnBcnoIDgtVKppXr3xyz4FyCD
         gbV4jbwgfvLFEGGr7gBFIyjxdllRgx0TNA004tkWgeZb0lVje6oKq/395q/w9FkRar+S
         T3f39eR2Qo2uBCyEmyh+iaL8/z5ePAQaSyWZxacfNJXyP5Zdha9nCcXoR+EjHjFjK4Z+
         RFC1NJ80+AdRk9g5x3EhmP6WJBe1EGqywKzyfyj9NGBYM9NgheeEEbH+kFh95xGM4CSu
         KnFw==
X-Gm-Message-State: AOAM5303tKFWh5JteRt9RGbrPdxdbNz/2p2u/X7VjY76ByU94X4lRTtw
        hUhWc5YX8+gMxa7VWaaPC31sQApLvT1WrA==
X-Google-Smtp-Source: ABdhPJyCKTiS68ltMDOjoqogI8DPaUY5lhMrd/Ldxc9wQ1klvoy7rTcUWwqKZZR1Opu84lCAH6Zg6A==
X-Received: by 2002:a05:6000:2cd:b0:20a:9403:1681 with SMTP id o13-20020a05600002cd00b0020a94031681mr4019160wry.474.1650638883804;
        Fri, 22 Apr 2022 07:48:03 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id w4-20020a7bc104000000b0038eba17a797sm4603969wmi.31.2022.04.22.07.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 07:48:03 -0700 (PDT)
Message-ID: <db89b86f-4b53-db99-8ec5-e4e469b02694@gmail.com>
Date:   Fri, 22 Apr 2022 16:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v14 0/2] Add basic SoC support for mediatek mt8195
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Johnson Wang <johnson.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Henry Chen <henryc.chen@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
References: <20220411022724.11005-1-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220411022724.11005-1-tinghan.shen@mediatek.com>
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



On 11/04/2022 04:27, Tinghan Shen wrote:
> This series adds basic SoC support for Mediatek's SoC MT8195.

Both patches applied to their respective branches.

Thanks!

> 
> ---
> Changes in v14:
>    - update pwrap dt-bindings
>      this patch is picked from 20220411014121.15015-2-zhiyong.tao@mediatek.com
>    - enable u3phy2 and u3phy3 in evb dts
> Changes in v13:
>    - add more description of reg items in mtk-sd.yaml
> Changes in v12:
>    - update mtk-sd.yaml to extend reg property and fix yamllint error
>    - add xhci nodes and move xhci3 property (usb2-lpm-disable) to evb.dts
> Changes in v11:
>    - rebase on 5.17-rc4
> Changes in v10:
>    - clean CC list
> Changes in v9:
>    - remove duplicated cpus dt-bindings patch in v8
> Changes in v8:
>    - v7 mediatek,spi-mtk-nor.yaml patch is applied in branch for-5.17 at
>      kernel/git/broonie/spi.git
>    - v7 pinctrl-mt8195.yaml patch is applied in branch for-next at
>      kernel/git/linusw/linux-pinctrl.git
>    - add cortex-a78 compatible to cpus dt-bindings
>    - add mediatek,drive-strength-adv property to pinctrl dt-bindings
>    - fix evb dts
>      - remove i2c nodes with disabled status from dts
>      - fix pin properties not match pinctrl dt-bindings
>      - remove unnecessary u3port*
>    - fix dtsi
>      - fix node format
>      - reorder oscillator* nodes
>      - fix node name of cpu idle nodes
>      - remove clock-frequency property in the timer node
>      - reorder clock and clock names in usb nodes
> Changes in v7:
>    - refine title of spi-nor dt-bindings patch
>    - refine commit message of pinctrl dt-bindings patch
>    - update pinctrl-mt8195.yaml
>      - change property pattern from 'pins' to '^pins'
>      - update examples with new property in descriptions
>      - add new example
>    - drop '_' from node names of pinctrl subnodes in mt8195-evb.dts
> Changes in v6:
>    - rebase on 5.16-rc1
>    - add new clock name to spi-nor dt-bindings
>    - add "pins" property in pinctrl dt-bindings
>    - fix fails of dtbs_checks
>      - remove "arm,armv8" not matched in yaml from cpu compatile
>      - fix node name of xhci
>      - remvoe xhci upstreaming wakeup properties
>      - remove xhci unused properties address-cells and size-cells
>      - fix node name of ufs-phy
>      - fix node name of spi-nor
>      - fix node name and sub-nodes of pinctrl
>      - fix mmc compatible
> Changes in v5:
>    - enable basic nodes in mt8195-evb.dts
>    - remove dedicated clock nodes
>    - add mmc2 node
>    - fix interrupt number of pinctrl node
>    - update clock nodes to apply internal fixes
>    - add dt-bindings for perficfg node
> 
> v4 thread:
> https://lore.kernel.org/all/20210922093303.23720-2-seiya.wang@mediatek.com/
> v3 thread:
> https://lore.kernel.org/all/20210601075350.31515-2-seiya.wang@mediatek.com/
> v2 thread:
> https://lore.kernel.org/all/20210319023427.16711-10-seiya.wang@mediatek.com/
> v1 thread:
> https://lore.kernel.org/all/20210316111443.3332-11-seiya.wang@mediatek.com/
> ---
> 
> Tinghan Shen (1):
>    arm64: dts: Add mediatek SoC mt8195 and evaluation board
> 
> Zhiyong.Tao (1):
>    dt-bindings: pwrap: mediatek: fix pwrap document for mt8195
> 
>   .../bindings/soc/mediatek/pwrap.txt           |   10 +-
>   arch/arm64/boot/dts/mediatek/Makefile         |    1 +
>   arch/arm64/boot/dts/mediatek/mt8195-evb.dts   |  181 +++
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 1045 +++++++++++++++++
>   4 files changed, 1232 insertions(+), 5 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi
> 
