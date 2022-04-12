Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7804FE9CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 23:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiDLVFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 17:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiDLVFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 17:05:14 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2AD14924A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:52:30 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r11so14418379ila.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a8eg2yzAecVeUuwX/DvYd1G0G8R3IZjwawoKgnX7++A=;
        b=RoRUBLBNEdFp6tHUcgRo1ArWP9/7EpvS8lI3VgZN4k528t6NxFPQEZ240Fl3J3qPbA
         hDk7g5226Whc1WrnoxKw0HGvFkfSx1GZPBsBbOVUI9c0DDlsXd164UJDlaedPbNPktXw
         NP0r7q73+2fTY9yoBPt5V9WSFQ/+wBCNHlCcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a8eg2yzAecVeUuwX/DvYd1G0G8R3IZjwawoKgnX7++A=;
        b=d8znIrTp9MEnMsPuEuNzBTgqis5OWKB7H5MHWeGeQKT/dG+r5G7VWgGgg3sY6EsOQT
         iox3GN3OiBnXZ3kBvZAT8EWxlqnCoGj2D+3WB0YErfxjlBUXeDrLrRig/K/CY5fcObpd
         z5yP/TXRYD3uxCvEqq4ubdHT6gFZI9DXa69V7miCYAVO+Oe1SV6lU1WDc3G/irwqOmbd
         hISob/+mjSJkTJZYEEjwnz6WdCEekDhXYtSdETmNdT+E3bnoFwSIWfQFDWltyELwOlqY
         p2RY6IgF+OFB5vAGK9hMUcr6dY2CG58t+XnWsqacEXytTHuS0cCzqL0dB2uPWa1kODUT
         mMjQ==
X-Gm-Message-State: AOAM533TfYuktiLtmgrBfAtT1H9AO6SoKXe7YZGcGouOxFac+HjliskJ
        hRIAHJauACQHU2Au3uT7WFrWBxfIfVxD4Q==
X-Google-Smtp-Source: ABdhPJyZwF3N9eKCE+uoniArzYLmJrGKYpGN52eFh5MJtZwJUiayFr7Ejn+4wk0Cgoeay+Yn7sAs4g==
X-Received: by 2002:a5e:a717:0:b0:649:6328:792b with SMTP id b23-20020a5ea717000000b006496328792bmr16283519iod.54.1649795939583;
        Tue, 12 Apr 2022 13:38:59 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05660227ce00b00645ebb013c1sm25513647ios.45.2022.04.12.13.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 13:38:59 -0700 (PDT)
Message-ID: <34645b35-d857-cb57-77e2-2b913a2a0f95@ieee.org>
Date:   Tue, 12 Apr 2022 15:38:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] staging: greybus: correct typo in comment
Content-Language: en-US
To:     Jaehee Park <jhpark1013@gmail.com>, johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <cover.1649793138.git.jhpark1013@gmail.com>
 <811ff26b07cf61efcc2814ed5033e8864ef16d7e.1649793138.git.jhpark1013@gmail.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <811ff26b07cf61efcc2814ed5033e8864ef16d7e.1649793138.git.jhpark1013@gmail.com>
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
> Correct a spelling typo from 'Atleast' to 'At least' in comment.
> Issue found by checkpatch.
> 
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>

Thanks for updating the subject and description.

Looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

(When you send version 3 of these patches, please include the
above line above your "Signed-off-by" line, to indicate I've
reviewed it.)

> ---
>   drivers/staging/greybus/arche-apb-ctrl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
> index bbf3ba744fc4..45afa208d004 100644
> --- a/drivers/staging/greybus/arche-apb-ctrl.c
> +++ b/drivers/staging/greybus/arche-apb-ctrl.c
> @@ -445,7 +445,7 @@ static int __maybe_unused arche_apb_ctrl_suspend(struct device *dev)
>   static int __maybe_unused arche_apb_ctrl_resume(struct device *dev)
>   {
>   	/*
> -	 * Atleast for ES2 we have to meet the delay requirement between
> +	 * At least for ES2 we have to meet the delay requirement between
>   	 * unipro switch and AP bridge init, depending on whether bridge is in
>   	 * OFF state or standby state.
>   	 *

