Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3B24BB7D2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiBRLLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:11:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiBRLKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:10:39 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29E62B4071;
        Fri, 18 Feb 2022 03:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645182616; x=1676718616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CbfVTNhsS2bqMRasM6gcxO6lnE300E5ZKpXg7xb5KNY=;
  b=C+qqt7AMdUnShTjExaUd6elC+3gVikMiE4f22bxqgQ51MRjNe6GyA70Z
   lOBcwj2Tqh38aCQXJAcFTeYOJf/P06YQutYKT8YwUtm1ks23v6e5xR/J1
   f7FAhmibvkRe36QREUJRdtl32D+V8atMvU0P37JzZaqYyVaSOZndGdUtW
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Feb 2022 03:10:16 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 03:10:15 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Feb 2022 03:10:15 -0800
Received: from [10.216.13.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 18 Feb
 2022 03:10:09 -0800
Message-ID: <25bb20e4-3de5-65fb-0520-fad8f352cc08@quicinc.com>
Date:   Fri, 18 Feb 2022 16:40:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 0/8] Add APCS support for SDX65
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <dianders@chromium.org>,
        <jassisinghbrar@gmail.com>, <linus.walleij@linaro.org>,
        <linux@armlinux.org.uk>, <mani@kernel.org>,
        <mturquette@baylibre.com>, <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1644821540-17928-1-git-send-email-quic_rohiagar@quicinc.com>
 <20220217220829.76DB9C340E8@smtp.kernel.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <20220217220829.76DB9C340E8@smtp.kernel.org>
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


On 2/18/2022 3:38 AM, Stephen Boyd wrote:
> Quoting Rohit Agarwal (2022-02-13 22:52:20)
>> Hello,
>>
>> This series adds APCS mailbox and clock support for SDX65. The APCS IP
>> in SDX65 provides IPC and clock functionalities. Hence, mailbox support
>> is added to the "qcom-apcs-ipc-mailbox" driver and a dedicated clock
>> driver "apcs-sdx65" is added.
>>
> Something is wrong with your series. I only see a couple patches and
> they're not threaded.

I uploaded the patches individually based on the maintainers which is why it is not coming as thread. I will upload the next version as a patch series with the comments addressed. Thanks!

