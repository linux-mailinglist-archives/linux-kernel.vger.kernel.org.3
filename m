Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47F3569B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiGGHHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiGGHHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:07:08 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8AED64;
        Thu,  7 Jul 2022 00:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657177627; x=1688713627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MVVnthjUDTVnZM9X3riNSKa4dXFwEii4fHlXf9p0rYI=;
  b=l9dv7GLsMVzAixz2P++iBUt0tnjsQ1a5TT2kLRIVKgcERuk3LMQ21cVh
   mC2EqVM01geMA7iAKOXrX8wLw4uyZJgT6z4QdW8ZERlg9fFj8eYZTSFfS
   vvYNGACdkwBdJw2U357XYxSYLKR242hZJVkz4LtvpNlHQYIxZqQUHSL/z
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 07 Jul 2022 00:07:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 00:07:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 00:07:06 -0700
Received: from [10.216.26.218] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 7 Jul 2022
 00:07:02 -0700
Message-ID: <ac679a45-9574-7978-860f-1a1bcefb53ec@quicinc.com>
Date:   Thu, 7 Jul 2022 12:36:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Update lpassaudio clock
 controller for resets
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        "Andy Gross" <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220614161118.12458-1-quic_tdas@quicinc.com>
 <Yqi8rcs95CEEjGY4@google.com>
 <CAE-0n50cqBWpDKsiyDNMZ8GnNtj7xJn930S1hucdAGn7tGXewA@mail.gmail.com>
From:   Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <CAE-0n50cqBWpDKsiyDNMZ8GnNtj7xJn930S1hucdAGn7tGXewA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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


Hi Stephen,

On 6/15/2022 2:08 AM, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2022-06-14 09:51:57)
>> On Tue, Jun 14, 2022 at 09:41:18PM +0530, Taniya Das wrote:
>>> The lpass audio supports TX/RX/WSA block resets. The LPASS PIL clock
>>> driver is not supported and mark it disabled. Also to keep consistency
>>> update lpasscore to lpass_core.
>>
>> There is a driver for "qcom,sc7280-lpasscc", what does it mean that is
>> isn't supported?
>>
>> IIUC one problem is that 'lpasscc@3000000' and 'lpass_aon / clock-controller@3380000'
>> have overlapping register ranges, so they can't be used together.
>>
>> You could just say 'Disable the LPASS PIL clock by default, boards
>> can enable it if needed'.
> 
> For the pinctrl driver we added a "qcom,adsp-bypass-mode" property[1] to
> indicate that the ADSP was being bypassed or not. Can we do the same
> here and combine the device nodes that have overlapping reg properties?
> 
> [1] https://lore.kernel.org/r/1654921357-16400-2-git-send-email-quic_srivasam@quicinc.com

Could we take up as a cleanup and take it forward:
https://lore.kernel.org/lkml/20220614153306.29339-1-quic_tdas@quicinc.com/T/#t

-- 
Thanks & Regards,
Taniya Das.
