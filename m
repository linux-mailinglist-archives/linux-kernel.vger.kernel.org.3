Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E066148A318
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbiAJWn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbiAJWn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:43:28 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E137DC06173F;
        Mon, 10 Jan 2022 14:43:27 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b13so6377249edn.0;
        Mon, 10 Jan 2022 14:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L3nxE3NC5WQDqgbf8XFAFwIX0VBGrF90p5azUyWILT4=;
        b=Q5ZQv10zp3VNrYs+xmNHMiyRP1a2adc8JMePB7WgIxkIWC1ebUCav34Yy7x4vT8T1a
         fNmEuQRENYEcQaDKe+tb50yTLW8A6sMKrkg8FHbCBLQwODEgQdMPpkXbzfFxjIzUP3St
         G0EQLRJWAuRtRzYNU6AQrYk0odaF/F8YJUN9m7K1TNGkyCsDYEnOdfzxfkR5f99bCwV6
         eI5/5bBKiwLgHTM7JBY0wJ6DhX3VHFtDjO4H2yjoKlrqp4X3/aZXAGhZaZSc2YaT8Cbh
         A/hZGxwnMdzMB0TR9l5dAvpHxbML3bddktBaLlatf7fbji3w2fxrYDEO4BAVXdwFgQvA
         CSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L3nxE3NC5WQDqgbf8XFAFwIX0VBGrF90p5azUyWILT4=;
        b=pCLI09XnTfxlRY3y86jkRwqdkhdCkEST1c3SIOKiUJwjMa19Kwdoo5nJCDOBkjSlRg
         +YFnul+Rf1n6XnsMtEPpAhEJhjCACQIt58Tab3Y6mDCWOTTtYsqqqqw4RtWvMsrHWeq+
         pzmiz9EJNCkW6lMEF2PLGy3AExQHFOpLrufCpPSWy2dwmCoFZn3Gmc2G4U54IhWvXkXh
         ghUWnmD9kvFkX2uMWnqa9NgRhsp/ClaC3PNGRk+cNm3oM1csC7widCcp01GmmkIdLc9K
         aKFYfYHVGeEHKiGjXoQD7YJWPFyUhb6wSFxgcfmved5CPPlSVfeXpcEOnGIDoQAaVZhZ
         zdkw==
X-Gm-Message-State: AOAM530VlgYSnbC6fLFTlpJVUdfUAMuV2wVfHfL54EHU7HE2+9SYpmNy
        32shsvmh5dTVeDlKIwHUCC9RY5ODEYU=
X-Google-Smtp-Source: ABdhPJx0WcBMaEnnloeLRUVE7kGac9jBsy225Jeg5JdKah764Ugg2FyIJUfNXq6GALvPiV1M1vqOQg==
X-Received: by 2002:a17:906:87c9:: with SMTP id zb9mr1428769ejb.49.1641854606489;
        Mon, 10 Jan 2022 14:43:26 -0800 (PST)
Received: from [192.168.0.182] ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id d15sm4228688edv.44.2022.01.10.14.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 14:43:26 -0800 (PST)
Message-ID: <ab212905-2377-040b-ce8a-2cef3ae13002@gmail.com>
Date:   Tue, 11 Jan 2022 00:43:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 2/2] iio: accel: add ADXL367 driver
Content-Language: en-US
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211217114548.1659721-1-cosmin.tanislav@analog.com>
 <20211217114548.1659721-3-cosmin.tanislav@analog.com>
 <20211223130100.059231d6@jic23-huawei>
 <edb634a17ba04f4cb5e77fa3b5c69358@analog.com>
 <20211228205757.7654cb66@jic23-huawei>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20211228205757.7654cb66@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/28/21 22:58, Jonathan Cameron wrote:
