Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CB95572B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiFWFx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiFWFx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:53:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3049F3E5D4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 22:53:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c65so3914952edf.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 22:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kcwJ6iz0WSRqkk4otNBkZUgi8EG0jqf80hBxBcLJjoI=;
        b=fw1jQ2idkZYe6jKTepYjZZxhD5giE5xmrVbaEL98EFHaGhs4KpxpLZgXV2E+ZzgVeE
         oMMh+qhpElWo0b5AGkujeZNW/sJx3VlXvuAowr+oxIq4cV1DfMKSr74Yhjhd5Tx2Zhqh
         uh2/CSeRAyVHmBcX0HZR3VHrdsyiaAKqPjCbJwnmWW1aeam455jrHGHKwZSaQbkgPYt1
         VoSy90kfmNFRVeLRDKB7NmN/6G9taLBkyCb28b0IRgfe8pRR7Y4AXn1e887kVoRJ9DAQ
         ainC/Q4GSwL56yLXeKNcZDrMdHyFWEi1GnSUUCyq8+Bst+wlT8I4Gf7kmRcWlWSLX5AL
         8aLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kcwJ6iz0WSRqkk4otNBkZUgi8EG0jqf80hBxBcLJjoI=;
        b=UWDcQ58ePI1Yq33VnmObVo94z/K2oD6ULavKjBlS5uWLus9nft4OUbuQBAbVVsqAWw
         otomIlLmnVj8qaV99R/qipAn0wLulmNNomNuqnkHnsi/4SNGv2SL1s85UKumhv6tMJvu
         jybsGXBmZzGPlBnIedefJh37GsfbRkwLGTPRoAN/Me5EvvMGEoXsNW7lSd35F20RMCtw
         Armn/mrDH5XsXuS5tyaRsYv3NOY28DdioHQ2xyehh+S25DKHmXgS/me19ARy7M8k064T
         E1Xa1knciSF2YQMtUQkxwXlE2E9FdDVrCFxxzm0rmAYXPd2r38aW8fMkX19OmRDo62EI
         akEw==
X-Gm-Message-State: AJIora+jAqgi+TtNRy1oandiz9XRscNjJf+P62kgj0oOE6cunlpsrQy7
        /dePSUlXuuvQl4EqyqnG8LTR53UthAQ=
X-Google-Smtp-Source: AGRyM1u/0UVLNbC6rm1zOkyTAmn61viyenIsLAhw8yIHE1PtF2FEAPRS8XTizxeuck1l8LAh4MgbJw==
X-Received: by 2002:a05:6402:274a:b0:435:9807:7752 with SMTP id z10-20020a056402274a00b0043598077752mr8606211edd.63.1655963603696;
        Wed, 22 Jun 2022 22:53:23 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906318a00b00711aed17047sm10162207ejy.28.2022.06.22.22.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 22:53:23 -0700 (PDT)
Message-ID: <02cc4538-73c4-9f0f-45d9-29f867143df7@gmail.com>
Date:   Thu, 23 Jun 2022 07:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] staging: r8188eu: combine nested if statements into
 one
Content-Language: en-US
To:     Chang Yu <marcus.yu.56@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220623051404.410632-1-marcus.yu.56@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220623051404.410632-1-marcus.yu.56@gmail.com>
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

On 6/23/22 07:14, Chang Yu wrote:
> Combine two nested if statements into a single one
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
> Changes in v2:
> Added a pair of parentheses to make operator precedence explicit.
> 
>   drivers/staging/r8188eu/core/rtw_recv.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 6564e82ddd66..020bc212532f 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -166,10 +166,8 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
>   
>   	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
>   
> -	if (padapter) {
> -		if (pfree_recv_queue == &precvpriv->free_recv_queue)
> -				precvpriv->free_recvframe_cnt++;
> -	}
> +	if (padapter && (pfree_recv_queue == &precvpriv->free_recv_queue))
> +		precvpriv->free_recvframe_cnt++;
>   
>   	spin_unlock_bh(&pfree_recv_queue->lock);
>   


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
