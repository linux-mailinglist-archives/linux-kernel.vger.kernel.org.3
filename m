Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67508511FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243747AbiD0RHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243653AbiD0RHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:07:03 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C113CC5;
        Wed, 27 Apr 2022 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651079032; x=1682615032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gWtMjealXxMHXRF0LWd1TUST3B9sTJlDVXRxi1eBdHI=;
  b=MhTVMTBCHhSUuvvmAsFQEkcBPYlkFiKvSMJgAOq+YDeEd8Q/XhFu3SyT
   6pCu25I51qAnzjLGAX6vMcvlBvYEZzsG3r+Nl71atUMxgImE1u4CWsNkx
   MMRrYwFbV+QdHOLSvyVW1zo4e9pvErIDQvsQY3AyAuC8fDrA0jkvh0uI1
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Apr 2022 10:03:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 10:03:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 10:03:51 -0700
Received: from [10.216.24.54] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 10:03:46 -0700
Message-ID: <5d0ebb2d-c672-8037-b1dd-bb8a61d4d027@quicinc.com>
Date:   Wed, 27 Apr 2022 22:33:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v11 2/4] arm64: dts: qcom: sc7280: Add MI2S pinmux
 specifications for CRD 3.0/3.1
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1650957666-6266-1-git-send-email-quic_srivasam@quicinc.com>
 <1650957666-6266-3-git-send-email-quic_srivasam@quicinc.com>
 <YmhrDvBGhqtdQVQ1@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YmhrDvBGhqtdQVQ1@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/27/2022 3:28 AM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Tue, Apr 26, 2022 at 12:51:04PM +0530, Srinivasa Rao Mandadapu wrote:
>
>> Subject: arm64: dts: qcom: sc7280: Add MI2S pinmux specifications for CRD 3.0/3.1
>>
>> Add drive strength property for primary and secondary MI2S on
>> sc7280 based platforms of rev5+ (aka CRD 3.0/3.1) boards.
> The subject and the commit message are misleading. What this
> change does is to configure these setting for all herobrine
> based boards, not only the CRD rev5+.
>
> That doesn't seem correct. The setting may be similar across
> boards, but they aren't necessarily the same, especially for
> the drive strength. One could argue that mi2s0 and the wcd9385
> are on the qcard and hence the config should be in
> sc7280-qcard.dtsi, however not all qcard based boards use the
> wcd9385, so the config shouldn't be shared across all of them.
> Please move it to sc7280-herobrine-crd.dts
Okay. Will do accordingly.
