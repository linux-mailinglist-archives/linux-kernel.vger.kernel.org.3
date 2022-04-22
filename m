Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529AF50C4ED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiDVXpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiDVXpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:45:13 -0400
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612E5C3E2C;
        Fri, 22 Apr 2022 16:42:11 -0700 (PDT)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 6A34221159;
        Fri, 22 Apr 2022 23:42:10 +0000 (UTC)
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.113.132])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id AD68C200FE;
        Fri, 22 Apr 2022 23:42:06 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 00FF13ECD9;
        Sat, 23 Apr 2022 01:42:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id DF4E52A515;
        Fri, 22 Apr 2022 23:42:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Dvo1OGrq-QyV; Fri, 22 Apr 2022 23:42:02 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Fri, 22 Apr 2022 23:42:02 +0000 (UTC)
Received: from [172.16.34.145] (unknown [113.67.11.122])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id EFA834006D;
        Fri, 22 Apr 2022 23:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1650670922; bh=dwsRumBLd0aj8mHwodE1g9daT4rDqqCXMqV4XFMJd3I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cXWi6rftuSlEvUF9RzBrnd1Sea3D1DPUJTogtnBLcyNi64VudHUVdog/cI6WvrleP
         CRBAsydT2W3ZZO3lS8HqBfel3sLgBi+mWHheX8Ar7fSw2iOUuB+Wph4VGPq23zzqnN
         oO5OR3fT0OySOMQHcriQDMfo+Ih4HN+Rb3v7VjE4=
Message-ID: <a80fa962ac4a852b599ccf8e383e43e8eea7d12e.camel@aosc.io>
Subject: Re: [PATCH 2/2] thermal: sun8i: add R329 THS
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Samuel Holland <samuel@sholland.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Sat, 23 Apr 2022 07:41:51 +0800
In-Reply-To: <f21303dd-14e2-80e6-ef07-2a1584d93b2e@sholland.org>
References: <20220422161156.1075227-1-icenowy@outlook.com>
         <BYAPR20MB24720C488FD2BB42038D9825BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
         <f21303dd-14e2-80e6-ef07-2a1584d93b2e@sholland.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022-04-22星期五的 18:39 -0500，Samuel Holland写道：
> Hi Icenowy,
> 
> On 4/22/22 11:11 AM, icenowy@outlook.com wrote:
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > The thermal sensor controller on R329 is similar to the one on H6,
> > but
> > with only one sensor. Calibration method is still unknown because
> > no
> > calibration is implemented in BSP kernel, neither is it documented
> > in
> > the user manual.
> 
> Looking at the BSP smartx-r329-tina-for-jishu-community-v0.2, I see:
> 
> ths_calib: calib@14 {
>         reg = <0x14 4>;
> };
> 
> And the BSP driver (drivers/thermal/sunxi_thermal-ng.c) claims that
> R329 uses
> the same calibration method as for H616. Maybe you are looking at an
> older BSP?

Yes. All these r329 work is done the last year during my internship at
Sipeed.

I will check the newer version of BSP and if okay I will add the
calibrate routine in the next revision.

> 
> Regards,
> Samuel
> 
> > 
> > Add its support to sun8i-thermal driver. Calibrating it is now
> > prevented.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  drivers/thermal/sun8i_thermal.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/sun8i_thermal.c
> > b/drivers/thermal/sun8i_thermal.c
> > index d9cd23cbb671..3a2f381005b4 100644
> > --- a/drivers/thermal/sun8i_thermal.c
> > +++ b/drivers/thermal/sun8i_thermal.c
> > @@ -312,7 +312,8 @@ static int sun8i_ths_calibrate(struct
> > ths_device *tmdev)
> >                 goto out;
> >         }
> >  
> > -       tmdev->chip->calibrate(tmdev, caldata, callen);
> > +       if (tmdev->chip->calibrate)
> > +               tmdev->chip->calibrate(tmdev, caldata, callen);
> >  
> >         kfree(caldata);
> >  out:
> > @@ -628,6 +629,17 @@ static const struct ths_thermal_chip
> > sun50i_h6_ths = {
> >         .calc_temp = sun8i_ths_calc_temp,
> >  };
> >  
> > +static const struct ths_thermal_chip sun50i_r329_ths = {
> > +       .sensor_num = 1,
> > +       .has_bus_clk_reset = true,
> > +       .offset = 188744,
> > +       .scale = 672,
> > +       .temp_data_base = SUN50I_H6_THS_TEMP_DATA,
> > +       .init = sun50i_h6_thermal_init,
> > +       .irq_ack = sun50i_h6_irq_ack,
> > +       .calc_temp = sun8i_ths_calc_temp,
> > +};
> > +
> >  static const struct of_device_id of_ths_match[] = {
> >         { .compatible = "allwinner,sun8i-a83t-ths", .data =
> > &sun8i_a83t_ths },
> >         { .compatible = "allwinner,sun8i-h3-ths", .data =
> > &sun8i_h3_ths },
> > @@ -636,6 +648,7 @@ static const struct of_device_id of_ths_match[]
> > = {
> >         { .compatible = "allwinner,sun50i-a100-ths", .data =
> > &sun50i_a100_ths },
> >         { .compatible = "allwinner,sun50i-h5-ths", .data =
> > &sun50i_h5_ths },
> >         { .compatible = "allwinner,sun50i-h6-ths", .data =
> > &sun50i_h6_ths },
> > +       { .compatible = "allwinner,sun50i-r329-ths", .data =
> > &sun50i_r329_ths },
> >         { /* sentinel */ },
> >  };
> >  MODULE_DEVICE_TABLE(of, of_ths_match);
> > 
> 
> 


