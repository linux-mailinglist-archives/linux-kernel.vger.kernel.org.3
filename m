Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3756E52D203
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbiESMGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiESMGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:06:36 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2A017060;
        Thu, 19 May 2022 05:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652961993; x=1684497993;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D5j1Ifb/J4M13HhjxMm8U24f9WHy6ZigKkypuV4JDek=;
  b=wBJdeAdGZxx04WLGY/g3ykivQLUJCANgkCuUysK1W6GDFpOSvvrwr/p2
   2M8BxraTirdMkZTMmSXwm4JSu4Q43ErUtoXFwiQENIsuZlLl4tP0IEgSN
   7KdekgsTcbEGx7tAr3Fei9N8AysyNpYAa7AokoHvy9fEmZ/NoiSjKEpJM
   A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 May 2022 05:06:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 05:06:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 05:06:25 -0700
Received: from [10.50.18.252] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 19 May
 2022 05:06:21 -0700
Message-ID: <ce66745c-3182-f3b7-ec21-7cbf39e5278a@quicinc.com>
Date:   Thu, 19 May 2022 17:36:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V12 7/9] regulator: Add a regulator driver for the PM8008
 PMIC
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1652275113-10277-1-git-send-email-quic_c_skakit@quicinc.com>
 <1652275113-10277-8-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n51JeC7oobCYNCJ-rOi3n_FVPBjz7yFmtwKEDeqWcX0vFw@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <CAE-0n51JeC7oobCYNCJ-rOi3n_FVPBjz7yFmtwKEDeqWcX0vFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/17/2022 12:33 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-05-11 06:18:31)
>> diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
>> new file mode 100644
>> index 0000000..0361f02
>> --- /dev/null
>> +++ b/drivers/regulator/qcom-pm8008-regulator.c
>> @@ -0,0 +1,221 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
>> +
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/qcom_pm8008.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
> Is this include used?


This is used for of_property_read_* APIs.


>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/driver.h>
>> +#include <linux/regulator/of_regulator.h>
> Is this include used?


This is not required, I will remove this.


>> +
>> +#define VSET_STEP_MV                   8
>> +#define VSET_STEP_UV                   (VSET_STEP_MV * 1000)
>> +
>> +#define LDO_ENABLE_REG(base)           ((base) + 0x46)
>> +#define ENABLE_BIT                     BIT(7)
>> +
>> +#define LDO_VSET_LB_REG(base)          ((base) + 0x40)
>> +
>> +#define LDO_STEPPER_CTL_REG(base)      ((base) + 0x3b)
>> +#define DEFAULT_VOLTAGE_STEPPER_RATE   38400
>> +#define STEP_RATE_MASK                 GENMASK(1, 0)
>> +
>> +struct pm8008_regulator_data {
>> +       const char                      *name;
>> +       const char                      *supply_name;
>> +       int                             min_uv;
>> +       int                             max_uv;
>> +       int                             min_dropout_uv;
>> +       const struct linear_range       *voltage_range;
>> +};
>> +
>> +struct pm8008_regulator {
>> +       struct device           *dev;
>> +       struct regmap           *regmap;
>> +       struct regulator_desc   rdesc;
>> +       u16                     base;
>> +       int                     step_rate;
>> +       int                     voltage_selector;
>> +};
>> +
>> +static const struct linear_range nldo_ranges[] = {
>> +       REGULATOR_LINEAR_RANGE(528000, 0, 122, 8000),
>> +};
>> +
>> +static const struct linear_range pldo_ranges[] = {
>> +       REGULATOR_LINEAR_RANGE(1504000, 0, 237, 8000),
>> +};
>> +
>> +static const struct pm8008_regulator_data reg_data[] = {
>> +       /* name  parent       min_uv  max_uv  headroom_uv voltage_range */
>> +       { "ldo1", "vdd_l1_l2", 528000, 1504000, 225000, nldo_ranges, },
>> +       { "ldo2", "vdd_l1_l2", 528000, 1504000, 225000, nldo_ranges, },
>> +       { "ldo3", "vdd_l3_l4", 1504000, 3400000, 300000, pldo_ranges, },
>> +       { "ldo4", "vdd_l3_l4", 1504000, 3400000, 300000, pldo_ranges, },
>> +       { "ldo5", "vdd_l5",    1504000, 3400000, 200000, pldo_ranges, },
>> +       { "ldo6", "vdd_l6",    1504000, 3400000, 200000, pldo_ranges, },
>> +       { "ldo7", "vdd_l7",    1504000, 3400000, 200000, pldo_ranges, },
>> +};
>> +
>> +static int pm8008_regulator_get_voltage(struct regulator_dev *rdev)
>> +{
>> +       struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
>> +
>> +       return pm8008_reg->voltage_selector;
>> +}
>> +
>> +static inline int pm8008_write_voltage(struct pm8008_regulator *pm8008_reg,
>> +                                                       int mV)
>> +{
>> +       __le16 vset_raw;
>> +
>> +       vset_raw = cpu_to_le16(mV);
>> +
>> +       return regmap_bulk_write(pm8008_reg->regmap,
>> +                       LDO_VSET_LB_REG(pm8008_reg->base),
>> +                       (const void *)&vset_raw, sizeof(vset_raw));
> Does sparse complain about casting away __le16?


No.


>> +}
>> +
>> +static int pm8008_regulator_set_voltage_time(struct regulator_dev *rdev,
>> +                               int old_uV, int new_uv)
>> +{
>> +       struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
>> +
>> +       return DIV_ROUND_UP(abs(new_uv - old_uV), pm8008_reg->step_rate);
>> +}
>> +
