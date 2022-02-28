Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19504C7056
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbiB1PLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbiB1PLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:11:42 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7F780221
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:11:03 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 195so15061104iou.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XTQ8XgKYT+Q/JvWFqzx2y4Gzlrg2alh7l/BePdwDFcs=;
        b=UX8Egme6Uu9BuECN4hURosB7FqCaqlIpy73una+Vu6qM04exv4EAx6JCZ5kVMtpwqa
         IVEP6IfxoKWAh84UrQhxj6Q5dZ8SiN8Y+G6it2p+Fu6a3z9kNtCfYoj4qW7RlZtMrQnZ
         kzjroGud24OZ7X8p1I3gI6Mma+m8Jhe9BSw19vDDfHH7v4ZnPqWdwEDib1FGyB7yt1NB
         x2SOridVZ0BMfgfm9iyLTuGLC2/jX8PiHqbizvAkzpPo2uMJ5zNiy8lH4Ip9wuoGcwZc
         Gdx8az8cDRukH6VKAfePuvmTTD4Vah/B5fVGKJ19MdX6/M7HXrEUW5Qf+xZdmMorGA27
         HM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XTQ8XgKYT+Q/JvWFqzx2y4Gzlrg2alh7l/BePdwDFcs=;
        b=IORSFM92/vSeHnjmpskRxOsG0BxrlXWGu77ojLpc4m8uiNj7HYPXqlu4PnuIO0JpLM
         1p65EiPcLnfDNu51oaK0H95LQRG/pBkC0VWNoFjW5R0WLS/rPTEsHUYUxeKvPc1znVEa
         7OClxTYiKfGMQRlfqJ3ZE25+V+ADlSj1XQOlaqWuAnc1Uk+hCxTinqRYJlqA3R8jacKQ
         JaIV6/gaaqSTUYjmmAvfM8MZbyXuwTejjks4yGPkpqMVD06ZL5Ggs6SUVMVAX2kUmBvs
         FXxl3piRFR7c44KMRXRTed4ppWnbWGNBpMP/cxY+2jMeSNFbgtQWCdLJfoe567Yd32rp
         ZfQQ==
X-Gm-Message-State: AOAM532Pb9jXO5Lj5RgLhlyBuNBm1xr0i/bJxnneukDrmdrJtbabYm9x
        dpWtvtqWR7jp57Xg0qxwEQRTAg==
X-Google-Smtp-Source: ABdhPJwDp1HaPBPyDiCQZrAQM5hqCMVKJ2btPV685lxA8goodVZyCyK7w7mJ2Gjqsz4h0zaBPs7c+w==
X-Received: by 2002:a02:3f47:0:b0:314:4eea:a549 with SMTP id c7-20020a023f47000000b003144eeaa549mr17575819jaf.279.1646061062540;
        Mon, 28 Feb 2022 07:11:02 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v2-20020a92c802000000b002c1ed616004sm6481202iln.82.2022.02.28.07.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 07:11:01 -0800 (PST)
Message-ID: <c8bb126e-f71c-8ae7-74a3-46e05c803255@linaro.org>
Date:   Mon, 28 Feb 2022 09:11:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 05/27] bus: mhi: Use bitfield operations for handling
 DWORDs of ring elements
Content-Language: en-US
To:     'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     "mhi@lists.linux.dev" <mhi@lists.linux.dev>,
        "quic_hemantk@quicinc.com" <quic_hemantk@quicinc.com>,
        "quic_bbhatt@quicinc.com" <quic_bbhatt@quicinc.com>,
        "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
        "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "quic_vbadigan@quicinc.com" <quic_vbadigan@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_skananth@quicinc.com" <quic_skananth@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
 <20220228124344.77359-6-manivannan.sadhasivam@linaro.org>
 <90b1d3954b8c4157a4045db82b562271@AcuMS.aculab.com>
 <20220228144336.GB12451@workstation>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220228144336.GB12451@workstation>
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

On 2/28/22 8:43 AM, 'Manivannan Sadhasivam' wrote:
> On Mon, Feb 28, 2022 at 02:00:07PM +0000, David Laight wrote:
>> From: Manivannan Sadhasivam
>>> Sent: 28 February 2022 12:43
>>>
>>> Instead of using the hardcoded bits in DWORD definitions, let's use the
>>> bitfield operations to make it more clear how the DWORDs are structured.
>>
>> That all makes it as clear as mud.
> 
> It depends on how you see it ;)

It's possible David was commenting on the description, but I'm not sure.

> For instance,
> 
> #define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
> 
> vs
> 
> #define MHI_TRE_GET_CMD_TYPE(tre) (FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 1))))

