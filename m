Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049A24C6F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbiB1OTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiB1OTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:19:03 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D213225EA3;
        Mon, 28 Feb 2022 06:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646057905; x=1677593905;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0cpC9p1ddwPK2S+4/BHJ62v/Y9aY97sSXc6b8uoISf0=;
  b=dlgZVNc6Lx0lgWn+d3GzGM0/dECKHz4uwa9gzbEMyA5HQ/oNoLVRThhI
   h6B0F+PRHh21vVkP5gF6wF6s7yzb9Kp3OcVj1f3KPeLnhc/0Mb8fBO/q5
   WgMF9O5vphCpbWhWCzr+9oE9c72kH21w3sMkxAfYQ0tyqEKOAYOu60cSt
   k=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 28 Feb 2022 06:18:24 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 06:18:24 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Feb 2022 06:18:23 -0800
Received: from [10.216.7.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 28 Feb
 2022 06:18:18 -0800
Subject: Re: [PATCH V7 3/5] regulator: Add a regulator driver for the PM8008
 PMIC
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1645182064-15843-1-git-send-email-quic_c_skakit@quicinc.com>
 <1645182064-15843-4-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n50GRE1hUxpeLcv_jdNtxHuABMpGNJO5oMvMGimQHxAwHA@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <6233f2c5-40b5-33ec-7864-812ed45884b1@quicinc.com>
Date:   Mon, 28 Feb 2022 19:48:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n50GRE1hUxpeLcv_jdNtxHuABMpGNJO5oMvMGimQHxAwHA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/19/2022 7:20 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-02-18 03:01:01)
>> Qualcomm Technologies, Inc. PM8008 is an I2C controlled PMIC
>> containing 7 LDO regulators.  Add a PM8008 regulator driver to
>> support PMIC regulator management via the regulator framework.
>>
>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>> diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
>> new file mode 100644
>> index 0000000..1c52864
>> --- /dev/null
>> +++ b/drivers/regulator/qcom-pm8008-regulator.c
>> @@ -0,0 +1,205 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
>> +
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/driver.h>
>> +#include <linux/regulator/machine.h>
>> +
>> +#define VSET_STEP_MV                   8
>> +#define VSET_STEP_UV                   (VSET_STEP_MV * 1000)
>> +
>> +#define LDO_ENABLE_REG(base)           ((base) + 0x46)
>> +#define ENABLE_BIT                     BIT(7)
> This is SPMI_COMMON_REG_ENABLE and SPMI_COMMON_ENABLE_MASK
>
>> +
>> +#define LDO_VSET_LB_REG(base)          ((base) + 0x40)
>> +
>> +#define LDO_STEPPER_CTL_REG(base)      ((base) + 0x3b)
>> +#define DEFAULT_VOLTAGE_STEPPER_RATE   38400
>> +#define STEP_RATE_MASK                 GENMASK(1, 0)
>> +
>> +struct regulator_data {
> Please use a name like spmi_regulator_data :) Or pm8008_regulator_data?
> Something that isn't so generic.


Okay.


> It seems similar to qcom_spmi-regulator.c so is there some reason we
> can't shove this into there? Less code for things that aren't relevant I
> guess?


As mentioned earlier, the register layout is not compatible and some 
other differences w.r.t to code like headrooms, using mfd driver to 
register ldos etc..


>> +       const char                      *name;
>> +       const char                      *supply_name;
>> +       u16                             base;
>> +       int                             min_uv;
>> +       int                             max_uv;
>> +       int                             min_dropout_uv;
>> +       const struct linear_range       *voltage_range;
