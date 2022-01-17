Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C3490CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbiAQQ6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:58:35 -0500
Received: from h04mx16.reliablemail.org ([185.76.67.209]:24116 "EHLO
        h04mx16.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbiAQQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:58:33 -0500
X-Halon-Out: b2e2f59c-77b6-11ec-a232-556aad082471
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bxHnRO+ZZNCykuv+GQhMJoyIuDE1pbW3HrrBUSFbebE=; b=h61VRck2sedpu+9pZZHhH2F1gP
        UNhUz34RbJaoM9MpZrsN7o4O0VtuyIkHaUGaNlTxYpCU6lirPEMvomwgjEmCsFm/GH2ECzoU6zL+H
        cLLCosj6toaWdDl0PdqKWU1JWfsAchQQhOSALPk0VBN8rJb3uzRUdDa+drs8VMc3J/b788eRKEfSB
        FgvT2F76nZCOTT8gYC7kJrJpRxRXlQimHAxXN3RSEr/vyEQlIYfty8lwzwpfamHIsycDcvtS3t7u0
        pF2N2KUDudaVpHyeUMCeLp6lggk+DgBzW2JZw4co5ucf0OfOBEJFeHA5UD0vJbv3HnVwxIqGu4B3b
        aVipvsnQ==;
Date:   Mon, 17 Jan 2022 17:58:28 +0100
From:   Henrik Grimler <henrik@grimler.se>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     'Krzysztof Kozlowski' <krzysztof.kozlowski@canonical.com>,
        semen.protsenko@linaro.org, virag.david003@gmail.com,
        martin.juecker@gmail.com, cw00.choi@samsung.com,
        m.szyprowski@samsung.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 3/3] ARM: dts: Add support for Samsung Chagall WiFi
Message-ID: <YeWgNJaDHxKROpQs@grimlerstat>
References: <20220116165035.437274-1-henrik@grimler.se>
 <20220116165035.437274-4-henrik@grimler.se>
 <ca8c4613-a058-6cde-f9e6-8530f142a821@canonical.com>
 <CGME20220116205940epcas5p3dbab01fb6bb7a4af76169231e6d94469@epcas5p3.samsung.com>
 <YeSHNCywXhp8gHC7@L14.lan>
 <001301d80b66$190901a0$4b1b04e0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001301d80b66$190901a0$4b1b04e0$@samsung.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpsrv07.misshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grimler.se
X-Get-Message-Sender-Via: cpsrv07.misshosting.com: authenticated_id: henrik@grimler.se
X-Authenticated-Sender: cpsrv07.misshosting.com: henrik@grimler.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alim,

> >> > +/* External sdcard */
> >> > +&mmc_2 {
> >> > +	status = "okay";
> >> > +	bus-width = <4>;
> >> > +	cap-sd-highspeed;
> >> > +	card-detect-delay = <200>;
> >> > +	pinctrl-0 = <&sd2_clk &sd2_cmd &mmc2_cd &sd2_bus1 &sd2_bus4>;
> >> > +	pinctrl-names = "default";
> >> > +	samsung,dw-mshc-ciu-div = <3>;
> >> > +	samsung,dw-mshc-ddr-timing = <0 2>;
> >> > +	samsung,dw-mshc-sdr-timing = <0 4>;
> >> > +	sd-uhs-sdr50;
> >> > +	vmmc-supply = <&ldo19_reg>;
> >> > +	vqmmc-supply = <&ldo13_reg>;
> >> > +};
> >> > +
> >> > +&pinctrl_0 {
> >> > +	mmc2_cd: sd2-cd-pins {
> >> > +		samsung,pins = "gpx2-4";
> >>
> >> Interesting... I looked at vendor sources to board-chagall and
> >> standard pin gpc2-2 is mentioned as PULL down and not-connected
> >comment.
> >>
> >> gpx2-4 seems not mentioned at all, unless other board files are
> >> actually used.
> >
> >Gpio seems to be spread out. GPIO_T_FLASH_DETECT is defined as gpx2-4 in
> >board-universal5420-mmc.c, and then used for card detection.
> >(Looking at it now again I see that write protection through sd2_wp should
> >also be supported for mmc_2, can add that in next patch set.)
> >
> Card detect pin is generally a special function (dedicated pin) pin,
> directly connected from SoC to card external slot.
> And for exynos5420 it is gpc2-2 as pointed by Krzysztof.

gpio/pinctrl is still not my area of expertise so your feedback is
greatly appreciated!

gpc2-2 does not seem to be the card-detect pin for these tablets.  If
I add sd2_cd to pinctrl-0 above I am unable to use the sdcard at all,
instead dmesg is filled with repeating messages like:

[  18.669050] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 300000Hz, actual 297619HZ div = 84)
[  18.703711] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 200000Hz, actual 200000HZ div = 125)
[  18.737167] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 100000Hz, actual 100000HZ div = 250)
[  19.058352] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
[  19.093037] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 300000Hz, actual 297619HZ div = 84)
[  19.127701] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 200000Hz, actual 200000HZ div = 125)
[  19.162380] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 100000Hz, actual 100000HZ div = 250)

