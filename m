Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2D4BA383
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiBQOsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:48:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbiBQOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:47:55 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D55915E6E3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:47:40 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id s1so3894551iob.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0LwNHxMLBqWHq5UdmZcwyo12hCqKdpdE8z/NMC5mOnQ=;
        b=f4gEnGMI525rjiUi4DZX0djNgTslPdt5e+8rG9KofRiRGAgxnzNRhi8FA0jqVgs9no
         glP06rtX6XMFdFbCoVpMQq471WApvxcZ/Q13zENAzWIseHrjbf22QFegTofArtcU5Y8q
         Md7iTAGHviOkLuYkslG8Z4KxjfhyxWry6UKBaStc656ax4DYLXObmsn7Q322tZ70rZuQ
         CJ/qcqVSGFbHBZiG37Lbn5VFMj9VJtcLvnDRV934gLI08G4F8WQ7rwZhQw0UmO69AA5O
         v4MZBYlUMjqRVKTZgvoOcB38K5PlBJu7dlKMZM7J5gn1/nLHYaCUsp24QNxcZCIHbTye
         KRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0LwNHxMLBqWHq5UdmZcwyo12hCqKdpdE8z/NMC5mOnQ=;
        b=Ps4tHRUZf3Itg+akvcR/MgRhxEZXjm+e/2hEUe4FwyEeNbO7lOM4rSYrCmDX1RFgB7
         2nhx2fFTBY9zOt5/R7DIogDBgF6x4mLQ4CIlogak5lUyfcU/NP5Chkur/BAqwA5pZTgH
         WK528kVArGj1WrenTSqZSSUz2cP4vSKR7cv7J04rP1upq+ZBqrC8GoI+9bNsbCQ35g53
         eXvtSrf9GzpCXOLWBCbS27b5oAZGlMOfEFZHbhAVyOHmyXvSv84V/jFjv/H+gOfJJRpH
         TYERuRIOfidW7S5VDtkk7rSo95sjuXKJxlc4GA1Mw6yC0nTSuQfsxI3Sj8iNc3dUQ9MD
         cehw==
X-Gm-Message-State: AOAM530eJBqiBjvBWFGoB9KWq5ur4cZkkw7xbbzTTIR+hpnUaBPCtcP1
        4/kjTFFVjCEDBo1yTfFblqygPg==
X-Google-Smtp-Source: ABdhPJwYbU2SBo3j8jg7jYBmG36dJ69vqpIRCj4Pc+VDCa653h1SKlhGTiJW48GmhuJt6nMp6zLIyw==
X-Received: by 2002:a05:6638:1409:b0:30f:843:f953 with SMTP id k9-20020a056638140900b0030f0843f953mr2212765jad.22.1645109259664;
        Thu, 17 Feb 2022 06:47:39 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id f16sm2043929ioz.49.2022.02.17.06.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 06:47:38 -0800 (PST)
Message-ID: <95007a30-cf83-992c-79bd-80e332a7b6cf@linaro.org>
Date:   Thu, 17 Feb 2022 08:47:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 08/25] bus: mhi: ep: Add support for registering MHI
 endpoint controllers
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-9-manivannan.sadhasivam@linaro.org>
 <4cc78936-b419-4738-b5b2-65c53be06f33@linaro.org>
 <20220217095319.GA11964@workstation>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220217095319.GA11964@workstation>
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

On 2/17/22 3:53 AM, Manivannan Sadhasivam wrote:
> On Tue, Feb 15, 2022 at 02:02:41PM -0600, Alex Elder wrote:
> 
> [...]
> 
>>> +#define MHI_REG_OFFSET				0x100
>>> +#define BHI_REG_OFFSET				0x200

. . .

> [...]
> 
>>> +/* Generic context */
>>> +struct mhi_generic_ctx {
>>> +	__u32 reserved0;
>>> +	__u32 reserved1;
>>> +	__u32 reserved2;
>>> +
>>> +	__u64 rbase __packed __aligned(4);
>>> +	__u64 rlen __packed __aligned(4);
>>> +	__u64 rp __packed __aligned(4);
>>> +	__u64 wp __packed __aligned(4);
>>> +};
>>
>> I'm pretty sure this constitutes an external interface, so
>> every field should have its endianness annotated.
>>
>> Mentioned elsewhere, I think you can define the structure
>> with those attributes rather than the multiple fields.
>>
> 
> As I said before, this was suggested by Arnd during MHI host review. He
> suggested adding the alignment and packed to only members that require
> them.
> 
> But I think I should change it now...

Despite suggesting this more than once, I'm not 100% sure it's
even a correct suggestion.  I trust Arnd's judgement, and I
can see the value of being explicit about *which* fields have
the alignment requirement.  So I'll leave it up to you to
decide...  If you make my suggested change, be sure to test
it.  But I'm fine if you leave these as-is.

