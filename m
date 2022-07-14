Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1205752B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbiGNQYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGNQYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:24:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2CC5A2F1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:24:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v12so3072670edc.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SNJdwt4J/a4nmUvGYwj0JK1QGMlisy3KLxTZfRyxWr4=;
        b=vJdTwWn8Dj7oxymbs4i0qKnupjTva4ANYSy1oJP2d83UTl2hVQhHTZzXzR6v79zYcU
         XxSNgALXRje5eQlruTp9WYXoXIQazb0YjAWo21gMo3FMT/wZa4bOLRSW/9s70f/0fpIZ
         e1EQ5+kSgtC6H25bxFOP7ryZkS/7/w6jeKsRwhUcBo8PmQvl4tf2ukEMwG2rSjfG4wt6
         QRcEMbz/CTOiMoPIU3Di53ba7V0G/UswWamtAl7fhimJZG5BF3qff5mRcgrT1HoPLB86
         K5Mj/bVGsnaGogHEYkVfHCsYMo+i5NKcl20hVkUFoc5qD1FLPdo20FlL85JACwJt1n9d
         YswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SNJdwt4J/a4nmUvGYwj0JK1QGMlisy3KLxTZfRyxWr4=;
        b=JovXYsE+sT2hNg1DmaG7EfIe4OQ+XC1fSlCYmarGK+j1CkZRikyBpSYOAoKw+zen35
         JVlN3+Bn8irIsh6suuDdhgCC42SPHlrzLo32n39AQwCPyDmC/lp/UZ9vMoYvHLa/pEHD
         xaaOPiJzsnp6wEAC0PtC7SsJhBUpKseFd/XFWaYWdYoV9AgKIZ3LGTj35W4pu1QAVct6
         KL4O+g9DTiyZrLk8w4jfDVRfsbm54w6By/cSoUW2ZLA7YOaSvNZ/7aL+tdmaCRTsc1x8
         NAeso7gQVsICJjJ/JMQMkrbDIDjNblSgqvGKwwim/m5RvfZxvXky7bCpaouGAqL9qId2
         HBgg==
X-Gm-Message-State: AJIora/PeCzRyVhALk3d44GNPdNNs665y6T0eMk9+Y682Vp/SPzseNxz
        cdA24JJ2P8PHsajwCPvmdTYQaE6W36vjCZ4/
X-Google-Smtp-Source: AGRyM1s9zbP2VSsxT5KxMIs0KPWksSiXG9ySDvZeY3eORMvnIJt21iTwHZA4gLg8TAUYcpzNAi3EHQ==
X-Received: by 2002:a05:6402:5189:b0:43a:c55c:cf00 with SMTP id q9-20020a056402518900b0043ac55ccf00mr13417813edd.390.1657815885343;
        Thu, 14 Jul 2022 09:24:45 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id k15-20020a17090632cf00b0072afb9fe3f3sm855880ejk.110.2022.07.14.09.24.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:24:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] arm64: dts: rockchip: Fix SD card init on rk3399-nanopi4
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
Date:   Thu, 14 Jul 2022 18:24:43 +0200
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
 <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Am 14.07.2022 um 15:50 schrieb Robin Murphy <robin.murphy@arm.com>:
