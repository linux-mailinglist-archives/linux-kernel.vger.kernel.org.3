Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3810649C7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbiAZKdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240044AbiAZKdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:33:49 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F712C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:33:49 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id h7so38016921ejf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JDPOR1SRUbDqEoavr/5bPQmBuHYS8fhwHW77mQ3ZGIQ=;
        b=iVhjPTjyX1JLwhUov1+kpQmjOcqNeo60P/B9i4czSsEFFcFL0RTFaaAVUmPccPfoP6
         wlZmE9eW4a83a5qfueIMh/fsw/430FAnGAwYDVoGRo0dx2TUqNcbZm5nZn9m0UpzWKv9
         p6hO8IXIIcXdUTYkPTy9gO3NZCoq7Q91U1A670mry1HBZpcBFiR7GRf9KzcT/DpvBwfs
         ZogjwgCDp0xU50gLZAv4jCmQq1+UmsIynDXawjH1VrXBHhMeYXzE6m8iEh3wv9CUDXlo
         YhBZUCGSeDUHq7Bp/04vIiJxyj+otTlV//NRxl56HovRDh46pVHsW2Bw8EYuATMOk0tb
         fFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JDPOR1SRUbDqEoavr/5bPQmBuHYS8fhwHW77mQ3ZGIQ=;
        b=XNtXyAqp5sW9TUQolzrrhttXnxmM7lbHo+02dfWetHrV2wcGzBcSnc9Ez2IVocvsgA
         NBDKhO6L75m7w9YISuefizC/68TdMkaRiK283pUq9S1MwH2Hpr/WV885tlqR41nlA1k5
         dW2Z+Ffw777uG6nTC/uqkTVNEX0SY/CBUrNUORWBIc9BXfuRKy2TSCJLDiwOyWrsnye/
         bdk1eTAi/L15Frls9ko5MLMaQ+bFddx6FWVjGyD+4eAOs9dySy2U8nKTbnfKuS2mxfN4
         ujDUw3EnJIhEHMtZVLTp5JtFBDOyZI24N6gLdSS0vmWfNP/EOHOaJ8jqcbf1vaO0bE6B
         sRtA==
X-Gm-Message-State: AOAM533sx/NidEZpeKv/wfxiDQhREONNmg3jPpKCBUTmdddB8GLyz9Tb
        7UbJx7yBrGScW2H1h9zMfVbJRcNP8ls=
X-Google-Smtp-Source: ABdhPJxU68uu1/4I14xkb/CI7GcckQjc7FUMaRH+HGlgiwwWWqF2iVqo9FGo4eYYGCWr2hAVAzu8Aw==
X-Received: by 2002:a17:907:3f87:: with SMTP id hr7mr1722123ejc.64.1643193227843;
        Wed, 26 Jan 2022 02:33:47 -0800 (PST)
Received: from [192.168.0.253] (ip5f5abb86.dynamic.kabel-deutschland.de. [95.90.187.134])
        by smtp.gmail.com with ESMTPSA id bv2sm7220228ejb.155.2022.01.26.02.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 02:33:47 -0800 (PST)
Message-ID: <e63e7a5c-68a8-8160-bc84-b5ecbca6e5cc@gmail.com>
Date:   Wed, 26 Jan 2022 11:33:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 10/10] staging: r8188eu: remove GlobalDebugLevel flag
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com
References: <20220124225032.860-1-phil@philpotter.co.uk>
 <20220124225950.784-1-phil@philpotter.co.uk>
 <20220124225950.784-3-phil@philpotter.co.uk>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20220124225950.784-3-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 23:59, Phillip Potter wrote:
> Remove hal/odm_debug.c, to get rid of the GlobalDebugLevel flag,
> and remove the two other lines that reference GlobalDebugLevel, as
> the last remaining user (DBG_88E) is now gone. Also modify Makefile
> to no longer build hal/odm_debug.c.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>   drivers/staging/r8188eu/Makefile            | 1 -
>   drivers/staging/r8188eu/hal/odm_debug.c     | 6 ------
>   drivers/staging/r8188eu/include/rtw_debug.h | 2 --
>   drivers/staging/r8188eu/os_dep/os_intfs.c   | 1 -
>   4 files changed, 10 deletions(-)
>   delete mode 100644 drivers/staging/r8188eu/hal/odm_debug.c
> 
> diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
> index a7a486cc16dd..ecd6fe5bd94c 100644
> --- a/drivers/staging/r8188eu/Makefile
> +++ b/drivers/staging/r8188eu/Makefile
> @@ -10,7 +10,6 @@ r8188eu-y = \
>   		hal/hal_intf.o \
>   		hal/hal_com.o \
>   		hal/odm.o \
> -		hal/odm_debug.o \
>   		hal/odm_HWConfig.o \
>   		hal/odm_RegConfig8188E.o \
>   		hal/odm_RTL8188E.o \
> diff --git a/drivers/staging/r8188eu/hal/odm_debug.c b/drivers/staging/r8188eu/hal/odm_debug.c
> deleted file mode 100644
> index 7a134229fe39..000000000000
> --- a/drivers/staging/r8188eu/hal/odm_debug.c
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/* Copyright(c) 2007 - 2011 Realtek Corporation. */
> -
> -#include "../include/rtw_debug.h"
> -
> -u32 GlobalDebugLevel;
> diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
> index 959fb6bd25ca..01a7d987d6cc 100644
> --- a/drivers/staging/r8188eu/include/rtw_debug.h
> +++ b/drivers/staging/r8188eu/include/rtw_debug.h
> @@ -52,6 +52,4 @@
>   
>   #define DRIVER_PREFIX	"R8188EU: "
>   
> -extern u32 GlobalDebugLevel;
> -
>   #endif	/* __RTW_DEBUG_H__ */
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 17249b4fb7ad..8589de487289 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -155,7 +155,6 @@ static uint loadparam(struct adapter *padapter)
>   {
>   	struct registry_priv  *registry_par = &padapter->registrypriv;
>   
> -	GlobalDebugLevel = rtw_debug;
>   	registry_par->chip_version = (u8)rtw_chip_version;
>   	registry_par->rfintfs = (u8)rtw_rfintfs;
>   	registry_par->lbkmode = (u8)rtw_lbkmode;

Hi Phillip,

so rtw_debug is unused now. Should we remove the 'debug' module
parameter and rtw_debug as well?

Regards,
Michael
