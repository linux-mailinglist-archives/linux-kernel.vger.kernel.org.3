Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B73554F99
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359285AbiFVPlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359247AbiFVPkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:40:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA392ED76;
        Wed, 22 Jun 2022 08:40:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z9so9465352wmf.3;
        Wed, 22 Jun 2022 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6HvjioZHPtwBf4fSwa9wIuwFcez8I2M80JFO0QJMojs=;
        b=dpZHPTmcfuFjzjJ0Lys34TeMfY59Nf1bKZM5XTxOYpqqCBsl7Y6AhxrXkzb+gPakMK
         FloXTG3essSGnodFfCg3jtPf0tPM+4wamt0q6BPSfR89FBPb/HfsmktFXGDn/eile+Y8
         /yK/eD6l6WjEX6SjenLshLSETc34Dq0GIAUxh5to/GL+FYMWttj7fc3sYov1tPtYCCOR
         dBP/PX7cqo2YrMZAIB7/zxxxT0TtRBoETiX67M1AssNL8bCqTidpwSyWiO3dm0cdg1ES
         JdHLImitJR/7Tnz6Cv6zOWfoqt9Zh8aGFUZVk+pLR7jGoIrbbaB8qllQxWmm2FDQhN5q
         Yt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6HvjioZHPtwBf4fSwa9wIuwFcez8I2M80JFO0QJMojs=;
        b=PA8F2uSqZZooPnDPLKJO+B75lJxoyIxtPni3WDIK3dJI+0Z7boygya/ye/Z+TnfPPt
         mHMu0kDn8yi7Y+tRCYuseEX5jxg0SXDnw6kKlwjgJleo+rEDEzUmr4Ik/QdohVOv3Dg8
         bHRrjJZgfDQ4Z4GV4CcaGfOBuznLSeQZGIJnE6ibgxsGa+KAXK/y8YfKZ7l40oBdfAQB
         47RdJBKZzSvm4O9fNETwz1iHQvE9I/Ud7IsG0I1AHATwruhBEM9NeoozUO1rFL6XINMM
         JU6bJDYwzqxA2CHkz4qEHU44S1NoQZMBc2duaHYqGCYECy5vehY3dlAmRUTGMG+dEDbF
         zLvg==
X-Gm-Message-State: AJIora/USaZmMK+7EboWDXmue9v04GyOGU+YO7eh7cAJVAlRxR8I8VAb
        t9WJJR8w+nCFBMyPWoOvl5Q=
X-Google-Smtp-Source: AGRyM1ulMlpI/C9yUV5vRRJTaw3SQd1l5jIXTUtRosaGOoW6+N4l7XU10IynPKr7U0RVMv8wVfr7bw==
X-Received: by 2002:a7b:c402:0:b0:3a0:2ba7:1fa7 with SMTP id k2-20020a7bc402000000b003a02ba71fa7mr3160994wmi.152.1655912449594;
        Wed, 22 Jun 2022 08:40:49 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.148.38])
        by smtp.gmail.com with ESMTPSA id r64-20020a1c4443000000b003942a244f39sm31645408wma.18.2022.06.22.08.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 08:40:48 -0700 (PDT)
Message-ID: <37fb545a-bc45-65b0-b67b-5ef1b0346777@gmail.com>
Date:   Wed, 22 Jun 2022 17:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v11 0/3] Add basic node support for MediaTek MT8186 SoC
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>, hsinyi@chromium.org
References: <20220520122217.30716-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220520122217.30716-1-allen-kh.cheng@mediatek.com>
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



On 20/05/2022 14:22, Allen-KH Cheng wrote:
> MT8186 is a SoC based on 64bit ARMv8 architecture.
> It contains 6 CA55 and 2 CA76 cores.
> MT8186 share many HW IP with MT65xx series.
> 
> This patchset was tested on MT8186 evaluation board to shell.
> 

Applied, thanks!

> Based on next-20220519, linux-next/master
> 
> changes since v9:
>   - remove some merged PATCHs from series
>   - reorder nodes in dts (cpu-map)
>   - remove okay status in auxadc
>   - remove unnecessary suffix node name for i2c
>   - add pwm node
>   - add dsi-phy node
>   - add dpi node
> 
> changes since v9:
>   - add one space before equal sign of drive-strength-adv
>   - corect compatible name for big cores (ca76)
>   - use upper case of address in pinctrl
>   - add pwrap node
>   - add pwm node
> 
> changes since v8:
>   - change name from pins_bus to pins-sda-scl
>   - correct email address
>   - add capacity-dmips-mhz for each CPU
>   - add ppi-partitions in gic node
>   - change name to power-domain
>   - remove status "okay" in scp node
>   - update timer and pericfg compatible in series
> 
> changes since v7:
>   - add scp&auxadc node
> 
> changes since v6:
>   - remove unnecessary blank line
> 
> changes since v5:
>   - replace Mediatek a to MediaTek
>   - use GPL-2.0-only OR BSD-2-Clause
> 
> changes since v4:
>   - correct driver clock of mt8186
>   - add power domains controller and clock controllers
>   - add pinctrl, usb host, spi and i2c nodes
>   - add node status in mt8186-evb.dts
>   - correct some dtbs_check warnings
> 
> changes since v3:
>   - remove serial, mmc and phy patch from series. (already merged)
>   - remove mcusysoff node
>   - move oscillator nodes at the head of dts
>   - change name from usb-phy to t-phy
> 
> changes since v2:
>   - add soc {} in mt8186.dtsi
> 
> changes since v1:
>   - add dt-bindings: arm: Add compatible for MediaTek MT8186
> 
> Allen-KH Cheng (3):
>    dt-bindings: arm: mediatek: Add mt8186 pericfg compatible
>    dt-bindings: arm: Add compatible for MediaTek MT8186
>    arm64: dts: Add MediaTek SoC MT8186 dts and evaluation board and
>      Makefile
> 
>   .../devicetree/bindings/arm/mediatek.yaml     |    4 +
>   .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
>   arch/arm64/boot/dts/mediatek/Makefile         |    1 +
>   arch/arm64/boot/dts/mediatek/mt8186-evb.dts   |  232 ++++
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 1016 +++++++++++++++++
>   5 files changed, 1254 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi
> 
