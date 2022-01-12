Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8431448CB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356463AbiALTFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356438AbiALTEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:04:33 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3833DC06173F;
        Wed, 12 Jan 2022 11:04:33 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s30so11505058lfo.7;
        Wed, 12 Jan 2022 11:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AoPuX+EUlxzJxYdQxRNYp+9dW2sZW6liSiiQkVnA/Jw=;
        b=NO7erDCSXeezum1F/S4Q1RhF4Orm3SIVVirAVX/RwbK8t4jRcfKHi6TBRWRq8OX7WW
         BGoU0GYg4r2Tartb55ujVvTepkYFLYfUJjmWbrglXCghFolUnucinXGck7ibP9x8o57K
         YwmszPPlhdEj58moQ3gyxMHBguanVYHUjYSZQgzWcLNRySdL0RqhcLfMih5tkwKaVZr8
         MKkYdqpiWAgAEVunDLwsLDhOanE4YN83vDinjQ6lSjGDaW8JN6HsE3/P/gyqNafHo9Y9
         RUn8B2I61Gtpr07TfRqfva0Glvs9ADefUljifR9nNGu1pbq9UHknCjZ3hNQ/bTZpurON
         N5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AoPuX+EUlxzJxYdQxRNYp+9dW2sZW6liSiiQkVnA/Jw=;
        b=jnLwscBQeXnz2U5Fi8B7oQyXIRQ+0UqPdIFYKcixbGhWDiZZCgSbpKvVA7Djgm3k93
         BcT6p5FtUasbqghfU9iLbsk+z8u+YYr1B/Dt8wQeHqLCfVfZNb6EB4f7P00f7a0tOP05
         p9lOuJl9wLjjcRra3ceJXUsy+etKrfRsSm8dhMp5qaRqy96P3IKlHawmSmxw++Ua10QN
         vjIo4iA/Ca67Zw82P/1ftpskQuxKYQZsVTjcfslVWEz/ITvvpZ8rxQMOKhnjQVXbQZb9
         /MWYhAPQoY01pdIBr0FNVosMtt1PpTG9wgcNmnN6my9oOnkMWLTKLeFRTy0fXRzTvob2
         ZaeQ==
X-Gm-Message-State: AOAM5307PiMPJ8K49g668qu+F2YgdbpkELkv0NSUGcr00kyqkx+Z0X5g
        TYTXF3yQ2ffiGjFHoNUmPP9NvjVFQvg=
X-Google-Smtp-Source: ABdhPJxYmby34wzVXbOHaAIVC1OMnAStvNIDPd5+AYkLk6XmDkHvYoHM3XLMOL3hHUA2BFluOZ7QMQ==
X-Received: by 2002:a05:6512:74a:: with SMTP id c10mr819861lfs.234.1642014271240;
        Wed, 12 Jan 2022 11:04:31 -0800 (PST)
Received: from [192.168.2.145] (94-29-62-108.dynamic.spd-mgts.ru. [94.29.62.108])
        by smtp.googlemail.com with ESMTPSA id j1sm45110ljg.45.2022.01.12.11.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 11:04:30 -0800 (PST)
Subject: Re: [PATCH v1 2/2] media: staging: tegra-vde: Support V4L stateless
 video decoder API
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220112153952.1291-1-digetx@gmail.com>
 <20220112153952.1291-3-digetx@gmail.com>
 <e5bcc0a6d283ce3ed0cfe7d318232fb878c1b47d.camel@ndufresne.ca>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0ae51264-8578-0b4f-4348-7f7a239c98dc@gmail.com>