gpx2-4 on the other hand switches state when an sdcard is inserted or
removed.  After exporting relevant pins I have, with the card
inserted:

# grep -A 2 gpx2 /sys/kernel/debug/gpio
gpiochip3: GPIOs 24-31, parent: platform/13400000.pinctrl, gpx2:
 gpio-26  (                    |Power               ) in  hi IRQ ACTIVE LOW
 gpio-28  (                    |sysfs               ) in  lo 

and when removed gpx2-4 changes to high:

gpiochip3: GPIOs 24-31, parent: platform/13400000.pinctrl, gpx2:
 gpio-26  (                    |Power               ) in  hi IRQ ACTIVE LOW
 gpio-28  (                    |sysfs               ) in  hi 

All the gpc2 pins are low no matter if sdcard is inserted or removed:

gpiochip7: GPIOs 56-62, parent: platform/13410000.pinctrl, gpc2:
 gpio-56  (                    |sysfs               ) in  lo 
 gpio-57  (                    |sysfs               ) in  lo 
 gpio-58  (                    |sysfs               ) in  lo 
 gpio-59  (                    |sysfs               ) in  lo 
 gpio-60  (                    |sysfs               ) in  lo 
 gpio-61  (                    |sysfs               ) in  lo 
 gpio-62  (                    |sysfs               ) in  lo 

That being said, I am not sure if it is working properly:

> Also PIN_FUNC_2 for gpx2-4 indicate that it is wakeup_int2 function.
> Do you get a card detect interrupt when removing and inserting the card to
> the card slot?

(What is the best way to check this?) I don't get any irq related
messages in dmesg, and I don't see any changes in /proc/interrupts if
tracked with something like `watch -n1 "cat /proc/interrupts"` when
card is removed or inserted, so seems likely that pin config is wrong.
All I can find in vendor kernel for this device is that pull config is
set to S3C_GPIO_PULL_NONE [1].  For some of the sibling tablets the
pin is configured as {S3C_GPIO_INPUT, GPIO_LV_N, S3C_GPIO_PULL_NONE}
[2] though, which I think should correspond to having:

mmc2_cd: mmc2-cd-pins {
  samsung,pins = "gpx2-4";
  samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
  samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
  samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
};

Changing to that does not seem to change anything though, I don't get
any interrupt, or any messages in dmesg, when inserting or removing
the sdcard.

> Also to avoid confusion, probably you can change the node name as "mmc2_cd:
> mmc2-cd-pins" 
> (as sd2-cd-pins is gpc2-2 for this SoC)

Thanks, will fix in a v4 (after discussions here are settled).

[1] https://github.com/exynos5420/android_kernel_samsung_exynos5420/blob/lineage-17.1/arch/arm/mach-exynos/board-universal5420-mmc.c#L388
[2] https://github.com/exynos5420/android_kernel_samsung_exynos5420/blob/lineage-17.1/arch/arm/mach-exynos/board-n1-gpio.c#L119

Best regards,
Henrik Grimler
