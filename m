Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE424FFA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbiDMPlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiDMPlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:41:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F17A654BA;
        Wed, 13 Apr 2022 08:38:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso2626120pjh.3;
        Wed, 13 Apr 2022 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0yec1enjCeHuEsZdYQYVsHUxCAVmB/vYXKs5nIk3Z50=;
        b=ZFQXu9DcWOTea3sc/KQ69KmeTgc9qyoWVjUPjhyUL5lQt4MaZjgPkFwgN27Dq/Dy1J
         k7+KzCI6nHn+Nn3Qw0TX17u0QBfm/MiWDuStpHBU1OckKU4O6Do6AwtB2EMVZQJgASkX
         xP7tA0ZlqLSYzRDXifHoNjMHWnoPjvHUdY/zmnSyUAA4ZJitlAkO6XmE2y+Q26Nkl04z
         kaqWoEjXVoliO0cwpbz7jXi8aeCsuQcpwZAHDX1AKC4t0b3FzuX99egojY8eDkgMsf/Q
         Pl1ioYOhE7ai3LOcwOlT4QKT8doeJiAEUTv++1D5GcLq/Qdh84GE0wxEzrWAxdsisZlT
         EZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0yec1enjCeHuEsZdYQYVsHUxCAVmB/vYXKs5nIk3Z50=;
        b=oCtVerZPjDYG7dLz901qkLbOtYd0WjuXs/LbswDlDFwcFPywoTApgeyYXSfUQyBJxv
         G8WSKtWNq9Ur3+YsYD5dJQzNjMqbf6pCvCFqIZQySAjZ2Fdh0wBW5z9WAkp1mVrtS5SH
         BYvcN04IFwLhoWOfh1pemwx2lwFyaI2PcK33NIXpjXXpyeTp8Z8LFrAQIvieH6W88wte
         zHwbNtMlOyO/psllFPNsYWyCSpu34liS/eQeRUh52TeSZqp4xjI+0BQfIo6KbTbTMCeK
         k9S96slP/nEE79XvutH9owXxw5r9DwbJuwsajT9cpxEvAEG/GseZdxqGGKb6y0aAWSFT
         rxEA==
X-Gm-Message-State: AOAM531h3zJzkxP4s8Pyzz1CH18x3JTnN+DEnK9qvVz7pD7P9DsQ9fP+
        WrBuABHK0AiUC9J4oW3ES8I=
X-Google-Smtp-Source: ABdhPJxoxsrxUe08aoYeorQsNSnROQ73dUbYAK4djWPhjhDsp0KohsY7uvEpTZmrwngO1SNCXq/ajA==
X-Received: by 2002:a17:90b:1e4d:b0:1cb:ae06:2c4 with SMTP id pi13-20020a17090b1e4d00b001cbae0602c4mr11587399pjb.12.1649864323806;
        Wed, 13 Apr 2022 08:38:43 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id gt14-20020a17090af2ce00b001c701e0a129sm3412190pjb.38.2022.04.13.08.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 08:38:43 -0700 (PDT)
Message-ID: <e9c81a3d-d03a-5b13-ee14-9ba6103093f7@gmail.com>
Date:   Wed, 13 Apr 2022 08:38:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/1] firmware: tee_bnxt: Use UUID API for exporting the
 UUID
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Allen Pais <apais@linux.microsoft.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220412113250.57997-1-andriy.shevchenko@linux.intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220412113250.57997-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 4/12/2022 4:32 AM, Andy Shevchenko wrote:
> There is export_uuid() function which exports uuid_t to the u8 array.
> Use it instead of open coding variant.
> 
> This allows to hide the uuid_t internals.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: rebased on the latest vanilla, added Andrew since it has no move for 1y+

I don't think this is going to be picked up unless we designate a entry 
in the MAINTAINERS file, I don't mind taking this via the Broadcom ARM 
SoCs pull request if this does not move.

>   drivers/firmware/broadcom/tee_bnxt_fw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
> index a5bf4c3f6dc7..40e3183a3d11 100644
> --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
> +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
> @@ -197,7 +197,7 @@ static int tee_bnxt_fw_probe(struct device *dev)
>   		return -ENODEV;
>   
>   	/* Open session with Bnxt load Trusted App */
> -	memcpy(sess_arg.uuid, bnxt_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
> +	export_uuid(sess_arg.uuid, &bnxt_device->id.uuid);
>   	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
>   	sess_arg.num_params = 0;
>   

-- 
Florian
