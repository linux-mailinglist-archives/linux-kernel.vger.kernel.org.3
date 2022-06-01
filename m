Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755C253A3B8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352607AbiFALTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350587AbiFALTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:19:05 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0A3A76FA;
        Wed,  1 Jun 2022 04:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654082343; x=1685618343;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j2WptiZFrMPVKC6oFMmIy8W8fAs1p7FSZjkRo4TZHV0=;
  b=AIVtraew/9SX3q9818j9qKmyDg28YakAK5lNbC9tAJWoN1zI3HJtQT0N
   lrVvJfOcRqQRLUGPMXGXJDl0Tuo+ozEVEGYhD4MCXBHuVVTLYQScHpA4w
   vUJVHrCXP8OgVBzayHbKxvCPia48xDcEURlUUoYrpxMb15XLtJv7JHl3M
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Jun 2022 04:19:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 04:19:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 04:19:01 -0700
Received: from [10.50.27.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 1 Jun 2022
 04:18:55 -0700
Message-ID: <def29b3f-b5a1-5f23-7727-1308f7033cff@quicinc.com>
Date:   Wed, 1 Jun 2022 16:48:52 +0530
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
 <4b9a2abe-c462-81d9-2098-d430da24f030@quicinc.com>
 <CAE-0n529AD8OKrxbTpDNqR7Gw9SdCnJyWtiWvZAsADQKgj4kxQ@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <CAE-0n529AD8OKrxbTpDNqR7Gw9SdCnJyWtiWvZAsADQKgj4kxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/1/2022 7:36 AM, Stephen Boyd wrote:
> Quoting Satya Priya Kakitapalli (Temp) (2022-05-30 03:33:47)
>> On 5/28/2022 2:32 AM, Stephen Boyd wrote:
>>> Quoting Satya Priya Kakitapalli (Temp) (2022-05-27 01:24:19)
>>>> On 5/21/2022 8:26 AM, Stephen Boyd wrote:
>>>>           +       }
>>>>           +
>>>>           +       pm8008_reg->dev = dev;
>>>>           +
>>>>           +       rc = of_property_read_string(dev->of_node, "regulator-name", &name);
>>>>           +       if (rc)
>>>>           +               return rc;
>>>>           +
>>>>           +       /* get the required regulator data */
>>>>           +       for (i = 0; i < ARRAY_SIZE(reg_data); i++)
>>>>           +               if (strstr(name, reg_data[i].name))
>>>>
>>>>       Why not find this via reg/address instead? It would save storing the
>>>>       regulator name in the reg_data table.
>>>>
>>>>
>>>> You mean match this using base address? then we should add base address in the
>>>> reg_data table. We will need the name to be stored in reg_data table anyway for
>>>> the pm8008_reg->rdesc.of_match
>>> Why? Now that this driver binds to each node individually the usage of
>>> of_match doesn't make any sense to me. Can you set 'struct
>>> regulator_config::dev' instead and not set of_match?
>>
>> Currently we are setting regulator_config::dev as dev->parent i.e.,
>> pm8008@8, because the parent supplies are present under pm8008@8, to get
>> the regulators mapped correctly to the parent supplies we are using
>> dev->parent.
>>
>> If we do not set of_match in regulator descriptor,
>> regulator_of_get_init_node() would return NULL, causing init_data to be
>> NULL during regulator_register and regulators are not getting probed.
>> This can be resolved, if we get the init_data during pm8008_probe
>> itself. I'll do that in the next version.
>>
> Ok then it seems ok to leave it as is. I suspect getting init data
> during probe is more code vs. having the node name and the address in
> the table.


Okay. If we are leaving it as is then, there is no need to add address 
in the table.

