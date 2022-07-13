Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08F57374D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiGMNYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiGMNYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:24:30 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA9D1A077
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:24:28 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id r82so14354394oig.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lUQLne+JhhKgQgKkIvDuMGH4xM00A9LvBOpvkHXzsyY=;
        b=lmMwME3g46cg8BRoIkdwP6l70gY/8HZZrCEbVCsM56FaKD2OSlHNgdHMKQUGnZAJWI
         Z7IU/DL4xvdcmNOORZsem0YrgjM4XpPQxzqE55Bxy3qGrizRLMMugPFeftgFJUyQDwLt
         UnNGJkPYDFGPMnvchhAfH5Ov/2Qj45QcZyo7U0m05drgNTFGwTIw8mXLzhf3BxbqQZD4
         j3Ag55p6EikhKxxi/Zsy22GhsyqRoXtlmf6AtdLEkz+whrwlyFWRflbKE4wTYXD/OhU2
         31bmXG1rpPy4q8xLd3QRdNLmoAt/phSanu7hQIXo/7A0tSIf4yvtK+Wi9OGx/yBcB89D
         NLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lUQLne+JhhKgQgKkIvDuMGH4xM00A9LvBOpvkHXzsyY=;
        b=IZDKMgDwPK3Bpt3SGXSACs42IrlI8ykql1Fcr2uUSKwrmXOFU4l9c1ju/756cwZpsf
         RemxvUR5u1/TnS67cjdXdAzBF/tOt/lCxUe+x8EXmWy9zdTZQ6xJcKMz9RN7tCtvmLQM
         sQoga44gNsnFCzCjk4DdJYmcSG/gTTSioENULMagNnyVzNpyFh0XdCp1vIx7FBpF871d
         Q+Y3JK7llk1vv7+sDwA77+oAbUVK27FnuuKF6MqiA7VE5zgaUTRgWEMoYCfxvybr92iw
         P9xThhJvtYV21Lv2tMTxRBnJ4FH5Zg8nwrISqaeBMBVO5bpZsmX4s4LbMQOZ5cdTiJrM
         7PDw==
X-Gm-Message-State: AJIora8/DEKxqdfzvaAikZ18w2tsPh+t3I8cowMsnhBBr/pPgTFdR49u
        VPCB6bPi0MhOAX5T9JwBXRs=
X-Google-Smtp-Source: AGRyM1uCzqROZt6ZnYpN6lbz4N5rUB35fNvpRXXUieJRDpqf6VwgQxsiQXc7FyE8lUraSYkAUqCxnw==
X-Received: by 2002:a05:6808:1928:b0:339:f15a:ec8f with SMTP id bf40-20020a056808192800b00339f15aec8fmr4723297oib.35.1657718667305;
        Wed, 13 Jul 2022 06:24:27 -0700 (PDT)
Received: from [192.168.1.108] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id y6-20020a056870458600b001089aef1815sm5941623oao.20.2022.07.13.06.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 06:24:26 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <a6cb9f7d-cd62-1ba9-ff1c-12e95073fd60@lwfinger.net>
Date:   Wed, 13 Jul 2022 08:24:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r888eu: use dynamic allocation for efuse buffer
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220713075804.140986-1-martin@kaiser.cx>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220713075804.140986-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 02:58, Martin Kaiser wrote:
> Use kmalloc to allocate the efuse buffer in ReadAdapterInfo8188EU and
> free it on exit. This is better than using a 512 byte array on the stack.
> 
> It's ok to drop the __aligned(4) qualifier. kmalloc aligns to
> ARCH_KMALLOC_MINALIGN, this is at least 8 bytes.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_halinit.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index 8902dda7b8d8..421fe7c40390 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -926,7 +926,7 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
>   {
>   	struct eeprom_priv *eeprom = &Adapter->eeprompriv;
>   	struct led_priv *ledpriv = &Adapter->ledpriv;
> -	u8 efuse_buf[EFUSE_MAP_LEN_88E] __aligned(4);
> +	u8 *efuse_buf;
>   	u8 eeValue;
>   	int res;
>   
> @@ -937,7 +937,10 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
>   
>   	eeprom->bautoload_fail_flag	= !(eeValue & EEPROM_EN);
>   
> -	memset(efuse_buf, 0xFF, sizeof(efuse_buf));
> +	efuse_buf = kmalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
> +	if (!efuse_buf)
> +		return;
> +	memset(efuse_buf, 0xFF, EFUSE_MAP_LEN_88E);
>   
>   	if (!(eeValue & BOOT_FROM_EEPROM) && !eeprom->bautoload_fail_flag) {
>   		rtl8188e_EfusePowerSwitch(Adapter, true);
> @@ -957,6 +960,7 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
>   	Hal_ReadThermalMeter_88E(Adapter, efuse_buf, eeprom->bautoload_fail_flag);
>   
>   	ledpriv->bRegUseLed = true;
> +	kfree(efuse_buf);
>   }
>   
>   static void ResumeTxBeacon(struct adapter *adapt)

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry
