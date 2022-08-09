Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8983658D335
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiHIFc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHIFcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:32:53 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7453A17A9B;
        Mon,  8 Aug 2022 22:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1660023173; x=1691559173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kRh7Xg0bAN5gI5RiNA0NlWDogb/6vTO04ax3UGyd03A=;
  b=mTpMFD/Toy4y3Qo2NT5DNxESWrxtzR2BqQ3pJuR6vN2QhKhmF94H1UML
   3lrPBdP1DBazpmnDRhCfjTBoXdbIR180+SDyS0jEiCh6UZbmUNIevedAz
   4J2yeavgY8d17Tufh/uzpkR1aJ6ANvpoHxcGcI88Q9PqhcN2HXKID1ivi
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 08 Aug 2022 22:32:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 22:32:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 8 Aug 2022 22:32:51 -0700
Received: from [10.50.1.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 8 Aug 2022
 22:32:48 -0700
Message-ID: <8a4ccbc6-cf81-1939-40f6-4796550fc646@quicinc.com>
Date:   Tue, 9 Aug 2022 11:02:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V3 2/2] arm64: dts: qcom: sc7280: Update lpassaudio clock
 controller for resets
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>
References: <1658316144-16520-1-git-send-email-quic_c_skakit@quicinc.com>
 <1658316144-16520-3-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53wdhH2P729KDDbghScCcU=4-sFmxVugyJgxmGeFs4mgw@mail.gmail.com>
 <e28ef7e2-c23a-f87b-09b2-958f2212c30e@quicinc.com>
 <CAE-0n50qou6zy6E=cDafMi6RknMjtVgDiBnbeVE+tNTj-JLshw@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <CAE-0n50qou6zy6E=cDafMi6RknMjtVgDiBnbeVE+tNTj-JLshw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 8/9/2022 5:43 AM, Stephen Boyd wrote:
> Quoting Satya Priya Kakitapalli (Temp) (2022-07-26 22:51:08)
>> On 7/27/2022 6:52 AM, Stephen Boyd wrote:
>>> Quoting Satya Priya (2022-07-20 04:22:24)
>>>> From: Taniya Das <quic_tdas@quicinc.com>
>>>>
>>>> The lpass audio supports TX/RX/WSA block resets. Also to keep
>>>> consistency update lpasscore to lpass_core.
>>> Consistency with what?
>>
>> Hi Stephen,
>>
>>
>> We got a comment to change this on previous posts, to keep consistency
>> with the other nodes like lpass_aon etc
> Can you make that change in a different patch? Then the focus can be on
> what the patch subject is about. You're not changing the same lines,
> right?


No, I will move this change to separate patch.

