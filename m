Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D924BBC50
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbiBRPjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:39:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbiBRPjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:39:33 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B078B3DA41
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:39:16 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id j5so2197457ila.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VwsaeoUeJ22T2TW4cn8CPvPj+OsxArfVqqwFY08bAhM=;
        b=iWVaM+KGzRMFJt1OBbMJFdA2FcyOSEQR4LJ7B81mwaESj4YsbaNUwnluUs8nnJkpr9
         8Y2VZcJOibqh8n6TUaulLniXUAS4QEojAdBYeszkKKO7H2l5YAQ+ne9qiIGDUET5QYYA
         l95Ad8eQGGduWud19c++DFbRXjBUrq8/lvK0kqknaRTl35e+9xOSWUhcsnou7/pJPVw5
         ruh2w/+RkhxXCbu7OU06kJYc1vtvJJztX+G85OcEw1TttFno97aN70OiJ44hjDyDtnYv
         u7Wob04aDWuZxJGP8DprZrJNQuslZEMpZgnYAgvzQ+Cnw6UZHWCFkACU0AfrqQHYAe84
         yeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VwsaeoUeJ22T2TW4cn8CPvPj+OsxArfVqqwFY08bAhM=;
        b=wC64qAN/ELi+j26+DkZXbQLtaQLd6jBMDh+0wNDT4VgcyaOxMeCskoUl07ywUxI95s
         WPnfwiTGjaEm3z+gUAHU7AUOPI8a3XMp9kYLMd/J1af4lLsZbFpsWimDpeut3L1Kebad
         k0krOslsYzmcIQYeHEwTyBWDNE02YgMbgxC4xALkzyz+VXjXIls8Kw/gdZkrvPsOqAIw
         4GKUkMyLwFRPIOrw1srfWfzShy3KxiNHFNHFu/wStukiIGUZddWSa+TRMPzQUxWx7AcJ
         Vb2w3Zq+4OOgAjFRGLV3x4F39PqWnMVms3MsO/6N0qE2+XUdqqTAJVnQMlIAbLVvbueN
         6gBg==
X-Gm-Message-State: AOAM531ZjBf7Dt3WYFb2CU53/ABVFVQ4qTbVOVCmoieg9Wi3N6gbgAGm
        vZQ6mGY+mxvtGEu4Ug/PUHZFzIpfQt/gyqU7
X-Google-Smtp-Source: ABdhPJykOdkq3B8Pv6DQ8GuwWzQ7X7zppMZWqePsHUFZupRBGwOfgPOmn3jonMYG9dIRKCQQdlZzEw==
X-Received: by 2002:a92:2603:0:b0:2bf:86bc:f860 with SMTP id n3-20020a922603000000b002bf86bcf860mr6030831ile.75.1645198755464;
        Fri, 18 Feb 2022 07:39:15 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id g21sm4495723iow.4.2022.02.18.07.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 07:39:14 -0800 (PST)
Message-ID: <7de37015-da47-1f2e-9879-d84021905fed@linaro.org>
Date:   Fri, 18 Feb 2022 09:39:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 12/25] bus: mhi: ep: Add support for ring management
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-13-manivannan.sadhasivam@linaro.org>
 <20504c14-6df5-83d1-53e9-85c682a5a3c7@linaro.org>
 <20220218080704.GD11964@workstation>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220218080704.GD11964@workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 2:07 AM, Manivannan Sadhasivam wrote:
> On Tue, Feb 15, 2022 at 02:03:13PM -0600, Alex Elder wrote:
>> On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
>>> Add support for managing the MHI ring. The MHI ring is a circular queue
>>> of data structures used to pass the information between host and the
>>> endpoint.
>>>
>>> MHI support 3 types of rings:
>>>
>>> 1. Transfer ring
>>> 2. Event ring
>>> 3. Command ring
>>>
>>> All rings reside inside the host memory and the MHI EP device maps it to
>>> the device memory using blocks like PCIe iATU. The mapping is handled in
>>> the MHI EP controller driver itself.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> Great explanation.  One more thing to add, is that the command
>> and transfer rings are directed from the host to the MHI EP device,
>> while the event rings are directed from the EP device toward the
>> host.
>>
> 
> That's correct, will add.
> 
>> I notice that you've improved a few things I had notes about,
>> and I don't recall suggesting them.  I'm very happy about that.
>>
>> I have a few more comments here, some worth thinking about
>> at least.
>>
>> 					-Alex
>>
>>> ---
>>>    drivers/bus/mhi/ep/Makefile   |   2 +-
>>>    drivers/bus/mhi/ep/internal.h |  33 +++++
>>>    drivers/bus/mhi/ep/main.c     |  59 +++++++-
>>>    drivers/bus/mhi/ep/ring.c     | 267 ++++++++++++++++++++++++++++++++++
>>>    include/linux/mhi_ep.h        |  11 ++
>>>    5 files changed, 370 insertions(+), 2 deletions(-)
>>>    create mode 100644 drivers/bus/mhi/ep/ring.c
>>>
>>> diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
>>> index a1555ae287ad..7ba0e04801eb 100644
>>> --- a/drivers/bus/mhi/ep/Makefile
>>> +++ b/drivers/bus/mhi/ep/Makefile

. . .

>>> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
>>> index 950b5bcabe18..2c8045766292 100644
>>> --- a/drivers/bus/mhi/ep/main.c
>>> +++ b/drivers/bus/mhi/ep/main.c
>>> @@ -18,6 +18,48 @@
>>>    static DEFINE_IDA(mhi_ep_cntrl_ida);
>>
>> The following function handles command or channel interrupt work.
>>
> 
> Both

What I meant was to suggest a comment that stated that it
is used for both of those.  Not really a bit deal though.

>>> +static void mhi_ep_ring_worker(struct work_struct *work)
>>> +{
>>> +	struct mhi_ep_cntrl *mhi_cntrl = container_of(work,
>>> +				struct mhi_ep_cntrl, ring_work);
>>> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>>> +	struct mhi_ep_ring_item *itr, *tmp;
>>> +	struct mhi_ep_ring *ring;
>>> +	struct mhi_ep_chan *chan;
>>> +	unsigned long flags;
>>> +	LIST_HEAD(head);
>>> +	int ret;
>>> +
>>> +	/* Process the command ring first */
>>> +	ret = mhi_ep_process_ring(&mhi_cntrl->mhi_cmd->ring);
>>> +	if (ret) {
>>
>> At the moment I'm not sure where this work gets scheduled.
>> But what if there is no command to process?  It looks
>> like you go update the cached pointer no matter what
>> to see if there's anything new.  But it seems like you
>> ought to be able to do this when interrupted for a
>> command rather than all the time.
>>
> 
> No, ring cache is not getting updated all the time. If you look into
> process_ring(), first the write pointer is read from MMIO and there is a
> check to see if there are elements in the ring or not. Only if that
> check passes, the ring cache will get updated.
> 
> Since the same work item is used for both cmd and transfer rings, this
> check is necessary. The other option would be to use different work items
> for command and transfer rings. This is something I want to try once
> this initial version gets merged.

OK.  I accept your explanation (even though I confess I did not
go back and look at the code again...).

Thanks Mani.

					-Alex

> Thanks,
> Mani

