Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D1B54BC18
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiFNUtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358310AbiFNUsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:48:21 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24634F9DA;
        Tue, 14 Jun 2022 13:48:04 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.155]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2xjg-1o083W0hxM-003Qxn; Tue, 14 Jun 2022 22:47:50 +0200
Message-ID: <c3c62929-77ba-6bae-1e0c-4d4ece9c9b32@i2se.com>
Date:   Tue, 14 Jun 2022 22:47:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ARM: dts: bcm2711-rpi: Use aliases to set custom MMC
 device index
Content-Language: en-US
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org, nsaenz@kernel.org,
        robh+dt@kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pbrobinson@gmail.com, f.fainelli@gmail.com
References: <20220614141208.15614-1-ariel.dalessandro@collabora.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220614141208.15614-1-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ev5Y1UAMHhakQEIsXd3jAGQVfh1ZoDVgwBRewrW352KCLaZSHcS
 RJxybRgGozeHf+gAbneTxFONxw2v/IplM/PWqwdZnKEWD3O/oBGwBGbFrrCSv7PFddalOiD
 scx8+HE08wfm/6tW1vlxKARvJuFWuQManI+1auvYzS/2s86ymiy6IzYl4JsOzSxM2xnyItF
 Dp72SIj+RFyMvExKk9Cvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xdxch3NdT9c=:/AVSF2Bfvn3CnRhjodBZd7
 6bh8cZgTTTpFnUEKlbqWO0n+KL/xAE5PsLmqpw82gDqkoIEN7jDrd5IhX5gvbCFcK9ON8juFn
 Lt1PiMu8Adbp5mR/W64zWiFx+v/XJ3QPVXwpO+ZmOVYXeQG2xSWmB61xKJKKbfqbY+aZXlQS5
 BQrUOeAt3H5biUF+30LlDnV0p/2JYRBy4Htnk5CLel29QfdeKF8KAQasr8aJEeyhYTRVmCrj5
 +oSWejmjaoK45i54g4vEhfdSHf8eR+1AHu2lwxgYasx1XY0YBEd+4JItc2nCRrC7Ifx/JzQnT
 xfPBgl8wMu6zy2rkCRFVIGCQDdSqHJcM8rOcVrFmMJU/2FavV8B6+NBwc0IHGPxfGb9i/pFsf
 j3UNlnjzRd9WzeXc8dy/W08r3Fkiqj2V998O+woQzLAu7gb5dfaEeNEhIvMgRUf8t9DBy6ArZ
 H/L5oMew5SRGV+pmJw62YegUqS7UtirxDXm7/PLLVyn5RHsPVXoKaHijV8/WnQZrPM4Yg4kHK
 FdLxRO7R1tphl7t8ybzuKwBVGXlc1490BMa+Z5XA2uFDATraVExuxFn7BIaX830YcE4td+1iw
 Q2KIP/h0CR9U/oVhHFGoUsKUPtQIWH1mTw6X8337ssffSWf5d3TnJPmPmsar23KXzgKRY3bRg
 6zOfQ+Ke8B16JUkZcDxsi7p/N83dZFX9qsl6ghugOOw6WfQ6xGeZf3wfhlWXZydTtQEfhCTwA
 tzSO3JgWpVx1sOyydMvv/Cr4FFLjz9AcOq3XdZsa1PDAEN0EOIlfPZJ5jjg=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ariel,

Am 14.06.22 um 16:12 schrieb Ariel D'Alessandro:
> Add MMC aliases to ensure that the /dev/mmcblk ID for the first
> eMMC/SD card won't change depending on the probe order of the MMC
> drivers.

this changes the emmc2 from mmc1 to mmc0 in my case (RPi 4, 
multi_v7_defconfig), which i consider as a regression / unexpected 
change in userspace.

Could you please explain your actual motivation of your patch?

>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>
> Changes in v2:
> * Moved alias from bcm2711-rpi-4-b.dts to bcm2711-rpi.dtsi
>
>   arch/arm/boot/dts/bcm2711-rpi.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/bcm2711-rpi.dtsi b/arch/arm/boot/dts/bcm2711-rpi.dtsi
> index ca266c5d9f9b..a39b2f68e4cc 100644
> --- a/arch/arm/boot/dts/bcm2711-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2711-rpi.dtsi
> @@ -13,6 +13,7 @@ memory@0 {
>   	aliases {
>   		emmc2bus = &emmc2bus;
>   		ethernet0 = &genet;
> +		mmc0 = &emmc2;	/* mmcblk0 for eMMC/SD */
>   		pcie0 = &pcie0;
>   		blconfig = &blconfig;
>   	};
