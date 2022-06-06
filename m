Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B4F53EBD2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiFFKOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiFFKOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:14:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09521498C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:11:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d14so10175137wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SKMeYqCcEfGfSDa+Q181OzEqniNNtYhyJ3KyTSBEY4Y=;
        b=mlMaVVVH5V5IY6V+cat825TU8tvhR1u2cHimuFiap7iVJSe+XE7uHWFrzj6EnLuQK3
         mp5evB7Qw3HfmlN8DiU25Fwjf8mORJShAPBg2F8fezIWajhtssceeO53VhlUFNdkmS2U
         hF/W87/wUfMFCih1tfMiT2RyxlbdwYxdrP9vsKV2QH8fayGpS4/N3h2Y0FF0ORFnFXFd
         pkdQuCpbMoeY7NTPdPdZgmdF27l9Gm+VSf9fs+hMCjI+oshigc7CoNLaKrYWYvK3x7CK
         3+fu0fkhw/OmjX9A+TC+O975l7FA3Jz1KvzbcUpkxolykDnEfdH0Y4vvBv5/NPhXnD6X
         tuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SKMeYqCcEfGfSDa+Q181OzEqniNNtYhyJ3KyTSBEY4Y=;
        b=v0NfHYPtZ8e0w7SIOHfH7FXzpL/5M8q4QXT7KgE3iK3UNMWGVhOptPFYiOUvIDpe3X
         oUfhjtVhgiVIiOIFLqjZvf9bxikC+GkzB5wCVNycPdq4DAK0a1ivIa8LG9nkqE+ATnV9
         sUoq8+BtW47TX4n0+yaEnrfsJOLLnY8CosjfUKE+CALE7GxVC6HFL0vRFaw5fCSyDVK1
         JzlJmJqT06Zq318/Gw1jUAZ+CsbDvtAxk9qM4KEXh6yaKT82eHPFxZGSBruW7iLCUPRy
         G1rDaOj4x9pIcEbXhPnMN58eGXAdr3kj4PSfVa9SjT8mbvw/euCFfg3vnNCdbK+aMUaK
         xBGg==
X-Gm-Message-State: AOAM533rzEGBKxPtkE8eLC1TdPyandaoLgPjFd+eM/RaFUqlIipfLMwG
        DEvfIVi09JRT97v4SUYAtXcSCw==
X-Google-Smtp-Source: ABdhPJzuTMoyD/Jp/baSYmSwhReRg4JOV5WbVbl4L+tU9o+doSR2QFiSxN2MEG6WtjZLPQNyUse1ng==
X-Received: by 2002:a05:6000:1a88:b0:20e:6eb4:124e with SMTP id f8-20020a0560001a8800b0020e6eb4124emr21566830wry.8.1654510294109;
        Mon, 06 Jun 2022 03:11:34 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id 186-20020a1c19c3000000b0039c4ec6fdacsm3027736wmz.40.2022.06.06.03.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 03:11:33 -0700 (PDT)
Message-ID: <a8fdaff6-396c-5450-74a8-65acb660de5d@linaro.org>
Date:   Mon, 6 Jun 2022 11:11:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] slimbus: messaging: fix typos in comments
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220521111145.81697-88-Julia.Lawall@inria.fr>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220521111145.81697-88-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/05/2022 12:11, Julia Lawall wrote:
> Spelling mistakes (triple letters) in comments.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 

Applied thanks,

--srini
> ---
>   drivers/slimbus/messaging.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
> index e5ae26227bdb..4ce0cb61e481 100644
> --- a/drivers/slimbus/messaging.c
> +++ b/drivers/slimbus/messaging.c
> @@ -79,7 +79,7 @@ int slim_alloc_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn)
>   EXPORT_SYMBOL_GPL(slim_alloc_txn_tid);
>   
>   /**
> - * slim_free_txn_tid() - Freee tid of txn
> + * slim_free_txn_tid() - Free tid of txn
>    *
>    * @ctrl: Controller handle
>    * @txn: transaction whose tid should be freed
> @@ -101,7 +101,7 @@ EXPORT_SYMBOL_GPL(slim_free_txn_tid);
>    * @txn: Transaction to be sent over SLIMbus
>    *
>    * Called by controller to transmit messaging transactions not dealing with
> - * Interface/Value elements. (e.g. transmittting a message to assign logical
> + * Interface/Value elements. (e.g. transmitting a message to assign logical
>    * address to a slave device
>    *
>    * Return: -ETIMEDOUT: If transmission of this message timed out
> 
