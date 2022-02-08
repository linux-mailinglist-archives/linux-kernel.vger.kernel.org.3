Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B7A4AE359
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387223AbiBHWVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386662AbiBHVFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:05:12 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D96AC0612B8;
        Tue,  8 Feb 2022 13:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644354311; x=1675890311;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o7oYewk50pS0qCdX2y8F9493WNWazaE0j+QKGL2KdZo=;
  b=udVIrxP4pR+24mkn57gDxySmx2Zjxmki9MRlQ2p0ttCpcn7YHz+xEShQ
   7Ikm7QVkgvZ7WE4oZpNDyteXGcnzZVdbFUCeC1lyvFUOLuuomBqd5B3/v
   7pscPkTw0RZEyaUMLxhGpoNqr/muCKZR6QD7zPaDhK5PUxC/UKckZpyrf
   o=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 08 Feb 2022 13:05:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 13:05:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 13:04:48 -0800
Received: from [10.111.162.111] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 8 Feb 2022
 13:04:45 -0800
Message-ID: <ebd340e4-2a02-d484-2ed0-9ee738d5b5c5@quicinc.com>
Date:   Tue, 8 Feb 2022 13:04:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <seanpaul@chromium.org>, <swboyd@chromium.org>,
        <nganji@codeaurora.org>, <aravindh@codeaurora.org>,
        <khsieh@codeaurora.org>, <daniel@ffwll.ch>,
        <dmitry.baryshkov@linaro.org>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
 <8d67484c7e4b9fb4560d2eca1f71c75fde8bae0d.camel@sipsolutions.net>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <8d67484c7e4b9fb4560d2eca1f71c75fde8bae0d.camel@sipsolutions.net>
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

Hi Johannes

Thanks for the response.

On 2/8/2022 12:35 PM, Johannes Berg wrote:
> On Tue, 2022-02-08 at 11:44 -0800, Abhinav Kumar wrote:
>> There are cases where depending on the size of the devcoredump and the speed
>> at which the usermode reads the dump, it can take longer than the current 5 mins
>> timeout.
>>
>> This can lead to incomplete dumps as the device is deleted once the timeout expires.
>>
>> One example is below where it took 6 mins for the devcoredump to be completely read.
>>
>> 04:22:24.668 23916 23994 I HWDeviceDRM::DumpDebugData: Opening /sys/class/devcoredump/devcd6/data
>> 04:28:35.377 23916 23994 W HWDeviceDRM::DumpDebugData: Freeing devcoredump node
>>
>> Increase the timeout to 10 mins to accommodate system delays and large coredump
>> sizes.
>>
> 
> No real objection, I guess, but can the data actually disappear *while*
> the sysfs file is open?!
> 
> Or did it take 5 minutes to open the file?
> 
> If the former, maybe we should fix that too (or instead)?
> 
> johannes

It opened the file rightaway but could not finish reading.

The device gets deleted so the corresponding /data will disappear too ( 
as the data node is under devcd*/data)

60 static void devcd_del(struct work_struct *wk)
61 {
62 	struct devcd_entry *devcd;
63
64 	devcd = container_of(wk, struct devcd_entry, del_wk.work);
65
66 	device_del(&devcd->devcd_dev);
67 	put_device(&devcd->devcd_dev);
68 }

Are you suggesting we implement a logic like :

a) if the usermode has started reading the data but has not finished yet 
( we can detect the former with something like devcd->data_read_ongoing 
= 1 and we know it has finished when it acks and we can clear this flag 
then), in the timeout del_wk then we can delay the the delete timer by 
another TIMEOUT amount of time to give usermode time to finish the data?

b) If usermode acks, we will clear both the flag and delete the device 
as usual

But there is a corner case here:

c) If usermode starts the read, but then for some reason crashes, the 
timer will timeout and try to delete the device but will detect that 
usermode is still reading and will keep the device. How do we detect 
this case?

Thats why i thought maybe the easier way right now is to try increasing 
the timeout.
