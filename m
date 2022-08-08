Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1806158CFD3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244480AbiHHVk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244556AbiHHVk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:40:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5605FAE5F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 14:40:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a89so12953107edf.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gkFvTJ+lMEAnmpJeB3TZKbAbGAultpKGgkndxtQgwnU=;
        b=PGF12FrKfQc8uLPYrpkrJL/G8CFXZQsXCrJCtRmMGovlq2aaxGywhxxwjH2ondvzpb
         dvp8x6hM6vOTPMbDv6o5Uk7e624rHMBsHSOaOyajzjzKcy5vwtVY8+DYUcqd3qR+SaX9
         f1nrl5lgYhaI0UtHEqglEgxoBHuesGV8JSv/4a4nb0rNxpKoKctMprtF4rqG8IQmtb9/
         /A1pvPrZwLsv4P2m3VpYWpY8jPZebmdKZpFIQ4BmPGXN2XZGT8FpQUwtw5t/MoFxD8w+
         4Gj1PJ9KJ1ePs1YDjnZyN5S9Cs+QXI1PmJVJCFfbQ0dWGfUy5ORbURStuJ9xbea48+cv
         9+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gkFvTJ+lMEAnmpJeB3TZKbAbGAultpKGgkndxtQgwnU=;
        b=lUH0Otv1hytnSyuM0Cx6L75QftTRW9C7bVTB72t2g1bZLQxuR2CAaFgAEDLkwY29xk
         YrDV/2O8lJQL4DMhsIa/V3yt84lW07vOdozQJXZVm7YhO0jhmd9bDv0M/a7urqxRv0WV
         T+XeL1T81/1f3J7Ot3OeuGROMAH1iV3YXQ4indddjzaTUgCaLVzRwI7WkNH/zj+Yd0Ig
         dhG9Mz31Fta2wYDMInQFa5AF1xnvDENmJiq0zHiYIfkJMBsgxg5NNxxxA3DmEh63g5HY
         +w1mVzf5OLq6rqwk5Cgc7qGjBq2fCUH5D6/S3nZw0WCZsHBZ0Vln0Z/gVYFEuyHYsKIy
         KU7g==
X-Gm-Message-State: ACgBeo3Ox/WLmeaHUK6wLQ2LkTweALK4vCdW2wYddTePVDAFSvZ7A27f
        FvQ3X2ERKBUaHQIS+D4Aa1UDVZFwcLM=
X-Google-Smtp-Source: AA6agR4nKPcmWadEOFeDp+tkJIwTtHVKgfyB9VaRZMUXB264prfV+TwmvsIgDSjtVNv5wTkK/bJqTw==
X-Received: by 2002:a05:6402:1d54:b0:43d:280c:f25b with SMTP id dz20-20020a0564021d5400b0043d280cf25bmr19705130edb.379.1659994853960;
        Mon, 08 Aug 2022 14:40:53 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id u25-20020aa7d999000000b0043bc19efc15sm5082775eds.28.2022.08.08.14.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 14:40:53 -0700 (PDT)
Message-ID: <db7b4ace-d8e7-a8c9-12c8-66049043ea32@gmail.com>
Date:   Mon, 8 Aug 2022 23:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: do not spam the kernel log
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220808065023.3175-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220808065023.3175-1-straube.linux@gmail.com>
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

On 8/8/22 08:50, Michael Straube wrote:
> Drivers should not spam the kernel log if they work properly. Convert
> the functions Hal_EfuseParseIDCode88E() and _netdev_open() to use
> netdev_dbg() instead of pr_info() so that developers can still enable
> it if they want to see this information.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 3 ++-
>   drivers/staging/r8188eu/os_dep/os_intfs.c       | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> index 5b8f1a912bbb..58a193334b91 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> @@ -688,6 +688,7 @@ Hal_EfuseParseIDCode88E(
>   	)
>   {
>   	struct eeprom_priv *pEEPROM = &padapter->eeprompriv;
> +	struct net_device *netdev = padapter->pnetdev;
>   	u16			EEPROMId;
>   
>   	/*  Check 0x8129 again for making sure autoload status!! */
> @@ -699,7 +700,7 @@ Hal_EfuseParseIDCode88E(
>   		pEEPROM->bautoload_fail_flag = false;
>   	}
>   
> -	pr_info("EEPROM ID = 0x%04x\n", EEPROMId);
> +	netdev_dbg(netdev, "EEPROM ID = 0x%04x\n", EEPROMId);
>   }
>   
>   static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G, u8 *PROMContent, bool AutoLoadFail)
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index cac9553666e6..22e91657f3fb 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -635,7 +635,7 @@ int _netdev_open(struct net_device *pnetdev)
>   		if (status == _FAIL)
>   			goto netdev_open_error;
>   
> -		pr_info("MAC Address = %pM\n", pnetdev->dev_addr);
> +		netdev_dbg(pnetdev, "MAC Address = %pM\n", pnetdev->dev_addr);
>   
>   		status = rtw_start_drv_threads(padapter);
>   		if (status == _FAIL) {

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
