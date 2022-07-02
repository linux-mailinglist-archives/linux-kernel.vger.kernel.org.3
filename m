Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673A5563EC5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 08:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiGBGK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 02:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBGK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 02:10:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFA913F7A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 23:10:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fd6so5297527edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 23:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c9aRMVwYtfkfMlwkA5VyP9vLiqvlVljw+yPYyHTXtbE=;
        b=XNEYz0WpjDgjGstGMDxR+NmBd7nUrys9bGzgDKsIV45z11roggbhCKYBNhCNCtmIYC
         maqk6WGc7vXJdFP20NUQqic7e+FOrVELJrEhioTMp8zMgjufVu01xIn9rD5xNLd04YU5
         A3c4Ncp/uPx5z4obqA5v90No3fQsmTB1qX+h9PGo45ShuXhN5qHWep0IFHHtBRgOARJc
         t6yLh7/WSqya9XyY8QzxPYAEl1yTz3eyx4caDjdqDvATIqQTVnoLo+ozKD2Xfkd7nO6Q
         TV2WgtQcVBfvuHpXCOWdstIOg7n+UoQHCcLtZglA6XTwP6qiOzWofnOk5nWarXov5njM
         uhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c9aRMVwYtfkfMlwkA5VyP9vLiqvlVljw+yPYyHTXtbE=;
        b=Tpj/eqQacC1MoKCj2ze+jBijpR5/ievlg63r7RWDaElD+rMP4P4y2LQxguokWr60JY
         vw9HhlMxvKgPtBX39gnk5M/0DGKZXlSfzwh/tGn/zffCgd8yI8bZbT7QXHIzARDbWxJi
         XV2yXwukI1AgjxqFOQExWy5sxepnZGBoOqNqDhCo34f6+j/ROwK0os3XMp6xjOrEyndY
         2SocAFJ9ZZi0EqwxvjUqhiJESSLVhWW1zDXOYwHNhIXy0EL7u7qM92hl4sL2u6kNDeDf
         fjxs9TYAf7u8Lqv46Ec4YVO2y58HFwPRTQy+1UZbZ7PjGmyVKw32qez7Xcvg1vGm96Lx
         D9jw==
X-Gm-Message-State: AJIora+AvDRAcH5JYsMspMWOY0kESES4NTKy873626E58WYqDqsx9JAd
        y8VlrFuAGztSLFwzBnsOyoQ=
X-Google-Smtp-Source: AGRyM1sHU47hdgqgrbU8mfdIQmPvxLpnvEGtRtucKil8fW6N2BdEaIH7NXQajwpKwYiAzyaZku4QCA==
X-Received: by 2002:a05:6402:3591:b0:436:c109:1fa7 with SMTP id y17-20020a056402359100b00436c1091fa7mr23297705edc.208.1656742225416;
        Fri, 01 Jul 2022 23:10:25 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6912:39ab:4063:59d3:a7cd? (p200300c78f2e691239ab406359d3a7cd.dip0.t-ipconnect.de. [2003:c7:8f2e:6912:39ab:4063:59d3:a7cd])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00437d3e6c4c7sm6144249edb.53.2022.07.01.23.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 23:10:25 -0700 (PDT)
Message-ID: <7e78f88f-6957-2734-ddbc-5e6def80f106@gmail.com>
Date:   Sat, 2 Jul 2022 08:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 4/6] Staging: rtl8192e: Added braces around else
Content-Language: en-US
To:     Felix Schlepper <f3sch.git@outlook.com>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com
References: <cover.1656667089.git.f3sch.git@outlook.com>
 <651f51d9f92e8a445ceaf9f2073f16dd10458a74.1656667089.git.f3sch.git@outlook.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <651f51d9f92e8a445ceaf9f2073f16dd10458a74.1656667089.git.f3sch.git@outlook.com>
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

On 7/1/22 11:24, Felix Schlepper wrote:
> This addresses two issues raised by checkpatch.pl:
> 
>       $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
>       CHECK: braces {} should be used on all arms of this statement
>       CHECK: Unbalanced braces around else statement
> 
> The coding style rule with not using unnecessary braces around if/else
> does not apply if only one branch is a single statement.
> 
> Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
> ---
>   drivers/staging/rtl8192e/rtllib_wx.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> index db076e819993..b949e7234150 100644
> --- a/drivers/staging/rtl8192e/rtllib_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> @@ -304,8 +304,9 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
>   			netdev_dbg(ieee->dev,
>   				   "Disabling encryption on key %d.\n", key);
>   			lib80211_crypt_delayed_deinit(&ieee->crypt_info, crypt);
> -		} else
> +		} else {
>   			netdev_dbg(ieee->dev, "Disabling encryption.\n");
> +		}
>   
>   		/* Check all the keys to see if any are still configured,
>   		 * and if no key index was provided, de-init them all
> @@ -724,8 +725,9 @@ int rtllib_wx_set_auth(struct rtllib_device *ieee,
>   		} else if (data->value & IW_AUTH_ALG_LEAP) {
>   			ieee->open_wep = 1;
>   			ieee->auth_mode = 2;
> -		} else
> +		} else {
>   			return -EINVAL;
> +		}
>   		break;
>   
>   	case IW_AUTH_WPA_ENABLED:

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
