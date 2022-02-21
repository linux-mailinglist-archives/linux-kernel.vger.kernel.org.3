Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB74D4BDC91
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358503AbiBUNDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:03:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346408AbiBUNDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:03:11 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EBAF34;
        Mon, 21 Feb 2022 05:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645448568; x=1676984568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KZx0AC6N1KetqJgjIGPHT+c6fRZkwXmMUhQ/6zLIsZ0=;
  b=zAipwSRgTinJBatAPL2aYqA5hrm6rOEFmtMmEQjQ7YQRvsA5M89Vn0xE
   Kkr2JUaFysvmR//urkkITDHAFsnFhWCHpzsjDMMTqsqgFVFuWPnL7cDIv
   +fiTuvV2/KhhqiZJNGKad0Arne1i54pYMunHuEuca5JOhLP2YjXfADBu/
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Feb 2022 05:02:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 05:02:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Feb 2022 05:02:47 -0800
Received: from [10.216.15.213] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 21 Feb
 2022 05:02:44 -0800
Message-ID: <58726955-9682-15fc-56c7-cf504ef4d3e9@quicinc.com>
Date:   Mon, 21 Feb 2022 18:32:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/3] soundwire: qcom: add pm runtime support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>,
        <yung-chuan.liao@linux.intel.com>
CC:     <pierre-louis.bossart@linux.intel.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
From:   "Srinivasa Rao Mandadapu (Temp)" <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
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

Thanks Srini for Your patches!!!

I think runtime pm support in bolero codecs side still pending right?


On 2/21/2022 4:11 PM, Srinivas Kandagatla wrote:
> This patchset adds pm runtime support to Qualcomm SounWire Controller using
> SoundWire Clock Stop and Wake up using Headset events on supported instances and
> a bus reset on instances that require full reset.
>
>
> Tested it on SM8250 MTP and Dragon Board DB845c
>
> --srini
>
>
> Srinivas Kandagatla (3):
>    soundwire: qcom: add runtime pm support
>    dt-bindings: soundwire: qcom: document optional wake irq
>    soundwire: qcom: add wake up interrupt support
>
>   .../bindings/soundwire/qcom,sdw.txt           |   2 +-
>   drivers/soundwire/qcom.c                      | 215 +++++++++++++++++-
>   2 files changed, 215 insertions(+), 2 deletions(-)
>
