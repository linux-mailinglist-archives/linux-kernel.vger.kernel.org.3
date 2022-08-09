Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66BD58E097
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbiHIUE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344154AbiHIUEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:04:51 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393BACF9;
        Tue,  9 Aug 2022 13:04:51 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id gj1so12777087pjb.0;
        Tue, 09 Aug 2022 13:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bHFnSCpx4s1yF8VGyhgz7QOF0G/eo6MkBMtMb/5y7Kw=;
        b=E7FMiwb3O8ooXaniJYbylzSC+9kgtUSTuW0xEDXX/lwZlszJeDkEe7T3LTCjs+8QPL
         lrLjvu7q5fYGW3WDnqeksSjb/h+Iklzk/8+u9eJ50VbSE6n7cLSplCeyUiR6p/1EWgEf
         JER8bWxEkBTAKpVV1GjZDHpra0lmlGGQf+a5M6bld9btVtZCyz9f3w7inkkRmwbIS77V
         3qRapLwXTaufaB3WrxhaoDkcnePhIXfZEBY7DDkiZyPqmkQnYG0TXYsETFxuQDx0QMK1
         f6TMkkyAjjmfT+j2CWo+BAlTFBkIAHf6kQpsFXaXt9aV9BL/bomYPaCyBPAZ6jOXAgey
         tdCA==
X-Gm-Message-State: ACgBeo2+LAuKWU2WIDDoXBwneXFBMFivZHaQGDVbd3wbr2hnI5w2dvPu
        Z7MDGth1r3g7tGZdM0XPpXoLMjTHH/o=
X-Google-Smtp-Source: AA6agR4UakHoOroAq+rmXZcbVw14rKs+gCvfRNkzhsXuB+C7jxhZoiGGzkFzF563PI2WPYky1xFY5w==
X-Received: by 2002:a17:90b:3807:b0:1f4:ecf7:5987 with SMTP id mq7-20020a17090b380700b001f4ecf75987mr146310pjb.13.1660075490640;
        Tue, 09 Aug 2022 13:04:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:61e9:2f41:c2d4:73d? ([2620:15c:211:201:61e9:2f41:c2d4:73d])
        by smtp.gmail.com with ESMTPSA id jn1-20020a170903050100b0016c4fb6e0b2sm4245532plb.55.2022.08.09.13.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 13:04:49 -0700 (PDT)
Message-ID: <70a33138-1981-f639-c371-b1ffb2378a73@acm.org>
Date:   Tue, 9 Aug 2022 13:04:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scsi: aic79xx: make read-only array tok_list static const
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220809182518.3046935-1-colin.i.king@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220809182518.3046935-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 11:25, Colin Ian King wrote:
> Don't populate the read-only array tok_list on the stack but instead make
> it static const. Also makes the object code a little smaller.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/scsi/aic7xxx/aic79xx_osm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
> index 928099163f0f..4ed40e6c5522 100644
> --- a/drivers/scsi/aic7xxx/aic79xx_osm.c
> +++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
> @@ -1044,7 +1044,7 @@ ahd_parse_brace_option(char *opt_name, char *opt_arg, char *end, int depth,
>   	int      instance;
>   	int	 targ;
>   	int	 done;
> -	char	 tok_list[] = {'.', ',', '{', '}', '\0'};
> +	static const char tok_list[] = {'.', ',', '{', '}', '\0'};

Has it been considered to write the above code as follows?

static const char tok_list[] = ".,{}";

Thanks,

Bart.
