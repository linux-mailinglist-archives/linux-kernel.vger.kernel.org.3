Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEC355257A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345000AbiFTULK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345223AbiFTUK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:10:59 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9601EEF6;
        Mon, 20 Jun 2022 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655755723; x=1687291723;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WoaLmubst55f6uHn7psiseCm0+Nuf62c9FVGfHGmGRY=;
  b=bLgp6e3/2ywkEultYq2EGyJOKQLds+cdIHWnlXg9iQRh6LzeoNhqAlIe
   bf+KiEEunEIkvzyjAShx++w57IxEELeM+N7e9skfhwkiacEloMuWgNf8y
   55ZEjLHSGjv25sKTmCbxpH1+snB6SMcnXYOo8l7SDzwbdN+m5s7OAy7n0
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 20 Jun 2022 13:07:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 13:07:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 13:07:57 -0700
Received: from [10.110.14.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 13:07:55 -0700
Message-ID: <6f1ade9f-38b0-827c-667b-5c8018b7779a@quicinc.com>
Date:   Mon, 20 Jun 2022 13:07:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v13 0/3] eDP/DP Phy vdda realted function
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1653512540-21956-1-git-send-email-quic_khsieh@quicinc.com>
 <YqvEjzgSbvrOCFtq@matsya>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <YqvEjzgSbvrOCFtq@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/16/2022 5:02 PM, Vinod Koul wrote:
> On 25-05-22, 14:02, Kuogee Hsieh wrote:
>> 1) add regulator_set_load() to eDP phy
>> 2) add regulator_set_load() to DP phy
>> 3) remove vdda related function out of eDP/DP controller
>>
>> Kuogee Hsieh (3):
>>    phy: qcom-edp: add regulator_set_load to edp phy
>>    phy: qcom-qmp: add regulator_set_load to dp phy
>>    drm/msm/dp: delete vdda regulator related functions from eDP/DP
>>      controller
>>
>>   drivers/gpu/drm/msm/dp/dp_parser.c  | 14 ------
>>   drivers/gpu/drm/msm/dp/dp_parser.h  |  8 ----
>>   drivers/gpu/drm/msm/dp/dp_power.c   | 95 +------------------------------------
>>   drivers/phy/qualcomm/phy-qcom-edp.c | 12 +++++
>>   drivers/phy/qualcomm/phy-qcom-qmp.c | 40 ++++++++++++----
> Please rebase this to phy-next and apply to specific qmp phy driver...
I will rebase to ==> 
https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