>>> +enum mhi_ep_ring_type {
>>> +	RING_TYPE_CMD = 0,
>>> +	RING_TYPE_ER,
>>> +	RING_TYPE_CH,
>>> +};
>>> +
>>> +struct mhi_ep_ring_element {
>>> +	u64 ptr;
>>> +	u32 dword[2];
>>> +};
>>
>> Are these host resident rings?  Even if not, this is an external
>> interface, so this should be defined with explicit endianness.
>> The cpu_to_le64() call will be a no-op so there is no cost
>> to correcting this.
>>
> 
> Ah, this should be reusing the "struct mhi_tre" defined in host. Will do.
> 
>>> +
>>> +/* Ring element */
>>> +union mhi_ep_ring_ctx {
>>> +	struct mhi_cmd_ctxt cmd;
>>> +	struct mhi_event_ctxt ev;
>>> +	struct mhi_chan_ctxt ch;
>>> +	struct mhi_generic_ctx generic;
>>> +};
>>> +
>>> +struct mhi_ep_ring {
>>> +	struct mhi_ep_cntrl *mhi_cntrl;
>>> +	int (*ring_cb)(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
>>> +	union mhi_ep_ring_ctx *ring_ctx;
>>> +	struct mhi_ep_ring_element *ring_cache;
>>> +	enum mhi_ep_ring_type type;
>>> +	size_t rd_offset;
>>> +	size_t wr_offset;
>>> +	size_t ring_size;
>>> +	u32 db_offset_h;
>>> +	u32 db_offset_l;
>>> +	u32 ch_id;
>>> +};
>>
>> Not sure about the db_offset fields, etc. here, but it's possible
>> they need endianness annotations.  I'm going to stop making this
>> comment; please make sure anything that's exposed to the host
>> specifies that it's little endian.  (The host and endpoint should
>> have a common definition of these shared structures anyway; maybe
>> I'm misreading this or assuming something incorrectly.)
>>
> 
> db_offset_* just holds the register offsets so they don't require
> endianness annotation. All MMIO read/write are using readl/writel APIs
> and they handle the endianness conversion implicitly.
> 
> Rest of the host memory accesses are annotated properly.

OK, good.

> 
>>> +
> 
> [...]
> 
>>> +	/*
>>> +	 * Allocate max_channels supported by the MHI endpoint and populate
>>> +	 * only the defined channels
>>> +	 */
>>> +	mhi_cntrl->mhi_chan = kcalloc(mhi_cntrl->max_chan, sizeof(*mhi_cntrl->mhi_chan),
>>> +				      GFP_KERNEL);
>>> +	if (!mhi_cntrl->mhi_chan)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = 0; i < config->num_channels; i++) {
>>> +		struct mhi_ep_chan *mhi_chan;
>>
>> This entire block could be encapsulated in mhi_channel_add()
>> or something,
> 
> Wrapping up in a function is useful if the same code is used in
> different places. But I don't think it adds any value here.
> 
>>
>>> +		ch_cfg = &config->ch_cfg[i];
>>
>> Move the above assignment down a few lines, to just before
>> where it's used.
>>
> 
> No, ch_cfg is used just below this.

Yes you're right, I missed that.

>>> +
>>> +		chan = ch_cfg->num;
>>> +		if (chan >= mhi_cntrl->max_chan) {
>>> +			dev_err(dev, "Channel %d not available\n", chan);
>>
>> Maybe report the maximum channel so it's obvious why it's
>> not available.
>>
>>> +			goto error_chan_cfg;
>>> +		}
>>> +
>>> +		/* Bi-directional and direction less channels are not supported */
>>> +		if (ch_cfg->dir == DMA_BIDIRECTIONAL || ch_cfg->dir == DMA_NONE) {
>>> +			dev_err(dev, "Invalid channel configuration\n");
>>
>> Maybe be more specific in your message about what's wrong here.
>>
>>> +			goto error_chan_cfg;
>>> +		}
>>> +
>>> +		mhi_chan = &mhi_cntrl->mhi_chan[chan];
>>> +		mhi_chan->name = ch_cfg->name;
>>> +		mhi_chan->chan = chan;
>>> +		mhi_chan->dir = ch_cfg->dir;
>>> +		mutex_init(&mhi_chan->lock);
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +error_chan_cfg:
>>> +	kfree(mhi_cntrl->mhi_chan);
>>
>> I'm not sure what the caller does, but maybe null this
>> after it's freed, or don't assign mhi_cntrll->mhi_chan
>> until the initialization is successful.
>>
> 
> This is not required here as there will be no access to the pointer
> after failing.

OK.

>>> +	return ret;
>>> +}
>>> +
>>> +/*
>>> + * Allocate channel and command rings here. Event rings will be allocated
>>> + * in mhi_ep_power_up() as the config comes from the host.
>>> + */
>>> +int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>>> +				const struct mhi_ep_cntrl_config *config)
>>> +{
>>> +	struct mhi_ep_device *mhi_dev;
>>> +	int ret;
>>> +
>>> +	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev)
>>> +		return -EINVAL;
>>> +
>>> +	ret = parse_ch_cfg(mhi_cntrl, config);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	mhi_cntrl->mhi_cmd = kcalloc(NR_OF_CMD_RINGS, sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);
>>
>> I said before I thought it was silly to even define NR_OF_CMD_RINGS.
>> Does the MHI specification actually allow more than one command
>> ring for a given MHI controller?  Ever?
>>
> 
> MHI spec doesn't limit the number of command rings. Eventhough I don't
> envision adding more command rings in the future, I'm going to keep this
> macro for now as the MHI host does the same.

OK.

> [...]
> 
>>> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
>>> new file mode 100644
>>> index 000000000000..20238e9df1b3
>>> --- /dev/null
>>> +++ b/include/linux/mhi_ep.h
> 
> [...]
> 
>>> +struct mhi_ep_device {
>>> +	struct device dev;
>>> +	struct mhi_ep_cntrl *mhi_cntrl;
>>> +	const struct mhi_device_id *id;
>>> +	const char *name;
>>> +	struct mhi_ep_chan *ul_chan;
>>> +	struct mhi_ep_chan *dl_chan;
>>> +	enum mhi_device_type dev_type;
>>
>> There are two device types, controller and transfer.  Unless
>> there is ever going to be anything more than that, I think
>> the distinction is better represented as a Boolean, such as:
>>
>> 	bool controller;
> 
> Again, this is how it is done in MHI host also. Since I'm going to
> maintain both stacks, it makes it easier for me if similarities are
> maintained. But I'll keep this suggestion and the one above for later.

Sounds good.  Thanks.

					-Alex

> Thanks,
> Mani

