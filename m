Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54313577801
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 21:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiGQTc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 15:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiGQTc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 15:32:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5780011836
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 12:32:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r18so12741868edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 12:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bzc8+SMTjAuL3hWfjVp5UNr8nKbzbn5xX+8BRCLvn/4=;
        b=SOKAhVvf6ZDCy89DcFq/ROSdecedn2B5HAoiH+Zlxisou3tv6x1m9OCk4lR2Ptu4YX
         7XT17iXG3fF0xyeDQcMEkQYDfMgaehCg8Y8j85DeA0HNp+6XWNKgPWafMZvkscRje2cS
         WNOhnoLJytL/UErwoiQPnjDRuwCKx3/HV5cJT6GGUmBiLgrSMCehrIgNoUvPOyqMDJQT
         /ahT+Hx6xANcVl6af018LBUYIUoh2cVbKE4aOHvg3cdTuFyWK0qNXj9LEY21RSUjgfaC
         kxli4VW6VRzAPCGOVNGwGvnq/lWDHSS8ISlmzEWQBmR9b0kDCqUEq3d9pAGpAhDM17N1
         vNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bzc8+SMTjAuL3hWfjVp5UNr8nKbzbn5xX+8BRCLvn/4=;
        b=MhrOj4IYD6KNcFreVu+3m+iN/IIvksgan2Wxk3s7ZomLN36jTtDwgWRihpzt0SBYeP
         1dGG67Gu1Y2onr7I5P3PCbbCNLOafx4iGyY5AFp5fQhkN+yAorSjKwN9SAhNW7StVz3g
         M3yM27YH+0l8cmNIrJaMhzK9fL0rWtkPiPXtmrw4RotqgwUa+UsHx33TgmSg3SGmFi6x
         xAlcBVX8CC99O7X07plKbLJwwlRTaqCCGE1TZcepPq9GJFWvD18fH4O8qyW5rll1GecP
         15k6BWkvSlOtHoC3WF1us2nX4+vvYOHDNz9Mysr2Tay0X2D1Gd/RWldeTFLR3M8CqPPT
         nzeA==
X-Gm-Message-State: AJIora8KzpJ5N1bA37HHMSG3XvhRereQ8hCEanI6QZl7Zzz6S9IuKuWH
        AFeeWrgeiqSosccXQ6AULIHezA==
X-Google-Smtp-Source: AGRyM1uF29btnV+ubkEnBmWrWy6/jD2F1VNvGsr1evGz6n+Z/04BFjDfx0RbVWmdkajKBB5gjDa+fA==
X-Received: by 2002:a05:6402:4016:b0:43a:f310:9522 with SMTP id d22-20020a056402401600b0043af3109522mr32447659eda.200.1658086344896;
        Sun, 17 Jul 2022 12:32:24 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id p13-20020a05640210cd00b00435a62d35b5sm7177568edu.45.2022.07.17.12.32.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jul 2022 12:32:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] arm64: dts: rockchip: rk3399-nanopi4: Fix voltage
 regulator config
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <963AF33B-54B7-4172-92D1-E2898E256A7E@kohlschutter.com>
Date:   Sun, 17 Jul 2022 21:32:23 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <750501EB-8A79-459B-89B8-E9064632A68B@kohlschutter.com>
References: <963AF33B-54B7-4172-92D1-E2898E256A7E@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch obviously requires "regulator: core: Resolve supply name =
earlier to prevent double-init" and obsoletes "[PATCH v5] arm64: dts: =
rockchip: Fix SD card init on rk3399-nanopi4".
The latter patch may still be useful for existing kernels where one can =
recompile the device tree separately.

> Am 17.07.2022 um 21:29 schrieb Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>:
>=20
> A series of issues exist around the "vcc3v0_sd" voltage regulator that
> made it necessary to mark it "always-on".
>=20
> With the patch "regulator: core: Resolve supply name earlier to =
prevent
> double-init", this option is no longer necessary.
>=20
> Removing this option not only prevents a hang when rebooting Nanopi =
R4S,
> it also ensures that bootloaders like u-boot can boot from an SD card
> right away, without out-of-tree patches that re-initialize voltage =
levels.
>=20
> Signed-off-by: Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>
> ---
> arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> index 8c0ff6c96e03..55b93eac2f99 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> @@ -70,7 +70,6 @@ vcc3v0_sd: vcc3v0-sd {
> 		gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
> 		pinctrl-names =3D "default";
> 		pinctrl-0 =3D <&sdmmc0_pwr_h>;
> -		regulator-always-on;
> 		regulator-min-microvolt =3D <3000000>;
> 		regulator-max-microvolt =3D <3000000>;
> 		regulator-name =3D "vcc3v0_sd";
> --=20
> 2.36.1
>=20
>=20

