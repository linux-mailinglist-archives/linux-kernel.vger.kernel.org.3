Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC5B4FE98B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiDLUmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiDLUmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:42:22 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F075AC912
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:37:27 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b16so23673851ioz.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M/SL6jGK0Sq77N5QBCF7FLbfokc9NofrgU/f7GHCINE=;
        b=IGHMDTCFCmYvFcY7njXSJlq5+k0qU5W4RKrNwWjdDDtLEYgaqVaxm42hs8yzb6WHvi
         jI5oFH9aT9H6BbgEvLkflG7LUpoXZIkVqyRoKSHvOJrnrHR68almb7jBJqmT1ydKXMmF
         5dDrb5DB40NuvHlklLXupzunEgHfkDZC5MaS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M/SL6jGK0Sq77N5QBCF7FLbfokc9NofrgU/f7GHCINE=;
        b=Yo3PShpyexYgYLwZpYgCfFOPACGZqPNcXJFAhQcNJcHhBBij2Xf/In2cxRYdZpyVrE
         g0wRhEUnkFUgDggPec1me7V1KD+w8cCwqrd2SPFO3oiDvpEP8mqK3lCIyPSMAQu7lVv5
         3pA+8wgDg9tr70dRB8IN0xT3A2TmFf8fTS8hF7uWrv5QHN4lhvcgG0/LF8tXqcHyS4dY
         X7NP4VsCas7sEDxaI0jt6xVpvECxL9mkO1jiuQ5257xx/k8d31V6HeGpKy/XWDVC83tA
         m9H4aqHDqpQ2Z80LAwCH8K+qICwLqn8kFf6BeXLo3vz7VDvRYq/r+zQ7BThS3Cd/vnp6
         mZhA==
X-Gm-Message-State: AOAM5330cbS8UCMszBLaz+WqnYpGuWlXBz5Jg6As0B1qOS0CM1N+RzsF
        BIdbidyQzIGaV2TqJmU19DgJbtouhJPbUQ==
X-Google-Smtp-Source: ABdhPJyD/kOVnJKuPO9y/dGCfdQxgbauiG7ap0jN30d4ZSdU8kjF8qORVJzxwDZAtMgQAX1lLuZ9+Q==
X-Received: by 2002:a05:6638:380a:b0:326:3710:8ffe with SMTP id i10-20020a056638380a00b0032637108ffemr4372793jav.47.1649795706265;
        Tue, 12 Apr 2022 13:35:06 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id c15-20020a5d8b4f000000b00648f75d0289sm22348849iot.6.2022.04.12.13.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 13:35:05 -0700 (PDT)
Message-ID: <a509099e-2b19-7a27-693c-b418bd2f7b28@ieee.org>
Date:   Tue, 12 Apr 2022 15:35:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] staging: greybus: remove unneeded return
Content-Language: en-US
To:     Jaehee Park <jhpark1013@gmail.com>, johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <cover.1649793138.git.jhpark1013@gmail.com>
 <d4d01ecdabc492e52a3decebf165d1f584f3b3bf.1649793138.git.jhpark1013@gmail.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <d4d01ecdabc492e52a3decebf165d1f584f3b3bf.1649793138.git.jhpark1013@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 2:59 PM, Jaehee Park wrote:
> An empty function with void return type does not need an explicit
> return. Issue found by checkpatch.
> 
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>

Dan's suggestion here was to simply remove this function
entirely.  It is only used as the ->remove callback
for the soc_codec_dev_gbaudio structure.

You can see that soc_codec_dev_gbaudio is only used in the
call to devm_snd_soc_register_component() near the end of
"audio_codec.c".  When a sound component is registered
that way, the ->remove callback is optional.  You can see
that because the only place in "sound/soc/soc-component.c"
that it is referenced is snd_soc_component_remove() (as
Dan said), and it only calls the function if it the pointer
is non-null.  Allowing null function pointers in places
like this. to allow them to be optionally omitted is not
an uncommon pattern you'll see in the kernel.

Anyway, please don't just add another small patch to remove
the function.  Just replace *this* patch with one that
removes the function, and omits the assignment if its
address to soc_codec_dev_gbaudio->remove.

					-Alex

> ---
>   drivers/staging/greybus/audio_codec.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index 0f50d1e51e2c..3e3a16568def 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -1032,7 +1032,6 @@ static int gbcodec_probe(struct snd_soc_component *comp)
>   static void gbcodec_remove(struct snd_soc_component *comp)
>   {
>   	/* Empty function for now */
> -	return;
>   }
>   
>   static int gbcodec_write(struct snd_soc_component *comp, unsigned int reg,

