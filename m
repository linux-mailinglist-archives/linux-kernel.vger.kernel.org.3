Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41321587B71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiHBLQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiHBLQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:16:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4090100;
        Tue,  2 Aug 2022 04:16:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bk11so7618423wrb.10;
        Tue, 02 Aug 2022 04:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=A2VfX0ohBEDI9pdacm9qg39DqZbTOcJ97Tvbb0ay7PA=;
        b=VEUHFtoWx1hsRT9yABC0bQ31nr/6iVyFPY07sKhk+zGOtFoAr032aVFnqJhsw8mIgM
         wo6+VbjXn94MA/HZ4zfb1Ts7PpY5VPW0MAOAlkpSFfHBWBZhnsrMsxRbQriOkylatqfs
         Dni8FpGvml5Rd/s0777eugW09N3nOd+IQTNMgFFrOpmR76tqEYoAAM8c1qIdIle0Us8+
         Zb79FKXDzoY2NE8xLMlrc/veUgICeLtdzZpvKpJuyITsrwj6P2TizZ2tuXuL4IuzGeIB
         WwIOodMTV6ZWwzzShjrFILwwZIl0zQarB4il5LwD644ZSbszNbpVPRCMuOyFi1dtONtP
         roqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=A2VfX0ohBEDI9pdacm9qg39DqZbTOcJ97Tvbb0ay7PA=;
        b=yvVAC0XqIz3tIpWudrrSBce2LwBHdxfTk4jsT3RHeDirhf7C1DB6v2MmTtT9rg3QRq
         NiQwlsqXFJZ9uMvXcSH+fWxuNZObfXYRjDV2Vml2MRj2I8tX7lBrGy8GNPL/1qds0WfA
         S5Ct4GVgrG7o5iw4qaG/Dh387CjCoF+wQ6LbAE6axz1tcSKSgGucYCxMNBQ2IbjoAY4H
         yHqE1UdUlN99N53St3BxucTAFfhcxO00wmaRj35Mp+hPZ8ZZHmURQ7teFcirZdqiUSsh
         SjyUZk30IY87d+2DiRKoe+pp2FxuK+jFkim1IYWDgnFLp3BzYcqXXJNDx7rd35veV19y
         XliA==
X-Gm-Message-State: ACgBeo1w6DUQDYYIEro+mj6lCr7DzIOthvkdX0c7GQNsEl1uAEdiEE2T
        mn2K3Dd8omf9lWqFW4+6+R8=
X-Google-Smtp-Source: AA6agR5UZhUHndApFToNzkGMWRF30QoaS3PKoIYA19437kHEspwNEJV7RjGO47a9PKuVvSVTjJuFCw==
X-Received: by 2002:a5d:6b09:0:b0:21e:2eb6:2d03 with SMTP id v9-20020a5d6b09000000b0021e2eb62d03mr12526766wrw.684.1659438960337;
        Tue, 02 Aug 2022 04:16:00 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id az13-20020a05600c600d00b003a32490c95dsm23044355wmb.35.2022.08.02.04.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 04:15:59 -0700 (PDT)
Message-ID: <3eb66813-14a9-8644-b2dd-588815a06079@gmail.com>
Date:   Tue, 2 Aug 2022 13:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>, hsinyi@chromium.org,
        Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
References: <20220802085152.31284-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v13 0/1] Add basic node support for MediaTek MT8186 SoC
In-Reply-To: <20220802085152.31284-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

Below some notes for myself.

On 02/08/2022 10:51, Allen-KH Cheng wrote:
> From: Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
> 
> MT8186 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
> and 2 CA76 cores. MT8186 share many HW IP with MT65xx series. This
> patchset was tested on MT8186 evaluation board to shell.
> 
> This series is based on tag: next-20220728, linux-next/master
> Since we have a another dts series of mt8195 [1] which is waiting for
> review from maintainers. I remove power domains controller node from
> this mt8186 series and will update in another patch.
> 
> There are some corrections in mt8186 hardware bindings. We need to
> apply the below patches.
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220725110702.11362-2-allen-kh.cheng@mediatek.com/
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220725110702.11362-3-allen-kh.cheng@mediatek.com/

Both are already merged.

> https://patchwork.kernel.org/project/linux-mediatek/patch/20220720130604.14113-2-allen-kh.cheng@mediatek.com/

Acked but not yet merged.

> https://patchwork.kernel.org/project/linux-mediatek/patch/20220721014845.19044-2-allen-kh.cheng@mediatek.com/

We still have some discussions here.


Regards,
Matthias

> 
> [1]
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=663978
> 
> changes since v12:
>   - remove drive-strength fom i2c pins
>   - use lowercase hex addresses in pinctrl node
>   - correct clk order in xhci0
>   - add clk26m for dma_ck
> 
> changes since v11:
>   - add #cooling-cells in cpu nodes
>   - add pmu nodes for mt8186
>   - change #interrupt-cells from 3 to 4
>   - correct interrupts property in each nodes for 4 interrupt cells
>   - remove power domains controller node
>   - move #address-cells and #size-cells into mt8186.dts
>   - remove unused ahb_cg clock in mmc0
>   - add efuse node
>   - add dsi node and remove dpi node
>   - move i2c status position in mt8186-evb.dts
>   - change i2c child nodee name in pio node to *-pins
>   - change property from mediatek,drive-strength-adv to drive-strength-microamp in i2c child nodes of pio
>   - change drive-strength value from MTK_DRIVE_4mA to 4 in i2c child nodes of pio
>   - change i2c child nodes from pins-sda-sc1 to pins-bus
>   - correct pintctrl clk names
> 
> changes since v10:
>   - remove merged PATCHes
>   - add pmu nodes
>   - add #cooling-cells
>   - change #interrupt-cells number from 3 to 4
>   - remove power domains controller node
>   - move #address-cells/#size-cells into mt8186.dts from evb dts for i2c
>   - move status = 'okay' position in i2cx
>   - fix pinctrl patternproperties name in pio
>   - add efuse node
>   - fix dsi node
>   - add #reset-cells in infracfg_ao: syscon
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
> Allen-KH Cheng (1):
>    arm64: dts: Add MediaTek MT8186 dts and evaluation board and Makefile
> 
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8186-evb.dts | 228 +++++
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi    | 875 ++++++++++++++++++++
>   3 files changed, 1104 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi
> 
