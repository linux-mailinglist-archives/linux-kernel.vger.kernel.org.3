Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E705537925
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiE3KeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiE3Kd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:33:58 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860D763535;
        Mon, 30 May 2022 03:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653906836; x=1685442836;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uaWrA9Ka6myw33tDlOhmilsHeblqSEZ4ITcAA+dKBEk=;
  b=WbugykDdHpdWno0rxwICS/cC7Nfj3BRTHG3TZ9QOXIxt0wguQ1/ccuC/
   zKgXJjI1XIbh6NjtbQ1OCUQDDdOKxTocagAVNCcIznbEMxVSOqlZY/J0u
   iNvnDYiPC0vezSBzAYJ3QrTtY/QK/RNhsJ3CEYTlLEdlYThC/MsHKQOBt
   Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 May 2022 03:33:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 03:33:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 30 May 2022 03:33:54 -0700
Received: from [10.50.10.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 30 May
 2022 03:33:50 -0700
Message-ID: <4b9a2abe-c462-81d9-2098-d430da24f030@quicinc.com>
Date:   Mon, 30 May 2022 16:03:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V13 7/9] regulator: Add a regulator driver for the PM8008
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
References: <1653043777-24003-1-git-send-email-quic_c_skakit@quicinc.com>
 <1653043777-24003-8-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53WLYR1pjnr6wASVmXXQ7xTq5n2Q7GdeKOCkWf4H4n=0A@mail.gmail.com>
 <e70aceba-02d5-15b5-46d0-d5ed5706e81a@quicinc.com>
 <CAE-0n539gePyXhw7r+XcaHtooN98KfYsx_qwgDaFkJtMSg+80g@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <CAE-0n539gePyXhw7r+XcaHtooN98KfYsx_qwgDaFkJtMSg+80g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/28/2022 2:32 AM, Stephen Boyd wrote:
> HTML mail? Please send plaintext next time.
>
> Quoting Satya Priya Kakitapalli (Temp) (2022-05-27 01:24:19)
>> On 5/21/2022 8:26 AM, Stephen Boyd wrote:
>>
>>      Quoting Satya Priya (2022-05-20 03:49:35)
>>
>>          diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
>>          new file mode 100644
>>          index 0000000..6e815c6
>>          --- /dev/null
>>          +++ b/drivers/regulator/qcom-pm8008-regulator.c
>>          @@ -0,0 +1,225 @@
>>          +// SPDX-License-Identifier: GPL-2.0-only
>>          +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
>>          +
>>          +#include <linux/device.h>
>>          +#include <linux/kernel.h>
>>          +#include <linux/mfd/qcom_pm8008.h>
>>          +#include <linux/module.h>
>>          +#include <linux/of.h>
>>          +#include <linux/of_device.h>
>>
>>      What in of_device.h is used?
>>
>>
>> struct of_device_id
> That struct is defined in mod_devicetable.h, not of_device.h
>
>>
>>
>>          +#include <linux/platform_device.h>
>>          +#include <linux/regmap.h>
>>          +#include <linux/regulator/driver.h>
>>          +
> [...]
>>
>>          +};
>>          +
>>          +static int pm8008_regulator_get_voltage(struct regulator_dev *rdev)
>>          +{
>>          +       struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
>>          +
>>          +       return pm8008_reg->voltage_selector;
>>
>>      Can this read the hardware instead of caching the value from
>>      pm8008_regulator_set_voltage()?
>>
>>
>> I can use the regmap_bulk_read like below (which was present in the earlier
>> versions)
> Please do
>
>>          +       }
>>          +
>>          +       pm8008_reg->dev = dev;
>>          +
>>          +       rc = of_property_read_string(dev->of_node, "regulator-name", &name);
>>          +       if (rc)
>>          +               return rc;
>>          +
>>          +       /* get the required regulator data */
>>          +       for (i = 0; i < ARRAY_SIZE(reg_data); i++)
>>          +               if (strstr(name, reg_data[i].name))
>>
>>      Why not find this via reg/address instead? It would save storing the
>>      regulator name in the reg_data table.
>>
>>
>> You mean match this using base address? then we should add base address in the
>> reg_data table. We will need the name to be stored in reg_data table anyway for
>> the pm8008_reg->rdesc.of_match
> Why? Now that this driver binds to each node individually the usage of
> of_match doesn't make any sense to me. Can you set 'struct
> regulator_config::dev' instead and not set of_match?


Currently we are setting regulator_config::dev as dev->parent i.e., 
pm8008@8, because the parent supplies are present under pm8008@8, to get 
the regulators mapped correctly to the parent supplies we are using 
dev->parent.

If we do not set of_match in regulator descriptor, 
regulator_of_get_init_node() would return NULL, causing init_data to be 
NULL during regulator_register and regulators are not getting probed. 
This can be resolved, if we get the init_data during pm8008_probe 
itself. I'll do that in the next version.


