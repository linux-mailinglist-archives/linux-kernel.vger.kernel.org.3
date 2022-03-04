Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7B4CDFDF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiCDVrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCDVrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:47:51 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B517B2364FC;
        Fri,  4 Mar 2022 13:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646430422; x=1677966422;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ntN3yl5eMGGkiNg9DiYAf56yeIsPRxv4Lrtu44Q+nhs=;
  b=Hl3mzwXmyn7UZ3Re6DZnon2qX+15LRIqtA20sMq0KETBexMSJnTKFIBC
   GOUfEM/tYqkbSy6ua6I8nikXXkiDXsmBKym0LkAwA0RIkpgf0KfU9NZRU
   LIktaZz61LF7LDvIjdOIzBlbrECCDyZhy82aMVuAOX4I8OiIvd01kcOW6
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Mar 2022 13:47:01 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 13:47:01 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 4 Mar 2022 13:47:01 -0800
Received: from [10.226.58.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 4 Mar 2022
 13:46:59 -0800
Message-ID: <a7b08bec-1692-4b77-cd22-6177aaa95c5e@quicinc.com>
Date:   Fri, 4 Mar 2022 14:46:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 08/25] bus: mhi: ep: Add support for registering MHI
 endpoint controllers
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alex Elder <elder@linaro.org>
CC:     <mhi@lists.linux.dev>, <quic_hemantk@quicinc.com>,
        <quic_bbhatt@quicinc.com>, <vinod.koul@linaro.org>,
        <bjorn.andersson@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <quic_vbadigan@quicinc.com>, <quic_cang@quicinc.com>,
        <quic_skananth@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-9-manivannan.sadhasivam@linaro.org>
 <4cc78936-b419-4738-b5b2-65c53be06f33@linaro.org>
 <20220217095319.GA11964@workstation>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20220217095319.GA11964@workstation>
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

On 2/17/2022 2:53 AM, Manivannan Sadhasivam wrote:
> On Tue, Feb 15, 2022 at 02:02:41PM -0600, Alex Elder wrote:
> 
> [...]
> 
>>> +#define MHI_REG_OFFSET				0x100
>>> +#define BHI_REG_OFFSET				0x200
>>
>> Rather than defining the REG_OFFSET values here and adding
>> them to every definition below, why not have the base
>> address used (e.g., in mhi_write_reg_field()) be adjusted
>> by the constant amount?
>>
>> I'm just looking at mhi_init_mmio() (in the existing code)
>> as an example, but for example, the base address used
>> comes from mhi_cntrl->regs.  Can you instead just define
>> a pointer somewhere that is the base of the MHI register
>> range, which is already offset by the appropriate amount?
>>
> 
> I've defined two set of APIs for MHI and BHI read/write. They will add the
> respective offsets.
> 

While you are making changes, maybe don't have a set BHI_REG_OFFSET? 
Sure, I think it is always 0x200, but that is a convention and nothing 
I've seen in the spec mandates it.  You can derive it from the bhi 
offset register.

This way, if it ever moves in some future chip, this code should just work.
