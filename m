Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A591C576E6B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 16:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiGPOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 10:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiGPOFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 10:05:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE351B781;
        Sat, 16 Jul 2022 07:05:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j12so5420523plj.8;
        Sat, 16 Jul 2022 07:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eaPtnvKFV0apkWupHq9ES8s7XqztCxIX8nzTx3h5Ojc=;
        b=HkMjd6Zm54qoB/XD2Zii/ZugSzVE/RvttIdgqryuefrxLODREFIJQULiATc+7PknTa
         XlbEko2JIkh2upiY01dh+2r5MWTOBCS5J4nHgkXXDmj5lqIc116YXPi2gNfp288/IYUA
         twukOri3JT8hyLl/OdxJaoT+g6Fl4L5wak+BSq7x4YgALdonvtUQ+OABjxXB5TAOhwa6
         PMusAVE6rE0xAruQ6e4aIjCl7VTFYVDyAjghUPTnQ7WXFrq6xEuEtZYZBqYL2agXERU0
         iAYuC7KR6mYpFoGZorNJuTjG7RWPIRzIfpPAL7vzsoz6eizdKF7TmNOPPA9ne6QZ4dIi
         hYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eaPtnvKFV0apkWupHq9ES8s7XqztCxIX8nzTx3h5Ojc=;
        b=CZBb6KEOM4u0aGgNS+PqjdDTaMC1OAcoVur5M9k3T5ARkrFiOyJH2vfP+cNS94U31B
         SzzFFf1vQMDNKLwX/GNnZSsNLBAqvc/TKb9zYGkoDweHj/W23ZL8hNTv51EEhfj4/uVs
         +Su2Bz+VTnzhmcKcb8x4bJd7SnG2xnNxiZ+DzLKpIrIc1M6DH410VbvHjQWoe/LypayO
         eyoRu6zrq177rfwxqzc+AwPn7fyi4afVWCsdvS6QU9r62hj1jxaAmITg4mYdnpN87ebD
         C5MDwRKEWVhgK+OL6qBsktaw7RqWGiq7RZBCPO+IOoNH/d8GqF17h8oqmfz919hinNdz
         Infw==
X-Gm-Message-State: AJIora9uyOO+J7yr/Jg+tkZvvlPZR9i5hHRkGoluG4qTO25SvGz71YOu
        5j7FNG92xm/gMN76UQTZG+5fWnZwJEoSTA==
X-Google-Smtp-Source: AGRyM1sqQiy2m3az0vZr0ZDy6aLxC1sPcmzmKi9+YHNEHalBli9ki9dyvYgQAHmvJQyoX6i/H7vrUQ==
X-Received: by 2002:a17:903:445:b0:16c:5d4f:c329 with SMTP id iw5-20020a170903044500b0016c5d4fc329mr19188016plb.104.1657980319482;
        Sat, 16 Jul 2022 07:05:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b0016bf7981d0bsm5676731plh.86.2022.07.16.07.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 07:05:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d17a72a0-998d-7640-becf-004cc62aadfc@roeck-us.net>
Date:   Sat, 16 Jul 2022 07:04:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb/typec/tcpm: fix repeated words in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220716135642.52460-1-yuanjilin@cdjrlc.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220716135642.52460-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/22 06:56, Jilin Yuan wrote:
>   Delete the redundant word 'to'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/tcpm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3bc2f4ebd1fe..2d80b5b17ea4 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4453,7 +4453,7 @@ static void run_state_machine(struct tcpm_port *port)
>   		 * The specification suggests that dual mode ports in sink
>   		 * mode should transition to state PE_SRC_Transition_to_default.
>   		 * See USB power delivery specification chapter 8.3.3.6.1.3.
> -		 * This would mean to to
> +		 * This would mean to
>   		 * - turn off VCONN, reset power supply
>   		 * - request hardware reset
>   		 * - turn on VCONN

