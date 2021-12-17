Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33EE47863D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhLQIdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:33:00 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:53029 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233855AbhLQIc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1639729977; x=1671265977;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lgtz188NuGFgwoOqrC9jCds8xdg+NuWFZrgUNDR9IdE=;
  b=Xc6nRShMz+3WKteIarwO6haWIOkvOTF6F4P46oRST+QqwRf4SGv+FFt7
   H5oNFJ5qgJZ/y3p3YvU9GZ4OgU/3XSAZwxh7rbNO5pPp8IIQfRkfI148l
   OPGKWAWRVGDS9X8t3A295q56cbn+4F4vbDkxWmlOASWtamB/utlG9Nbur
   0qfBDV2eQD+a9d25HaftFB8mbCtD6hVCJiykLu5uukHrsSgjGVQpKEOyq
   dnJyGzReu+KEKpAKP+kzZ3Z9xGnwS426J/n0uThvmbTybx27UJcgyjo58
   tQu0c7zzkgBTnS/WftSkdVZsWr78r83EEG8YrtN+6gnlbuo8oftnbZHev
   w==;
X-IronPort-AV: E=Sophos;i="5.88,213,1635199200"; 
   d="scan'208";a="21114790"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 17 Dec 2021 09:32:56 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 17 Dec 2021 09:32:56 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 17 Dec 2021 09:32:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1639729976; x=1671265976;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lgtz188NuGFgwoOqrC9jCds8xdg+NuWFZrgUNDR9IdE=;
  b=e6aYy6XIelvv8TQVzYc6SpfHY8aFejujq+yFwen2PV+CuOo/mv4iso/I
   nSMf6rjP1XWr8f/iKg00MGL3dIi0YUuq5KCHLZmnvlbBx+FUDwc30yTlM
   Qs4c6EKNJIwW/n7q/ZhqxfZ0Esa56cJ5pXB7gXvbc+z2MoRxi4CzeMshz
   pfJcBoH9WEHyryME4uiDipDcpOBjLaxxtx08O1h9SCjx2l7UBOCFbZHLw
   elvG9455VHku759PN5xU53NOflNQ10Gni460NyD/c0XhfTpXqEBNg9MWo
   QGO1i9VRBHsPuVlSDevGOt3S+D0R3ELmCPZ+P3POvU/ymP70p8MRRZ29D
   g==;
X-IronPort-AV: E=Sophos;i="5.88,213,1635199200"; 
   d="scan'208";a="21114789"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Dec 2021 09:32:56 +0100
Received: from steina-w (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 2A8E8280065;
        Fri, 17 Dec 2021 09:32:56 +0100 (CET)
Message-ID: <97b2f5bb633ff2e25d4953eea63b31a5499ff433.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH v3 3/7] arm64: defconfig: enable drivers for
 TQ TQMa8MxML-MBa8Mx
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 17 Dec 2021 09:32:53 +0100
In-Reply-To: <Ybug4acjSvCG+XxA@ryzen>
References: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
         <20211201072949.53947-4-alexander.stein@ew.tq-group.com>
         <Ybug4acjSvCG+XxA@ryzen>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 16.12.2021 um 22:26 +0200 schrieb Abel Vesa:
> On 21-12-01 08:29:44, Alexander Stein wrote:
> > With the device tree in place, enable missing drivers as modules,
> > if
> > possible. PHY driver needs built-in for interrupt support.
> > 
> > Signed-off-by: Alexander Stein <
> > alexander.stein@ew.tq-group.com
> > >
> > ---
> > Changes in v3:
> > * None
> > 
> > Changes in v2:
> > * Add interconnect driver for imx8mm and imx8mn
> > 
> >  arch/arm64/configs/defconfig | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig
> > b/arch/arm64/configs/defconfig
> > index 0da6a944d5cd..44ce56dd2638 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -363,6 +363,7 @@ CONFIG_MICROSEMI_PHY=y
> >  CONFIG_AT803X_PHY=y
> >  CONFIG_REALTEK_PHY=y
> >  CONFIG_ROCKCHIP_PHY=y
> > +CONFIG_DP83867_PHY=y
> >  CONFIG_VITESSE_PHY=y
> >  CONFIG_USB_PEGASUS=m
> >  CONFIG_USB_RTL8150=m
> > @@ -397,6 +398,7 @@ CONFIG_TOUCHSCREEN_EDT_FT5X06=m
> >  CONFIG_INPUT_MISC=y
> >  CONFIG_INPUT_PM8941_PWRKEY=y
> >  CONFIG_INPUT_PM8XXX_VIBRATOR=m
> > +CONFIG_INPUT_PWM_BEEPER=m
> >  CONFIG_INPUT_PWM_VIBRA=m
> >  CONFIG_INPUT_HISI_POWERKEY=y
> >  # CONFIG_SERIO_SERPORT is not set
> > @@ -556,6 +558,7 @@ CONFIG_BATTERY_MAX17042=m
> >  CONFIG_CHARGER_BQ25890=m
> >  CONFIG_CHARGER_BQ25980=m
> >  CONFIG_SENSORS_ARM_SCPI=y
> > +CONFIG_SENSORS_JC42=m
> >  CONFIG_SENSORS_LM90=m
> >  CONFIG_SENSORS_PWM_FAN=m
> >  CONFIG_SENSORS_RASPBERRYPI_HWMON=m
> > @@ -793,6 +796,7 @@ CONFIG_SND_SOC_RT5659=m
> >  CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
> >  CONFIG_SND_SOC_SIMPLE_MUX=m
> >  CONFIG_SND_SOC_TAS571X=m
> > +CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
> >  CONFIG_SND_SOC_WCD934X=m
> >  CONFIG_SND_SOC_WM8904=m
> >  CONFIG_SND_SOC_WM8960=m
> > @@ -908,6 +912,7 @@ CONFIG_RTC_DRV_DS1307=m
> >  CONFIG_RTC_DRV_HYM8563=m
> >  CONFIG_RTC_DRV_MAX77686=y
> >  CONFIG_RTC_DRV_RK808=m
> > +CONFIG_RTC_DRV_PCF85063=m
> >  CONFIG_RTC_DRV_PCF85363=m
> >  CONFIG_RTC_DRV_M41T80=m
> >  CONFIG_RTC_DRV_RX8581=m
> > @@ -1175,6 +1180,8 @@ CONFIG_SLIM_QCOM_NGD_CTRL=m
> >  CONFIG_MUX_MMIO=y
> >  CONFIG_INTERCONNECT=y
> >  CONFIG_INTERCONNECT_IMX=m
> > +CONFIG_INTERCONNECT_IMX8MM=m
> > +CONFIG_INTERCONNECT_IMX8MN=m
> 
> Nope. The interconnect doesn't work without imx8m-ddrc
> and imx-bus devfreq drivers. Those drivers do not work
> yet. 
> 
> So please drop the interconnect configs for now.

They have been applied to next already, see [1]. Shawn, do you want a
revert for those 2 options then?

Best regards,
Alexander

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm64/configs/defconfig?id=2ecc02a6b3f0e2a4339952c4f8b86a4d87876930