Maybe you should create a static inline function to
encapsulate this (and the same for others).

In other words, something like:

#define MHI_TRE_DWORD_1_CMD_TYPE_MASK	GENMASK(23, 16)

static inline enum mhi_pkt_type
mhi_tre_cmd_type(struct mhi_ring_element el)
{
	u32 dword = le32_to_cpu(el->dword[1]);
	enum mhi_pkt_type cmd_type;

	return FIELD_GET(MHI_TRE_DWORD_1_CMD_TYPE_MASK, dword);
}

It's still a little messy, but breaking it out makes it a
little easier to understand, and the function makes the
types involved a little more obvious.

					-Alex

> The later one makes it more obvious that the "type" field resides between bit 23
> and 16. Plus it avoids the extra masking.
> 
>> Try reading it!
>>
> 
> Well I did before sending the patch.
> 
> Thanks,
> Mani
> 
>> 	David
>>
>>>
>>> Suggested-by: Alex Elder <elder@linaro.org>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>   drivers/bus/mhi/host/internal.h | 58 +++++++++++++++++++--------------
>>>   1 file changed, 33 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
>>> index 156bf65b6810..1d1790e83a93 100644
>>> --- a/drivers/bus/mhi/host/internal.h
>>> +++ b/drivers/bus/mhi/host/internal.h
>>> @@ -7,6 +7,7 @@
>>>   #ifndef _MHI_INT_H
>>>   #define _MHI_INT_H
>>>
>>> +#include <linux/bitfield.h>
>>>   #include <linux/mhi.h>
>>>
>>>   extern struct bus_type mhi_bus_type;
>>> @@ -205,58 +206,65 @@ enum mhi_cmd_type {
>>>   /* No operation command */
>>>   #define MHI_TRE_CMD_NOOP_PTR (0)
>>>   #define MHI_TRE_CMD_NOOP_DWORD0 (0)
>>> -#define MHI_TRE_CMD_NOOP_DWORD1 (cpu_to_le32(MHI_CMD_NOP << 16))
>>> +#define MHI_TRE_CMD_NOOP_DWORD1 (cpu_to_le32(FIELD_PREP(GENMASK(23, 16), MHI_CMD_NOP)))
>>>
>>>   /* Channel reset command */
>>>   #define MHI_TRE_CMD_RESET_PTR (0)
>>>   #define MHI_TRE_CMD_RESET_DWORD0 (0)
>>> -#define MHI_TRE_CMD_RESET_DWORD1(chid) (cpu_to_le32((chid << 24) | \
>>> -					(MHI_CMD_RESET_CHAN << 16)))
>>> +#define MHI_TRE_CMD_RESET_DWORD1(chid) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid)) | \
>>> +					FIELD_PREP(GENMASK(23, 16), MHI_CMD_RESET_CHAN))
>>>
>>>   /* Channel stop command */
>>>   #define MHI_TRE_CMD_STOP_PTR (0)
>>>   #define MHI_TRE_CMD_STOP_DWORD0 (0)
>>> -#define MHI_TRE_CMD_STOP_DWORD1(chid) (cpu_to_le32((chid << 24) | \
>>> -				       (MHI_CMD_STOP_CHAN << 16)))
>>> +#define MHI_TRE_CMD_STOP_DWORD1(chid) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid)) | \
>>> +					FIELD_PREP(GENMASK(23, 16), MHI_CMD_STOP_CHAN))
>>>
>>>   /* Channel start command */
>>>   #define MHI_TRE_CMD_START_PTR (0)
>>>   #define MHI_TRE_CMD_START_DWORD0 (0)
>>> -#define MHI_TRE_CMD_START_DWORD1(chid) (cpu_to_le32((chid << 24) | \
>>> -					(MHI_CMD_START_CHAN << 16)))
>>> +#define MHI_TRE_CMD_START_DWORD1(chid) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid)) | \
>>> +					FIELD_PREP(GENMASK(23, 16), MHI_CMD_START_CHAN))
>>>
>>>   #define MHI_TRE_GET_DWORD(tre, word) (le32_to_cpu((tre)->dword[(word)]))
>>> -#define MHI_TRE_GET_CMD_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
>>> -#define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
>>> +#define MHI_TRE_GET_CMD_CHID(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 1))))
>>> +#define MHI_TRE_GET_CMD_TYPE(tre) (FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 1))))
>>>
>>>   /* Event descriptor macros */
>>>   #define MHI_TRE_EV_PTR(ptr) (cpu_to_le64(ptr))
>>> -#define MHI_TRE_EV_DWORD0(code, len) (cpu_to_le32((code << 24) | len))
>>> -#define MHI_TRE_EV_DWORD1(chid, type) (cpu_to_le32((chid << 24) | (type << 16)))
>>> +#define MHI_TRE_EV_DWORD0(code, len) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), code) | \
>>> +						FIELD_PREP(GENMASK(15, 0), len)))
>>> +#define MHI_TRE_EV_DWORD1(chid, type) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid) | \
>>> +						FIELD_PREP(GENMASK(23, 16), type)))
>>>   #define MHI_TRE_GET_EV_PTR(tre) (le64_to_cpu((tre)->ptr))
>>> -#define MHI_TRE_GET_EV_CODE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
>>> -#define MHI_TRE_GET_EV_LEN(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFFFF)
>>> -#define MHI_TRE_GET_EV_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
>>> -#define MHI_TRE_GET_EV_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
>>> -#define MHI_TRE_GET_EV_STATE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
>>> -#define MHI_TRE_GET_EV_EXECENV(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
>>> +#define MHI_TRE_GET_EV_CODE(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0))))
>>> +#define MHI_TRE_GET_EV_LEN(tre) (FIELD_GET(GENMASK(15, 0), (MHI_TRE_GET_DWORD(tre, 0))))
>>> +#define MHI_TRE_GET_EV_CHID(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 1))))
>>> +#define MHI_TRE_GET_EV_TYPE(tre) (FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 1))))
>>> +#define MHI_TRE_GET_EV_STATE(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0))))
>>> +#define MHI_TRE_GET_EV_EXECENV(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0))))
>>>   #define MHI_TRE_GET_EV_SEQ(tre) MHI_TRE_GET_DWORD(tre, 0)
>>>   #define MHI_TRE_GET_EV_TIME(tre) (MHI_TRE_GET_EV_PTR(tre))
>>>   #define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits(MHI_TRE_GET_EV_PTR(tre))
>>> -#define MHI_TRE_GET_EV_VEID(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 16) & 0xFF)
>>> -#define MHI_TRE_GET_EV_LINKSPEED(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
>>> -#define MHI_TRE_GET_EV_LINKWIDTH(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFF)
>>> +#define MHI_TRE_GET_EV_VEID(tre) (FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 0))))
>>> +#define MHI_TRE_GET_EV_LINKSPEED(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 1))))
>>> +#define MHI_TRE_GET_EV_LINKWIDTH(tre) (FIELD_GET(GENMASK(7, 0), (MHI_TRE_GET_DWORD(tre, 0))))
>>>
>>>   /* Transfer descriptor macros */
>>>   #define MHI_TRE_DATA_PTR(ptr) (cpu_to_le64(ptr))
>>> -#define MHI_TRE_DATA_DWORD0(len) (cpu_to_le32(len & MHI_MAX_MTU))
>>> -#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) (cpu_to_le32((2 << 16) | (bei << 10) \
>>> -	| (ieot << 9) | (ieob << 8) | chain))
>>> +#define MHI_TRE_DATA_DWORD0(len) (cpu_to_le32(FIELD_PREP(GENMASK(15, 0), len)))
>>> +#define MHI_TRE_TYPE_TRANSFER 2
>>> +#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) (cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
>>> +							MHI_TRE_TYPE_TRANSFER) | \
>>> +							FIELD_PREP(BIT(10), bei) | \
>>> +							FIELD_PREP(BIT(9), ieot) | \
>>> +							FIELD_PREP(BIT(8), ieob) | \
>>> +							FIELD_PREP(BIT(0), chain)))
>>>
>>>   /* RSC transfer descriptor macros */
>>> -#define MHI_RSCTRE_DATA_PTR(ptr, len) (cpu_to_le64(((u64)len << 48) | ptr))
>>> +#define MHI_RSCTRE_DATA_PTR(ptr, len) (cpu_to_le64(FIELD_PREP(GENMASK(64, 48), len) | ptr))
>>>   #define MHI_RSCTRE_DATA_DWORD0(cookie) (cpu_to_le32(cookie))
>>> -#define MHI_RSCTRE_DATA_DWORD1 (cpu_to_le32(MHI_PKT_TYPE_COALESCING << 16))
>>> +#define MHI_RSCTRE_DATA_DWORD1 (cpu_to_le32(FIELD_PREP(GENMASK(23, 16), MHI_PKT_TYPE_COALESCING)
>>>
>>>   enum mhi_pkt_type {
>>>   	MHI_PKT_TYPE_INVALID = 0x0,
>>> --
>>> 2.25.1
>>
>> -
>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
>> Registration No: 1397386 (Wales)
>>

