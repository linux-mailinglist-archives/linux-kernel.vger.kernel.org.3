Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA264E2324
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbiCUJSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345794AbiCUJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:18:44 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AA734BA2;
        Mon, 21 Mar 2022 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647854238; x=1679390238;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XkrQh8HNOKRZTYZajKmSJy0yIre4EaEsaL+x3pMdeWs=;
  b=XSM1FchXV0yYg641znsDfu7wxosC66LnVQ5w4Kd8xKRYgCO04l8sbGUZ
   vExFXX1bvMj33Z0zf58A+pyrUg9SmI69nSZlpFbwuxUuV0aroaOzJxx8o
   eszSClKf1CEUfqnoVPtYXhsWFvtOC6NTg+oenkNY4gmqTt7YVYCDTHWK3
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Mar 2022 02:17:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 02:17:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 02:17:16 -0700
Received: from [10.216.21.109] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 21 Mar
 2022 02:17:11 -0700
Subject: Re: [PATCH v2 2/3] usb: xhci: Remove unwanted header inclusion
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
References: <1646130507-26796-1-git-send-email-quic_c_sanm@quicinc.com>
 <1646130507-26796-3-git-send-email-quic_c_sanm@quicinc.com>
 <YjR0gNPdeI5FTBGs@kroah.com>
From:   "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>
Message-ID: <adb12afc-4591-4a96-9988-e0d6a2ceb060@quicinc.com>
Date:   Mon, 21 Mar 2022 14:47:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <YjR0gNPdeI5FTBGs@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

Hi Greg,

On 3/18/2022 5:31 PM, Greg Kroah-Hartman wrote:
> On Tue, Mar 01, 2022 at 03:58:26PM +0530, Sandeep Maheswaram wrote:
>> Remove the header file and forward declare struct usb_hcd.
> Why?

This was done to address below comment in previous version

https://patchwork.kernel.org/project/linux-arm-msm/patch/1644949454-814-2-git-send-email-quic_c_sanm@quicinc.com/#24739885


>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>> ---
>>   include/linux/usb/xhci-plat.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/usb/xhci-plat.h b/include/linux/usb/xhci-plat.h
>> index 906e907..576e400 100644
>> --- a/include/linux/usb/xhci-plat.h
>> +++ b/include/linux/usb/xhci-plat.h
>> @@ -9,7 +9,8 @@
>>   #define _XHCI_PLAT_H
>>   
>>   #include <linux/types.h>
>> -#include <linux/usb/hcd.h>
>> +
>> +struct usb_hcd;
>>   
>>   struct xhci_plat_priv {
>>   	const char *firmware_name;
>> -- 
>> 2.7.4
>>
> Where did this come from?  Is this fixing a build breakage from a
> previous patch?  If not, why is this needed?
>
> confused,
>
> greg k-h

There wasn't any build breakage.

This was done to address below comment in previous version

https://patchwork.kernel.org/project/linux-arm-msm/patch/1644949454-814-2-git-send-email-quic_c_sanm@quicinc.com/#24739885