> Hi Cosmin,
> 
> Happy New year for a few day's time.
> 
>>> ...
>>>    
>>>> +
>>>> +static bool adxl367_push_event(struct iio_dev *indio_dev, u8 status)
>>>> +{
>>>> +	unsigned int ev_dir;
>>>> +
>>>> +	if (FIELD_GET(ADXL367_STATUS_ACT_MASK, status))
>>>> +		ev_dir = IIO_EV_DIR_RISING;
>>>> +	else if (FIELD_GET(ADXL367_STATUS_INACT_MASK, status))
>>>> +		ev_dir = IIO_EV_DIR_FALLING;
>>>> +	else
>>>> +		return false;
>>>> +
>>>> +	iio_push_event(indio_dev,
>>>> +		       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
>>> IIO_MOD_X_OR_Y_OR_Z,
>>>> +					  IIO_EV_TYPE_THRESH, ev_dir),
>>> This is unusual for event detection as it's a simple or of separately
>>> applied thresholds on X, Y and Z axes.  Given the effect of gravity that
>>> means you have to set the thresholds very wide.
>>>
>>> Also, I'd expect these to be magnitudes, not THRESH - no data sheet that
>>> I can find though so can't be sure.
>>>    
>>
>> Actually, the chip has a referenced, and an absolute mode. We use reference mode
>> in this driver, as configured in write_event_config.
>> The motion detection details are about the same as ADXL362 (page 14).
>> https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL362.pdf
> 
> Interesting.  We should figure out some way to make that clear to userspace
> given right now it has no way of knowing that and might set inappropriate limits
> without that information.
> 

Any suggestions on how I should do this?

> It's kind of similar to some of the adaptive thresholds, just that it uses
> the value at a particular moment.
> 
> Worth noting that for the adxl362 at least the maths is
> ABS(Acceleration - reference) > Threshold which is a magnitude not a threshold
> unless you want to represent it as a pair of thresholds (above and below) which
> gets fiddly as I assume there is only one control
> 

Indeed. I didn't catch onto the difference between magnitude and
threshold. So, I should use IIO_EV_TYPE_MAG rather than
IIO_EV_TYPE_THRESH? Or IIO_EV_TYPE_MAG_ADAPTIVE? The ABI doesn't
describe these too well.

>>
>>
>>>> +		       iio_get_time_ns(indio_dev));
>>>> +
>>>> +	return true;
>>>> +}
> 
> ...
> 
>>>> +static int adxl367_write_event_config(struct iio_dev *indio_dev,
>>>> +				      const struct iio_chan_spec *chan,
>>>> +				      enum iio_event_type type,
>>>> +				      enum iio_event_direction dir,
>>>> +				      int state)
>>>> +{
>>>> +	struct adxl367_state *st = iio_priv(indio_dev);
>>>> +	enum adxl367_activity_type act;
>>>> +	int ret;
>>>> +
>>>> +	switch (dir) {
>>>> +	case IIO_EV_DIR_RISING:
>>>> +		act = ADXL367_ACTIVITY;
>>>> +		break;
>>>> +	case IIO_EV_DIR_FALLING:
>>>> +		act = ADXL367_INACTIVITY;
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	ret = iio_device_claim_direct_mode(indio_dev);
>>>
>>> It's unusual (though not unheard of) to have events that cannot be enabled
>>> at the same time as a fifo.  If that's true here, please add some comments
>>> to explain why.  Or is this just about the impact of having to disable
>>> the measurement to turn it on and the resulting interruption of data
>>> capture?
>>>
>>> If so that needs more thought as we have a situation where you can (I think)
>>> have events as long as you enable them before the fifo based capture is
>>> started,
>>> but cannot enable them after.
>>>    
>>
>> That is indeed the case. You mentioned in a previous patchset that various
>> attributes could toggle measurement mode while the FIFO capture was running,
>> so I checked all the possible places where that could happen and added claim
>> direct mode. Not too nice, but it's the nature of the chip...
> 
> Hmm. I'm not sure what the right thing to do here is. Maybe we need a docs update
> to explicitly call out that this might happen for the event enables?  Calling
> it out for all devices is fine because all we are doing is saying userspace would
> ideally cope with this situation and make the decision to disable the buffered
> mode if it wants to enable events then reenable it afterwards if that is what
> is desired.

By docs you mean the ABI file?

> 
> Jonathan
> 
> 