Date:   Wed, 12 Jan 2022 22:04:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e5bcc0a6d283ce3ed0cfe7d318232fb878c1b47d.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.01.2022 19:49, Nicolas Dufresne пишет:
> Le mercredi 12 janvier 2022 à 18:39 +0300, Dmitry Osipenko a écrit :
>> Expose Tegra video decoder as a generic V4L M2M stateless video decoder.
> 
> Thanks for working on this. Note that it would be nice to provide V4L2
> compliance test result, and if this is actually possible, provide fluster
> conformance results using ffmpeg, gstreamer, chromium or your own decoder,
> though if its your own, it would be nice to share a bit more so we can check
> that it's not interpreting the uAPI differently from other (we'd like drivers to
> work on multiple userland ideally).

Thank you for taking a look at this patch. Now I recalled that wanted to
run V4L2 compliance test, but forgot to do that.

I'll take a look at fluster, it's new to me.

> As usual I leave to other doing proper review, I added a comment below, pointing
> out the presence of a bitstream parser in this driver, and suggested an
> amendment to the spec to get rid of this. For me the code looks otherwise quite
> straight forward, is there any known issue that would keep this driver in
> staging ?

V4L decoding works on par with the legacy custom UAPI used by this
driver. I wish the hardware spec was made public, so we could support
more complex streams, but since it's not going to happen, I think
nothing keeps this driver in staging. It's working good for what is
supported.

> Please see below ...
> 
...
>> +	slice_type = tegra_h264_parse_slice_type(bitstream + bitstream_offset,
>> +						 bitstream_size);
> 
> Oh, this is a bit unfortunate, we didn't expect frame based decoder to ever need
> the slice_type (only available to slice based decoders). I've lookahead and
> notice a bitstream parsing, with emulation byte handling and Golum code. I
> expect to see maintainers concerns with doing this, the goals of the interface
> was to avoid parsing in kernel space (security in mind).

Initially I patched GStreamer to perform the flagging and it worked
okay. GStreamer even has variable for that, which is unused by the code
[1]. But in the end I decided that a universal solution will be a better
option.

[1]
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/blob/main/subprojects/gst-plugins-bad/gst-libs/gst/codecs/gsth264picture.h#L119

> If so, I may suggest to drop this fallback, and propose an amendment to the
> spec, we can require flagging KEYFRAME/PFRAME/BFRAME on the OUTPUT buffer, this
> won't break any drivers/userland on other HW, and will benefit possibly other HW
> in the future. I can volunteer to patch GStreamer and LibreELEC ffmpeg if we
> agree to this. Not sure how it works for Chromium, or if it actually make sense
> to support here.
> 
> (expecting feedback from Hans and Ezequiel here)

Amending the spec will be great, although it's not clear how to flag
frame that consists of slices having different types.

...
>> +static const struct v4l2_ctrl_config ctrl_cfgs[] = {
>> +	{	.id = V4L2_CID_STATELESS_H264_DECODE_PARAMS,	},
>> +	{	.id = V4L2_CID_STATELESS_H264_SPS,		},
>> +	{	.id = V4L2_CID_STATELESS_H264_PPS,		},
>> +	{
>> +		.id = V4L2_CID_STATELESS_H264_DECODE_MODE,
>> +		.min = V4L2_STATELESS_H264_DECODE_MODE_FRAME_BASED,
>> +		.max = V4L2_STATELESS_H264_DECODE_MODE_FRAME_BASED,
>> +		.def = V4L2_STATELESS_H264_DECODE_MODE_FRAME_BASED,
>> +	},
>> +	{
>> +		.id = V4L2_CID_STATELESS_H264_START_CODE,
>> +		.min = V4L2_STATELESS_H264_START_CODE_ANNEX_B,
>> +		.max = V4L2_STATELESS_H264_START_CODE_ANNEX_B,
>> +		.def = V4L2_STATELESS_H264_START_CODE_ANNEX_B,
>> +	},
>> +	{
>> +		.id = V4L2_CID_MPEG_VIDEO_H264_PROFILE,
>> +		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
>> +		.max = V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
>> +		.def = V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
> 
> No action needed, just be aware that exposing BASELINE is a small lie, since FMO
> and ASO feature are not supported in the uAPI.

Okay
