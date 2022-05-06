Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3187A51DC3A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442952AbiEFPhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443083AbiEFPgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:36:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AB449F9D;
        Fri,  6 May 2022 08:32:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AAFC61F46B21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651851166;
        bh=E9l9sl9XPbOxjAAJCEpY1wi9N4oVvcnWNoaRqxjeKaE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HwsVlLDRN+mPeE5XOJN9SrgZViyD4n7jTBgI133jgiTtJ270+gEcI1KTmgBO2nVJp
         3u8Bp/fL1gHcs78xMzxhXbjEyc+93iodMXlCkSyRzsoRN8nLT2Kud6tJazN0Z6a5vA
         MR39o257cBNwLSvC+emqdRhejNEplfY8ZpWfWg+9r8PQkFiS4Vk0N+V/DE9IIdJDEO
         g7VRMQA2n2nrR+yiUKFzJBYpjjFT4BS6x/tA7Pm17vjx15zCbbOT7NGz8T8u/dXtYJ
         bIMHDexQomhLGVOax3oXVaA1tt5TUdieOSAPxgM0fmGAXmURGW8ewY7Pni3UGDUuOO
         lQhGxClbKNJOg==
Message-ID: <22c1aa6b-d785-9bb3-354f-0d747e2392a1@collabora.com>
Date:   Fri, 6 May 2022 17:32:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 00/16] Introduce support for MediaTek MT8192 Google
 Chromebooks
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, Maxim Kutnij <gtk3@inbox.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220505194550.3094656-1-nfraprado@collabora.com>
 <CAGXv+5Hk2u+1zkVjNEt7wdwAJyoB+-PMAuh7UKWEkDeYxp5zUQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Hk2u+1zkVjNEt7wdwAJyoB+-PMAuh7UKWEkDeYxp5zUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/05/22 13:41, Chen-Yu Tsai ha scritto:
> On Fri, May 6, 2022 at 3:46 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
>>
>>
>> This series introduces Devicetrees for the MT8192-based Asurada platform
>> as well as Asurada Spherion and Asurada Hayato boards.
>>
>> Support for the boards is added to the extent that is currently enabled
>> in the mt8192.dtsi, as to not add any dependencies to this series.
>>
>> Besides the other dt-binding fixes already on linux-next to avoid new
>> warnings by this series, [1] is already merged but not on next yet.
>>
>> This series was peer-reviewed internally before submission.
>>
>> [1] https://lore.kernel.org/all/20220429201325.2205799-1-nfraprado@collabora.com/
>>
>> v1: https://lore.kernel.org/all/20220316151327.564214-1-nfraprado@collabora.com/
>>
>> Changes in v2:
>> - Added patches 1-2 for Mediatek board dt-bindings
>> - Added patches 13-16 enabling hardware for Asurada that has since been
>>    enabled on mt8192.dtsi
>>
>> Nícolas F. R. A. Prado (16):
>>    dt-bindings: arm64: dts: mediatek: Add mt8192-asurada-spherion
>>    dt-bindings: arm64: dts: mediatek: Add mt8192-asurada-hayato
>>    arm64: dts: mediatek: Introduce MT8192-based Asurada board family
>>    arm64: dts: mediatek: asurada: Document GPIO names
>>    arm64: dts: mediatek: asurada: Add system-wide power supplies
>>    arm64: dts: mediatek: asurada: Enable and configure I2C and SPI busses
>>    arm64: dts: mediatek: asurada: Add ChromeOS EC
>>    arm64: dts: mediatek: asurada: Add keyboard mapping for the top row
>>    arm64: dts: mediatek: asurada: Add Cr50 TPM
>>    arm64: dts: mediatek: asurada: Add Elan eKTH3000 I2C trackpad
>>    arm64: dts: mediatek: asurada: Add I2C touchscreen
>>    arm64: dts: mediatek: spherion: Add keyboard backlight
>>    arm64: dts: mediatek: asurada: Enable XHCI
>>    arm64: dts: mediatek: asurada: Enable PCIe and add WiFi
>>    arm64: dts: mediatek: asurada: Add MT6359 PMIC
>>    arm64: dts: mediatek: asurada: Add SPMI regulators
> 
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> I tested all the external peripherals, including touchpad, touchscreen,
> keyboard (which needs a fix), USB, WiFi on both models, and the keyboard
> backlight and (USB-based) Bluetooth on Spherion.
> 
> Could you also enable the SCP? Otherwise the vcodec generates big warnings
> when it probes.
> 
> And also would like to see MMC. :)
> 
> 
> Thanks
> ChenYu

Hello ChenYu,

we avoided enabling the SCP and the MMC because of some things that have to be
assessed and fixed on our side.
For the SCP, we have some issues about loading the firmware, we suspect that the
binary that is in linux-firmware needs different and/or larger carveouts;
For the MMC, we have some issues with the pin configuration regarding the pins
drive strength: this should be solved, but we want to make sure that more testing
gets done before we push that upstream.

We're trying to upstream the Asurada platform step by step as to see these
machines present on upstream as soon as possible, with functionality that is
well tested and clean, so that it would make no sense to modify them again in
the near future.

As this series gets picked (hopefully) by the maintainer, we will then make sure
to send one (or more, depending on various factors) followup series enabling more
and more functionality, until the platform integration reaches 100% completion.

At least, that's the plan :-)

Cheers,
Angelo