>=20
> On 2022-07-14 13:14, Christian Kohlsch=C3=BCtter wrote:
>>> Am 14.07.2022 um 13:41 schrieb Robin Murphy <robin.murphy@arm.com>:
>>>=20
>>> On 2022-07-14 00:41, Heiko St=C3=BCbner wrote:
>>>> Hi Christian,
>>>> Am Donnerstag, 14. Juli 2022, 00:22:23 CEST schrieb Christian =
Kohlsch=C3=BCtter:
>>>>> mmc/SD-card initialization may sometimes fail on NanoPi r4s with
>>>>> "mmc1: problem reading SD Status register" /
>>>>> "mmc1: error -110 whilst initialising SD card"
>>>>>=20
>>>>> Moreover, rebooting would also sometimes hang.
>>>>>=20
>>>> Nit: here the commit message should continue with something like:
>>>> -----
>>>> This is caused by the vcc3v0-sd regulator referencing the wrong =
gpio.
>>>> Fix the regulator to use the correct pin and drop the always-on =
property.
>>>> -----
>>>>> Signed-off-by: Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 6 +++---
>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>=20
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>>>> index 8c0ff6c96e03..91789801ab03 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>>>> @@ -67,10 +67,10 @@ vcc1v8_s3: vcc1v8-s3 {
>>>>>  	vcc3v0_sd: vcc3v0-sd {
>>>>>  		compatible =3D "regulator-fixed";
>>>>>  		enable-active-high;
>>>>> -		gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
>>>>> +		gpio =3D <&gpio0 RK_PD6 GPIO_ACTIVE_HIGH>;
>>>> The interesting question would be how nano-pi-specific that gpio =
is.
>>>> I.e. this is the rk3399-nanopi4.dtsi that is shared by multiple =
board types,
>>>> so can you check in schematics if gpio0-d6 is always used on all of =
them?
>>>=20
>>> On the R4S schematic, this is GPIO0_A1 same as the others. GPIO0 =
doesn't even have a bank D on RK3399, it only goes up to B5 :/
>>>=20
>>>> Thanks
>>>> Heiko
>>>>>  		pinctrl-names =3D "default";
>>>>>  		pinctrl-0 =3D <&sdmmc0_pwr_h>;
>>>>> -		regulator-always-on;
>>>>> +		regulator-boot-on;
>>>>>  		regulator-min-microvolt =3D <3000000>;
>>>>>  		regulator-max-microvolt =3D <3000000>;
>>>>>  		regulator-name =3D "vcc3v0_sd";
>>>>> @@ -580,7 +580,7 @@ wifi_reg_on_h: wifi-reg_on-h {
>>>>>    	sdmmc {
>>>>>  		sdmmc0_det_l: sdmmc0-det-l {
>>>>> -			rockchip,pins =3D <0 RK_PA7 RK_FUNC_GPIO =
&pcfg_pull_up>;
>>>>> +			rockchip,pins =3D <0 RK_PD6 RK_FUNC_GPIO =
&pcfg_pull_up>;
>>>=20
>>> ...and claiming the card detect is on the same non-existent pin as =
the regulator enable is clearly even more wrong.
>>>=20
>>> Is this another case where a UHS card is involved, such that =
VCC_SDIO gets left at 1.8V after a reboot, so subsequent attempts to do =
the initial handshake where the card is expecting 3V logic levels fail? =
(AKA the Tinkerboard problem). Hobbling the regulator such that Linux =
can never actually turn VCC3V0_SD off, thus the card never gets reset, =
might appear to "work", but isn't the right thing to do.
>>>=20
>>> Robin.
>> Right, this is all very strange.
>> Indeed, I have a UHS card and the problem you describe.
>> I've actually looked into the other RK3399 dts files to come up with =
that patch (e.g. rk3399-roc-pc.dtsi, which does this; also see [1])
>=20
> That patch is simply adding a description of the VCC3V0_SD regulator =
which is correct for that board (at least according to the =
roc-rk3399-pc-plus schematic that I could find); very different from =
breaking an existing already-correct description.
>=20
>> I understand that we should do the right thing, but I am by no means =
sure what the "right" thing for this problem is.
>> That said, I wished someone with expertise and authority in the =
mmc/rockchip community would fix this for good.
>> There are several patches around this 1.8V/3V voltage dance that do =
work, get used by several distributions but didn't get merged to =
mainline because, well, there could be a better right thing to do (like =
[2], which is also still needed when using mainline u-boot).
>> Given the state of this issue, at least aligning the code to match =
another board's fix =E2=80=94 which already is in the mainline kernel =
=E2=80=94 seems a sensible approach to me. It unblocks users like me who =
would perhaps otherwise just give up on using these devices.
>=20
> Indeed it's an unfortunate situation, and I'd like to see the "proper" =
solution too, but my point is more that this patch isn't even the =
correct way to do what this patch actually achieves. Tricking Linux into =
toggling a non-existent pin prevents it from turning this regulator off =
(or on, so we're already hoping that someone else has done that); =
however that's what the "regulator-always-on" property should already =
imply, so the patch should at least explain why we're taking this more =
drastic measure instead of trying to fix whatever causes the always-on =
property to apparently not be honoured. Furthermore, if it is justified =
to remove Linux's ability to control the regulator at all, then making =
up a bogus GPIO is still nonsensical (just remove it completely), and =
changing regulator-always-on to regulator-boot-on (saying that Linux =
*is* permitted to try to do the thing you're actively preventing it from =
doing) even more so.
>=20
> The other concern I have is whether this is really a sufficiently =
robust workaround anyway. I'm not familiar enough to know whether a =
soft-reset at potentially the wrong I/O voltage is something that all =
cards are going to handle reliably and without risk of damage. =
Furthermore, if a card reset happens anyway for any other reason, e.g. =
the user physically swaps cards during the reboot, then it's still not =
going to work.
>=20
> Thanks,
> Robin.

Thanks for the clarification, Robin! That makes a lot of sense to me =
now.

In a separate reply, Markus Reichl mentioned
> rk3399-roc-pc uses GPIO4-D6 for SDMMC0_PWR to enable VCC3V0_SD.
and that is what's reflected in rk3399-roc-pc.dtsi. Admittedly I copied =
that only partially =E2=80=94 I accidentally used GPIO0 D6, which, as =
you correctly said, doesn't exist).

GPIO4-D6 is indeed SDMMC_PWREN_d, but for RK3308 [1], not RK3399 (where, =
for example, ROCK960 drives the blue LED [6]).
I can't find a reference to GPIO4_D6 in the ROC-RK3399-PC specification =
[7].
I can find a reference to GPIO4_D6 in the RK3399 Datasheet [8], but it =
doesn't mention SDMMC / power.

=46rom what I understand when I look at the schematics of the nanopi4 =
family [1,2,3,4] (R4S, T4, M4, NEO4), VCC3V0_SD should be controllable =
via SDMMC0_PWR_H (which is GPIO0_A1, as in mainline).

So, my understanding is that GPIO0_A1 would indeed be the correct gpio =
binding, but something interferes with the power regulator when this =
configuration is set.

When I keep that gpio binding, the SD card would not be detected =
(problem reading SD Status register) or hang upon reboot (my original =
problem).
Here's the dmesg output with linux mainline (tested with 5.8.10)
> [    2.189133] dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit =
address mode.
> [    2.189852] dwmmc_rockchip fe320000.mmc: Using internal DMA =
controller.
> [    2.190451] dwmmc_rockchip fe320000.mmc: Version ID is 270a
> [    2.191075] dwmmc_rockchip fe320000.mmc: DW MMC controller at irq =
32,32 bit host data width,256 deep fifo
> [    2.193011] dwmmc_rockchip fe320000.mmc: Got CD GPIO
> [    2.206165] mmc_host mmc1: Bus speed (slot 0) =3D 400000Hz (slot =
req 400000Hz, actual 400000HZ div =3D 0)
> [    2.380276] mmc1: problem reading SD Status register
> [    2.380832] mmc_host mmc1: Bus speed (slot 0) =3D 25000000Hz (slot =
req 25000000Hz, actual 25000000HZ div =3D 0)
> [    2.382181] mmc1: error -110 whilst initialising SD card
> [    2.409380] mmc_host mmc1: Bus speed (slot 0) =3D 300000Hz (slot =
req 300000Hz, actual 300000HZ div =3D 0)
> [    2.558118] mmc1: problem reading SD Status register
> [    2.558673] mmc_host mmc1: Bus speed (slot 0) =3D 25000000Hz (slot =
req 25000000Hz, actual 25000000HZ div =3D 0)
> [    2.560067] mmc1: error -110 whilst initialising SD card
> [    2.587388] mmc_host mmc1: Bus speed (slot 0) =3D 200000Hz (slot =
req 200000Hz, actual 200000HZ div =3D 0)
> [    2.743852] mmc1: problem reading SD Status register
> [    2.744407] mmc_host mmc1: Bus speed (slot 0) =3D 25000000Hz (slot =
req 25000000Hz, actual 25000000HZ div =3D 0)
> [    2.745633] mmc1: error -110 whilst initialising SD card


Therefore, changing this to some other GPIO, existing (GPIO4_D6) or =
non-existing (GPIO0_D6), might have just fixed it by chance (no one else =
uses GPIO4_D6) or because a non-existing gpio binding is equivalent to a =
missing binding.

rk3399-rock960.dtsi, for example, doesn't have a gpio binding for =
vcc3v0_sd, and I think that's a better approach for an =
always-on-regulator than assigning a non-existing gpio.

So, with no gpio binding or a different one, I get the satisfying output =
of a properly detected SDHC card, all the time (cold boot, warm boot =
after reset). I still need the patch from [9] so u-boot wouldn't hang =
due to finding an unexpected voltage (1.8V vs 3.0V)
> [    2.182438] dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit =
address mode.
> [    2.183136] dwmmc_rockchip fe320000.mmc: Usi internal DMA =
controller.
> [    2.183730] dwmmc_rockchip fe320000.mmc: Version ID is 270a
> [    2.184293] dwmmc_rockchip fe320000.mmc: DW MMC controller at irq =
32,32 bit host data width,256 deep fifo
> [    2.185824] dwmmc_rockchip fe320000.mmc: Got CD GPIO
> [    2.199454] mmc_host mmc1: Bus speed (slot 0) =3D 400000Hz (slot =
req 400000Hz, actual 400000HZ div =3D 0)
> [    2.266425] mmc_host mmc1: Bus speed (slot 0) =3D 148500000Hz (slot =
req 150000000Hz, actual 148500000HZ div =3D 0)
> [    2.700022] dwmmc_rockchip fe320000.mmc: Successfully tuned phase =
to 212
> [    2.700656] mmc1: new ultra high speed SDR104 SDHC card at address =
0001

Thankfully, now we have a better fix. Is that the right approach? I =
don't know. After reading through all these RK3399 DTBs, I have the =
feeling that neither is fully correct, and some were lucky enough to use =
a different GPIO.

Heiko St=C3=BCbner asked,
> The interesting question would be how nano-pi-specific that gpio is.
>=20
> I.e. this is the rk3399-nanopi4.dtsi that is shared by multiple board =
types,
> so can you check in schematics if gpio0-d6 is always used on all of =
them?

While my analysis suggests that removing the reference to GPIO0_A1 may =
fix potential SD card issues for any affected RK3399 boards, I can only =
verify with the board I have: It works for my R4S, and according to the =
board specifications, I can be quite certain that it applies to all =
rk3399-nanopi4 variants.

All in all, I hope you like this approach (removing the gpio binding, a =
one-line fix) better than the first take. A revised patch will follow =
after this email.

Best,
Christian

PS: This is my first attempt at fixing a DTS. I learned a lot since =
yesterday but definitely not enough. My apologies if I missed anything =
obvious.

[1] =
https://wiki.friendlyelec.com/wiki/images/c/c2/NanoPi-R4S-4GB-2008-Schemat=
ic.pdf
[2] =
https://wiki.friendlyelec.com/wiki/images/e/e0/NanoPC-T4-1902-Schematic.pd=
f
[3] =
https://esys.ir/images/img_Item/1492/Files/NanoPi-M4-2GB-1807-Schematic.pd=
f
[4] =
https://wiki.friendlyelec.com/wiki/images/5/5c/NanoPi-NEO4-1808-Schematic.=
pdf
[5] https://dl.radxa.com/rockpis/docs/hw/ROCK-PI-S_v13_sch_200910.pdf
[6] =
https://www.96boards.org/documentation/consumer/rock/rock960c/hardware-doc=
s/hardware-user-manual.md.html
[7] =
https://drive.google.com/drive/folders/1zwrXegvh0q0u5Ru5pM2u5nJWS8-KbTdz
[8] https://www.rockchip.fr/RK3399%20datasheet%20V1.8.pdf
[9] =
https://patchwork.kernel.org/project/linux-mmc/patch/AM3PR03MB09664161A7FA=
2BD68B2800A7AC620@AM3PR03MB0966.eurprd03.prod.outlook.com/

