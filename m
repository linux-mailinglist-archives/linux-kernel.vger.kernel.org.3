Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86784FF713
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiDMMu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiDMMu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:50:26 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A869C40E60
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:48:05 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y65so1731602iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9jPZG9/+m97btsIbUfBFkqEN0JQ7wZ3+b8nQQ/RX0/U=;
        b=QBoFY5ec7cTEQSifRW8FUGrkedVgwRZQotcNk3yipnOF3lhr9Pcn4eFZ9Puuwt97s9
         uXvcFWEzJ2ok1oCj6cpgUqFryCjxuO3hPjWQrNyMdJDmwZw2HOQrGwO1anN03ZPZZR65
         VSUM5TcLIQTgDrKFO1rlFgqmx4H88Sn4OPrXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9jPZG9/+m97btsIbUfBFkqEN0JQ7wZ3+b8nQQ/RX0/U=;
        b=6dKW/Siv9SJjpnNxaK/ZDqTW97RTyhKL+zcDcnoSUFo6XDuV4BBu5I4UA045lJRhBg
         DJHuB73zFGOcUg+oQpNlig7F0pRQ7YbM2ibk6cu3TJJ9+a3jUtOcIe4LCqIe3X+QB7az
         sn/2KbcSCIaIKY3faw3pIahy7NlsFscjnBKT/UQDxCVIv1Ef69bFrwk1E7UUzcrzi3HP
         LVlX8XaSg08RBcN2peSVOjnoJa1VgRxEgdjPxYOb/CbefrP5EzDJYRx9Q9/8Z6uBlS5L
         z/WwjJicsF3VpZ+ZPHLEMoOB+R46eFS3EogVasLZv0mHcl87iy38La22tZxyHvS0PSvb
         1grg==
X-Gm-Message-State: AOAM531Ssyf2Jj9JtYIcW+voVMurONFGTuOzs5B8/5GqMP9FrnsvK9X5
        1htW6lTWiAfbgW3qIvYhR+/L1w==
X-Google-Smtp-Source: ABdhPJwcDwROpz/UfIELVwrdwOuvg76PG0BW+jpB2S6XlS8+0l+GjJIkxkMWI7DdRYklftWbiiTamQ==
X-Received: by 2002:a02:271f:0:b0:326:af4:3f0c with SMTP id g31-20020a02271f000000b003260af43f0cmr11290770jaa.300.1649854085065;
        Wed, 13 Apr 2022 05:48:05 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id x186-20020a6bc7c3000000b00648deae6630sm24343335iof.54.2022.04.13.05.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 05:48:04 -0700 (PDT)
Message-ID: <a4e5c567-63dd-f7de-114b-a357075444a2@ieee.org>
Date:   Wed, 13 Apr 2022 07:48:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/2] staging: greybus: remove empty callback function
Content-Language: en-US
To:     Jaehee Park <jhpark1013@gmail.com>, johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <cover.1649824370.git.jhpark1013@gmail.com>
 <12037ae2502ad7d0311bcdf2178c3d2156293236.1649824370.git.jhpark1013@gmail.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <12037ae2502ad7d0311bcdf2178c3d2156293236.1649824370.git.jhpark1013@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 11:38 PM, Jaehee Park wrote:
> Remove the optional remove callback for the soc_codec_dev_gbaudio
> structure. The only place it is referenced is
> snd_soc_component_remove() which is only called if the sound_component
> pointer is non-null. The null function pointers here can be optionally
> ommitted. When a sound component is registered this way, the remove
> callback is optional. We can safely remove the whole gbcodec_remove
> function, which used to be an empty function with a void return type.

Now I think your description is a little long...  But that's OK.

This looks good to me.  Thank you for responding to all our
feedback.

Reviewed-by: Alex Elder <elder@linaro.org>
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
>   drivers/staging/greybus/audio_codec.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index 0f50d1e51e2c..dc030caa64ba 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -1029,12 +1029,6 @@ static int gbcodec_probe(struct snd_soc_component *comp)
>   	return 0;
>   }
>   
> -static void gbcodec_remove(struct snd_soc_component *comp)
> -{
> -	/* Empty function for now */
> -	return;
> -}
> -
>   static int gbcodec_write(struct snd_soc_component *comp, unsigned int reg,
>   			 unsigned int value)
>   {
> @@ -1049,8 +1043,6 @@ static unsigned int gbcodec_read(struct snd_soc_component *comp,
>   
>   static const struct snd_soc_component_driver soc_codec_dev_gbaudio = {
>   	.probe	= gbcodec_probe,
> -	.remove	= gbcodec_remove,
> -
>   	.read = gbcodec_read,
>   	.write = gbcodec_write,
>   };

