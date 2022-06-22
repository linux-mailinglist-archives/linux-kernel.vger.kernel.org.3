Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DCE5550D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376499AbiFVQFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376524AbiFVQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:05:03 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386FC3FD89;
        Wed, 22 Jun 2022 09:04:50 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id o18so8721714plg.2;
        Wed, 22 Jun 2022 09:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y/E0abu7nd+/n02vnB39JPI2fjZU0lLiv9Lz90V/yI8=;
        b=DG6H2RxjC77+zYNJkQ4hNU8Hq+CGxYN1n4mJbtkU6F00pY+elv8MeE+aZr6RwxGn8b
         AtE26HNTgsnOQYo56FIEWUIHKZObZa1BaDoWe59xl8j/YfDfO5DiuqX4GG5qx3CT1p0C
         V9y1of9JZe775dRVUjoz6CmKjCPhz8pGcdG5K/Eqt8OFpzPso/K8xD4CGSsyeWgYNNAJ
         1okpkzx4auNwoMpDUj2V2aaGOyfQME1cYbA1ljTRM9C+k45C6meYvipWsUwKMhupEV1Z
         jce9dro7ag2nOLMTSesSIO0AaaZP/WGnHOhoKdtN0m/evCKIVIwq8Gs9EwZkpD6FvB58
         XLaw==
X-Gm-Message-State: AJIora8zI9JDfXRPYpHsGSTk0Nw/d6dGHuPwq8o3NAe8eEOnuSmLhAKq
        FNhskhCGMEP/rSiyXAZ07tcLmKq90ws=
X-Google-Smtp-Source: AGRyM1un/hCrO1Tux3G/1uw1RBOiuwd/JmRMKGmDWPGwnzJT+Mu6fFivFjUZXD11KEGMwOQSTkDsww==
X-Received: by 2002:a17:90a:eace:b0:1ec:b2a6:c9cf with SMTP id ev14-20020a17090aeace00b001ecb2a6c9cfmr15834261pjb.26.1655913889342;
        Wed, 22 Jun 2022 09:04:49 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9497:eb13:222f:4e4d? ([2620:15c:211:201:9497:eb13:222f:4e4d])
        by smtp.gmail.com with ESMTPSA id bx5-20020a17090af48500b001e0899052f1sm14603842pjb.3.2022.06.22.09.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 09:04:48 -0700 (PDT)
Message-ID: <4355e287-11e3-dfb2-f35e-5c991c57b85a@acm.org>
Date:   Wed, 22 Jun 2022 09:04:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] scsi: sg: Fix typo in comments
Content-Language: en-US
To:     Jiang Jian <jiangjian@cdjrlc.com>, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220622153029.4137-1-jiangjian@cdjrlc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220622153029.4137-1-jiangjian@cdjrlc.com>
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

On 6/22/22 08:30, Jiang Jian wrote:
> there is an unexpected word 'is' in the comments that need to be dropped
> 
> file: drivers/scsi/sg.c
> line: 697
> 
> * but is is possible that the app intended SG_DXFER_TO_DEV, because there
> 
> changed to:
> 
> * but is possible that the app intended SG_DXFER_TO_DEV, because there
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>   drivers/scsi/sg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 118c7b4a8af2..047761f62b23 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -694,7 +694,7 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
>   	}
>   	/*
>   	 * SG_DXFER_TO_FROM_DEV is functionally equivalent to SG_DXFER_FROM_DEV,
> -	 * but is is possible that the app intended SG_DXFER_TO_DEV, because there
> +	 * but is possible that the app intended SG_DXFER_TO_DEV, because there
>   	 * is a non-zero input_size, so emit a warning.
>   	 */
>   	if (hp->dxfer_direction == SG_DXFER_TO_FROM_DEV) {

I do not agree with this change since the author of that comment 
probably wanted to write "[...] but it is possible [...]"

Bart.
