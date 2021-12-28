Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E66480786
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 09:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhL1Iyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 03:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbhL1Iyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 03:54:52 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E1CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 00:54:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a9so36957045wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 00:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H5kooFMapB/0KjAVgfVIQg5n2UJOAisEF+Pze2Iutxc=;
        b=q6mKLH/W9YIDmIZ64NpWrbl80tK0H7KYBnVD9n1QlVR7nzrqFMSEqiJoggg7GMXQhB
         5nBbA7g6Jf8QnSGcDp4XgFubeqWYeI/coaXqHt3JltrZbp3MOuoS2suP+ZfxS36tVVtC
         LKunv0jeMgq/qnncyahcHcJjBvXx+B/e4jf1oYLemrmNOScHEF5zZICCdnObHU/pWxtj
         sESq5/WiVd43YuMc6yXhffqdcJlEBGGSBY6WAFEbfl0bJlq7hhQ8IH0QLFnhbnGTHrAV
         jTa6IrXf4aAd8Cu6r2CJxickUOxy/jqcHEEdk2xgL/Rs0AVyOXRbpE4K2p7Zf3E3/UDC
         fEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H5kooFMapB/0KjAVgfVIQg5n2UJOAisEF+Pze2Iutxc=;
        b=Aiylnl+gCBw3aoljZiCaNGslulY7wccAjpCwD5uVX5wVRAbqoUv8DgT1Ohm7c2iCwC
         V5QXABsRJvXpGxSezxV/lgi9LEyAtwQg3tWCGXk/xsd11M97pIGqhAQRxnrMl9AYaYUA
         h5VocT+GwWSS0E6FGJSyH8KJNUE6kAuifiht2IdZneyEzjFi9txhs5Y3o6UPYF7/+/sR
         /8TPiA8SCUrABX3kzMizywIdwDDF0LeBKiaUL8Dtgnoq/s5DJCHplUsHA7L08j6F0Mlk
         F0EoGwIrIzS9iINEaK0NXMuvl0GOGdZAk2vbICQ+KtMKCzlPR3DeAbUiOJYhcDpZGB9e
         XLxw==
X-Gm-Message-State: AOAM532Hp7gxwUvWmXAPXvMwxTbBTS4yQ2kOPkzeFeAjr9PDF8a0oRs/
        Ul3RtT7fWkNmxJCZPyBELSI=
X-Google-Smtp-Source: ABdhPJzQAxCWisCdkdfPr5vGpfIAG6IGoBOSCH9r8lH50zbUaVhfwdc1axTv6cEnISraUnufOUsQ8A==
X-Received: by 2002:adf:fe11:: with SMTP id n17mr15021730wrr.643.1640681690516;
        Tue, 28 Dec 2021 00:54:50 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7e8? ([2a02:8108:96c0:3b88::d7e8])
        by smtp.gmail.com with ESMTPSA id az15sm16843877wmb.47.2021.12.28.00.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 00:54:50 -0800 (PST)
Message-ID: <b6ff906f-63ff-17a1-9c1d-01e0ac8107d2@gmail.com>
Date:   Tue, 28 Dec 2021 09:54:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] staging: r8188eu: remove unused enum odm_h2c_cmd
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211227104312.13163-1-straube.linux@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211227104312.13163-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 11:43, Michael Straube wrote:
> The enum odm_h2c_cmd is not used in this driver. Remove it.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/include/odm_interface.h | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
> index 64c29c1da19d..e27ba77577a7 100644
> --- a/drivers/staging/r8188eu/include/odm_interface.h
> +++ b/drivers/staging/r8188eu/include/odm_interface.h
> @@ -4,13 +4,6 @@
>   #ifndef	__ODM_INTERFACE_H__
>   #define __ODM_INTERFACE_H__
>   
> -enum odm_h2c_cmd {
> -	ODM_H2C_RSSI_REPORT = 0,
> -	ODM_H2C_PSD_RESULT= 1,
> -	ODM_H2C_PathDiv = 2,
> -	ODM_MAX_H2CCMD
> -};
> -
>   /*  2012/02/17 MH For non-MP compile pass only. Linux does not support workitem. */
>   /*  Suggest HW team to use thread instead of workitem. Windows also support the feature. */
>   typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);

This patch is outdated, please drop it.
I'll resend it as part of a series.

Thanks,
Michael
