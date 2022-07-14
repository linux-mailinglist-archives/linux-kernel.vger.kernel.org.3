Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CD6574D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbiGNMOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbiGNMOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:14:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD004330F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:14:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sz17so3040694ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=io1aLTKdTpdVFlnqujmNPlo4oYNZZxJeBCS9meVocL0=;
        b=CeWiNxlZAbcouK3RkNKwezaE1z81eze3WW4P/p51909MqdufYLlp/sIXTsxGUwMNW8
         VQsB3+LoA+f2yzGTReV67D4y1XN47QyrRxLbl7qsHqt027P9Dpd7ryLXcuDpWI8Ow+OZ
         u9Ywst8kFKNn6prBNoll5cP+FIKXVcJQs8rFTst7bYrdKtEbK//N4Mhq54FgtmnZD0pa
         mXstZDB/KdmMdJj/MEZHvzr2NVdI+p2ZpIUgQWcpaQB3vO7kGxIgqyxWdclIriS2Djph
         SYR9hlPSbDHx7tDWBRZ+0AfwR7dmOpW2azZwAJG/qS+pDIyTWMN2XUAIUEJ/DAUjud9L
         SXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=io1aLTKdTpdVFlnqujmNPlo4oYNZZxJeBCS9meVocL0=;
        b=bFlyr1mtvnqWScUZ/qajasLsKtlys7G+LVN40IWyJqfZZuemibI7touScvhl4nmj+s
         1lwPmjWbzormZBPk3IVo0PC7v8UoSJwYT4DSAsXRted6y0mtNXZIZKaEZ7QtAGY3IRlP
         4DvmeCdmzDKaJZSigmy9Qy9i6Dsb7doCDEXTDpUWc0xdQR1ErLNccxngOn4H9pKJOzKO
         gfnxqeloXL3FKs3MsZZsTl5KnFodu9vt4GOzly7WtKCl/aQj8jlLHqUlvYvnT+njkMzY
         ADcVSY6MW68tiDZwB7oUnwzrmDe8Znmx1lqN7iwu1aO8ys2XIQaq8HvHASBxjQYwx474
         ZmIw==
X-Gm-Message-State: AJIora+jeCE2uxhUHNOWPPwnTJ8VtFmTPrAfu3djGI4REOn55G7niSUO
        ZgXR2TC8HUc7Uc46+Tw4KSEtBeDmOaHOzsP9
X-Google-Smtp-Source: AGRyM1vqBZFmek01u+7xSqpw1dXClD+ulujeqQrElJLi0r7GH8mAkTo0HbqXH+C8YX+WDMMQMI6oFA==
X-Received: by 2002:a17:906:9c82:b0:6e1:2c94:1616 with SMTP id fj2-20020a1709069c8200b006e12c941616mr8567049ejc.64.1657800846315;
        Thu, 14 Jul 2022 05:14:06 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id u2-20020aa7db82000000b0043a253973aasm934973edt.10.2022.07.14.05.14.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jul 2022 05:14:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] arm64: dts: rockchip: Fix SD card init on rk3399-nanopi4
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
Date:   Thu, 14 Jul 2022 14:14:04 +0200
Cc:     =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
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

> Am 14.07.2022 um 13:41 schrieb Robin Murphy <robin.murphy@arm.com>:
>=20
> On 2022-07-14 00:41, Heiko St=C3=BCbner wrote:
>> Hi Christian,
>> Am Donnerstag, 14. Juli 2022, 00:22:23 CEST schrieb Christian =
Kohlsch=C3=BCtter:
>>> mmc/SD-card initialization may sometimes fail on NanoPi r4s with
>>> "mmc1: problem reading SD Status register" /
>>> "mmc1: error -110 whilst initialising SD card"
>>>=20
>>> Moreover, rebooting would also sometimes hang.
>>>=20
>> Nit: here the commit message should continue with something like:
>> -----
>> This is caused by the vcc3v0-sd regulator referencing the wrong gpio.
>> Fix the regulator to use the correct pin and drop the always-on =
property.
>> -----
>>> Signed-off-by: Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>> index 8c0ff6c96e03..91789801ab03 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>> @@ -67,10 +67,10 @@ vcc1v8_s3: vcc1v8-s3 {
>>>  	vcc3v0_sd: vcc3v0-sd {
>>>  		compatible =3D "regulator-fixed";
>>>  		enable-active-high;
>>> -		gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
>>> +		gpio =3D <&gpio0 RK_PD6 GPIO_ACTIVE_HIGH>;
>> The interesting question would be how nano-pi-specific that gpio is.
>> I.e. this is the rk3399-nanopi4.dtsi that is shared by multiple board =
types,
>> so can you check in schematics if gpio0-d6 is always used on all of =
them?
>=20
> On the R4S schematic, this is GPIO0_A1 same as the others. GPIO0 =
doesn't even have a bank D on RK3399, it only goes up to B5 :/
>=20
>> Thanks
>> Heiko
>>>  		pinctrl-names =3D "default";
>>>  		pinctrl-0 =3D <&sdmmc0_pwr_h>;
>>> -		regulator-always-on;
>>> +		regulator-boot-on;
>>>  		regulator-min-microvolt =3D <3000000>;
>>>  		regulator-max-microvolt =3D <3000000>;
>>>  		regulator-name =3D "vcc3v0_sd";
>>> @@ -580,7 +580,7 @@ wifi_reg_on_h: wifi-reg_on-h {
>>>    	sdmmc {
>>>  		sdmmc0_det_l: sdmmc0-det-l {
>>> -			rockchip,pins =3D <0 RK_PA7 RK_FUNC_GPIO =
&pcfg_pull_up>;
>>> +			rockchip,pins =3D <0 RK_PD6 RK_FUNC_GPIO =
&pcfg_pull_up>;
>=20
> ...and claiming the card detect is on the same non-existent pin as the =
regulator enable is clearly even more wrong.
>=20
> Is this another case where a UHS card is involved, such that VCC_SDIO =
gets left at 1.8V after a reboot, so subsequent attempts to do the =
initial handshake where the card is expecting 3V logic levels fail? (AKA =
the Tinkerboard problem). Hobbling the regulator such that Linux can =
never actually turn VCC3V0_SD off, thus the card never gets reset, might =
appear to "work", but isn't the right thing to do.
>=20
> Robin.

Right, this is all very strange.=20

Indeed, I have a UHS card and the problem you describe.
I've actually looked into the other RK3399 dts files to come up with =
that patch (e.g. rk3399-roc-pc.dtsi, which does this; also see [1])

I understand that we should do the right thing, but I am by no means =
sure what the "right" thing for this problem is.
That said, I wished someone with expertise and authority in the =
mmc/rockchip community would fix this for good.

There are several patches around this 1.8V/3V voltage dance that do =
work, get used by several distributions but didn't get merged to =
mainline because, well, there could be a better right thing to do (like =
[2], which is also still needed when using mainline u-boot).

Given the state of this issue, at least aligning the code to match =
another board's fix =E2=80=94 which already is in the mainline kernel =
=E2=80=94 seems a sensible approach to me. It unblocks users like me who =
would perhaps otherwise just give up on using these devices.

[1] =
https://lore.kernel.org/linux-mmc/3364813.APbW32NlgJ@phil/T/#m1b23cd2c43b6=
00b5a6f084461ae53e482ad65316
[2] =
https://patchwork.kernel.org/project/linux-mmc/patch/AM3PR03MB09664161A7FA=
2BD68B2800A7AC620@AM3PR03MB0966.eurprd03.prod.outlook.com/

