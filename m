Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B4F53C9A3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbiFCL5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbiFCL5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:57:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24482DF76
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 04:57:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so7032731pjq.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=34rSocizJb09HjwR+91Khzk0c3L2rvbKlfunkNL6ZSM=;
        b=ie3hggV9l5qcE0vEJaPy/d+ITeToBpoxavsFPO0485cnFmybFwkg9xY2hHbiY+ulOI
         Ia1rQyEy/PCxPcSXlcQKYkinxe0MIqkN+cMuyBym8QA72T8iRK3U5zI5vdWCfBG/go3C
         yX1Xf4Wgb8ZI0QkWlPN0O6hicizw8q6TMr7+cQlNdQFe37CDBmyBqorR4XOty6/4zkQD
         CcV4oTK8keYaVSwsBSSEeSB6TU9yssFQFmQVvmPwtp0cxQ4xvwdEBzVBihRwZu/ZOP1W
         +AMf/RmDy5ZeeFpp1Du2C6p4oAjwyJOsqUl1uG6tFb9k70bSg/jfPMeugU0mbF1JPGlk
         1G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=34rSocizJb09HjwR+91Khzk0c3L2rvbKlfunkNL6ZSM=;
        b=Rb02JvDDTiLl0LtohzMkz42wP4A0tODEj6tC6hJQzpYQp/UKZS6U9yFkl64xcvp468
         K1eNT2xBk9NWOd+GvNdLWh3bai1LOje2AgCUwsO55T0Qhz5F7dzovrbeDv+IccrHHyyU
         dWFi8VtsfBhfqvwZAFWcAoARpcpKmSQQKwpkjuno8FLxXMXz3At3q4FseBmI2Sr/6wkV
         xRmZEu2kSn7WNglU5JCok5Yy/DzQLifS1mAoYM1aGdEy9LL50vgPYRX1jCGY9faT9HXI
         4fLWkjTKf2556/dPvW4qPtIuY0zvqohXH9zisIWisp7TbW7q8/DnxBAGwhxcyYPNPVfD
         DIeA==
X-Gm-Message-State: AOAM532UaP93x2Hsl7JEBQgsG2LaKa93BJak/BGZ1y251lo7MRfWgr7B
        xl/yLUnm6BrAMH18xTLHwmw=
X-Google-Smtp-Source: ABdhPJyEeVXjpH76hxW8r29sZUD7ZV2+MCtDjMvUlOT9dUiTtfKaRep4Csnb9Mfw04p81OVyyj0Hlw==
X-Received: by 2002:a17:902:c407:b0:163:df01:bbbc with SMTP id k7-20020a170902c40700b00163df01bbbcmr9899611plk.4.1654257430575;
        Fri, 03 Jun 2022 04:57:10 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.243.30])
        by smtp.gmail.com with ESMTPSA id a10-20020a056a001d0a00b0051be2ae1fb5sm1196345pfx.61.2022.06.03.04.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 04:57:10 -0700 (PDT)
Message-ID: <64570db1-e9f2-4f23-1d14-3d4b35776bca@gmail.com>
Date:   Fri, 3 Jun 2022 17:27:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] char: lp: ensure that index has not exceeded LP_NO
Content-Language: en-US
To:     gregkh@linuxfoundation.org, arnd@arndb.de
References: <20220515075455.306082-1-sshedi@vmware.com>
Cc:     yesshedi@gmail.com, Shreenidhi Shedi <sshedi@vmware.com>,
        linux-kernel@vger.kernel.org
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <20220515075455.306082-1-sshedi@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/22 1:24 pm, Shreenidhi Shedi wrote:
> After finishing the loop, index value can be equal to LP_NO and lp_table
> array is of size LP_NO, so this can end up in accessing an out of bound
> address in lp_register function.
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  drivers/char/lp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
> index bd95aba1f..e61060f3c 100644
> --- a/drivers/char/lp.c
> +++ b/drivers/char/lp.c
> @@ -971,7 +971,7 @@ static void lp_attach(struct parport *port)
>  			if (port_num[i] == -1)
>  				break;
>  
> -		if (!lp_register(i, port))
> +		if (i < LP_NO && !lp_register(i, port))
>  			lp_count++;
>  		break;
>  

Hi Greg and Arnd Bergmann,

Please review the above changes. Ignore second patch.

--
Shedi
