Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C536952AE7E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiEQXSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiEQXSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:18:12 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0D736B6C;
        Tue, 17 May 2022 16:18:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24HNHkg7092412;
        Tue, 17 May 2022 18:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652829466;
        bh=W9v9fHcaEJh6LKOtCpbqhS5fkM89n49DK7x+5trP2pE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=T/8mzD6rxUAhW2fQZXbJIv1ZYTSW6VlWDBJQUacwU9RMZEH9hIKMCiBc3z1CVk6MM
         YUrtEdlcWl3velc2dukLM0poqh+Iay1hWtzr2sRaHgBoL0266fYjAudv0FFWPlowAN
         v/Gts3NsD/xov01H9AxEITm6cqDNykawQ1Qk44HA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24HNHjcV022520
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 May 2022 18:17:45 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 17
 May 2022 18:17:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 17 May 2022 18:17:45 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24HNHjid013776;
        Tue, 17 May 2022 18:17:45 -0500
Date:   Tue, 17 May 2022 18:17:45 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH V3 2/2] rtc: Introduce ti-k3-rtc
Message-ID: <20220517231745.j364tz7djodgsh6p@gallon>
References: <20220513194457.25942-1-nm@ti.com>
 <20220513194457.25942-3-nm@ti.com>
 <YoQa6FoJV5eoxloa@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YoQa6FoJV5eoxloa@mail.local>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 00:00-20220518, Alexandre Belloni wrote:
> Hello Nishanth,
> 
> I have some very minor comments:

Thanks for the review.

> 
> On 13/05/2022 14:44:57-0500, Nishanth Menon wrote:
> > diff --git a/drivers/rtc/rtc-ti-k3.c b/drivers/rtc/rtc-ti-k3.c
> > new file mode 100644
> > index 000000000000..21a64051fd42
> > --- /dev/null
> > +++ b/drivers/rtc/rtc-ti-k3.c
> > @@ -0,0 +1,695 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Texas Instruments K3 RTC driver
> > + *
> > + * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
> > + */
> > +
> > +#define dev_fmt(fmt) "%s: " fmt, __func__
> 
> Are you sure you want to keep this line?

Saves me the headache of trying to find which function reported it from
the logs, but I can drop it.

> 
> > +static int ti_k3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> > +{
> > +	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
> > +	time64_t seconds;
> > +	int ret;
> > +
> > +	seconds = rtc_tm_to_time64(&alarm->time);
> > +
> > +	k3rtc_field_write(priv, K3RTC_ALM_S_CNT_LSW, seconds);
> > +	k3rtc_field_write(priv, K3RTC_ALM_S_CNT_MSW, (seconds >> 32));
> > +
> > +	/* Make sure the alarm time is synced in */
> > +	ret = k3rtc_fence(priv);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to fence(%d)!\n", ret);
> 
> I'm not sure this message is useful because the only thing the user may
> do would be trying to set the time again.

I should probably indicate a potential s/w config problem in driver
here - but the fail here is crucial for me to understand if there is
some other problem that I have'nt un-covered in the testing (hoping
none, but everytime I have had a configuration error, this shows up as
a symptom allowing me to drill down to the problem).


Let me know if you feel strongly about this, will drop.

> 
> > +		return ret;
> > +	}
> > +
> > +	/* Alarm irq enable will do a sync */
> > +	return ti_k3_rtc_alarm_irq_enable(dev, alarm->enabled);
> > +}
> > +
> 
> 
> > +
> > +static int k3rtc_get_vbusclk(struct device *dev, struct ti_k3_rtc *priv)
> > +{
> > +	int ret;
> > +	struct clk *clk;
> > +
> > +	/* Note: VBUS is'nt a context clock, it is needed for hardware operation */
> typo ---------------^

yup, will replace with  isn't

> 
> > +	clk = devm_clk_get(dev, "vbus");
> > +	if (IS_ERR(clk)) {
> > +		dev_err(dev, "No input vbus clock\n");
> > +		return PTR_ERR(clk);
> > +	}
> > +
> > +	ret = clk_prepare_enable(clk);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable the vbus clock(%d)\n", ret);
> 
> I would also remove those two dev_err

OK.

> 
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_add_action_or_reset(dev, (void (*)(void *))clk_disable_unprepare, clk);
> > +	return ret;

And will drop the ret usage here.. just return the result of
	devm_add_action_or_reset

> > +}
> > +
> > +static int ti_k3_rtc_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct ti_k3_rtc *priv;
> > +	void __iomem *rtc_base;
> > +	int ret;
> > +

	[...]

> > +	ret = k3rtc_configure(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (device_property_present(dev, "wakeup-source"))
> > +		device_init_wakeup(dev, true);
> > +	else
> > +		device_set_wakeup_capable(dev, true);
> > +
> > +	ret = devm_rtc_register_device(priv->rtc_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_rtc_nvmem_register(priv->rtc_dev, &ti_k3_rtc_nvmem_config);
> > +	return ret;
> 
> You don't need ret here and if I take that, I'll soon get an
> automatically generated patch.

Yup. will do.

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
