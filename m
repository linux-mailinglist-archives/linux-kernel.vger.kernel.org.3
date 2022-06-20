Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C41551286
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbiFTIVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbiFTIVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:21:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CD412087
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:21:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n185so5342189wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EVFjsrsD8O/Ly8SBCICyHVMqSVwP/VMmIEwnMpqK/k4=;
        b=XvRRzz9TGuyO5Gwhoh33U+2+M+0cJdWaF5wsH8PELsfkMp8thOOwgvFusE/Xj+qXgQ
         QMGTNGhnpeNauNYkpWiG2PV+421B98d8O72D6Og6c69MG9/9YqvYo8pUae0IKjqWBvTj
         NdkTcwK1NGP8Qk1+45a5iLr9f63NWixuWA/rhCD7Ufpbv5efqoxg2A9tPATQc16w+MHb
         PTVtGWlgvmv7g9hpU+N2FxiS7wllG/edfV9sXwqf3srD92RW2pylpvtPUOebAXvO9548
         fqX2wRHZ6renlBN44WY6WkVfY3QjMc1wnVpOICuoHlbTDsHQef2ztn5/jWDyItakhTWE
         YR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EVFjsrsD8O/Ly8SBCICyHVMqSVwP/VMmIEwnMpqK/k4=;
        b=usOWKHVlsKW1zjRvED8zmWeUafjpmwk6dSpLNKT8M5bKQwg0q9D6+50Uj4ey16gYL/
         KhYrNEOog2QiQDAESiO12xmysLTU3295Mje+2MgVv8OkffXe3H62ynTwQt9AAPmLCheb
         Pr5CfLMaVJjoFfB+4Skd0XxNi5km1iQ83BUWUTjXI3EzM9YVKgwF+4TboWtpfrl30fhP
         b2rwTOYmIwP79Csf+KWKZRxp4LJ/+/Q5O62mllUZH9BEHtKQ3bgkFhfAsOBqpUN8eVrW
         HLuS96Q6Fy1w17IR7qz4JH/SyS/BiLhpvIVLQhocMKQXZGkKOUGxaSBfNPFqGoq0NeLV
         Ya3w==
X-Gm-Message-State: AJIora930/mNGh6VQbFmHeIPsGxhAbsQLzQPhx9gXGrE9klepxW6r1Lj
        9J4GNI59PWvwgWAAG3mm2dp0rw==
X-Google-Smtp-Source: AGRyM1unkXgzjYWp7VyjReRJg1Ito996ylAaKPqwIvh9B1hNdEIM4OSDqV6AmMP+zsgse48mv10f3Q==
X-Received: by 2002:a05:600c:3594:b0:39d:b7c2:dc21 with SMTP id p20-20020a05600c359400b0039db7c2dc21mr27755841wmq.76.1655713259965;
        Mon, 20 Jun 2022 01:20:59 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b002108ab90e5asm12457698wrn.58.2022.06.20.01.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 01:20:59 -0700 (PDT)
Date:   Mon, 20 Jun 2022 09:20:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
Message-ID: <YrAt6dq6ty9p8d05@google.com>
References: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
 <1655200111-18357-7-git-send-email-quic_c_skakit@quicinc.com>
 <YquZRcuRCrdF+Q1z@google.com>
 <eccbb030-97f7-3a6c-958e-05adcdca6210@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eccbb030-97f7-3a6c-958e-05adcdca6210@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022, Satya Priya Kakitapalli (Temp) wrote:

> 
> On 6/17/2022 2:27 AM, Lee Jones wrote:
> > On Tue, 14 Jun 2022, Satya Priya wrote:
> > 
> > > Use i2c_new_dummy_device() to register pm8008-regulator
> > > client present at a different address space, instead of
> > > defining a separate DT node. This avoids calling the probe
> > > twice for the same chip, once for each client pm8008-infra
> > > and pm8008-regulator.
> > > 
> > > As a part of this define pm8008_regmap_init() to do regmap
> > > init for both the clients and define pm8008_get_regmap() to
> > > pass the regmap to the regulator driver.
> > > 
> > > Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > > Changes in V15:
> > >   - None.
> > > 
> > > Changes in V14:
> > >   - None.
> > > 
> > > Changes in V13:
> > >   - None.
> > > 
> > >   drivers/mfd/qcom-pm8008.c       | 34 ++++++++++++++++++++++++++++++++--
> > >   include/linux/mfd/qcom_pm8008.h |  9 +++++++++
> > >   2 files changed, 41 insertions(+), 2 deletions(-)
> > >   create mode 100644 include/linux/mfd/qcom_pm8008.h
> > > 
> > > diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> > > index 569ffd50..55e2a8e 100644
> > > --- a/drivers/mfd/qcom-pm8008.c
> > > +++ b/drivers/mfd/qcom-pm8008.c
> > > @@ -9,6 +9,7 @@
> > >   #include <linux/interrupt.h>
> > >   #include <linux/irq.h>
> > >   #include <linux/irqdomain.h>
> > > +#include <linux/mfd/qcom_pm8008.h>
> > >   #include <linux/module.h>
> > >   #include <linux/of_device.h>
> > >   #include <linux/of_platform.h>
> > > @@ -57,6 +58,7 @@ enum {
> > >   struct pm8008_data {
> > >   	struct device *dev;
> > > +	struct regmap *regulators_regmap;
> > >   	int irq;
> > >   	struct regmap_irq_chip_data *irq_data;
> > >   };
> > > @@ -150,6 +152,12 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
> > >   	.max_register	= 0xFFFF,
> > >   };
> > > +struct regmap *pm8008_get_regmap(const struct pm8008_data *chip)
> > > +{
> > > +	return chip->regulators_regmap;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pm8008_get_regmap);
> > Seems like abstraction for the sake of abstraction.
> > 
> > Why not do the dereference inside the regulator driver?
> 
> To derefer this in the regulator driver, we need to have the pm8008_data
> struct definition in the qcom_pm8008 header file.
> 
> I think it doesn't look great to have only that structure in header and all
> other structs and enum in the mfd driver.

Then why pass 'pm8008_data' at all?

What's preventing you from passing 'regmap'?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
