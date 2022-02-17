Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB024BA39E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbiBQOuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:50:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbiBQOuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:50:24 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1DA29E94E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:50:09 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id s20so342363ioe.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BB2sDvKYuJ4OLXpcVUGPxnotzFekLMPB3gl02E+RGsM=;
        b=YiEwitx6YvoB2nLcFD8bvXs7jZb3EykcXZmD7fGnXJ62QfN2Yn6CVFt4RdwWssx2KC
         dYoKA5BRbuFUaYUc0lWFTViyLS/tKHsiTwvaJTXxoqhp+UbIFWgR3DsuLjYujvXsK4+L
         iYKOsW6iphIC3oCHcdqoTdJSeHmYt2TXAdZfJA3N8jEbmY4ngcKM1DtFQnGcQKbz/FTN
         1SysA6Dqjq6au3OA26TkTt981TV/iENjZKyVxNnYikqzBDKKME3POcalIrzUemOIuP+F
         wgLo0vnfYDHl2Dsd8ty/kO0axIPJ2hGoCIB8R6C0Bkjbn3xx7FuZfBEk149pUrr6YNyd
         Nw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BB2sDvKYuJ4OLXpcVUGPxnotzFekLMPB3gl02E+RGsM=;
        b=GlavAWVP6ZDcH7lLvl9D+Dl8+YTlYa3RnBAHixWy1pwdR5fXo+EdLCIM59xN7WTEeC
         7LYVzjUnAVvsLGqYrFIgn6WaMQZRUFno786SQAo/dkUD8stoBLjDGJ1HAJKNSn4IgBoQ
         aRgxST4ct0sPMRP+qEx6Pi5Fa92NwcgPjJuCTvsktVLQbo/1qmdjrtNoHMkyRwFjxxzG
         GfEzRCDXtfT5EHshfVHM3JVXu3SFpxSmz+Yf1TF7Xl7hYNaAO1Z+V/NvboM7F3KkAwpW
         2/O+OwTZCIIqCYVcnZepHC3hzLls5GNfdHSy1T/HEK5eMBveosxUJWGmJU+d+7NrqNNM
         Ny9g==
X-Gm-Message-State: AOAM530f6+PB7tJqqpgOK3fd8H/Ujm5Fn6gpcNIuqZVLzNlqQYCdvIiI
        p4dBoOhKfzsOlV1tFhThL1ULuZs964liuw0b
X-Google-Smtp-Source: ABdhPJyMLeE45HvinoisFgWKSjp6PKe7sDpN4NNHmMEA8u9XTMVU1hPsnC7IB6GtHV9pPqbHeyxaCA==
X-Received: by 2002:a05:6602:1485:b0:635:213f:abd2 with SMTP id a5-20020a056602148500b00635213fabd2mr2158395iow.8.1645109408688;
        Thu, 17 Feb 2022 06:50:08 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id z23sm2016397iol.11.2022.02.17.06.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 06:50:08 -0800 (PST)
Message-ID: <c0b89a9e-156c-c56a-c387-5d9ee2c83871@linaro.org>
Date:   Thu, 17 Feb 2022 08:50:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 09/25] bus: mhi: ep: Add support for registering MHI
 endpoint client drivers
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-10-manivannan.sadhasivam@linaro.org>
 <94abdf83-5749-14b1-7a57-ceceb1b27167@linaro.org>
 <20220217102038.GB11964@workstation>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220217102038.GB11964@workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 4:20 AM, Manivannan Sadhasivam wrote:
> On Tue, Feb 15, 2022 at 02:02:50PM -0600, Alex Elder wrote:
> 
> [...]
> 
>>> +static int mhi_ep_driver_remove(struct device *dev)
>>> +{
>>> +	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
>>> +	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(dev->driver);
>>> +	struct mhi_result result = {};
>>> +	struct mhi_ep_chan *mhi_chan;
>>> +	int dir;
>>> +
>>> +	/* Skip if it is a controller device */
>>> +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
>>> +		return 0;
>>> +
>>
>> It would be my preference to encapsulate the body of the
>> following loop into a called function, then call that once
>> for the UL channel and once for the DL channel.
>>
> 
> This follows the host stack, so I'd like to keep it the same.

I think you should change both, but I'll leave that up to you.

>>> +	/* Disconnect the channels associated with the driver */
>>> +	for (dir = 0; dir < 2; dir++) {
>>> +		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
>>> +
>>> +		if (!mhi_chan)
>>> +			continue;
>>> +
>>> +		mutex_lock(&mhi_chan->lock);
>>> +		/* Send channel disconnect status to the client driver */
>>> +		if (mhi_chan->xfer_cb) {
>>> +			result.transaction_status = -ENOTCONN;
>>> +			result.bytes_xferd = 0;
>>> +			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>>
>> It appears the result is ignored here.  If so, can we
>> define the xfer_cb() function so that a NULL pointer may
>> be supplied by the caller in cases like this?
>>
> 
> result is not ignored, only the bytes_xfered. "transaction_status" will
> be used by the client drivers for error handling.

Sorry, I was looking at the code *after* the call, and was
ignoring that it was information being passed in...  My
mistake.

>>> +		}
>>> +
>>> +		/* Set channel state to DISABLED */
>>
>> That comment is a little tautological.  Just omit it.
>>
>>> +		mhi_chan->state = MHI_CH_STATE_DISABLED;
>>> +		mhi_chan->xfer_cb = NULL;
>>> +		mutex_unlock(&mhi_chan->lock);
>>> +	}
>>> +
>>> +	/* Remove the client driver now */
>>> +	mhi_drv->remove(mhi_dev);
>>> +
>>> +	return 0;
>>> +}
> 
> [...]
> 
>>> +struct mhi_ep_driver {
>>> +	const struct mhi_device_id *id_table;
>>> +	struct device_driver driver;
>>> +	int (*probe)(struct mhi_ep_device *mhi_ep,
>>> +		     const struct mhi_device_id *id);
>>> +	void (*remove)(struct mhi_ep_device *mhi_ep);
>>
>> I get confused by the "ul" versus "dl" naming scheme here.
>> Is "ul" from the perspective of the host, meaning upload
>> is from the host toward the WWAN network (and therefore
>> toward the SDX AP), and download is from the WWAN toward
>> the host?  Somewhere this should be stated clearly in
>> comments; maybe I just missed it.
>>
> 
> Yes UL and DL are as per host context. I didn't state this explicitly
> since this is the MHI host stack behaviour but I'll add a comment for
> clarity

Sounds good, thanks.

					-Alex

> 
> Thanks,
> Mani

