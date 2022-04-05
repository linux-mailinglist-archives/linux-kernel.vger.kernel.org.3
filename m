Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE24F226F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiDEFKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiDEFJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:09:37 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77B8FD1B;
        Mon,  4 Apr 2022 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649135249; x=1680671249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SynVIeeqJ4gMyigKuFuVZOWVZKN22mkbmgQvCqXZPts=;
  b=sFYju/gQM0837cLo/xZYa2dh0yppGhu2l7+Tvv71tHGBO0z6ikNPJbxn
   u9UcfbLmJnmxg3A1jxNXcFdZvOpDZNEEeOjqYZGD7773l+9nwEdaVanJO
   XVpkO/x8Q7kz5myTZUd10I/McMPckT1axmf08P1P9SDOOeVe2Cr16SqIV
   k=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 04 Apr 2022 22:07:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 22:07:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Apr 2022 22:07:12 -0700
Received: from [10.216.10.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Apr 2022
 22:07:08 -0700
Message-ID: <da80fb48-0bf7-ddce-b2a5-a51a6673f180@quicinc.com>
Date:   Tue, 5 Apr 2022 10:37:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: sc7280: Add pinctrl for wcd938x
 codec reset and CTIA/OMTP headset selection
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1647863959-3289-1-git-send-email-quic_srivasam@quicinc.com>
 <1647863959-3289-2-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n50yxLZ6j32Cmx9gdACnKT3uJxc5wsOp3SAd4VHB7aNUvw@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n50yxLZ6j32Cmx9gdACnKT3uJxc5wsOp3SAd4VHB7aNUvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/2022 1:57 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-03-21 04:59:17)
>> Add pinctrl nodes for wcd codec reset and CTIA/OMTP headset type selection.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
> Please combine this patch with the consumer that uses the pinctrl nodes.
> Otherwise it is too hard to review the contents of this patch.
Okay. Will do accordingly.
