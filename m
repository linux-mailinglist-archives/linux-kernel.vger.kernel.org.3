Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A459859C59A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbiHVR7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbiHVR7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:59:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB81F45F59
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:59:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq11so7611032wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7yBJRGwvl/pzUs+EDHj7+n2SkDx+t8AASlR3dqtZZaU=;
        b=YrTEYKKZZJ4+AKSYYoKlNFNH/p/HLBInnCt9pvlW0TOn3RykpWYHy34gjepSzQZY7R
         Yv7//FXhXGLAk+nHdErdXid773KJEqpXbQ3V7zZoD77P3KYy25Xb5dbumGodd1uCgAVT
         DXVyeMdRK+clNTwopsLiF0MzjeDfIaiUspH4h3vB+OcwBNn68ZPIC00EK/MA70F/v3Z8
         +1+l3Duh0ZbIxXAzlF5zScOTz1q4UY0FXnf9iFlZwJfQIS34YFtOubfJ4P1GYK1EPq3a
         aLhk0jo/R7tLEzIWKW5sgPe0JOVORpSQnhj+tNR8BfVTLLffCJM1pTSRWul4Mke3e5OU
         yu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7yBJRGwvl/pzUs+EDHj7+n2SkDx+t8AASlR3dqtZZaU=;
        b=7z9IS4wYROF6YQnh0QCYztdXPrDKGYuxsyeDs8L5yPrSVhoQMVvoLPr1wsz51+13C6
         9zaE1OGBvzbgERKt3UxNkzMwMZ/VPVE9sedyS4OgPBp83b9PS8cLhocNbKv1Pi2Tjmvh
         7XOESrnV18zmAnb6RRfs7cHwqVk4C6Ltqd41EZhCzOxZwhdu9fP37oEmxbVeHmM0Lhes
         UbSWYsaUikpw3Fvwu4iV1/YJTx2lQtcrbrMjpyl9mwk33GX3Gt+4kYjezVfV1bWCsDUc
         j3GBhxL8gMSHUAMUpxYEL8lxSI6z+mMlTz4K7gO2Psu59wchM+mn6mSViFYbuZ59jnpF
         Yp5g==
X-Gm-Message-State: ACgBeo20Z9W8KSVkmVrnuOdmpD2Cp6lVbPQRML/1g45NSp7+UBCMvkvt
        d8Dm0R7zpzrBqNOrCjS7k9c=
X-Google-Smtp-Source: AA6agR54fhx4TBdfypPsE0ikMuSvjARjCrHEb/YsmcAd6NF2wc6qTzPphSV/Qw7BzJQhbB9NLke3pQ==
X-Received: by 2002:a05:6000:156b:b0:222:c789:cb2d with SMTP id 11-20020a056000156b00b00222c789cb2dmr11648628wrz.197.1661191172237;
        Mon, 22 Aug 2022 10:59:32 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003a2e92edeccsm17150184wmp.46.2022.08.22.10.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 10:59:31 -0700 (PDT)
Message-ID: <5102d3a2-56b1-7111-72c9-905cd56f86bf@gmail.com>
Date:   Mon, 22 Aug 2022 19:59:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: remove unused module parameter
 rtw_chip_version
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220821123138.8070-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220821123138.8070-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/22 14:31, Michael Straube wrote:
> The module parameter rtw_chip_version sets the chip_version field of
> struct registry_priv but that field is never used in the driver code.
> Remove the unused module parameter.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/include/drv_types.h | 1 -
>   drivers/staging/r8188eu/os_dep/os_intfs.c   | 3 ---
>   2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
> index 79351b3aa60d..1bd0c8f3a358 100644
> --- a/drivers/staging/r8188eu/include/drv_types.h
> +++ b/drivers/staging/r8188eu/include/drv_types.h
> @@ -37,7 +37,6 @@
>   #define FW_RTL8188EU	"rtlwifi/rtl8188eufw.bin"
>   
>   struct registry_priv {
> -	u8	chip_version;
>   	u8	rfintfs;
>   	u8	lbkmode;
>   	u8	hci;
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 2d2a1c27d433..dd4e6aac3509 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -22,7 +22,6 @@ MODULE_FIRMWARE(FW_RTL8188EU);
>   #define RTW_NOTCH_FILTER 0 /* 0:Disable, 1:Enable, */
>   
>   /* module param defaults */
> -static int rtw_chip_version = 0x00;
>   static int rtw_rfintfs = HWPI;
>   static int rtw_lbkmode;/* RTL8712_AIR_TRX; */
>   static int rtw_network_mode = Ndis802_11IBSS;/* Ndis802_11Infrastructure; infra, ad-hoc, auto */
> @@ -104,7 +103,6 @@ char *rtw_initmac;  /*  temp mac address if users want to use instead of the mac
>   
>   module_param(rtw_initmac, charp, 0644);
>   module_param(rtw_channel_plan, int, 0644);
> -module_param(rtw_chip_version, int, 0644);
>   module_param(rtw_rfintfs, int, 0644);
>   module_param(rtw_lbkmode, int, 0644);
>   module_param(rtw_network_mode, int, 0644);
> @@ -151,7 +149,6 @@ static uint loadparam(struct adapter *padapter)
>   {
>   	struct registry_priv  *registry_par = &padapter->registrypriv;
>   
> -	registry_par->chip_version = (u8)rtw_chip_version;
>   	registry_par->rfintfs = (u8)rtw_rfintfs;
>   	registry_par->lbkmode = (u8)rtw_lbkmode;
>   	registry_par->network_mode  = (u8)rtw_network_mode;

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
