Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354AC4C70FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbiB1Pwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiB1Pwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:52:41 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E543A82D19
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:52:00 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id v5so10277763ilm.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n+LrXdbcpGcQ8auFYGfiJUll8i2HnwXcj9ZM2kN+ZWI=;
        b=cCiInmhSF4UKNIZsSBshdDzZjgdoJF2anW4ZfSHf8EhF9bQmAe0+h5U0g/DF6jdZPC
         0WcQwVOOS0mE9/30q1JVCTODRooSRxx8Xg/MqmZTEFhSdk9N+c0n/pVPYfdogbNB4Kaq
         ttf1Yv+7M2hF0ZQmZmzgRNUWE4Gwe4VYcvuPaDAkPRp/MO4SFRUvDK0QnH+uDvU78R+H
         ZfMo/Ih4aXtrRsAi6b9nEbszb75qsYIUqVk/ajMQi0g48khgpi6JTCVyu0dt+ORz4ThX
         ZcuK+EP0y0qefrtgNgay9cJ8KNStQsCg3q5U4Gqmj9VypItOw8PT+lDQ3Qbkf0vGJYCX
         G5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n+LrXdbcpGcQ8auFYGfiJUll8i2HnwXcj9ZM2kN+ZWI=;
        b=RqYUe2B+iFPXo6wCW/CGVCH6B3PcJMko4Yq/+TPmPWUajdhdRvfSpaf5ouE9sRQgg5
         tgzqAEXNiWRAbz1eRuBIXrFNG7cCidhJifvfu5Phu/8RIoDav8aHavB79Q2dfafBZtih
         mr9weVYQCRXlB9YyiwblPDSNlWjJHV4ulPMuqSDQnbw3Ama3V/tGT9k/Z9yoBjWV3zEH
         suNxPEXejKR/mw1ew9CQj0/7S5s1PGq41lVcZdf2bVoO5uEiIAKmd98DfQ5gB4QK6f8a
         LAQ5IR57ydoWptl3yBxR/JO72tmLJIGL1HWjjgaaPAAfb/f7TIoLMIlF4BPY6pEWaCJe
         O6gg==
X-Gm-Message-State: AOAM532javL4zxJ2md6xVQUh4W3qK9MwQDsnkg9OTB05dhSKISXK20TT
        PtsBn9Dc5Oflx31OXvpsaxa0IQ==
X-Google-Smtp-Source: ABdhPJyiELU+p4K8lD5zsnR15Ud37KFZggnoYuMacHPdu6g9dVWim9pWMBWGooBPrVZa0lMfdrN59g==
X-Received: by 2002:a05:6e02:17c7:b0:2c2:848f:fd62 with SMTP id z7-20020a056e0217c700b002c2848ffd62mr19731019ilu.91.1646063520260;
        Mon, 28 Feb 2022 07:52:00 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id k15-20020a92c24f000000b002c2e03c5925sm2501920ilo.8.2022.02.28.07.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 07:51:59 -0800 (PST)
Message-ID: <6423c8ed-8d3a-3f17-9947-1751e7a70a18@linaro.org>
Date:   Mon, 28 Feb 2022 09:51:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 05/27] bus: mhi: Use bitfield operations for handling
 DWORDs of ring elements
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
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
 <8433702975794b5389563393bf7bc405@AcuMS.aculab.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <8433702975794b5389563393bf7bc405@AcuMS.aculab.com>
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

On 2/28/22 9:40 AM, David Laight wrote:
> From: 'Manivannan Sadhasivam'
>> Sent: 28 February 2022 14:44
>>
>> On Mon, Feb 28, 2022 at 02:00:07PM +0000, David Laight wrote:
>>> From: Manivannan Sadhasivam
>>>> Sent: 28 February 2022 12:43
>>>>
>>>> Instead of using the hardcoded bits in DWORD definitions, let's use the
>>>> bitfield operations to make it more clear how the DWORDs are structured.
>>>
>>> That all makes it as clear as mud.
>>
>> It depends on how you see it ;)
>>
>> For instance,
>>
>> #define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
>>
>> vs
>>
>> #define MHI_TRE_GET_CMD_TYPE(tre) (FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 1))))
>>
>> The later one makes it more obvious that the "type" field resides between bit 23
>> and 16. Plus it avoids the extra masking.
> 
> No, (x >> 16) & 0xff is obviously bits 23 to 16.
> I can guess or try to remember what FIELD_GET() and GENMASK() do
> but it is really hard work.

Although I suggested the use of the bitfield functions, I don't
disagree with the above statement.

The intent was to simplify some code using some standard
helpers.  One benefit of those is that you don't need to
define the shift, because the mask already defines that
(so there is no chance for them mismatching).

The way this got implemented did not line up with what I had
envisioned though (and I had some discussion with Mani about
this earlier).  So this result ended up being messier than
I expected it would.

> Both lines are actually too long to read - especially given the
> number of times they are repeated with very minor changes.

I agree with that.

> I actually wonder if you shouldn't just have a struct like:
> struct mhi_cmd {
> 	__le64   address;
> 	__le16   len;
> 	u8       state;
> 	u8       vid;
> 	__le16   xxx; /* I can't see what this is */
> 	u8       chid;
> 	u8       cmd;
> };

I suggested something similar, and maybe more.  But here
too, Mani felt what he was doing was the right way and
that his way made things simpler overall.

I'm satisfied with the code, and frankly don't want to
delay it getting accepted any further if possible.

So I'm going to say this:

Reviewed-by: Alex Elder <elder@linaro.org>

However, Mani, please consider how you can make this
more readable, and have a plan to update things after
this gets accepted.  I suggested using inline functions
to help break it down a bit.  Or perhaps you could go
back to something like David suggests.

I don't need to review this again; I assume any changes
you make will improve the readability but will not change
the effect of the code.

					-Alex

> although you might need the odd anonymous union/struct
> to get the overlays in.
> 
> Even using something like:
> #define MAKE_WORD0(len, state, vid) (htole16(len) | state << 16 | vid << 16)
> would make for easier reading.
> 
> Oh yes, there are some 64bit fields here.
> So a 'word' is 64 bits, so a 'double word' would be 128 bits!
> 
> WTF is a DWORD anyway????
> Are you going to start using DWORD_PTR as well ?????
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

